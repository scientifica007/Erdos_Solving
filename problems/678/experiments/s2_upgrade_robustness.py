#!/usr/bin/env python3
"""Fail-closed apparatus for the predeclared Erdős #678 S2e upgrade experiment.

The program implements the frozen S2e contract. It never chooses upgrade
candidates, edits third-party source, or invents repairs. Detection always runs
first on pristine temporary worktrees. Optional repair runs consume an explicit
patch plan and enforce the frozen project scope, semantic-header fingerprints,
immutable regression files, and cumulative repair budgets.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
from pathlib import Path
from typing import Any, Callable, Iterable, Sequence

BASELINE_COMMIT = "5039d464f6196e6b47494f0a6fae869e3362d082"
PREDECLARATION_HEAD = "c733ac4baae1a53b20d2e395eaab5c938683a74a"
PREDECLARATION_MERGE = "0fcefd7ea8cb3753a80a3f93c2498841b1938e55"
PREDECLARATION_EXACT_HEAD_RUN = 32105032799
PREDECLARATION_EXACT_HEAD_JOB = 95612654549
PREDECLARATION_POSTMERGE_RUN = 32105520785
PREDECLARATION_POSTMERGE_JOB = 95614030394

BASELINE_TOOLCHAIN = "leanprover/lean4:v4.33.0"
CANDIDATE_TOOLCHAIN = "leanprover/lean4:v4.34.0-rc1"
BASELINE_MATHLIB_INPUT = "v4.33.0"
BASELINE_MATHLIB_RESOLVED = "db584cd6d46c92f209a44c0f1c829460d327499d"
U2_MATHLIB_COMMIT = "de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11"
U2_MATHLIB_TAG = "v4.34.0-rc1"
PNT_COMMIT = "2667e414c38e5a5dc9aa1946f16f13001e5cd3ed"
EXPECTED_BASELINE_BUILD_JOBS = 8808

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
NETWORK_RE = re.compile(
    r"(could not resolve host|failed to connect|connection (?:timed out|reset)|"
    r"operation timed out|temporary failure in name resolution|tls|ssl connect error|"
    r"remote end hung up|unexpected eof|http/2 stream|curl:\s*\(\d+\)|"
    r"the requested url returned error:\s*5\d\d)",
    re.IGNORECASE,
)
LEAN_VERSION_RE = re.compile(r"Lean \(version ([^,]+)")
DIAGNOSTIC_PATH_RE = re.compile(
    r"(?P<path>(?:\.{0,2}/)?[A-Za-z0-9_./+\-]+\.lean)"
    r"(?::(?P<line>\d+):(?P<col>\d+))?"
)
DECL_RE = re.compile(
    r"(?m)^[ \t]*(?:protected[ \t]+|private[ \t]+|noncomputable[ \t]+)*"
    r"(?:theorem|lemma|def|abbrev|opaque|axiom)[ \t]+(?P<name>[A-Za-z0-9_'.]+)"
)
PATCH_PATH_RE = re.compile(r"^(?:---|\+\+\+) (?:a/|b/)?(.+)$", re.MULTILINE)


class ExperimentError(RuntimeError):
    """Fail-closed apparatus/provenance error."""


@dataclasses.dataclass(frozen=True)
class Candidate:
    id: str
    short: str
    toolchain: str
    mathlib_mode: str


CANDIDATES = (
    Candidate(
        "U1-lean-4.34.0-rc1-compiler-only",
        "U1",
        CANDIDATE_TOOLCHAIN,
        "baseline-locked",
    ),
    Candidate(
        "U2-lean-mathlib-4.34.0-rc1-root-upgrade",
        "U2",
        CANDIDATE_TOOLCHAIN,
        "exact-candidate-commit",
    ),
)


def now_utc() -> str:
    import datetime as dt

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
    env: dict[str, str] | None = None,
) -> subprocess.CompletedProcess[str]:
    merged = os.environ.copy()
    if env:
        merged.update(env)
    return subprocess.run(
        list(cmd),
        cwd=cwd,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
        timeout=timeout,
        env=merged,
    )


def checked(
    cmd: Sequence[str],
    *,
    cwd: Path,
    timeout: int | None = None,
    env: dict[str, str] | None = None,
) -> str:
    proc = run(cmd, cwd=cwd, timeout=timeout, env=env)
    if proc.returncode != 0:
        raise ExperimentError(
            f"command failed ({proc.returncode}): {' '.join(cmd)}\n{proc.stdout or ''}"
        )
    return proc.stdout or ""


def git(repo: Path, *args: str) -> str:
    return checked(["git", *args], cwd=repo).strip()


def ensure_commit(repo: Path, commit: str) -> None:
    probe = run(["git", "cat-file", "-e", f"{commit}^{{commit}}"], cwd=repo)
    if probe.returncode == 0:
        return
    fetch = run(["git", "fetch", "--no-tags", "origin", commit], cwd=repo, timeout=180)
    if fetch.returncode != 0:
        raise ExperimentError(f"cannot materialize frozen commit {commit}:\n{fetch.stdout}")
    checked(["git", "cat-file", "-e", f"{commit}^{{commit}}"], cwd=repo)


def apparatus_commit(repo: Path) -> str:
    return checked(["git", "log", "-1", "--format=%H", "--", APPARATUS], cwd=repo).strip()


def _runner_version_from_proc() -> str | None:
    version_re = re.compile(r"(?:^|/)(\d+\.\d+\.\d+)(?:/|$)")
    try:
        pids = [p for p in Path("/proc").iterdir() if p.name.isdigit()]
    except OSError:
        return None
    for pid in pids:
        candidates: list[str] = []
        try:
            candidates.append(os.readlink(pid / "exe"))
        except OSError:
            pass
        try:
            raw = (pid / "cmdline").read_bytes().replace(b"\x00", b" ")
            candidates.append(raw.decode("utf-8", errors="replace"))
        except OSError:
            pass
        for text in candidates:
            if "Runner.Worker" not in text and "/runners/" not in text:
                continue
            match = version_re.search(text)
            if match:
                return match.group(1)
    return None


def runner_version() -> str:
    env_value = os.getenv("ACTIONS_RUNNER_VERSION") or os.getenv("S2E_RUNNER_VERSION")
    if env_value and re.fullmatch(r"\d+\.\d+\.\d+", env_value.strip()):
        return env_value.strip()
    proc_value = _runner_version_from_proc()
    if proc_value:
        return proc_value
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
        "runner_os": os.getenv("RUNNER_OS", "unknown"),
        "runner_arch": os.getenv("RUNNER_ARCH", "unknown"),
        "runner_name": os.getenv("RUNNER_NAME", "unknown"),
        "runner_environment": os.getenv("RUNNER_ENVIRONMENT", "unknown"),
        "runner_version": version,
        "image_os": image_os,
        "image_version": image_version,
        "cpu_count": os.cpu_count(),
        "uname": subprocess.check_output(["uname", "-a"], text=True).strip(),
    }


def validate_predeclaration(repo: Path) -> dict[str, str]:
    ensure_commit(repo, PREDECLARATION_MERGE)
    result: dict[str, str] = {}
    for rel in (PROTOCOL, MATRIX):
        current = (repo / rel).read_bytes()
        frozen = subprocess.check_output(
            ["git", "show", f"{PREDECLARATION_MERGE}:{rel}"], cwd=repo
        )
        if current != frozen:
            raise ExperimentError(f"predeclared artifact changed after integration: {rel}")
        result[rel] = sha256_bytes(current)
    text = (repo / MATRIX).read_text(encoding="utf-8")
    required_literals = (
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
    missing = [item for item in required_literals if item not in text]
    if missing:
        raise ExperimentError(f"matrix/constant contract mismatch: missing {missing}")
    return result


def validate_internal_source_baseline(repo: Path) -> None:
    ensure_commit(repo, BASELINE_COMMIT)
    paths = (
        "formalization/Formalization/Erdos678",
        "formalization/Formalization.lean",
        "formalization/lakefile.toml",
        "formalization/lake-manifest.json",
        "formalization/lean-toolchain",
    )
    proc = run(["git", "diff", "--quiet", BASELINE_COMMIT, "--", *paths], cwd=repo)
    if proc.returncode != 0:
        detail = checked(["git", "diff", "--stat", BASELINE_COMMIT, "--", *paths], cwd=repo)
        raise ExperimentError(
            "current proof/dependency source differs from frozen S2e baseline:\n" + detail
        )


def parse_lean_version(formalization: Path) -> str:
    text = checked(["lean", "--version"], cwd=formalization, timeout=180)
    match = LEAN_VERSION_RE.search(text)
    if not match:
        raise ExperimentError(f"could not parse Lean version:\n{text}")
    return match.group(1)


def manifest_packages(formalization: Path) -> dict[str, dict[str, Any]]:
    data = json.loads((formalization / "lake-manifest.json").read_text(encoding="utf-8"))
    return {item["name"]: item for item in data["packages"]}


def package_identities(formalization: Path) -> dict[str, str]:
    packages = manifest_packages(formalization)
    mathlib = packages["mathlib"]
    pnt = packages["PrimeNumberTheoremAnd"]
    return {
        "mathlib_input": str(mathlib.get("inputRev", "")),
        "mathlib_resolved": str(mathlib.get("rev", "")),
        "pnt_resolved": str(pnt.get("rev", "")),
    }


def code_mask(text: str) -> str:
    """Blank Lean comments/strings while preserving offsets and newlines."""
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
    root = project_root / "formalization" / "Formalization" / "Erdos678"
    for path in sorted(root.rglob("*.lean")):
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
    result: dict[str, str] = {}
    for rel in BASELINE_HASH_PATHS:
        path = project_root / rel
        if not path.is_file():
            raise ExperimentError(f"required baseline file missing: {rel}")
        result[rel] = sha256_file(path)
    return result


def write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


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
    for attempt in range(network_retries + 1):
        started = time.monotonic()
        proc = run(cmd, cwd=cwd, timeout=timeout)
        elapsed = time.monotonic() - started
        output = proc.stdout or ""
        is_network = bool(proc.returncode and NETWORK_RE.search(output))
        attempts.append(
            {
                "attempt": attempt + 1,
                "returncode": proc.returncode,
                "duration_seconds": elapsed,
                "network_failure": is_network,
            }
        )
        with log_path.open("a", encoding="utf-8") as handle:
            handle.write(
                f"\n===== attempt {attempt + 1}: {' '.join(cmd)} =====\n"
                f"returncode={proc.returncode} duration_seconds={elapsed:.3f}\n"
            )
            handle.write(output)
            if output and not output.endswith("\n"):
                handle.write("\n")
        if proc.returncode == 0:
            return {"returncode": 0, "output": output, "attempts": attempts}
        if not is_network or attempt >= network_retries:
            return {"returncode": proc.returncode, "output": output, "attempts": attempts}
        time.sleep(3 * (attempt + 1))
    raise AssertionError("unreachable")


def normalize_diag_path(path: str) -> str:
    while path.startswith("./"):
        path = path[2:]
    return path


def owner_for_path(path: str) -> str:
    norm = normalize_diag_path(path)
    if ".lake/packages/PrimeNumberTheoremAnd/" in norm:
        return "pnt_dependency_support"
    if ".lake/packages/" in norm:
        return "mathlib_or_transitive_dependency"
    if norm.startswith("Formalization/") or norm.startswith("formalization/Formalization/"):
        return "project_owned"
    return "ambiguous"


def declaration_at_line(path: Path, line: int | None) -> str | None:
    if line is None or not path.is_file():
        return None
    text = path.read_text(encoding="utf-8", errors="replace")
    masked = code_mask(text)
    offset = len(masked)
    current_line = 1
    for idx, ch in enumerate(masked):
        if current_line >= line:
            offset = idx
            break
        if ch == "\n":
            current_line += 1
    last: re.Match[str] | None = None
    for match in DECL_RE.finditer(masked):
        if match.start() > offset:
            break
        last = match
    return last.group("name") if last else None


def diagnose_failure(
    output: str,
    *,
    formalization: Path,
    default_owner: str = "ambiguous",
) -> dict[str, Any]:
    for match in DIAGNOSTIC_PATH_RE.finditer(output):
        raw = normalize_diag_path(match.group("path"))
        owner = owner_for_path(raw)
        if owner == "ambiguous":
            continue
        line = int(match.group("line")) if match.group("line") else None
        local = formalization / raw
        if raw.startswith("formalization/"):
            local = formalization.parent / raw
        declaration = declaration_at_line(local, line)
        begin = max(0, match.start() - 180)
        end = min(len(output), match.end() + 320)
        return {
            "owner": owner,
            "file": raw,
            "line": line,
            "declaration": declaration,
            "diagnostic_excerpt": output[begin:end].strip(),
        }
    lower = output.lower()
    if "toolchain" in lower or "lean version" in lower or "unknown release" in lower:
        default_owner = "lean_toolchain"
    return {
        "owner": default_owner,
        "file": None,
        "line": None,
        "declaration": None,
        "diagnostic_excerpt": output[-1200:].strip(),
    }


def stage(
    stage_id: str,
    cmd: Sequence[str],
    *,
    formalization: Path,
    log_path: Path,
    default_owner: str = "ambiguous",
    timeout: int = 1800,
) -> dict[str, Any]:
    result = command_with_log(cmd, cwd=formalization, log_path=log_path, timeout=timeout)
    out: dict[str, Any] = {
        "stage": stage_id,
        "command": list(cmd),
        "status": "green" if result["returncode"] == 0 else "failed",
        "returncode": result["returncode"],
        "attempts": result["attempts"],
    }
    if result["returncode"] != 0:
        out["failure"] = diagnose_failure(
            result["output"], formalization=formalization, default_owner=default_owner
        )
    return out


def make_worktree(repo: Path, root: Path, name: str) -> Path:
    ensure_commit(repo, BASELINE_COMMIT)
    work = root / name
    if work.exists():
        shutil.rmtree(work)
    checked(["git", "worktree", "add", "--detach", str(work), BASELINE_COMMIT], cwd=repo)
    return work


def remove_worktree(repo: Path, work: Path) -> None:
    run(["git", "worktree", "remove", "--force", str(work)], cwd=repo)
    if work.exists():
        shutil.rmtree(work, ignore_errors=True)


def validate_baseline(repo: Path, temp_root: Path, output: Path) -> dict[str, Any]:
    work = make_worktree(repo, temp_root, "baseline")
    try:
        formalization = work / "formalization"
        toolchain = (formalization / "lean-toolchain").read_text(encoding="utf-8").strip()
        if toolchain != BASELINE_TOOLCHAIN:
            raise ExperimentError(f"baseline lean-toolchain mismatch: {toolchain}")
        ids = package_identities(formalization)
        expected = {
            "mathlib_input": BASELINE_MATHLIB_INPUT,
            "mathlib_resolved": BASELINE_MATHLIB_RESOLVED,
            "pnt_resolved": PNT_COMMIT,
        }
        if ids != expected:
            raise ExperimentError(f"baseline manifest identity mismatch: {ids} != {expected}")
        version = parse_lean_version(formalization)
        if version != "4.33.0":
            raise ExperimentError(f"baseline Lean version mismatch: {version}")
        hashes = baseline_file_hashes(work)
        headers = declaration_headers(work)
        write_json(output / "baseline" / "source_hashes.json", hashes)
        write_json(output / "baseline" / "header_fingerprints.json", headers)
        write_json(
            output / "baseline" / "environment.json",
            {"lean": version, **ids, **runner_metadata(strict=True)},
        )
        mk = command_with_log(
            ["lake", "exe", "mk_all", "--check"],
            cwd=formalization,
            log_path=output / "baseline" / "mk_all.log",
            timeout=1800,
        )
        if mk["returncode"] != 0 or "No update necessary" not in mk["output"]:
            raise ExperimentError("baseline mk_all --check failed or lacked 'No update necessary'")
        build = command_with_log(
            ["lake", "build", "Formalization"],
            cwd=formalization,
            log_path=output / "baseline" / "build.log",
            timeout=2400,
        )
        marker = f"Build completed successfully ({EXPECTED_BASELINE_BUILD_JOBS} jobs)."
        if build["returncode"] != 0 or marker not in build["output"]:
            raise ExperimentError(f"baseline full build failed or lacked marker: {marker}")
        return {
            "status": "green",
            "lean": version,
            **ids,
            "source_hashes": hashes,
            "header_fingerprints": headers,
            "mk_all_marker": "No update necessary",
            "canonical_build_jobs": EXPECTED_BASELINE_BUILD_JOBS,
        }
    finally:
        remove_worktree(repo, work)


def candidate_config_hashes(formalization: Path) -> dict[str, str]:
    return {
        "lean_toolchain": sha256_file(formalization / "lean-toolchain"),
        "lakefile": sha256_file(formalization / "lakefile.toml"),
        "manifest": sha256_file(formalization / "lake-manifest.json"),
    }


def setup_candidate(
    candidate: Candidate,
    *,
    repo: Path,
    temp_root: Path,
    output: Path,
    suffix: str,
) -> Path:
    work = make_worktree(repo, temp_root, f"{candidate.short.lower()}-{suffix}")
    formalization = work / "formalization"
    baseline_lakefile = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:formalization/lakefile.toml"], cwd=repo
    )
    baseline_manifest = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:formalization/lake-manifest.json"], cwd=repo
    )
    (formalization / "lean-toolchain").write_text(CANDIDATE_TOOLCHAIN + "\n", encoding="utf-8")
    if candidate.short == "U1":
        if (formalization / "lakefile.toml").read_bytes() != baseline_lakefile:
            raise ExperimentError("U1 lakefile changed before execution")
        if (formalization / "lake-manifest.json").read_bytes() != baseline_manifest:
            raise ExperimentError("U1 manifest changed before execution")
    elif candidate.short == "U2":
        lakefile = (formalization / "lakefile.toml").read_text(encoding="utf-8")
        old = 'rev = "v4.33.0"'
        new = f'rev = "{U2_MATHLIB_COMMIT}"'
        if lakefile.count(old) != 1:
            raise ExperimentError("U2 could not uniquely locate root Mathlib revision")
        (formalization / "lakefile.toml").write_text(
            lakefile.replace(old, new, 1), encoding="utf-8"
        )
    else:
        raise ExperimentError(f"unknown candidate: {candidate.short}")
    cfg_dir = output / "candidates" / candidate.short / suffix
    cfg_dir.mkdir(parents=True, exist_ok=True)
    diff = checked(
        ["git", "diff", "--", "formalization/lean-toolchain", "formalization/lakefile.toml"],
        cwd=work,
    )
    (cfg_dir / "setup.diff").write_text(diff, encoding="utf-8")
    return work


def candidate_d0(candidate: Candidate, work: Path, output: Path, suffix: str) -> dict[str, Any]:
    formalization = work / "formalization"
    cfg_dir = output / "candidates" / candidate.short / suffix
    result: dict[str, Any] = {"stage": "D0", "status": "green", "candidate_id": candidate.id}
    try:
        actual = (formalization / "lean-toolchain").read_text(encoding="utf-8").strip()
        if actual != CANDIDATE_TOOLCHAIN:
            raise ExperimentError(f"candidate toolchain mismatch: {actual}")
        lean = parse_lean_version(formalization)
        if lean != "4.34.0-rc1":
            raise ExperimentError(f"candidate Lean mismatch: {lean}")
        source = git(work, "rev-parse", "HEAD")
        if source != BASELINE_COMMIT:
            raise ExperimentError(f"candidate source checkout mismatch: {source}")
        result.update(
            {
                "lean": lean,
                "source_commit": source,
                "runner": runner_metadata(strict=True),
            }
        )
    except Exception as exc:
        result["status"] = "failed"
        result["failure"] = {
            "owner": "apparatus_or_provenance",
            "diagnostic_excerpt": str(exc),
        }
    write_json(cfg_dir / "D0.json", result)
    return result


def candidate_d1(candidate: Candidate, work: Path, output: Path, suffix: str) -> dict[str, Any]:
    formalization = work / "formalization"
    cfg_dir = output / "candidates" / candidate.short / suffix
    baseline_manifest = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:formalization/lake-manifest.json"], cwd=work
    )
    result: dict[str, Any] = {"stage": "D1", "status": "green"}
    try:
        if candidate.short == "U1":
            if (formalization / "lake-manifest.json").read_bytes() != baseline_manifest:
                raise ExperimentError("U1 manifest changed; lake update is forbidden")
            ids = package_identities(formalization)
            expected = {
                "mathlib_input": BASELINE_MATHLIB_INPUT,
                "mathlib_resolved": BASELINE_MATHLIB_RESOLVED,
                "pnt_resolved": PNT_COMMIT,
            }
            if ids != expected:
                raise ExperimentError(f"U1 package identities mismatch: {ids} != {expected}")
            (cfg_dir / "D1.log").write_text(
                "U1 manifest byte-identical to baseline; no lake update executed.\n",
                encoding="utf-8",
            )
        else:
            update = command_with_log(
                ["lake", "update", "mathlib"],
                cwd=formalization,
                log_path=cfg_dir / "D1.log",
                timeout=1800,
            )
            if update["returncode"] != 0:
                raise ExperimentError("U2 lake update mathlib failed; see D1.log")
            ids = package_identities(formalization)
            if ids["mathlib_input"] != U2_MATHLIB_COMMIT:
                raise ExperimentError(f"U2 Mathlib input mismatch: {ids['mathlib_input']}")
            if ids["mathlib_resolved"] != U2_MATHLIB_COMMIT:
                raise ExperimentError(f"U2 Mathlib resolution mismatch: {ids['mathlib_resolved']}")
            if ids["pnt_resolved"] != PNT_COMMIT:
                raise ExperimentError(f"U2 PNT revision drift: {ids['pnt_resolved']}")
            manifest_diff = checked(
                ["git", "diff", "--", "formalization/lake-manifest.json"], cwd=work
            )
            (cfg_dir / "manifest.diff").write_text(manifest_diff, encoding="utf-8")
        result["identities"] = ids
        result["configuration_hashes"] = candidate_config_hashes(formalization)
    except Exception as exc:
        result["status"] = "failed"
        result["failure"] = {
            "owner": "package_resolution",
            "diagnostic_excerpt": str(exc),
        }
    write_json(cfg_dir / "D1.json", result)
    return result


def run_detection_stages(candidate: Candidate, work: Path, output: Path, suffix: str) -> dict[str, Any]:
    formalization = work / "formalization"
    cfg_dir = output / "candidates" / candidate.short / suffix
    d0 = candidate_d0(candidate, work, output, suffix)
    if d0["status"] != "green":
        return {
            "candidate_id": candidate.id,
            "D0": d0,
            "D1": {"stage": "D1", "status": "not_applicable"},
            "D2": [],
            "D3": {"stage": "D3", "status": "not_applicable"},
            "D4": {"stage": "D4", "status": "not_applicable"},
            "D5": {"stage": "D5", "status": "not_applicable"},
            "D6": {"stage": "D6", "status": "not_applicable"},
            "full_no_repair_survivor": False,
            "deepest_green_stage": None,
        }
    d1 = candidate_d1(candidate, work, output, suffix)
    if d1["status"] != "green":
        return {
            "candidate_id": candidate.id,
            "D0": d0,
            "D1": d1,
            "D2": [],
            "D3": {"stage": "D3", "status": "not_applicable"},
            "D4": {"stage": "D4", "status": "not_applicable"},
            "D5": {"stage": "D5", "status": "not_applicable"},
            "D6": {"stage": "D6", "status": "not_applicable"},
            "full_no_repair_survivor": False,
            "deepest_green_stage": "D0",
        }
    d2: list[dict[str, Any]] = []
    for target in D2_TARGETS:
        d2.append(
            stage(
                f"D2:{target}",
                ["lake", "build", target],
                formalization=formalization,
                log_path=cfg_dir / f"D2_{target.split('.')[-1]}.log",
            )
        )
    d3 = stage(
        "D3",
        ["lake", "build", D3_TARGET],
        formalization=formalization,
        log_path=cfg_dir / "D3_PNT.log",
        default_owner="pnt_dependency_support",
    )
    if d3["status"] == "green":
        d4 = stage(
            "D4",
            ["lake", "build", D4_TARGET],
            formalization=formalization,
            log_path=cfg_dir / "D4_project_PNT_boundary.log",
        )
        d5 = stage(
            "D5",
            ["lake", "build", D5_TARGET],
            formalization=formalization,
            log_path=cfg_dir / "D5_final.log",
        )
    else:
        d4 = {"stage": "D4", "status": "not_applicable", "reason": "D3-not-green"}
        d5 = {"stage": "D5", "status": "not_applicable", "reason": "D3-not-green"}
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
            log_path=cfg_dir / "D6_mk_all.log",
        )
        if mk["status"] == "green":
            text = (cfg_dir / "D6_mk_all.log").read_text(encoding="utf-8")
            if "No update necessary" not in text:
                mk["status"] = "failed"
                mk["failure"] = {
                    "owner": "apparatus_or_provenance",
                    "diagnostic_excerpt": "mk_all succeeded but lacked 'No update necessary'",
                }
        build = (
            stage(
                "D6:full_build",
                ["lake", "build", "Formalization"],
                formalization=formalization,
                log_path=cfg_dir / "D6_full_build.log",
                timeout=2400,
            )
            if mk["status"] == "green"
            else {"stage": "D6:full_build", "status": "not_applicable", "reason": "mk_all-not-green"}
        )
        d6 = {
            "stage": "D6",
            "status": "green" if build["status"] == "green" else "failed",
            "mk_all": mk,
            "full_build": build,
        }
    else:
        d6 = {
            "stage": "D6",
            "status": "not_applicable",
            "reason": "required-prior-stages-not-all-green",
        }
    status_pairs = [
        ("D0", d0["status"] == "green"),
        ("D1", d1["status"] == "green"),
        ("D2", all(item["status"] == "green" for item in d2)),
        ("D3", d3["status"] == "green"),
        ("D4", d4["status"] == "green"),
        ("D5", d5["status"] == "green"),
        ("D6", d6["status"] == "green"),
    ]
    attempted_green = [name for name, green in status_pairs if green]
    result = {
        "candidate_id": candidate.id,
        "D0": d0,
        "D1": d1,
        "D2": d2,
        "D3": d3,
        "D4": d4,
        "D5": d5,
        "D6": d6,
        "full_no_repair_survivor": all(green for _, green in status_pairs),
        "deepest_green_stage": attempted_green[-1] if attempted_green else None,
    }
    write_json(cfg_dir / "detection.json", result)
    return result


def repair_eligibility(detection: dict[str, Any]) -> dict[str, Any]:
    d2_failures = [x for x in detection.get("D2", []) if x.get("status") == "failed"]
    mathlib_only = (
        detection.get("D0", {}).get("status") == "green"
        and detection.get("D1", {}).get("status") == "green"
        and any(x.get("failure", {}).get("owner") == "project_owned" for x in d2_failures)
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


def project_diff_stats(work: Path) -> dict[str, Any]:
    scope = (
        "formalization/Formalization/Erdos678",
        "formalization/Formalization.lean",
    )
    names = [
        line.strip()
        for line in checked(["git", "diff", "HEAD", "--name-only", "--", *scope], cwd=work).splitlines()
        if line.strip()
    ]
    numstat = checked(["git", "diff", "HEAD", "--numstat", "--", *scope], cwd=work)
    additions = deletions = 0
    files: list[dict[str, Any]] = []
    for line in numstat.splitlines():
        if not line.strip():
            continue
        add_s, del_s, path = line.split("\t", 2)
        if add_s == "-" or del_s == "-":
            raise ExperimentError(f"binary/full-file repair is forbidden: {path}")
        add = int(add_s)
        delete = int(del_s)
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


def allowed_repair_path(path: str) -> bool:
    if path == "formalization/Formalization.lean":
        return True
    prefix = "formalization/Formalization/Erdos678/"
    return path.startswith(prefix) and path.endswith(".lean")


def patch_paths(patch: str) -> list[str]:
    result: list[str] = []
    for match in PATCH_PATH_RE.finditer(patch):
        value = match.group(1).strip()
        if value == "/dev/null":
            continue
        if value not in result:
            result.append(value)
    return result


def validate_root_import_only(repo: Path, work: Path) -> None:
    rel = "formalization/Formalization.lean"
    current = (work / rel).read_text(encoding="utf-8")
    baseline = subprocess.check_output(
        ["git", "show", f"{BASELINE_COMMIT}:{rel}"], cwd=repo, text=True
    )

    def non_import_lines(text: str) -> list[str]:
        return [line for line in text.splitlines() if not line.lstrip().startswith("import ")]

    if non_import_lines(current) != non_import_lines(baseline):
        raise ExperimentError("Formalization.lean repair changed non-import content")


def dependency_source_diffs(formalization: Path) -> list[str]:
    packages = formalization / ".lake" / "packages"
    if not packages.is_dir():
        return []
    dirty: list[str] = []
    for child in sorted(packages.iterdir()):
        if not (child / ".git").exists():
            continue
        proc = run(["git", "status", "--porcelain", "--untracked-files=no"], cwd=child)
        if proc.returncode == 0 and (proc.stdout or "").strip():
            dirty.append(child.name)
    return dirty


def validate_repair_invariants(
    repo: Path,
    work: Path,
    *,
    baseline_headers: dict[str, dict[str, str]],
    baseline_hashes: dict[str, str],
    expected_config_hashes: dict[str, str],
    batch_count: int,
) -> dict[str, Any]:
    formalization = work / "formalization"
    if candidate_config_hashes(formalization) != expected_config_hashes:
        raise ExperimentError("candidate toolchain/lakefile/manifest changed during repair")
    stats = project_diff_stats(work)
    forbidden = [p for p in stats["names"] if not allowed_repair_path(p)]
    immutable = [p for p in stats["names"] if p in IMMUTABLE_REGRESSION_FILES]
    if forbidden:
        raise ExperimentError(f"repair touched forbidden paths: {forbidden}")
    if immutable:
        raise ExperimentError(f"repair touched immutable regression files: {immutable}")
    if len(set(stats["names"])) > MAX_REPAIR_FILES:
        raise ExperimentError("project repair file budget exceeded")
    if stats["churn"] > MAX_REPAIR_CHURN:
        raise ExperimentError("project repair line-churn budget exceeded")
    if batch_count > MAX_REPAIR_BATCHES:
        raise ExperimentError("repair batch budget exceeded")
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
    immutable_hash_changes = [
        rel for rel in IMMUTABLE_REGRESSION_FILES if sha256_file(work / rel) != baseline_hashes[rel]
    ]
    if immutable_hash_changes:
        raise ExperimentError(f"immutable regression hash changed: {immutable_hash_changes}")
    dirty_dependencies = dependency_source_diffs(formalization)
    if dirty_dependencies:
        raise ExperimentError(f"third-party package source was modified: {dirty_dependencies}")
    return {
        **stats,
        "batch_count": batch_count,
        "immutable_regression_files_touched": [],
        "semantic_header_fingerprint_changes": [],
        "third_party_source_files_touched": [],
        "header_fingerprints": current_headers,
    }


def apply_patch_batch(
    repo: Path,
    work: Path,
    patch_path: Path,
    *,
    baseline_headers: dict[str, dict[str, str]],
    baseline_hashes: dict[str, str],
    expected_config_hashes: dict[str, str],
    batch_count: int,
    out_dir: Path,
) -> dict[str, Any]:
    patch = patch_path.read_text(encoding="utf-8")
    if not patch.strip():
        raise ExperimentError(f"empty repair patch: {patch_path}")
    paths = patch_paths(patch)
    if not paths or any(not allowed_repair_path(path) for path in paths):
        raise ExperimentError(f"repair patch has forbidden path(s): {paths}")
    if any(path in IMMUTABLE_REGRESSION_FILES for path in paths):
        raise ExperimentError(f"repair patch targets immutable regression file: {paths}")
    check = run(["git", "apply", "--check", "--index", str(patch_path)], cwd=work)
    if check.returncode != 0:
        raise ExperimentError(f"repair patch does not apply: {patch_path}\n{check.stdout}")
    checked(["git", "apply", "--index", str(patch_path)], cwd=work)
    audit = validate_repair_invariants(
        repo,
        work,
        baseline_headers=baseline_headers,
        baseline_hashes=baseline_hashes,
        expected_config_hashes=expected_config_hashes,
        batch_count=batch_count,
    )
    out_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(patch_path, out_dir / f"batch_{batch_count:02d}.patch")
    diff = checked(
        ["git", "diff", "HEAD", "--", "formalization/Formalization/Erdos678", "formalization/Formalization.lean"],
        cwd=work,
    )
    (out_dir / f"batch_{batch_count:02d}_cumulative.diff").write_text(diff, encoding="utf-8")
    write_json(out_dir / f"batch_{batch_count:02d}_audit.json", audit)
    return audit


def load_repair_plan(path: Path, candidate: Candidate) -> list[dict[str, Any]]:
    data = json.loads(path.read_text(encoding="utf-8"))
    if data.get("candidate_id") != candidate.id:
        raise ExperimentError(
            f"repair plan candidate mismatch: {data.get('candidate_id')} != {candidate.id}"
        )
    batches = data.get("batches")
    if not isinstance(batches, list):
        raise ExperimentError("repair plan must contain a batches list")
    for index, item in enumerate(batches, start=1):
        if not isinstance(item, dict):
            raise ExperimentError(f"repair batch {index} is not an object")
        if item.get("trigger_stage") not in {"D2", "D4", "D5", "D6"}:
            raise ExperimentError(f"repair batch {index} has invalid trigger_stage")
        if not isinstance(item.get("patch"), str):
            raise ExperimentError(f"repair batch {index} lacks patch path")
    if len(batches) > MAX_REPAIR_BATCHES:
        raise ExperimentError("repair plan exceeds frozen batch budget")
    return batches


def run_targets(
    targets: Iterable[tuple[str, Sequence[str]]],
    *,
    formalization: Path,
    out_dir: Path,
    label: str,
) -> list[dict[str, Any]]:
    results: list[dict[str, Any]] = []
    for stage_id, cmd in targets:
        safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", stage_id)
        results.append(
            stage(
                stage_id,
                cmd,
                formalization=formalization,
                log_path=out_dir / f"{label}_{safe}.log",
            )
        )
    return results


def final_class_for_owner(owner: str | None) -> str:
    if owner in {"pnt_dependency_support", "mathlib_or_transitive_dependency"}:
        return "dependency_support_blocked"
    return "apparatus_invalid"


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
    batches = load_repair_plan(plan_path, candidate)
    work = setup_candidate(
        candidate, repo=repo, temp_root=temp_root, output=output, suffix="repair"
    )
    formalization = work / "formalization"
    out_dir = output / "candidates" / candidate.short / "repair"
    applied = 0
    consumed: set[int] = set()
    previously_green: list[tuple[str, Sequence[str]]] = []

    def next_batch(trigger: str) -> tuple[int, dict[str, Any]] | None:
        for idx, item in enumerate(batches):
            if idx not in consumed and item["trigger_stage"] == trigger:
                return idx, item
        return None

    def apply_one(trigger: str, expected_config_hashes: dict[str, str]) -> None:
        nonlocal applied
        selected = next_batch(trigger)
        if selected is None:
            raise ExperimentError(f"no remaining repair batch for {trigger}")
        idx, item = selected
        patch = (plan_path.parent / item["patch"]).resolve()
        applied += 1
        apply_patch_batch(
            repo,
            work,
            patch,
            baseline_headers=baseline_headers,
            baseline_hashes=baseline_hashes,
            expected_config_hashes=expected_config_hashes,
            batch_count=applied,
            out_dir=out_dir,
        )
        consumed.add(idx)
        regressions = run_targets(
            previously_green,
            formalization=formalization,
            out_dir=out_dir,
            label=f"batch_{applied:02d}_regression",
        )
        failed = [x for x in regressions if x["status"] != "green"]
        if failed:
            raise ExperimentError(
                f"repair batch {applied} broke previously green target(s): "
                f"{[x['stage'] for x in failed]}"
            )

    try:
        d0 = candidate_d0(candidate, work, output, "repair")
        d1 = candidate_d1(candidate, work, output, "repair")
        if d0["status"] != "green" or d1["status"] != "green":
            return {
                "candidate_id": candidate.id,
                "repair_eligibility": eligibility,
                "final_repair_class": "apparatus_invalid",
                "repair_batch_count": 0,
                "reason": "repair pristine candidate failed D0/D1",
            }
        expected_config_hashes = d1["configuration_hashes"]

        def d2_group(label: str) -> list[dict[str, Any]]:
            return run_targets(
                [(f"D2:{t}", ["lake", "build", t]) for t in D2_TARGETS],
                formalization=formalization,
                out_dir=out_dir,
                label=label,
            )

        d2 = d2_group("D2_initial")
        while any(x["status"] != "green" for x in d2):
            failed = [x for x in d2 if x["status"] != "green"]
            owners = {x.get("failure", {}).get("owner") for x in failed}
            if owners != {"project_owned"}:
                return {
                    "candidate_id": candidate.id,
                    "repair_eligibility": eligibility,
                    "final_repair_class": final_class_for_owner(next(iter(owners), None)),
                    "repair_batch_count": applied,
                    "D2": d2,
                }
            if not eligibility["mathlib_only"]:
                raise ExperimentError("D2 repair attempted without frozen eligibility")
            if next_batch("D2") is None:
                return {
                    "candidate_id": candidate.id,
                    "repair_eligibility": eligibility,
                    "final_repair_class": "project_repair_budget_exceeded",
                    "repair_batch_count": applied,
                    "reason": "D2 remains project-broken with no legal preplanned batch",
                }
            apply_one("D2", expected_config_hashes)
            d2 = d2_group(f"D2_after_batch_{applied:02d}")
        previously_green.extend((f"D2:{t}", ["lake", "build", t]) for t in D2_TARGETS)

        d3 = stage(
            "D3",
            ["lake", "build", D3_TARGET],
            formalization=formalization,
            log_path=out_dir / "D3.log",
            default_owner="pnt_dependency_support",
        )
        if d3["status"] != "green":
            return {
                "candidate_id": candidate.id,
                "repair_eligibility": eligibility,
                "final_repair_class": final_class_for_owner(d3.get("failure", {}).get("owner")),
                "repair_batch_count": applied,
                "D3": d3,
            }
        previously_green.append(("D3", ["lake", "build", D3_TARGET]))

        for trigger, cmd in (
            ("D4", ["lake", "build", D4_TARGET]),
            ("D5", ["lake", "build", D5_TARGET]),
        ):
            current = stage(
                trigger,
                cmd,
                formalization=formalization,
                log_path=out_dir / f"{trigger}.log",
            )
            while current["status"] != "green":
                owner = current.get("failure", {}).get("owner")
                if owner != "project_owned":
                    return {
                        "candidate_id": candidate.id,
                        "repair_eligibility": eligibility,
                        "final_repair_class": final_class_for_owner(owner),
                        "repair_batch_count": applied,
                        trigger: current,
                    }
                if next_batch(trigger) is None:
                    return {
                        "candidate_id": candidate.id,
                        "repair_eligibility": eligibility,
                        "final_repair_class": "project_repair_budget_exceeded",
                        "repair_batch_count": applied,
                        trigger: current,
                    }
                apply_one(trigger, expected_config_hashes)
                current = stage(
                    trigger,
                    cmd,
                    formalization=formalization,
                    log_path=out_dir / f"{trigger}_after_batch_{applied:02d}.log",
                )
            previously_green.append((trigger, cmd))

        mk = stage(
            "D6:mk_all",
            ["lake", "exe", "mk_all", "--check"],
            formalization=formalization,
            log_path=out_dir / "D6_mk_all.log",
        )
        while mk["status"] != "green" or "No update necessary" not in (
            out_dir / "D6_mk_all.log"
        ).read_text(encoding="utf-8"):
            owner = mk.get("failure", {}).get("owner")
            if mk["status"] == "green":
                owner = "apparatus_or_provenance"
            if owner != "project_owned":
                return {
                    "candidate_id": candidate.id,
                    "repair_eligibility": eligibility,
                    "final_repair_class": final_class_for_owner(owner),
                    "repair_batch_count": applied,
                    "D6": {"mk_all": mk},
                }
            if next_batch("D6") is None:
                return {
                    "candidate_id": candidate.id,
                    "repair_eligibility": eligibility,
                    "final_repair_class": "project_repair_budget_exceeded",
                    "repair_batch_count": applied,
                    "D6": {"mk_all": mk},
                }
            apply_one("D6", expected_config_hashes)
            mk = stage(
                "D6:mk_all",
                ["lake", "exe", "mk_all", "--check"],
                formalization=formalization,
                log_path=out_dir / f"D6_mk_all_after_batch_{applied:02d}.log",
            )
        previously_green.append(("D6:mk_all", ["lake", "exe", "mk_all", "--check"]))

        full = stage(
            "D6:full_build",
            ["lake", "build", "Formalization"],
            formalization=formalization,
            log_path=out_dir / "D6_full_build.log",
            timeout=2400,
        )
        while full["status"] != "green":
            owner = full.get("failure", {}).get("owner")
            if owner != "project_owned":
                return {
                    "candidate_id": candidate.id,
                    "repair_eligibility": eligibility,
                    "final_repair_class": final_class_for_owner(owner),
                    "repair_batch_count": applied,
                    "D6": {"mk_all": mk, "full_build": full},
                }
            if next_batch("D6") is None:
                return {
                    "candidate_id": candidate.id,
                    "repair_eligibility": eligibility,
                    "final_repair_class": "project_repair_budget_exceeded",
                    "repair_batch_count": applied,
                    "D6": {"mk_all": mk, "full_build": full},
                }
            apply_one("D6", expected_config_hashes)
            full = stage(
                "D6:full_build",
                ["lake", "build", "Formalization"],
                formalization=formalization,
                log_path=out_dir / f"D6_full_build_after_batch_{applied:02d}.log",
                timeout=2400,
            )

        regressions = run_targets(
            [(f"final-regression:{t}", ["lake", "build", t]) for t in IMMUTABLE_REGRESSION_TARGETS],
            formalization=formalization,
            out_dir=out_dir,
            label="final_regression",
        )
        if any(x["status"] != "green" for x in regressions):
            raise ExperimentError("final immutable regression build failed")
        final_audit = validate_repair_invariants(
            repo,
            work,
            baseline_headers=baseline_headers,
            baseline_hashes=baseline_hashes,
            expected_config_hashes=expected_config_hashes,
            batch_count=applied,
        )
        unused = [i + 1 for i in range(len(batches)) if i not in consumed]
        if unused:
            raise ExperimentError(f"repair plan contained unused batch(es): {unused}")
        final_diff = checked(
            ["git", "diff", "HEAD", "--", "formalization/Formalization/Erdos678", "formalization/Formalization.lean"],
            cwd=work,
        )
        (out_dir / "final_source.diff").write_text(final_diff, encoding="utf-8")
        write_json(out_dir / "final_scope_audit.json", final_audit)
        return {
            "candidate_id": candidate.id,
            "repair_eligibility": eligibility,
            "final_repair_class": "repaired_green" if applied else "not_needed",
            "repair_batch_count": applied,
            "project_owned_files_touched": final_audit["names"],
            "additions": final_audit["additions"],
            "deletions": final_audit["deletions"],
            "third_party_source_files_touched": 0,
            "immutable_regression_files_touched": 0,
            "semantic_header_fingerprint_changes": 0,
            "final_targets_reached": ["D2", "D3", "D4", "D5", "D6"],
        }
    except ExperimentError as exc:
        return {
            "candidate_id": candidate.id,
            "repair_eligibility": eligibility,
            "final_repair_class": "apparatus_invalid",
            "repair_batch_count": applied,
            "reason": str(exc),
        }
    finally:
        remove_worktree(repo, work)


def candidate_primary_owner(detection: dict[str, Any]) -> str | None:
    ordered: list[dict[str, Any]] = list(detection.get("D2", []))
    for key in ("D3", "D4", "D5"):
        value = detection.get(key)
        if isinstance(value, dict):
            ordered.append(value)
    d6 = detection.get("D6")
    if isinstance(d6, dict):
        for key in ("mk_all", "full_build"):
            if isinstance(d6.get(key), dict):
                ordered.append(d6[key])
    for item in ordered:
        if item.get("status") == "failed":
            owner = item.get("failure", {}).get("owner")
            if owner in OWNER_CLASSES:
                return owner
    return None


def markdown_summary(result: dict[str, Any]) -> str:
    lines = [
        "# Erdős #678 — S2e Upgrade Robustness Run",
        "",
        f"- generated: `{result['generated_at']}`",
        f"- workflow commit: `{result['provenance']['workflow_commit']}`",
        f"- apparatus commit: `{result['provenance']['apparatus_commit']}`",
        f"- baseline commit: `{BASELINE_COMMIT}`",
        f"- phase: `{result['phase']}`",
        "",
        "## Baseline",
        "",
        f"- status: `{result['baseline']['status']}`",
        f"- Lean: `{result['baseline']['lean']}`",
        f"- canonical build jobs: `{result['baseline']['canonical_build_jobs']}`",
        "",
        "## Candidates",
        "",
    ]
    for item in result.get("candidates", []):
        det = item.get("detection", {})
        lines.extend(
            [
                f"### {item['candidate_id']}",
                "",
                f"- full no-repair survivor: `{det.get('full_no_repair_survivor')}`",
                f"- deepest green stage: `{det.get('deepest_green_stage')}`",
                f"- primary failure owner: `{item.get('primary_failure_owner')}`",
                f"- repair eligibility: `{json.dumps(item.get('repair_eligibility', {}), sort_keys=True)}`",
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
            "This artifact records only the two frozen S2e candidates. A dependency-support "
            "blocker is a version-boundary observation, not a proof-quality defect. Timing "
            "is metadata only and is not an outcome metric.",
            "",
        ]
    )
    return "\n".join(lines)


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
        "candidate_ids": [c.id for c in CANDIDATES],
        "repair_budget": {
            "batches": MAX_REPAIR_BATCHES,
            "files": MAX_REPAIR_FILES,
            "line_churn": MAX_REPAIR_CHURN,
        },
        "frozen_headers": list(FROZEN_HEADERS),
        "immutable_regression_files": list(IMMUTABLE_REGRESSION_FILES),
    }


def select_candidates(value: str) -> tuple[Candidate, ...]:
    if value == "all":
        return CANDIDATES
    for candidate in CANDIDATES:
        if value in {candidate.short, candidate.id}:
            return (candidate,)
    raise ExperimentError(f"unknown candidate selector: {value}")


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
        help="repair phase only; one explicit JSON plan per repair-eligible candidate",
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
        temp_parent = Path(tempfile.mkdtemp(prefix="erdos678-s2e-"))
        try:
            baseline = validate_baseline(repo, temp_parent, output)
            baseline_headers = baseline["header_fingerprints"]
            baseline_hashes = baseline["source_hashes"]
            candidate_results: list[dict[str, Any]] = []
            detections: dict[str, dict[str, Any]] = {}
            for candidate in selected:
                work = setup_candidate(
                    candidate, repo=repo, temp_root=temp_parent, output=output, suffix="detection"
                )
                try:
                    detection = run_detection_stages(candidate, work, output, "detection")
                finally:
                    remove_worktree(repo, work)
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
                plans: dict[str, Path] = {}
                for spec in args.repair_plan:
                    if "=" not in spec:
                        raise ExperimentError("--repair-plan must be SHORT=PATH")
                    short, raw = spec.split("=", 1)
                    plans[short] = Path(raw).resolve()
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
                            temp_root=temp_parent,
                            output=output,
                            baseline_headers=baseline_headers,
                            baseline_hashes=baseline_hashes,
                        )
                    elif eligibility["dependency_support_blocked"] and not eligibility["mathlib_only"]:
                        item["repair"] = {
                            "candidate_id": candidate.id,
                            "final_repair_class": "dependency_support_blocked",
                            "repair_batch_count": 0,
                        }
                    else:
                        raise ExperimentError(
                            f"repair phase requires explicit legal plan for {candidate.short}"
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
            shutil.rmtree(temp_parent, ignore_errors=True)
    except (ExperimentError, subprocess.TimeoutExpired, OSError, ValueError) as exc:
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
