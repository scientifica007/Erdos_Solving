#!/usr/bin/env python3
"""Fail-closed apparatus for the predeclared Erdős #678 S2e upgrade experiment.

This harness implements the frozen S2e contract only. It never chooses a new
candidate, edits third-party source, or invents a repair. Candidate changes live
in detached temporary worktrees. Detection always precedes repair. Optional
repair consumes explicit patch plans and enforces the frozen ownership scope,
semantic-header fingerprints, immutable regression files, and cumulative budget.
"""

from __future__ import annotations

import argparse
import dataclasses
import datetime as dt
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
from contextlib import contextmanager
from pathlib import Path
from typing import Any, Iterable, Iterator, Sequence

# Frozen S2e provenance.
BASELINE_COMMIT = "5039d464f6196e6b47494f0a6fae869e3362d082"
PREDECLARATION_HEAD = "c733ac4baae1a53b20d2e395eaab5c938683a74a"
PREDECLARATION_MERGE = "0fcefd7ea8cb3753a80a3f93c2498841b1938e55"
PREDECLARATION_EXACT_HEAD_RUN = 32105032799
PREDECLARATION_EXACT_HEAD_JOB = 95612654549
PREDECLARATION_POSTMERGE_RUN = 32105520785
PREDECLARATION_POSTMERGE_JOB = 95614030394

BASELINE_TOOLCHAIN = "leanprover/lean4:v4.33.0"
BASELINE_LEAN_VERSION = "4.33.0"
CANDIDATE_TOOLCHAIN = "leanprover/lean4:v4.34.0-rc1"
CANDIDATE_LEAN_VERSION = "4.34.0-rc1"
BASELINE_MATHLIB_INPUT = "v4.33.0"
BASELINE_MATHLIB_RESOLVED = "db584cd6d46c92f209a44c0f1c829460d327499d"
U2_MATHLIB_COMMIT = "de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11"
U2_MATHLIB_TAG = "v4.34.0-rc1"
PNT_COMMIT = "2667e414c38e5a5dc9aa1946f16f13001e5cd3ed"
BASELINE_BUILD_JOBS = 8808

PROTOCOL = "problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md"
MATRIX = "problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml"
APPARATUS = "problems/678/experiments/s2_upgrade_robustness.py"

D2_TARGETS = (
    "Formalization.Erdos678.Intervals",
    "Formalization.Erdos678.ValuationBasic",
    "Formalization.Erdos678.Claim4Density",
)
D3_TARGET = "PrimeNumberTheoremAnd"
D4_TARGET = "Formalization.Erdos678.Claim4RelativePrimePNT"
D5_TARGET = "Formalization.Erdos678.Erdos678Final"
IMMUTABLE_REGRESSION_TARGETS = (
    "Formalization.Erdos678.ConcreteTests",
    "Formalization.Erdos678.Erdos678FinalTests",
    "Formalization.Erdos678.ExternalStatementBridgeTests",
)
IMMUTABLE_REGRESSION_FILES = (
    "formalization/Formalization/Erdos678/ConcreteTests.lean",
    "formalization/Formalization/Erdos678/Erdos678FinalTests.lean",
    "formalization/Formalization/Erdos678/ExternalStatementBridgeTests.lean",
)
FROZEN_HEADERS = (
    "cambie_lcm_ratio_eventually_with_large_start_real",
    "erdos678_unbounded_witnesses",
    "erdos678_good_lengths_infinite",
    "erdos678_formalConjectures_eventual_nonempty",
)
BASELINE_HASH_PATHS = (
    "formalization/lean-toolchain",
    "formalization/lakefile.toml",
    "formalization/lake-manifest.json",
    "formalization/Formalization.lean",
    "formalization/Formalization/Erdos678/Intervals.lean",
    "formalization/Formalization/Erdos678/ValuationBasic.lean",
    "formalization/Formalization/Erdos678/Claim4Density.lean",
    "formalization/Formalization/Erdos678/Claim4RelativePrimePNT.lean",
    "formalization/Formalization/Erdos678/Erdos678Final.lean",
    "formalization/Formalization/Erdos678/ExternalStatementBridge.lean",
    *IMMUTABLE_REGRESSION_FILES,
)

MAX_REPAIR_BATCHES = 12
MAX_REPAIR_FILES = 10
MAX_REPAIR_CHURN = 250

OWNER_CLASSES = {
    "apparatus_or_provenance",
    "package_resolution",
    "lean_toolchain",
    "mathlib_or_transitive_dependency",
    "pnt_dependency_support",
    "project_owned",
    "ambiguous",
}

NETWORK_RE = re.compile(
    r"(could not resolve host|failed to connect|connection (?:timed out|reset)|"
    r"operation timed out|temporary failure in name resolution|tls|ssl connect error|"
    r"remote end hung up|unexpected eof|http/2 stream|curl:\s*\(\d+\)|"
    r"the requested url returned error:\s*5\d\d)",
    re.IGNORECASE,
)
LEAN_VERSION_RE = re.compile(r"Lean \(version ([^,]+)")
LEAN_PATH_RE = re.compile(
    r"(?P<path>(?:\.{0,2}/)?[A-Za-z0-9_./+\-]+\.lean)"
    r"(?::(?P<line>\d+):(?P<col>\d+))?"
)
DECL_RE = re.compile(
    r"(?m)^[ \t]*(?:protected[ \t]+|private[ \t]+|noncomputable[ \t]+)*"
    r"(?:theorem|lemma|def|abbrev|opaque|axiom)[ \t]+(?P<name>[A-Za-z0-9_'.]+)"
)
PATCH_PATH_RE = re.compile(r"^(?:---|\+\+\+) (?:a/|b/)?([^\t\r\n]+)", re.MULTILINE)


class ExperimentError(RuntimeError):
    """A run cannot receive scientific credit because the apparatus contract failed."""


class RepairBudgetExceeded(ExperimentError):
    """The frozen project-owned repair budget was exceeded."""


@dataclasses.dataclass(frozen=True)
class Candidate:
    id: str
    short: str
    toolchain: str
    mathlib_mode: str


CANDIDATES = (
    Candidate(
        id="U1-lean-4.34.0-rc1-compiler-only",
        short="U1",
        toolchain=CANDIDATE_TOOLCHAIN,
        mathlib_mode="baseline-locked",
    ),
    Candidate(
        id="U2-lean-mathlib-4.34.0-rc1-root-upgrade",
        short="U2",
        toolchain=CANDIDATE_TOOLCHAIN,
        mathlib_mode="exact-candidate-commit",
    ),
)


def now_utc() -> str:
    return dt.datetime.now(dt.timezone.utc).isoformat()


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    return sha256_bytes(path.read_bytes())


def run(
    cmd: Sequence[str],
    *,
    cwd: Path,
    timeout: int | None = None,
) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        list(cmd),
        cwd=cwd,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
        timeout=timeout,
        env=os.environ.copy(),
    )


def checked(cmd: Sequence[str], *, cwd: Path, timeout: int | None = None) -> str:
    proc = run(cmd, cwd=cwd, timeout=timeout)
    if proc.returncode != 0:
        raise ExperimentError(
            f"command failed ({proc.returncode}): {' '.join(cmd)}\n{proc.stdout or ''}"
        )
    return proc.stdout or ""


def git(repo: Path, *args: str) -> str:
    return checked(["git", *args], cwd=repo).strip()


def write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def ensure_commit(repo: Path, commit: str) -> None:
    if run(["git", "cat-file", "-e", f"{commit}^{{commit}}"], cwd=repo).returncode == 0:
        return
    fetched = run(["git", "fetch", "--no-tags", "origin", commit], cwd=repo, timeout=180)
    if fetched.returncode != 0:
        raise ExperimentError(f"cannot materialize frozen commit {commit}:\n{fetched.stdout or ''}")
    checked(["git", "cat-file", "-e", f"{commit}^{{commit}}"], cwd=repo)


def apparatus_commit(repo: Path) -> str:
    return checked(["git", "log", "-1", "--format=%H", "--", APPARATUS], cwd=repo).strip()


def runner_version() -> str:
    env_value = os.getenv("ACTIONS_RUNNER_VERSION") or os.getenv("S2E_RUNNER_VERSION")
    if env_value and re.fullmatch(r"\d+\.\d+\.\d+", env_value.strip()):
        return env_value.strip()
    version_re = re.compile(r"(?:^|/)(\d+\.\d+\.\d+)(?:/|$)")
    try:
        pids = [p for p in Path("/proc").iterdir() if p.name.isdigit()]
    except OSError:
        pids = []
    for pid in pids:
        texts: list[str] = []
        try:
            texts.append(os.readlink(pid / "exe"))
        except OSError:
            pass
        try:
            texts.append(
                (pid / "cmdline").read_bytes().replace(b"\x00", b" ").decode(
                    "utf-8", errors="replace"
                )
            )
        except OSError:
            pass
        for text in texts:
            if "Runner.Worker" not in text and "/runners/" not in text:
                continue
            match = version_re.search(text)
            if match:
                return match.group(1)
    for root in (Path("/home/runner/runners"), Path("/opt/actions-runner")):
        if not root.exists():
            continue
        for child in sorted(root.iterdir()):
            if re.fullmatch(r"\d+\.\d+\.\d+", child.name):
                return child.name
    raise ExperimentError("GitHub runner version could not be recovered")


def runner_metadata(*, strict: bool) -> dict[str, Any]:
    image_os = os.getenv("ImageOS", "unknown")
    image_version = os.getenv("ImageVersion", "unknown")
    version = "unknown"
    try:
        version = runner_version()
    except ExperimentError:
        if strict:
            raise
    if strict and (image_os == "unknown" or image_version == "unknown"):
        raise ExperimentError("runner image identity is unavailable")
    return {
        "runner_version": version,
        "runner_os": os.getenv("RUNNER_OS", "unknown"),
        "runner_arch": os.getenv("RUNNER_ARCH", "unknown"),
        "runner_name": os.getenv("RUNNER_NAME", "unknown"),
        "runner_environment": os.getenv("RUNNER_ENVIRONMENT", "unknown"),
        "image_os": image_os,
        "image_version": image_version,
        "cpu_count": os.cpu_count(),
        "uname": subprocess.check_output(["uname", "-a"], text=True).strip(),
    }


def validate_predeclaration(repo: Path) -> dict[str, str]:
    ensure_commit(repo, PREDECLARATION_MERGE)
    hashes: dict[str, str] = {}
    for rel in (PROTOCOL, MATRIX):
        current = (repo / rel).read_bytes()
        frozen = subprocess.check_output(
            ["git", "show", f"{PREDECLARATION_MERGE}:{rel}"], cwd=repo
        )
        if current != frozen:
            raise ExperimentError(f"predeclared artifact changed after integration: {rel}")
        hashes[rel] = sha256_bytes(current)

    matrix = (repo / MATRIX).read_text(encoding="utf-8")
    required = (
        BASELINE_COMMIT,
        BASELINE_TOOLCHAIN,
        BASELINE_MATHLIB_INPUT,
        BASELINE_MATHLIB_RESOLVED,
        CANDIDATE_TOOLCHAIN,
        U2_MATHLIB_COMMIT,
        U2_MATHLIB_TAG,
        PNT_COMMIT,
        "max_repair_batches: 12",
        "max_project_owned_files_touched: 10",
        "max_aggregate_line_churn_additions_plus_deletions: 250",
    )
    missing = [literal for literal in required if literal not in matrix]
    if missing:
        raise ExperimentError(f"matrix/constant contract mismatch; missing: {missing}")
    return hashes


def validate_internal_source_baseline(repo: Path) -> None:
    ensure_commit(repo, BASELINE_COMMIT)
    scope = (
        "formalization/Formalization/Erdos678",
        "formalization/Formalization.lean",
        "formalization/lakefile.toml",
        "formalization/lake-manifest.json",
        "formalization/lean-toolchain",
    )
    proc = run(["git", "diff", "--quiet", BASELINE_COMMIT, "--", *scope], cwd=repo)
    if proc.returncode != 0:
        stat = checked(["git", "diff", "--stat", BASELINE_COMMIT, "--", *scope], cwd=repo)
        raise ExperimentError(
            "current proof/dependency source differs from frozen S2e baseline:\n" + stat
        )


def parse_lean_version(formalization: Path) -> str:
    text = checked(["lean", "--version"], cwd=formalization, timeout=180)
    match = LEAN_VERSION_RE.search(text)
    if not match:
        raise ExperimentError(f"could not parse Lean version:\n{text}")
    return match.group(1)


def package_identities(formalization: Path) -> dict[str, str]:
    manifest = json.loads((formalization / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {item["name"]: item for item in manifest["packages"]}
    mathlib = packages["mathlib"]
    pnt = packages["PrimeNumberTheoremAnd"]
    return {
        "mathlib_input": str(mathlib.get("inputRev", "")),
        "mathlib_resolved": str(mathlib.get("rev", "")),
        "pnt_resolved": str(pnt.get("rev", "")),
    }


def candidate_config_hashes(formalization: Path) -> dict[str, str]:
    return {
        "lean_toolchain": sha256_file(formalization / "lean-toolchain"),
        "lakefile": sha256_file(formalization / "lakefile.toml"),
        "manifest": sha256_file(formalization / "lake-manifest.json"),
    }


def code_mask(text: str) -> str:
    """Blank Lean comments and strings while preserving offsets/newlines."""
    out = list(text)
    i = 0
    block_depth = 0
    in_string = False
    escaped = False
    line_comment = False
    while i < len(text):
        c = text[i]
        nxt = text[i + 1] if i + 1 < len(text) else ""
        if line_comment:
            if c == "\n":
                line_comment = False
            else:
                out[i] = " "
            i += 1
            continue
        if block_depth:
            if c == "/" and nxt == "-":
                out[i] = out[i + 1] = " "
                block_depth += 1
                i += 2
                continue
            if c == "-" and nxt == "/":
                out[i] = out[i + 1] = " "
                block_depth -= 1
                i += 2
                continue
            if c != "\n":
                out[i] = " "
            i += 1
            continue
        if in_string:
            if c != "\n":
                out[i] = " "
            if escaped:
                escaped = False
            elif c == "\\":
                escaped = True
            elif c == '"':
                in_string = False
            i += 1
            continue
        if c == "-" and nxt == "-":
            out[i] = out[i + 1] = " "
            line_comment = True
            i += 2
            continue
        if c == "/" and nxt == "-":
            out[i] = out[i + 1] = " "
            block_depth = 1
            i += 2
            continue
        if c == '"':
            out[i] = " "
            in_string = True
        i += 1
    return "".join(out)


def find_header_end(masked: str, start: int) -> int:
    paren = bracket = brace = 0
    i = start
    while i < len(masked) - 1:
        c = masked[i]
        if c == "(":
            paren += 1
        elif c == ")":
            paren = max(0, paren - 1)
        elif c == "[":
            bracket += 1
        elif c == "]":
            bracket = max(0, bracket - 1)
        elif c == "{":
            brace += 1
        elif c == "}":
            brace = max(0, brace - 1)
        if paren == bracket == brace == 0 and masked[i : i + 2] == ":=":
            return i
        i += 1
    raise ExperimentError("could not locate ':=' terminator for frozen declaration header")


def declaration_headers(project_root: Path) -> dict[str, dict[str, str]]:
    wanted = set(FROZEN_HEADERS)
    found: dict[str, dict[str, str]] = {}
    lean_root = project_root / "formalization" / "Formalization" / "Erdos678"
    for path in sorted(lean_root.rglob("*.lean")):
        text = path.read_text(encoding="utf-8")
        masked = code_mask(text)
        for match in DECL_RE.finditer(masked):
            short = match.group("name").split(".")[-1]
            if short not in wanted:
                continue
            end = find_header_end(masked, match.start())
            normalized = re.sub(r"\s+", " ", text[match.start() : end]).strip()
            if short in found:
                raise ExperimentError(f"frozen declaration is not unique: {short}")
            found[short] = {
                "file": path.relative_to(project_root).as_posix(),
                "normalized_header": normalized,
                "sha256": sha256_bytes(normalized.encode("utf-8")),
            }
    missing = sorted(wanted - set(found))
    if missing:
        raise ExperimentError(f"could not locate frozen declaration headers: {missing}")
    return found


def baseline_file_hashes(project_root: Path) -> dict[str, str]:
    hashes: dict[str, str] = {}
    for rel in BASELINE_HASH_PATHS:
        path = project_root / rel
        if not path.is_file():
            raise ExperimentError(f"required baseline file missing: {rel}")
        hashes[rel] = sha256_file(path)
    return hashes


@contextmanager
def baseline_worktree(repo: Path, parent: Path, name: str) -> Iterator[Path]:
    ensure_commit(repo, BASELINE_COMMIT)
    work = parent / name
    if work.exists():
        shutil.rmtree(work)
    checked(["git", "worktree", "add", "--detach", str(work), BASELINE_COMMIT], cwd=repo)
    try:
        yield work
    finally:
        run(["git", "worktree", "remove", "--force", str(work)], cwd=repo)
        shutil.rmtree(work, ignore_errors=True)


def command_with_log(
    cmd: Sequence[str],
    *,
    cwd: Path,
    log_path: Path,
    timeout: int = 1800,
    network_retries: int = 2,
) -> dict[str, Any]:
    attempts: list[dict[str, Any]] = []
    log_path.parent.mkdir(parents=True, exist_ok=True)
    for attempt in range(1, network_retries + 2):
        started = time.monotonic()
        proc = run(cmd, cwd=cwd, timeout=timeout)
        elapsed = time.monotonic() - started
        output = proc.stdout or ""
        network_failure = bool(proc.returncode and NETWORK_RE.search(output))
        attempts.append(
            {
                "attempt": attempt,
                "returncode": proc.returncode,
                "duration_seconds": elapsed,
                "network_failure": network_failure,
            }
        )
        with log_path.open("a", encoding="utf-8") as handle:
            handle.write(
                f"\n===== attempt {attempt}: {' '.join(cmd)} =====\n"
                f"returncode={proc.returncode} duration_seconds={elapsed:.3f}\n"
            )
            handle.write(output)
            if output and not output.endswith("\n"):
                handle.write("\n")
        if proc.returncode == 0:
            return {"returncode": 0, "output": output, "attempts": attempts}
        if not network_failure or attempt > network_retries:
            return {"returncode": proc.returncode, "output": output, "attempts": attempts}
        time.sleep(3 * attempt)
    raise AssertionError("unreachable")


def normalize_path(path: str) -> str:
    value = path.strip()
    while value.startswith("./"):
        value = value[2:]
    return value


def owner_for_lean_path(path: str) -> str:
    norm = normalize_path(path)
    if norm.startswith("formalization/Formalization/") or norm.startswith("Formalization/"):
        return "project_owned"
    if (
        ".lake/packages/PrimeNumberTheoremAnd/" in norm
        or norm.startswith("PrimeNumberTheoremAnd/")
    ):
        return "pnt_dependency_support"
    if norm.startswith("Lean/") or norm.startswith("Init/"):
        return "lean_toolchain"
    if norm.endswith(".lean"):
        # All remaining Lean source in these Lake builds is external package source.
        return "mathlib_or_transitive_dependency"
    return "ambiguous"


def declaration_at_line(path: Path, line: int | None) -> str | None:
    if line is None or not path.is_file():
        return None
    text = path.read_text(encoding="utf-8", errors="replace")
    masked = code_mask(text)
    current_line = 1
    offset = len(masked)
    for idx, char in enumerate(masked):
        if current_line >= line:
            offset = idx
            break
        if char == "\n":
            current_line += 1
    previous: re.Match[str] | None = None
    for match in DECL_RE.finditer(masked):
        if match.start() > offset:
            break
        previous = match
    return previous.group("name") if previous else None


def substantive_error_line(output: str) -> str | None:
    lines = output.splitlines()
    for line in lines:
        if ".lean" in line and re.search(r"\berror:", line, re.IGNORECASE):
            return line
    # Some tools put the path and the word error on adjacent lines.
    for index, line in enumerate(lines):
        if ".lean" not in line or "warning:" in line.lower():
            continue
        neighborhood = "\n".join(lines[max(0, index - 1) : min(len(lines), index + 2)])
        if re.search(r"\berror:", neighborhood, re.IGNORECASE):
            return line
    return None


def diagnose_failure(output: str, *, formalization: Path) -> dict[str, Any]:
    line = substantive_error_line(output)
    if line:
        match = LEAN_PATH_RE.search(line)
        if match:
            raw = normalize_path(match.group("path"))
            owner = owner_for_lean_path(raw)
            line_no = int(match.group("line")) if match.group("line") else None
            local = formalization / raw
            if raw.startswith("formalization/"):
                local = formalization.parent / raw
            declaration = declaration_at_line(local, line_no)
            lines = output.splitlines()
            try:
                index = lines.index(line)
            except ValueError:
                index = 0
            excerpt = "\n".join(lines[max(0, index - 2) : min(len(lines), index + 5)])
            return {
                "owner": owner,
                "file": raw,
                "line": line_no,
                "declaration": declaration,
                "diagnostic_excerpt": excerpt.strip(),
            }
    lower = output.lower()
    if (
        "unknown toolchain" in lower
        or "toolchain" in lower and "not installed" in lower
        or "lean version" in lower and "mismatch" in lower
    ):
        owner = "lean_toolchain"
    else:
        owner = "ambiguous"
    return {
        "owner": owner,
        "file": None,
        "line": None,
        "declaration": None,
        "diagnostic_excerpt": output[-1600:].strip(),
    }


def stage(
    stage_id: str,
    cmd: Sequence[str],
    *,
    formalization: Path,
    log_path: Path,
    timeout: int = 1800,
    required_marker: str | None = None,
    config_hashes: dict[str, str] | None = None,
) -> dict[str, Any]:
    measured = command_with_log(cmd, cwd=formalization, log_path=log_path, timeout=timeout)
    result: dict[str, Any] = {
        "stage": stage_id,
        "command": list(cmd),
        "returncode": measured["returncode"],
        "attempts": measured["attempts"],
        "status": "green" if measured["returncode"] == 0 else "failed",
    }
    if measured["returncode"] != 0:
        result["failure"] = diagnose_failure(measured["output"], formalization=formalization)
        return result
    if required_marker is not None and required_marker not in measured["output"]:
        result["status"] = "failed"
        result["failure"] = {
            "owner": "apparatus_or_provenance",
            "file": None,
            "line": None,
            "declaration": None,
            "diagnostic_excerpt": f"successful command lacked required marker: {required_marker}",
        }
        return result
    if config_hashes is not None:
        current = candidate_config_hashes(formalization)
        if current != config_hashes:
            result["status"] = "failed"
            result["failure"] = {
                "owner": "apparatus_or_provenance",
                "file": None,
                "line": None,
                "declaration": None,
                "diagnostic_excerpt": f"candidate configuration drifted: {current} != {config_hashes}",
            }
    return result


def setup_candidate(candidate: Candidate, work: Path, output_dir: Path) -> None:
    formalization = work / "formalization"
    baseline_lakefile = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:formalization/lakefile.toml"], cwd=work
    )
    baseline_manifest = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:formalization/lake-manifest.json"], cwd=work
    )
    (formalization / "lean-toolchain").write_text(candidate.toolchain + "\n", encoding="utf-8")
    if candidate.short == "U1":
        if (formalization / "lakefile.toml").read_bytes() != baseline_lakefile:
            raise ExperimentError("U1 lakefile is not byte-identical to baseline")
        if (formalization / "lake-manifest.json").read_bytes() != baseline_manifest:
            raise ExperimentError("U1 manifest is not byte-identical to baseline")
    elif candidate.short == "U2":
        lakefile_path = formalization / "lakefile.toml"
        text = lakefile_path.read_text(encoding="utf-8")
        old = 'rev = "v4.33.0"'
        if text.count(old) != 1:
            raise ExperimentError("U2 could not uniquely identify the root Mathlib revision")
        lakefile_path.write_text(
            text.replace(old, f'rev = "{U2_MATHLIB_COMMIT}"', 1), encoding="utf-8"
        )
    else:
        raise ExperimentError(f"unknown candidate: {candidate.short}")
    output_dir.mkdir(parents=True, exist_ok=True)
    diff = checked(
        ["git", "diff", "--", "formalization/lean-toolchain", "formalization/lakefile.toml"],
        cwd=work,
    )
    (output_dir / "setup.diff").write_text(diff, encoding="utf-8")


def candidate_d0(candidate: Candidate, work: Path, output_dir: Path) -> dict[str, Any]:
    formalization = work / "formalization"
    result: dict[str, Any] = {"stage": "D0", "candidate_id": candidate.id, "status": "green"}
    try:
        toolchain = (formalization / "lean-toolchain").read_text(encoding="utf-8").strip()
        if toolchain != candidate.toolchain:
            raise ExperimentError(f"candidate toolchain mismatch: {toolchain}")
        version = parse_lean_version(formalization)
        if version != CANDIDATE_LEAN_VERSION:
            raise ExperimentError(f"candidate Lean mismatch: {version}")
        source_commit = git(work, "rev-parse", "HEAD")
        if source_commit != BASELINE_COMMIT:
            raise ExperimentError(f"candidate source checkout mismatch: {source_commit}")
        result.update(
            {
                "lean": version,
                "source_commit": source_commit,
                "runner": runner_metadata(strict=True),
            }
        )
    except (ExperimentError, OSError, subprocess.TimeoutExpired) as exc:
        result["status"] = "failed"
        result["failure"] = {
            "owner": "apparatus_or_provenance",
            "diagnostic_excerpt": f"{type(exc).__name__}: {exc}",
        }
    write_json(output_dir / "D0.json", result)
    return result


def candidate_d1(candidate: Candidate, work: Path, output_dir: Path) -> dict[str, Any]:
    formalization = work / "formalization"
    baseline_manifest = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:formalization/lake-manifest.json"], cwd=work
    )
    result: dict[str, Any] = {"stage": "D1", "status": "green"}
    try:
        if candidate.short == "U1":
            if (formalization / "lake-manifest.json").read_bytes() != baseline_manifest:
                raise ExperimentError("U1 manifest changed; lake update is forbidden")
            identities = package_identities(formalization)
            expected = {
                "mathlib_input": BASELINE_MATHLIB_INPUT,
                "mathlib_resolved": BASELINE_MATHLIB_RESOLVED,
                "pnt_resolved": PNT_COMMIT,
            }
            if identities != expected:
                raise ExperimentError(f"U1 package identities mismatch: {identities} != {expected}")
            (output_dir / "D1.log").write_text(
                "U1 manifest byte-identical to baseline; lake update not executed.\n",
                encoding="utf-8",
            )
        else:
            update = command_with_log(
                ["lake", "update", "mathlib"],
                cwd=formalization,
                log_path=output_dir / "D1.log",
                timeout=1800,
            )
            if update["returncode"] != 0:
                raise ExperimentError("U2 package resolution failed; see D1.log")
            identities = package_identities(formalization)
            if identities["mathlib_input"] != U2_MATHLIB_COMMIT:
                raise ExperimentError(f"U2 Mathlib input drift: {identities['mathlib_input']}")
            if identities["mathlib_resolved"] != U2_MATHLIB_COMMIT:
                raise ExperimentError(
                    f"U2 Mathlib resolved revision drift: {identities['mathlib_resolved']}"
                )
            if identities["pnt_resolved"] != PNT_COMMIT:
                raise ExperimentError(f"U2 PNT revision drift: {identities['pnt_resolved']}")
            manifest_diff = checked(
                ["git", "diff", "--", "formalization/lake-manifest.json"], cwd=work
            )
            (output_dir / "manifest.diff").write_text(manifest_diff, encoding="utf-8")
        result["identities"] = identities
        result["configuration_hashes"] = candidate_config_hashes(formalization)
    except (ExperimentError, OSError, ValueError, KeyError, subprocess.TimeoutExpired) as exc:
        result["status"] = "failed"
        result["failure"] = {
            "owner": "package_resolution",
            "diagnostic_excerpt": f"{type(exc).__name__}: {exc}",
        }
    write_json(output_dir / "D1.json", result)
    return result


def validate_baseline(repo: Path, temp_root: Path, output: Path) -> dict[str, Any]:
    with baseline_worktree(repo, temp_root, "baseline") as work:
        formalization = work / "formalization"
        toolchain = (formalization / "lean-toolchain").read_text(encoding="utf-8").strip()
        if toolchain != BASELINE_TOOLCHAIN:
            raise ExperimentError(f"baseline toolchain mismatch: {toolchain}")
        identities = package_identities(formalization)
        expected = {
            "mathlib_input": BASELINE_MATHLIB_INPUT,
            "mathlib_resolved": BASELINE_MATHLIB_RESOLVED,
            "pnt_resolved": PNT_COMMIT,
        }
        if identities != expected:
            raise ExperimentError(f"baseline package identity mismatch: {identities} != {expected}")
        version = parse_lean_version(formalization)
        if version != BASELINE_LEAN_VERSION:
            raise ExperimentError(f"baseline Lean version mismatch: {version}")

        hashes = baseline_file_hashes(work)
        headers = declaration_headers(work)
        write_json(output / "baseline" / "source_hashes.json", hashes)
        write_json(output / "baseline" / "header_fingerprints.json", headers)
        write_json(
            output / "baseline" / "environment.json",
            {"lean": version, **identities, **runner_metadata(strict=True)},
        )

        mk = stage(
            "baseline:mk_all",
            ["lake", "exe", "mk_all", "--check"],
            formalization=formalization,
            log_path=output / "baseline" / "mk_all.log",
            required_marker="No update necessary",
        )
        if mk["status"] != "green":
            raise ExperimentError(f"baseline mk_all validation failed: {mk}")
        build = stage(
            "baseline:full_build",
            ["lake", "build", "Formalization"],
            formalization=formalization,
            log_path=output / "baseline" / "build.log",
            timeout=2400,
            required_marker=f"Build completed successfully ({BASELINE_BUILD_JOBS} jobs).",
        )
        if build["status"] != "green":
            raise ExperimentError(f"baseline full build validation failed: {build}")
        return {
            "status": "green",
            "lean": version,
            **identities,
            "source_hashes": hashes,
            "header_fingerprints": headers,
            "mk_all_marker": "No update necessary",
            "canonical_build_jobs": BASELINE_BUILD_JOBS,
        }


def not_applicable(stage_id: str, reason: str) -> dict[str, Any]:
    return {"stage": stage_id, "status": "not_applicable", "reason": reason}


def run_detection(candidate: Candidate, work: Path, output_dir: Path) -> dict[str, Any]:
    formalization = work / "formalization"
    d0 = candidate_d0(candidate, work, output_dir)
    if d0["status"] != "green":
        return {
            "candidate_id": candidate.id,
            "D0": d0,
            "D1": not_applicable("D1", "D0-not-green"),
            "D2": [],
            "D3": not_applicable("D3", "D0-not-green"),
            "D4": not_applicable("D4", "D0-not-green"),
            "D5": not_applicable("D5", "D0-not-green"),
            "D6": not_applicable("D6", "D0-not-green"),
            "deepest_green_stage": None,
            "full_no_repair_survivor": False,
        }
    d1 = candidate_d1(candidate, work, output_dir)
    if d1["status"] != "green":
        return {
            "candidate_id": candidate.id,
            "D0": d0,
            "D1": d1,
            "D2": [],
            "D3": not_applicable("D3", "D1-not-green"),
            "D4": not_applicable("D4", "D1-not-green"),
            "D5": not_applicable("D5", "D1-not-green"),
            "D6": not_applicable("D6", "D1-not-green"),
            "deepest_green_stage": "D0",
            "full_no_repair_survivor": False,
        }
    config = d1["configuration_hashes"]

    d2: list[dict[str, Any]] = []
    for target in D2_TARGETS:
        d2.append(
            stage(
                f"D2:{target}",
                ["lake", "build", target],
                formalization=formalization,
                log_path=output_dir / f"D2_{target.split('.')[-1]}.log",
                config_hashes=config,
            )
        )

    d3 = stage(
        "D3",
        ["lake", "build", D3_TARGET],
        formalization=formalization,
        log_path=output_dir / "D3_PNT.log",
        config_hashes=config,
    )
    if d3["status"] == "green":
        d4 = stage(
            "D4",
            ["lake", "build", D4_TARGET],
            formalization=formalization,
            log_path=output_dir / "D4_project_PNT_boundary.log",
            config_hashes=config,
        )
        d5 = stage(
            "D5",
            ["lake", "build", D5_TARGET],
            formalization=formalization,
            log_path=output_dir / "D5_final.log",
            config_hashes=config,
        )
    else:
        d4 = not_applicable("D4", "D3-not-green")
        d5 = not_applicable("D5", "D3-not-green")

    prior_green = (
        all(item["status"] == "green" for item in d2)
        and d3["status"] == "green"
        and d4["status"] == "green"
        and d5["status"] == "green"
    )
    if prior_green:
        mk = stage(
            "D6:mk_all",
            ["lake", "exe", "mk_all", "--check"],
            formalization=formalization,
            log_path=output_dir / "D6_mk_all.log",
            required_marker="No update necessary",
            config_hashes=config,
        )
        full = (
            stage(
                "D6:full_build",
                ["lake", "build", "Formalization"],
                formalization=formalization,
                log_path=output_dir / "D6_full_build.log",
                timeout=2400,
                config_hashes=config,
            )
            if mk["status"] == "green"
            else not_applicable("D6:full_build", "mk_all-not-green")
        )
        d6 = {
            "stage": "D6",
            "status": "green" if full["status"] == "green" else "failed",
            "mk_all": mk,
            "full_build": full,
        }
    else:
        d6 = not_applicable("D6", "required-prior-stages-not-all-green")

    ordered = (
        ("D0", d0["status"] == "green"),
        ("D1", d1["status"] == "green"),
        ("D2", all(item["status"] == "green" for item in d2)),
        ("D3", d3["status"] == "green"),
        ("D4", d4["status"] == "green"),
        ("D5", d5["status"] == "green"),
        ("D6", d6["status"] == "green"),
    )
    green = [name for name, value in ordered if value]
    result = {
        "candidate_id": candidate.id,
        "D0": d0,
        "D1": d1,
        "D2": d2,
        "D3": d3,
        "D4": d4,
        "D5": d5,
        "D6": d6,
        "deepest_green_stage": green[-1] if green else None,
        "full_no_repair_survivor": all(value for _, value in ordered),
    }
    write_json(output_dir / "detection.json", result)
    return result


def candidate_primary_owner(detection: dict[str, Any]) -> str | None:
    attempted: list[dict[str, Any]] = list(detection.get("D2", []))
    for key in ("D3", "D4", "D5"):
        value = detection.get(key)
        if isinstance(value, dict):
            attempted.append(value)
    d6 = detection.get("D6")
    if isinstance(d6, dict):
        for key in ("mk_all", "full_build"):
            value = d6.get(key)
            if isinstance(value, dict):
                attempted.append(value)
    for item in attempted:
        if item.get("status") == "failed":
            owner = item.get("failure", {}).get("owner")
            if owner in OWNER_CLASSES:
                return owner
    return None


def repair_eligibility(detection: dict[str, Any]) -> dict[str, bool]:
    d2_failures = [item for item in detection.get("D2", []) if item.get("status") == "failed"]
    mathlib_only = (
        detection.get("D0", {}).get("status") == "green"
        and detection.get("D1", {}).get("status") == "green"
        and any(item.get("failure", {}).get("owner") == "project_owned" for item in d2_failures)
    )
    d3 = detection.get("D3", {})
    dependency_blocked = (
        d3.get("status") == "failed"
        and d3.get("failure", {}).get("owner")
        in {"pnt_dependency_support", "mathlib_or_transitive_dependency"}
    )
    return {
        "mathlib_only": mathlib_only,
        "pnt_dependent_full": d3.get("status") == "green",
        "dependency_support_blocked": dependency_blocked,
    }


def allowed_repair_path(path: str) -> bool:
    if path == "formalization/Formalization.lean":
        return True
    return path.startswith("formalization/Formalization/Erdos678/") and path.endswith(".lean")


def patch_paths(patch: str) -> list[str]:
    paths: list[str] = []
    for match in PATCH_PATH_RE.finditer(patch):
        path = match.group(1).strip()
        if path == "/dev/null":
            continue
        if path not in paths:
            paths.append(path)
    return paths


def project_diff_stats(work: Path) -> dict[str, Any]:
    scope = ("formalization/Formalization/Erdos678", "formalization/Formalization.lean")
    names = [
        line.strip()
        for line in checked(["git", "diff", "HEAD", "--name-only", "--", *scope], cwd=work).splitlines()
        if line.strip()
    ]
    additions = 0
    deletions = 0
    files: list[dict[str, Any]] = []
    numstat = checked(["git", "diff", "HEAD", "--numstat", "--", *scope], cwd=work)
    for line in numstat.splitlines():
        if not line.strip():
            continue
        add_raw, del_raw, path = line.split("\t", 2)
        if add_raw == "-" or del_raw == "-":
            raise ExperimentError(f"binary repair is forbidden: {path}")
        add = int(add_raw)
        delete = int(del_raw)
        additions += add
        deletions += delete
        files.append({"path": path, "additions": add, "deletions": delete})
    return {
        "names": names,
        "files": files,
        "additions": additions,
        "deletions": deletions,
        "churn": additions + deletions,
    }


def validate_root_import_only(repo: Path, work: Path) -> None:
    rel = "formalization/Formalization.lean"
    current = (work / rel).read_text(encoding="utf-8")
    baseline = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:{rel}"], cwd=repo, text=True
    )

    def non_import(text: str) -> list[str]:
        return [line for line in text.splitlines() if not line.lstrip().startswith("import ")]

    if non_import(current) != non_import(baseline):
        raise ExperimentError("Formalization.lean repair changed non-import content")


def dirty_dependency_packages(formalization: Path) -> list[str]:
    packages = formalization / ".lake" / "packages"
    if not packages.is_dir():
        return []
    dirty: list[str] = []
    for package in sorted(packages.iterdir()):
        if not (package / ".git").exists():
            continue
        status = run(["git", "status", "--porcelain", "--untracked-files=no"], cwd=package)
        if status.returncode == 0 and (status.stdout or "").strip():
            dirty.append(package.name)
    return dirty


def validate_repair_invariants(
    repo: Path,
    work: Path,
    *,
    baseline_headers: dict[str, dict[str, str]],
    baseline_hashes: dict[str, str],
    expected_config: dict[str, str],
    batch_count: int,
) -> dict[str, Any]:
    formalization = work / "formalization"
    current_config = candidate_config_hashes(formalization)
    if current_config != expected_config:
        raise ExperimentError(f"candidate configuration drifted during repair: {current_config}")
    stats = project_diff_stats(work)
    forbidden = [path for path in stats["names"] if not allowed_repair_path(path)]
    immutable = [path for path in stats["names"] if path in IMMUTABLE_REGRESSION_FILES]
    if forbidden:
        raise ExperimentError(f"repair touched forbidden project paths: {forbidden}")
    if immutable:
        raise ExperimentError(f"repair touched immutable regression files: {immutable}")
    if batch_count > MAX_REPAIR_BATCHES:
        raise RepairBudgetExceeded("repair batch budget exceeded")
    if len(set(stats["names"])) > MAX_REPAIR_FILES:
        raise RepairBudgetExceeded("project repair file budget exceeded")
    if stats["churn"] > MAX_REPAIR_CHURN:
        raise RepairBudgetExceeded("project repair line-churn budget exceeded")
    if "formalization/Formalization.lean" in stats["names"]:
        validate_root_import_only(repo, work)

    current_headers = declaration_headers(work)
    changed_headers = [
        name
        for name in FROZEN_HEADERS
        if current_headers[name]["sha256"] != baseline_headers[name]["sha256"]
    ]
    if changed_headers:
        raise ExperimentError(f"frozen semantic declaration headers changed: {changed_headers}")
    changed_immutable = [
        rel for rel in IMMUTABLE_REGRESSION_FILES if sha256_file(work / rel) != baseline_hashes[rel]
    ]
    if changed_immutable:
        raise ExperimentError(f"immutable regression file hash changed: {changed_immutable}")
    dirty_dependencies = dirty_dependency_packages(formalization)
    if dirty_dependencies:
        raise ExperimentError(f"third-party package source was modified: {dirty_dependencies}")
    return {
        **stats,
        "batch_count": batch_count,
        "third_party_source_files_touched": [],
        "immutable_regression_files_touched": [],
        "semantic_header_fingerprint_changes": [],
        "header_fingerprints": current_headers,
    }


def load_repair_plan(path: Path, candidate: Candidate) -> list[dict[str, Any]]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if value.get("candidate_id") != candidate.id:
        raise ExperimentError(
            f"repair-plan candidate mismatch: {value.get('candidate_id')} != {candidate.id}"
        )
    batches = value.get("batches")
    if not isinstance(batches, list):
        raise ExperimentError("repair plan must contain a batches list")
    if len(batches) > MAX_REPAIR_BATCHES:
        raise RepairBudgetExceeded("repair plan exceeds frozen batch budget")
    for index, batch in enumerate(batches, start=1):
        if not isinstance(batch, dict):
            raise ExperimentError(f"repair batch {index} is not an object")
        if batch.get("trigger_stage") not in {"D2", "D4", "D5", "D6"}:
            raise ExperimentError(f"repair batch {index} has invalid trigger_stage")
        if not isinstance(batch.get("patch"), str):
            raise ExperimentError(f"repair batch {index} lacks a patch path")
    return batches


def apply_patch_batch(
    repo: Path,
    work: Path,
    patch_path: Path,
    *,
    baseline_headers: dict[str, dict[str, str]],
    baseline_hashes: dict[str, str],
    expected_config: dict[str, str],
    batch_count: int,
    output_dir: Path,
) -> dict[str, Any]:
    patch = patch_path.read_text(encoding="utf-8")
    paths = patch_paths(patch)
    if not patch.strip() or not paths:
        raise ExperimentError(f"empty or pathless repair patch: {patch_path}")
    if any(not allowed_repair_path(path) for path in paths):
        raise ExperimentError(f"repair patch targets forbidden path(s): {paths}")
    if any(path in IMMUTABLE_REGRESSION_FILES for path in paths):
        raise ExperimentError(f"repair patch targets immutable regression file: {paths}")
    check = run(["git", "apply", "--check", "--index", str(patch_path)], cwd=work)
    if check.returncode != 0:
        raise ExperimentError(f"repair patch does not apply: {patch_path}\n{check.stdout or ''}")
    checked(["git", "apply", "--index", str(patch_path)], cwd=work)
    audit = validate_repair_invariants(
        repo,
        work,
        baseline_headers=baseline_headers,
        baseline_hashes=baseline_hashes,
        expected_config=expected_config,
        batch_count=batch_count,
    )
    output_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(patch_path, output_dir / f"batch_{batch_count:02d}.patch")
    diff = checked(
        [
            "git",
            "diff",
            "HEAD",
            "--",
            "formalization/Formalization/Erdos678",
            "formalization/Formalization.lean",
        ],
        cwd=work,
    )
    (output_dir / f"batch_{batch_count:02d}_cumulative.diff").write_text(diff, encoding="utf-8")
    write_json(output_dir / f"batch_{batch_count:02d}_audit.json", audit)
    return audit


def run_project_targets(
    targets: Iterable[tuple[str, Sequence[str]]],
    *,
    formalization: Path,
    output_dir: Path,
    label: str,
    config: dict[str, str],
) -> list[dict[str, Any]]:
    results: list[dict[str, Any]] = []
    for stage_id, cmd in targets:
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", stage_id)
        results.append(
            stage(
                stage_id,
                cmd,
                formalization=formalization,
                log_path=output_dir / f"{label}_{safe}.log",
                config_hashes=config,
            )
        )
    return results


def dependency_final_class(owner: str | None) -> str | None:
    if owner in {"pnt_dependency_support", "mathlib_or_transitive_dependency"}:
        return "dependency_support_blocked"
    return None


def run_repair(
    candidate: Candidate,
    *,
    detection: dict[str, Any],
    plan_path: Path,
    repo: Path,
    temp_root: Path,
    output: Path,
    baseline_headers: dict[str, dict[str, str]],
    baseline_hashes: dict[str, str],
) -> dict[str, Any]:
    eligibility = repair_eligibility(detection)
    if detection.get("full_no_repair_survivor"):
        return {
            "candidate_id": candidate.id,
            "repair_eligibility": eligibility,
            "final_repair_class": "not_needed",
            "repair_batch_count": 0,
        }

    try:
        batches = load_repair_plan(plan_path, candidate)
    except RepairBudgetExceeded as exc:
        return {
            "candidate_id": candidate.id,
            "repair_eligibility": eligibility,
            "final_repair_class": "project_repair_budget_exceeded",
            "repair_batch_count": 0,
            "reason": str(exc),
        }

    with baseline_worktree(repo, temp_root, f"{candidate.short.lower()}-repair") as work:
        output_dir = output / "candidates" / candidate.short / "repair"
        setup_candidate(candidate, work, output_dir)
        formalization = work / "formalization"
        applied = 0
        consumed: set[int] = set()
        previously_green_project_targets: list[tuple[str, Sequence[str]]] = []

        def next_batch(trigger: str) -> tuple[int, dict[str, Any]]:
            for idx, batch in enumerate(batches):
                if idx not in consumed and batch["trigger_stage"] == trigger:
                    return idx, batch
            raise ExperimentError(
                f"repair plan exhausted while {trigger} still has a project-owned failure"
            )

        def apply_one(trigger: str, config: dict[str, str]) -> None:
            nonlocal applied
            idx, batch = next_batch(trigger)
            patch = (plan_path.parent / batch["patch"]).resolve()
            applied += 1
            apply_patch_batch(
                repo,
                work,
                patch,
                baseline_headers=baseline_headers,
                baseline_hashes=baseline_hashes,
                expected_config=config,
                batch_count=applied,
                output_dir=output_dir,
            )
            consumed.add(idx)
            regressions = run_project_targets(
                previously_green_project_targets,
                formalization=formalization,
                output_dir=output_dir,
                label=f"batch_{applied:02d}_regression",
                config=config,
            )
            failed = [item for item in regressions if item["status"] != "green"]
            if failed:
                raise ExperimentError(
                    f"repair batch {applied} broke previously green project targets: "
                    f"{[item['stage'] for item in failed]}"
                )

        try:
            d0 = candidate_d0(candidate, work, output_dir)
            d1 = candidate_d1(candidate, work, output_dir)
            if d0["status"] != "green" or d1["status"] != "green":
                raise ExperimentError("pristine repair candidate failed D0/D1")
            config = d1["configuration_hashes"]

            def d2_group(label: str) -> list[dict[str, Any]]:
                return run_project_targets(
                    [(f"D2:{target}", ["lake", "build", target]) for target in D2_TARGETS],
                    formalization=formalization,
                    output_dir=output_dir,
                    label=label,
                    config=config,
                )

            d2 = d2_group("D2_initial")
            while any(item["status"] != "green" for item in d2):
                failed = [item for item in d2 if item["status"] != "green"]
                owners = {item.get("failure", {}).get("owner") for item in failed}
                if owners != {"project_owned"}:
                    dependency = next((dependency_final_class(owner) for owner in owners if dependency_final_class(owner)), None)
                    if dependency:
                        return {
                            "candidate_id": candidate.id,
                            "repair_eligibility": eligibility,
                            "final_repair_class": dependency,
                            "repair_batch_count": applied,
                            "D2": d2,
                        }
                    raise ExperimentError(f"D2 repair encountered non-project failure owner(s): {owners}")
                if not eligibility["mathlib_only"]:
                    raise ExperimentError("D2 repair is not eligible under frozen detection result")
                apply_one("D2", config)
                d2 = d2_group(f"D2_after_batch_{applied:02d}")
            previously_green_project_targets.extend(
                (f"D2:{target}", ["lake", "build", target]) for target in D2_TARGETS
            )

            d3 = stage(
                "D3",
                ["lake", "build", D3_TARGET],
                formalization=formalization,
                log_path=output_dir / "D3.log",
                config_hashes=config,
            )
            if d3["status"] != "green":
                dependency = dependency_final_class(d3.get("failure", {}).get("owner"))
                if dependency:
                    return {
                        "candidate_id": candidate.id,
                        "repair_eligibility": eligibility,
                        "final_repair_class": dependency,
                        "repair_batch_count": applied,
                        "D3": d3,
                    }
                raise ExperimentError(
                    f"D3 failed without dependency-support attribution: {d3.get('failure')}"
                )

            for trigger, command in (
                ("D4", ["lake", "build", D4_TARGET]),
                ("D5", ["lake", "build", D5_TARGET]),
            ):
                current = stage(
                    trigger,
                    command,
                    formalization=formalization,
                    log_path=output_dir / f"{trigger}.log",
                    config_hashes=config,
                )
                while current["status"] != "green":
                    owner = current.get("failure", {}).get("owner")
                    dependency = dependency_final_class(owner)
                    if dependency:
                        return {
                            "candidate_id": candidate.id,
                            "repair_eligibility": eligibility,
                            "final_repair_class": dependency,
                            "repair_batch_count": applied,
                            trigger: current,
                        }
                    if owner != "project_owned":
                        raise ExperimentError(f"{trigger} has non-repairable owner: {owner}")
                    apply_one(trigger, config)
                    current = stage(
                        trigger,
                        command,
                        formalization=formalization,
                        log_path=output_dir / f"{trigger}_after_batch_{applied:02d}.log",
                        config_hashes=config,
                    )
                previously_green_project_targets.append((trigger, command))

            mk = stage(
                "D6:mk_all",
                ["lake", "exe", "mk_all", "--check"],
                formalization=formalization,
                log_path=output_dir / "D6_mk_all.log",
                required_marker="No update necessary",
                config_hashes=config,
            )
            while mk["status"] != "green":
                owner = mk.get("failure", {}).get("owner")
                dependency = dependency_final_class(owner)
                if dependency:
                    return {
                        "candidate_id": candidate.id,
                        "repair_eligibility": eligibility,
                        "final_repair_class": dependency,
                        "repair_batch_count": applied,
                        "D6": {"mk_all": mk},
                    }
                if owner != "project_owned":
                    raise ExperimentError(f"D6 mk_all has non-repairable owner: {owner}")
                apply_one("D6", config)
                mk = stage(
                    "D6:mk_all",
                    ["lake", "exe", "mk_all", "--check"],
                    formalization=formalization,
                    log_path=output_dir / f"D6_mk_all_after_batch_{applied:02d}.log",
                    required_marker="No update necessary",
                    config_hashes=config,
                )

            full = stage(
                "D6:full_build",
                ["lake", "build", "Formalization"],
                formalization=formalization,
                log_path=output_dir / "D6_full_build.log",
                timeout=2400,
                config_hashes=config,
            )
            while full["status"] != "green":
                owner = full.get("failure", {}).get("owner")
                dependency = dependency_final_class(owner)
                if dependency:
                    return {
                        "candidate_id": candidate.id,
                        "repair_eligibility": eligibility,
                        "final_repair_class": dependency,
                        "repair_batch_count": applied,
                        "D6": {"mk_all": mk, "full_build": full},
                    }
                if owner != "project_owned":
                    raise ExperimentError(f"D6 full build has non-repairable owner: {owner}")
                apply_one("D6", config)
                full = stage(
                    "D6:full_build",
                    ["lake", "build", "Formalization"],
                    formalization=formalization,
                    log_path=output_dir / f"D6_full_build_after_batch_{applied:02d}.log",
                    timeout=2400,
                    config_hashes=config,
                )

            regressions = run_project_targets(
                [
                    (f"final-regression:{target}", ["lake", "build", target])
                    for target in IMMUTABLE_REGRESSION_TARGETS
                ],
                formalization=formalization,
                output_dir=output_dir,
                label="final_regression",
                config=config,
            )
            if any(item["status"] != "green" for item in regressions):
                raise ExperimentError("final immutable regression build failed")
            final_audit = validate_repair_invariants(
                repo,
                work,
                baseline_headers=baseline_headers,
                baseline_hashes=baseline_hashes,
                expected_config=config,
                batch_count=applied,
            )
            unused = [index + 1 for index in range(len(batches)) if index not in consumed]
            if unused:
                raise ExperimentError(f"repair plan contained unused batch(es): {unused}")
            final_diff = checked(
                [
                    "git",
                    "diff",
                    "HEAD",
                    "--",
                    "formalization/Formalization/Erdos678",
                    "formalization/Formalization.lean",
                ],
                cwd=work,
            )
            (output_dir / "final_source.diff").write_text(final_diff, encoding="utf-8")
            write_json(output_dir / "final_scope_audit.json", final_audit)
            return {
                "candidate_id": candidate.id,
                "repair_eligibility": eligibility,
                "final_repair_class": "repaired_green" if applied else "not_needed",
                "repair_batch_count": applied,
                "project_owned_files_touched": final_audit["names"],
                "diff_hunks": final_diff.count("@@"),
                "additions": final_audit["additions"],
                "deletions": final_audit["deletions"],
                "third_party_source_files_touched": 0,
                "immutable_regression_files_touched": 0,
                "semantic_header_fingerprint_changes": 0,
                "final_targets_reached": ["D2", "D3", "D4", "D5", "D6"],
            }
        except RepairBudgetExceeded as exc:
            return {
                "candidate_id": candidate.id,
                "repair_eligibility": eligibility,
                "final_repair_class": "project_repair_budget_exceeded",
                "repair_batch_count": applied,
                "reason": str(exc),
            }
        except ExperimentError as exc:
            return {
                "candidate_id": candidate.id,
                "repair_eligibility": eligibility,
                "final_repair_class": "apparatus_invalid",
                "repair_batch_count": applied,
                "reason": str(exc),
            }


def static_check(repo: Path) -> dict[str, Any]:
    freeze_hashes = validate_predeclaration(repo)
    validate_internal_source_baseline(repo)
    return {
        "status": "PASS",
        "baseline_commit": BASELINE_COMMIT,
        "predeclaration_head": PREDECLARATION_HEAD,
        "predeclaration_merge": PREDECLARATION_MERGE,
        "predeclaration_exact_head_run_job": [
            PREDECLARATION_EXACT_HEAD_RUN,
            PREDECLARATION_EXACT_HEAD_JOB,
        ],
        "predeclaration_postmerge_run_job": [
            PREDECLARATION_POSTMERGE_RUN,
            PREDECLARATION_POSTMERGE_JOB,
        ],
        "freeze_hashes": freeze_hashes,
        "candidate_ids": [candidate.id for candidate in CANDIDATES],
        "repair_budget": {
            "batches": MAX_REPAIR_BATCHES,
            "files": MAX_REPAIR_FILES,
            "line_churn": MAX_REPAIR_CHURN,
        },
        "frozen_headers": list(FROZEN_HEADERS),
        "immutable_regression_files": list(IMMUTABLE_REGRESSION_FILES),
    }


def select_candidates(selector: str) -> tuple[Candidate, ...]:
    if selector == "all":
        return CANDIDATES
    for candidate in CANDIDATES:
        if selector in {candidate.short, candidate.id}:
            return (candidate,)
    raise ExperimentError(f"unknown candidate selector: {selector}")


def markdown_summary(result: dict[str, Any]) -> str:
    lines = [
        "# Erdős #678 — S2e Upgrade Robustness Run",
        "",
        f"- generated: `{result['generated_at']}`",
        f"- phase: `{result['phase']}`",
        f"- workflow commit: `{result['provenance']['workflow_commit']}`",
        f"- apparatus commit: `{result['provenance']['apparatus_commit']}`",
        f"- baseline commit: `{BASELINE_COMMIT}`",
        "",
        "## Baseline",
        "",
        f"- status: `{result['baseline']['status']}`",
        f"- Lean: `{result['baseline']['lean']}`",
        f"- canonical baseline graph: `{result['baseline']['canonical_build_jobs']}` jobs",
        "",
        "## Candidates",
        "",
    ]
    for item in result.get("candidates", []):
        detection = item["detection"]
        lines.extend(
            [
                f"### {item['candidate_id']}",
                "",
                f"- full no-repair survivor: `{detection.get('full_no_repair_survivor')}`",
                f"- deepest green stage: `{detection.get('deepest_green_stage')}`",
                f"- primary failure owner: `{item.get('primary_failure_owner')}`",
                f"- repair eligibility: `{json.dumps(item['repair_eligibility'], sort_keys=True)}`",
            ]
        )
        if "repair" in item:
            lines.append(f"- final repair class: `{item['repair'].get('final_repair_class')}`")
            lines.append(f"- repair batches: `{item['repair'].get('repair_batch_count')}`")
        lines.append("")
    lines.extend(
        [
            "## Interpretation boundary",
            "",
            "These measurements apply only to the two frozen S2e candidates. A dependency-support "
            "blocker is a supply-chain/version-boundary observation, not a proof-quality defect. "
            "Timing is apparatus metadata only and is not an outcome metric.",
            "",
        ]
    )
    return "\n".join(lines)


def parse_plan_specs(specs: Sequence[str]) -> dict[str, Path]:
    plans: dict[str, Path] = {}
    for spec in specs:
        if "=" not in spec:
            raise ExperimentError("--repair-plan must use SHORT=PATH")
        short, raw = spec.split("=", 1)
        if short in plans:
            raise ExperimentError(f"duplicate repair plan for {short}")
        plans[short] = Path(raw).resolve()
    return plans


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", type=Path, default=Path("."))
    parser.add_argument("--output", type=Path, default=Path("s2e-upgrade-artifact"))
    parser.add_argument(
        "--phase", choices=("static-check", "detection", "repair"), default="static-check"
    )
    parser.add_argument("--candidate", default="all")
    parser.add_argument(
        "--repair-plan",
        action="append",
        default=[],
        metavar="SHORT=PATH",
        help="repair phase only; explicit JSON patch plan for a repair-eligible candidate",
    )
    args = parser.parse_args()

    repo = args.repo.resolve()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    try:
        if not (repo / ".git").exists():
            raise ExperimentError(f"not a Git checkout: {repo}")
        freeze = static_check(repo)
        write_json(output / "STATIC_CHECK.json", freeze)
        if args.phase == "static-check":
            print(json.dumps(freeze, indent=2, sort_keys=True))
            return 0

        selected = select_candidates(args.candidate)
        provenance = {
            "repository": "scientifica007/Erdos_Solving",
            "workflow_commit": git(repo, "rev-parse", "HEAD"),
            "apparatus_commit": apparatus_commit(repo),
            "baseline_commit": BASELINE_COMMIT,
            "predeclaration_head": PREDECLARATION_HEAD,
            "predeclaration_merge": PREDECLARATION_MERGE,
            "predeclaration_exact_head_run": PREDECLARATION_EXACT_HEAD_RUN,
            "predeclaration_exact_head_job": PREDECLARATION_EXACT_HEAD_JOB,
            "predeclaration_postmerge_run": PREDECLARATION_POSTMERGE_RUN,
            "predeclaration_postmerge_job": PREDECLARATION_POSTMERGE_JOB,
            "protocol_sha256": freeze["freeze_hashes"][PROTOCOL],
            "matrix_sha256": freeze["freeze_hashes"][MATRIX],
        }
        write_json(output / "PROVENANCE.json", provenance)

        temp_root = Path(tempfile.mkdtemp(prefix="erdos678-s2e-"))
        try:
            baseline = validate_baseline(repo, temp_root, output)
            candidate_results: list[dict[str, Any]] = []
            detections: dict[str, dict[str, Any]] = {}
            for candidate in selected:
                with baseline_worktree(
                    repo, temp_root, f"{candidate.short.lower()}-detection"
                ) as work:
                    candidate_dir = output / "candidates" / candidate.short / "detection"
                    setup_candidate(candidate, work, candidate_dir)
                    detection = run_detection(candidate, work, candidate_dir)
                detections[candidate.short] = detection
                candidate_results.append(
                    {
                        "candidate_id": candidate.id,
                        "detection": detection,
                        "primary_failure_owner": candidate_primary_owner(detection),
                        "repair_eligibility": repair_eligibility(detection),
                    }
                )

            if args.phase == "repair":
                plans = parse_plan_specs(args.repair_plan)
                for candidate, item in zip(selected, candidate_results, strict=True):
                    detection = detections[candidate.short]
                    eligibility = repair_eligibility(detection)
                    if detection.get("full_no_repair_survivor"):
                        item["repair"] = {
                            "candidate_id": candidate.id,
                            "final_repair_class": "not_needed",
                            "repair_batch_count": 0,
                        }
                    elif candidate.short in plans:
                        item["repair"] = run_repair(
                            candidate,
                            detection=detection,
                            plan_path=plans[candidate.short],
                            repo=repo,
                            temp_root=temp_root,
                            output=output,
                            baseline_headers=baseline["header_fingerprints"],
                            baseline_hashes=baseline["source_hashes"],
                        )
                    elif eligibility["dependency_support_blocked"] and not eligibility["mathlib_only"]:
                        item["repair"] = {
                            "candidate_id": candidate.id,
                            "final_repair_class": "dependency_support_blocked",
                            "repair_batch_count": 0,
                        }
                    else:
                        raise ExperimentError(
                            f"repair phase requires an explicit legal plan for {candidate.short}"
                        )

            result = {
                "schema_version": 1,
                "experiment": "erdos-678-s2e-upgrade-robustness",
                "generated_at": now_utc(),
                "phase": args.phase,
                "provenance": provenance,
                "baseline": baseline,
                "candidates": candidate_results,
                "scientific_limits": [
                    "no_general_maintainability_claim",
                    "no_human_repair_time_claim",
                    "no_architecture_superiority_claim",
                    "no_expected_future_upgrade_cost_claim",
                    "no_general_lean_mathlib_compatibility_claim",
                    "dependency_support_blocker_is_not_proof_quality_defect",
                    "timing_is_not_an_outcome_metric",
                ],
            }
            write_json(output / "result.json", result)
            (output / "SUMMARY.md").write_text(markdown_summary(result), encoding="utf-8")
            write_json(
                output / "scope_audit.json",
                {
                    "tracked_repository_diff_after_run": git(
                        repo, "status", "--porcelain", "--untracked-files=no"
                    ),
                    "candidate_changes_isolated_to_temporary_worktrees": True,
                    "third_party_source_repair_allowed": False,
                },
            )
            print(json.dumps(result, indent=2, sort_keys=True))
            return 0
        finally:
            shutil.rmtree(temp_root, ignore_errors=True)
    except (ExperimentError, subprocess.TimeoutExpired, OSError, ValueError, KeyError) as exc:
        failure = {
            "schema_version": 1,
            "experiment": "erdos-678-s2e-upgrade-robustness",
            "generated_at": now_utc(),
            "phase": args.phase,
            "status": "apparatus_invalid",
            "error": f"{type(exc).__name__}: {exc}",
        }
        write_json(output / "APPARATUS_FAILURE.json", failure)
        print(json.dumps(failure, indent=2, sort_keys=True), file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
