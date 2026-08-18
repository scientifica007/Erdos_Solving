#!/usr/bin/env python3
"""Execute the predeclared Erdős #678 S2d semantic/index mutation experiment.

S2d applies exactly three frozen, type-correct semantic/index perturbations to
each of two immutable artifacts. It performs no repair. A semantic rejection is
a measurement outcome, not an apparatus failure; a mutation that survives every
required check is retained as a scientifically meaningful outcome.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterable

INTERNAL_BASELINE = "47b85a2f2f5be6e6e4ede2b600723b8616aeeee4"
PREDECLARATION_HEAD = "5aaef5a667ee11cc526beae587cf9ab799727f7e"
PREDECLARATION_MERGE = "2db145226bf530f406e734129fd8a451a2ab3899"
PREDECLARATION_EXACT_HEAD_RUN = 32073161789
PREDECLARATION_EXACT_HEAD_JOB = 95520595880
PREDECLARATION_POSTMERGE_RUN = 32073820006
PREDECLARATION_POSTMERGE_JOB = 95522556326

EXPECTED_LEAN = "4.33.0"
EXPECTED_MATHLIB_INPUT = "v4.33.0"
EXPECTED_MATHLIB_RESOLVED = "db584cd6d46c92f209a44c0f1c829460d327499d"
EXPECTED_PNT = "2667e414c38e5a5dc9aa1946f16f13001e5cd3ed"

COMPARATOR_REPO = "https://github.com/plby/lean-proofs.git"
COMPARATOR_COMMIT = "6f906fef432892db5c910c48ad1a3728dd42cdac"
COMPARATOR_PATH = "src/latest/ErdosProblems/Erdos678.lean"
COMPARATOR_BLOB = "f2331e8bcc71bc36cce7724a0c54fafd8d64d480"
COMPARATOR_SOURCE_SHA256 = "186a651174c7f8f7ef1e7d7d86f262ff51889a55c6767ca116b08a009fe8a4db"

PROTOCOL = "problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md"
MANIFEST = "problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml"

FORMALIZATION_TRACKED_SCOPE = [
    "formalization/Formalization/Erdos678",
    "formalization/Formalization.lean",
    "formalization/lakefile.toml",
    "formalization/lake-manifest.json",
    "formalization/lean-toolchain",
]


class ExperimentError(RuntimeError):
    """Fail-closed apparatus/provenance error."""


@dataclass(frozen=True)
class Stage:
    check_id: str
    stratum: str
    command: tuple[str, ...]


@dataclass(frozen=True)
class SideMutation:
    file: str
    declaration: str
    old: str
    new: str
    required_occurrences: int = 1


@dataclass(frozen=True)
class Mutation:
    id: str
    family: str
    role: str
    internal: SideMutation
    comparator: SideMutation
    internal_stages: tuple[Stage, ...]


def build_stage(check_id: str, stratum: str, target: str) -> Stage:
    return Stage(check_id, stratum, ("lake", "build", target))


COMMON_AFTER_LOCAL = (
    build_stage(
        "statement_bridge",
        "L3_statement_bridge",
        "Formalization.Erdos678.ExternalStatementBridge",
    ),
    build_stage(
        "statement_bridge_tests",
        "L3_statement_bridge",
        "Formalization.Erdos678.ExternalStatementBridgeTests",
    ),
    Stage("mk_all_check", "L4_canonical_import_graph", ("lake", "exe", "mk_all", "--check")),
    build_stage("full_formalization_build", "L5_full_canonical_build", "Formalization"),
)

MUTATIONS = (
    Mutation(
        id="I1-canonical-start-left-shift",
        family="interval-start-index",
        role="primitive-canonical-interval-semantics",
        internal=SideMutation(
            file="formalization/Formalization/Erdos678/Intervals.lean",
            declaration="erdosM",
            old="intervalLCM (n + 1) k",
            new="intervalLCM n k",
        ),
        comparator=SideMutation(
            file=COMPARATOR_PATH,
            declaration="lcmInterval",
            old="(Finset.Ioc n (n + k)).lcm id",
            new="(Finset.Ico n (n + k)).lcm id",
        ),
        internal_stages=(
            build_stage(
                "mutation_source",
                "L0_mutation_source_elaboration",
                "Formalization.Erdos678.Intervals",
            ),
            build_stage(
                "concrete_semantic_oracle",
                "L1_concrete_semantic_oracle",
                "Formalization.Erdos678.ConcreteTests",
            ),
            build_stage(
                "local_endpoint_regression",
                "L2_local_endpoint_regression",
                "Formalization.Erdos678.Erdos678FinalTests",
            ),
            *COMMON_AFTER_LOCAL,
        ),
    ),
    Mutation(
        id="I2-long-block-drop-final-term",
        family="interval-length-index",
        role="strong-cambie-endpoint",
        internal=SideMutation(
            file="formalization/Formalization/Erdos678/Erdos678Final.lean",
            declaration="cambie_lcm_ratio_eventually_with_large_start",
            old="C * intervalLCM y (k + 1) < intervalLCM x k := by",
            new="C * intervalLCM y k < intervalLCM x k := by",
        ),
        comparator=SideMutation(
            file=COMPARATOR_PATH,
            declaration="MainTheoremStatement",
            old="lcm_real (Finset.Icc x (x + k - 1)) > C * lcm_real (Finset.Icc y (y + k))",
            new="lcm_real (Finset.Icc x (x + k - 1)) > C * lcm_real (Finset.Icc y (y + k - 1))",
        ),
        internal_stages=(
            build_stage(
                "mutation_source",
                "L0_mutation_source_elaboration",
                "Formalization.Erdos678.Erdos678Final",
            ),
            build_stage(
                "local_endpoint_regression",
                "L2_local_endpoint_regression",
                "Formalization.Erdos678.Erdos678FinalTests",
            ),
            *COMMON_AFTER_LOCAL,
        ),
    ),
    Mutation(
        id="I3-strengthen-canonical-separation-one",
        family="separation-index",
        role="canonical-unbounded-or-infinitude-endpoint",
        internal=SideMutation(
            file="formalization/Formalization/Erdos678/Erdos678Final.lean",
            declaration="erdos678_unbounded_witnesses",
            old="B ≤ k ∧ 3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + k ≤ m ∧",
            new="B ≤ k ∧ 3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + (k + 1) ≤ m ∧",
        ),
        comparator=SideMutation(
            file=COMPARATOR_PATH,
            declaration="erdos_678_kmn_infinite",
            old="{(k, m, n) | 3 ≤ k ∧ n + k ≤ m ∧ lcmInterval m (k + 1) < lcmInterval n k}.Infinite",
            new="{(k, m, n) | 3 ≤ k ∧ n + (k + 1) ≤ m ∧ lcmInterval m (k + 1) < lcmInterval n k}.Infinite",
        ),
        internal_stages=(
            build_stage(
                "mutation_source",
                "L0_mutation_source_elaboration",
                "Formalization.Erdos678.Erdos678Final",
            ),
            build_stage(
                "local_endpoint_regression",
                "L2_local_endpoint_regression",
                "Formalization.Erdos678.Erdos678FinalTests",
            ),
            *COMMON_AFTER_LOCAL,
        ),
    ),
)


def run(
    cmd: Iterable[str], *, cwd: Path, timeout: int | None = None
) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        list(cmd),
        cwd=cwd,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
        timeout=timeout,
    )


def checked(cmd: Iterable[str], *, cwd: Path, timeout: int | None = None) -> str:
    command = list(cmd)
    proc = run(command, cwd=cwd, timeout=timeout)
    if proc.returncode != 0:
        raise ExperimentError(
            f"command failed ({proc.returncode}): {' '.join(command)}\n{proc.stdout or ''}"
        )
    return proc.stdout or ""


def git(repo: Path, *args: str) -> str:
    return checked(["git", *args], cwd=repo).strip()


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def read_manifest_identities(formalization: Path) -> dict[str, str]:
    data = json.loads((formalization / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {p["name"]: p for p in data["packages"]}
    return {
        "mathlib_input": packages["mathlib"]["inputRev"],
        "mathlib_resolved": packages["mathlib"]["rev"],
        "pnt_revision": packages["PrimeNumberTheoremAnd"]["rev"],
    }


def parse_lean_version(formalization: Path) -> str:
    text = checked(["lean", "--version"], cwd=formalization)
    match = re.search(r"Lean \(version ([^,]+)", text)
    if not match:
        raise ExperimentError(f"could not parse Lean version: {text}")
    return match.group(1)


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
    env_value = os.getenv("ACTIONS_RUNNER_VERSION") or os.getenv("S2D_RUNNER_VERSION")
    if env_value and re.fullmatch(r"\d+\.\d+\.\d+", env_value.strip()):
        return env_value.strip()
    proc_value = _runner_version_from_proc()
    if proc_value:
        return proc_value
    for root in (Path("/home/runner/runners"), Path("/opt/actions-runner")):
        if not root.exists():
            continue
        for candidate in sorted(root.rglob("Runner.Listener"))[:5]:
            try:
                proc = subprocess.run(
                    [str(candidate), "--version"],
                    text=True,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    timeout=5,
                    check=False,
                )
                text = (proc.stdout or "").strip()
                if proc.returncode == 0 and text:
                    value = text.splitlines()[-1].strip()
                    if re.fullmatch(r"\d+\.\d+\.\d+", value):
                        return value
            except (OSError, subprocess.TimeoutExpired):
                pass
        for child in sorted(root.iterdir()):
            if re.fullmatch(r"\d+\.\d+\.\d+", child.name):
                return child.name
    raise ExperimentError("GitHub runner version could not be recovered; provenance invariant failed")


def environment_metadata(formalization: Path) -> dict[str, Any]:
    ids = read_manifest_identities(formalization)
    lean = parse_lean_version(formalization)
    expected = {
        "mathlib_input": EXPECTED_MATHLIB_INPUT,
        "mathlib_resolved": EXPECTED_MATHLIB_RESOLVED,
        "pnt_revision": EXPECTED_PNT,
    }
    if lean != EXPECTED_LEAN:
        raise ExperimentError(f"Lean mismatch: {lean} != {EXPECTED_LEAN}")
    for key, value in expected.items():
        if ids[key] != value:
            raise ExperimentError(f"{key} mismatch: {ids[key]} != {value}")
    image_os = os.getenv("ImageOS", "unknown")
    image_version = os.getenv("ImageVersion", "unknown")
    if image_os == "unknown" or image_version == "unknown":
        raise ExperimentError("runner image identity is unavailable")
    return {
        "lean": lean,
        **ids,
        "runner_version": runner_version(),
        "runner_os": os.getenv("RUNNER_OS", "unknown"),
        "runner_arch": os.getenv("RUNNER_ARCH", "unknown"),
        "runner_name": os.getenv("RUNNER_NAME", "unknown"),
        "runner_environment": os.getenv("RUNNER_ENVIRONMENT", "unknown"),
        "image_os": image_os,
        "image_version": image_version,
        "cpu_count": os.cpu_count(),
        "uname": checked(["uname", "-a"], cwd=formalization).strip(),
    }


def code_mask(text: str) -> str:
    """Blank Lean comments/strings while preserving offsets and newlines."""
    out = list(text)
    i = 0
    n = len(text)
    block_depth = 0
    in_string = False
    escaped = False
    line_comment = False
    while i < n:
        c = text[i]
        nxt = text[i + 1] if i + 1 < n else ""
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
            continue
        i += 1
    return "".join(out)


DECL_START_RE = re.compile(
    r"(?m)^[ \t]*(?:(?:noncomputable|private|protected)\s+)?"
    r"(?:def|theorem|lemma|abbrev|structure|class|instance)\s+"
    r"([A-Za-z0-9_'.]+)"
)


def declaration_bounds(text: str, name: str) -> tuple[int, int]:
    mask = code_mask(text)
    matches = list(DECL_START_RE.finditer(mask))
    exact = [m for m in matches if m.group(1) == name]
    if len(exact) != 1:
        raise ExperimentError(f"expected exactly one declaration {name}, found {len(exact)}")
    current = exact[0]
    start = current.start()
    end = len(text)
    for item in matches:
        if item.start() > current.start():
            end = item.start()
            break
    return start, end


def line_of(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def replace_frozen_snippet(text: str, spec: SideMutation) -> tuple[str, dict[str, Any]]:
    start, end = declaration_bounds(text, spec.declaration)
    segment = text[start:end]
    count = segment.count(spec.old)
    if count != spec.required_occurrences:
        raise ExperimentError(
            f"{spec.declaration}: frozen snippet occurrence mismatch {count} != {spec.required_occurrences}"
        )
    relative = segment.index(spec.old)
    absolute = start + relative
    mutated = text[:absolute] + spec.new + text[absolute + len(spec.old):]
    mstart, mend = declaration_bounds(mutated, spec.declaration)
    if mutated[mstart:mend].count(spec.new) != spec.required_occurrences:
        raise ExperimentError(f"{spec.declaration}: replacement identity validation failed")
    return mutated, {
        "declaration": spec.declaration,
        "declaration_start_line": line_of(text, start),
        "declaration_end_line": line_of(text, max(start, end - 1)),
        "mutation_line": line_of(text, absolute),
        "original": spec.old,
        "replacement": spec.new,
        "required_occurrences": spec.required_occurrences,
    }


def manifest_mutation_block(text: str, mutation_id: str) -> str:
    marker = f"  - id: {mutation_id}\n"
    start = text.find(marker)
    if start < 0:
        raise ExperimentError(f"mutation missing from frozen manifest: {mutation_id}")
    next_mut = text.find("\n  - id: ", start + len(marker))
    end_marker = text.find("\nrejection_strata:", start + len(marker))
    candidates = [x for x in (next_mut, end_marker) if x >= 0]
    end = min(candidates) if candidates else len(text)
    return text[start:end]


def validate_embedded_mutation_contract(manifest_text: str) -> None:
    for mutation in MUTATIONS:
        block = manifest_mutation_block(manifest_text, mutation.id)
        required_fragments = [
            f"family: {mutation.family}",
            f"role: {mutation.role}",
            f"file: {mutation.internal.file}",
            f"declaration: {mutation.internal.declaration}",
            f'original: "{mutation.internal.old}"',
            f'replacement: "{mutation.internal.new}"',
            f"file: {mutation.comparator.file}",
            f"declaration: {mutation.comparator.declaration}",
            f'original: "{mutation.comparator.old}"',
            f'replacement: "{mutation.comparator.new}"',
        ]
        missing = [frag for frag in required_fragments if frag not in block]
        if missing:
            raise ExperimentError(
                f"embedded apparatus contract diverges from frozen manifest for {mutation.id}: {missing}"
            )


def validate_predeclaration(repo: Path) -> dict[str, Any]:
    for commit in (PREDECLARATION_HEAD, PREDECLARATION_MERGE, INTERNAL_BASELINE):
        checked(["git", "cat-file", "-e", f"{commit}^{{commit}}"], cwd=repo)
    result: dict[str, Any] = {}
    for path in (PROTOCOL, MANIFEST):
        current = (repo / path).read_bytes()
        frozen_head = subprocess.check_output(
            ["git", "show", f"{PREDECLARATION_HEAD}:{path}"], cwd=repo
        )
        frozen_merge = subprocess.check_output(
            ["git", "show", f"{PREDECLARATION_MERGE}:{path}"], cwd=repo
        )
        if current != frozen_head or current != frozen_merge:
            raise ExperimentError(f"predeclared file changed after freeze/integration: {path}")
        result[path] = {
            "sha256": sha256_bytes(current),
            "bytes": len(current),
        }
    validate_embedded_mutation_contract((repo / MANIFEST).read_text(encoding="utf-8"))
    return result


def validate_internal_source_baseline(repo: Path) -> None:
    proc = run(
        ["git", "diff", "--quiet", INTERNAL_BASELINE, "--", *FORMALIZATION_TRACKED_SCOPE],
        cwd=repo,
    )
    if proc.returncode != 0:
        detail = checked(
            ["git", "diff", "--stat", INTERNAL_BASELINE, "--", *FORMALIZATION_TRACKED_SCOPE],
            cwd=repo,
        )
        raise ExperimentError(f"internal source differs from frozen baseline:\n{detail}")


def tracked_formalization_diff(repo: Path) -> list[str]:
    text = git(repo, "diff", "--name-only", INTERNAL_BASELINE, "--", *FORMALIZATION_TRACKED_SCOPE)
    return [line for line in text.splitlines() if line.strip()]


def fetch_comparator(work: Path) -> tuple[str, dict[str, Any]]:
    if work.exists():
        shutil.rmtree(work)
    work.mkdir(parents=True)
    checked(["git", "init", "-q"], cwd=work)
    checked(["git", "remote", "add", "origin", COMPARATOR_REPO], cwd=work)
    checked(
        ["git", "fetch", "--depth=1", "--filter=blob:none", "origin", COMPARATOR_COMMIT],
        cwd=work,
    )
    commit = git(work, "rev-parse", "FETCH_HEAD")
    blob = git(work, "rev-parse", f"FETCH_HEAD:{COMPARATOR_PATH}")
    source_bytes = subprocess.check_output(
        ["git", "show", f"FETCH_HEAD:{COMPARATOR_PATH}"], cwd=work
    )
    digest = sha256_bytes(source_bytes)
    if commit != COMPARATOR_COMMIT:
        raise ExperimentError(f"comparator commit mismatch: {commit}")
    if blob != COMPARATOR_BLOB:
        raise ExperimentError(f"comparator blob mismatch: {blob}")
    if digest != COMPARATOR_SOURCE_SHA256:
        raise ExperimentError(f"comparator source digest mismatch: {digest}")
    return source_bytes.decode("utf-8"), {
        "repository": COMPARATOR_REPO,
        "commit": commit,
        "blob": blob,
        "source_sha256": digest,
        "source_bytes": len(source_bytes),
    }


def first_error_line(output: str) -> str | None:
    for line in output.splitlines():
        if "error:" in line.lower():
            return line.strip()
    return None


def normalized_diagnostic(output: str) -> str | None:
    line = first_error_line(output)
    if line is None:
        return None
    low = output.lower()
    if "unknown identifier" in low:
        return "unknown_identifier"
    if "application type mismatch" in low:
        return "application_type_mismatch"
    if "type mismatch" in low:
        return "type_mismatch"
    if "unsolved goals" in low:
        return "unsolved_goals"
    if "tactic" in low and ("failed" in low or "did not close" in low):
        return "tactic_failure"
    if "failed to synthesize" in low:
        return "failed_to_synthesize"
    return "lean_error"


def error_line_number(output: str) -> int | None:
    for line in output.splitlines():
        if "error:" not in line.lower():
            continue
        match = re.search(r":(\d+):\d+:\s*(?:error|Error):", line)
        if match:
            return int(match.group(1))
    return None


def enclosing_declaration(text: str, line: int | None) -> str | None:
    if line is None:
        return None
    offset = 0
    lines = text.splitlines(keepends=True)
    for idx, value in enumerate(lines, start=1):
        if idx >= line:
            break
        offset += len(value)
    mask = code_mask(text)
    candidates = [m for m in DECL_START_RE.finditer(mask) if m.start() <= offset]
    return candidates[-1].group(1) if candidates else None


def classify_comparator_declaration(name: str | None) -> str:
    if name is None:
        return "whole_artifact_completion"
    if name == "lcmInterval":
        return "primitive_definition"
    if name in {"MainTheoremStatement", "main_theorem_given_pnt"}:
        return "strong_theorem"
    if name in {"erdos_678_kmn_infinite"}:
        return "canonical_corollary"
    return "local_lemma_or_regression"


def run_stage(
    stage: Stage,
    *,
    cwd: Path,
    log_dir: Path,
    ordinal: int,
    timeout: int = 1800,
) -> dict[str, Any]:
    started = time.monotonic()
    proc = run(stage.command, cwd=cwd, timeout=timeout)
    wall = time.monotonic() - started
    log_name = f"{ordinal:02d}-{stage.check_id}.log"
    (log_dir / log_name).write_text(proc.stdout or "", encoding="utf-8")
    return {
        "check_id": stage.check_id,
        "stratum": stage.stratum,
        "command": list(stage.command),
        "exit": proc.returncode,
        "wall_seconds_metadata_only": wall,
        "log": log_name,
        "first_error": first_error_line(proc.stdout or ""),
        "diagnostic_class": normalized_diagnostic(proc.stdout or ""),
        "mk_all_no_update_necessary": (
            "No update necessary" in (proc.stdout or "")
            if stage.check_id == "mk_all_check"
            else None
        ),
        "full_build_completed_8808_jobs": (
            "Build completed successfully (8808 jobs)" in (proc.stdout or "")
            if stage.check_id == "full_formalization_build"
            else None
        ),
    }


def stage_field(results: list[dict[str, Any]], check_ids: set[str]) -> bool | None:
    selected = [r for r in results if r["check_id"] in check_ids]
    if not selected:
        return None
    if any(r["exit"] != 0 for r in selected):
        return True
    return False


def reset_internal_source(
    repo: Path,
    formalization: Path,
    source_path: Path,
    original: str,
    mutation: Mutation,
    out: Path,
) -> None:
    source_path.write_text(original, encoding="utf-8")
    if tracked_formalization_diff(repo):
        raise ExperimentError(
            f"tracked source did not return to baseline after {mutation.id}: "
            f"{tracked_formalization_diff(repo)}"
        )
    reset_target = mutation.internal_stages[0].command
    proc = run(reset_target, cwd=formalization, timeout=1800)
    (out / "reset-baseline.log").write_text(proc.stdout or "", encoding="utf-8")
    if proc.returncode != 0:
        raise ExperimentError(
            f"failed to restore baseline build after {mutation.id}:\n{proc.stdout or ''}"
        )


def run_internal_mutation(
    repo: Path,
    formalization: Path,
    mutation: Mutation,
    out: Path,
    env: dict[str, Any],
) -> dict[str, Any]:
    validate_internal_source_baseline(repo)
    out.mkdir(parents=True, exist_ok=True)
    spec = mutation.internal
    source_path = repo / spec.file
    original = source_path.read_text(encoding="utf-8")
    original_digest = sha256_bytes(original.encode("utf-8"))
    mutated, identity = replace_frozen_snippet(original, spec)
    mutated_digest = sha256_bytes(mutated.encode("utf-8"))
    results: list[dict[str, Any]] = []
    first_failure: dict[str, Any] | None = None

    try:
        source_path.write_text(mutated, encoding="utf-8")
        diffs = tracked_formalization_diff(repo)
        if diffs != [spec.file]:
            raise ExperimentError(
                f"{mutation.id}/internal touched unexpected tracked sources: {diffs}"
            )
        for ordinal, stage in enumerate(mutation.internal_stages, start=1):
            result = run_stage(stage, cwd=formalization, log_dir=out, ordinal=ordinal)
            results.append(result)
            if result["exit"] != 0:
                first_failure = result
                break

        survived = first_failure is None
        first = first_failure or {}
        return {
            "artifact": "internal",
            "mutation_id": mutation.id,
            "family": mutation.family,
            "logical_role": mutation.role,
            "baseline_identity_valid": True,
            "mutation_occurrence_valid": True,
            "mutation_identity": identity,
            "baseline_source_sha256": original_digest,
            "mutated_source_sha256": mutated_digest,
            "files_touched": [spec.file],
            "non_mutation_files_touched": 0,
            "mutation_source_elaborated": bool(results and results[0]["exit"] == 0),
            "outcome": "semantic_mutation_survived" if survived else "semantic_rejection",
            "first_rejection_stratum": None if survived else first["stratum"],
            "first_failing_module_or_declaration": (
                None if survived else first["check_id"]
            ),
            "first_diagnostic_line": None if survived else first["first_error"],
            "normalized_diagnostic_class": (
                None if survived else first["diagnostic_class"]
            ),
            "staged_checks_passed": sum(1 for item in results if item["exit"] == 0),
            "staged_checks_executed": len(results),
            "stages": results,
            "concrete_oracle_rejected": (
                stage_field(results, {"concrete_semantic_oracle"})
                if mutation.id == "I1-canonical-start-left-shift"
                else None
            ),
            "statement_bridge_rejected": stage_field(
                results, {"statement_bridge", "statement_bridge_tests"}
            ),
            "mk_all_rejected": stage_field(results, {"mk_all_check"}),
            "full_canonical_build_rejected": stage_field(
                results, {"full_formalization_build"}
            ),
            "semantic_mutation_survived_canonical_verification": survived,
            "runner_version": env["runner_version"],
            "runner_image": f"{env['image_os']}/{env['image_version']}",
            "raw_log_paths": [item["log"] for item in results],
            "third_party_dependency_files_touched": 0,
            "proof_repairs_performed": 0,
        }
    finally:
        reset_internal_source(repo, formalization, source_path, original, mutation, out)


def compile_comparator(
    formalization: Path, source_path: Path, log_path: Path
) -> tuple[int, float, str]:
    started = time.monotonic()
    proc = run(
        ["lake", "env", "lean", str(source_path)],
        cwd=formalization,
        timeout=1800,
    )
    wall = time.monotonic() - started
    log_path.write_text(proc.stdout or "", encoding="utf-8")
    return proc.returncode, wall, proc.stdout or ""


def clean_comparator_outputs(source_path: Path) -> None:
    for suffix in (".olean", ".ilean", ".c", ".o"):
        candidate = source_path.with_suffix(suffix)
        if candidate.exists():
            candidate.unlink()


def run_comparator_mutation(
    formalization: Path,
    comparator_text: str,
    mutation: Mutation,
    out: Path,
    source_path: Path,
    env: dict[str, Any],
) -> dict[str, Any]:
    out.mkdir(parents=True, exist_ok=True)
    spec = mutation.comparator
    original_digest = sha256_bytes(comparator_text.encode("utf-8"))
    mutated, identity = replace_frozen_snippet(comparator_text, spec)
    mutated_digest = sha256_bytes(mutated.encode("utf-8"))
    source_path.write_text(mutated, encoding="utf-8")
    clean_comparator_outputs(source_path)
    code, wall, output = compile_comparator(
        formalization, source_path, out / "01-full-pinned-source-compile.log"
    )
    error_line = error_line_number(output)
    failing_decl = enclosing_declaration(mutated, error_line)
    target_start, target_end = declaration_bounds(mutated, spec.declaration)
    target_start_line = line_of(mutated, target_start)
    target_end_line = line_of(mutated, max(target_start, target_end - 1))
    if code == 0:
        source_elaborated: bool | None = True
    elif error_line is None:
        source_elaborated = None
    else:
        source_elaborated = not (target_start_line <= error_line <= target_end_line)
    survived = code == 0
    logical_class = None if survived else classify_comparator_declaration(failing_decl)
    try:
        return {
            "artifact": "comparator",
            "mutation_id": mutation.id,
            "family": mutation.family,
            "logical_role": mutation.role,
            "baseline_identity_valid": True,
            "mutation_occurrence_valid": True,
            "mutation_identity": identity,
            "baseline_source_sha256": original_digest,
            "mutated_source_sha256": mutated_digest,
            "files_touched": [COMPARATOR_PATH],
            "non_mutation_files_touched": 0,
            "mutation_source_elaborated": source_elaborated,
            "outcome": "semantic_mutation_survived" if survived else "semantic_rejection",
            "first_rejection_stratum": logical_class,
            "first_failing_module_or_declaration": failing_decl,
            "first_diagnostic_line": first_error_line(output),
            "normalized_diagnostic_class": normalized_diagnostic(output),
            "staged_checks_passed": 1 if survived else 0,
            "staged_checks_executed": 1,
            "stages": [
                {
                    "check_id": "full_pinned_source_compile",
                    "stratum": logical_class or "whole_artifact_completion",
                    "command": ["lake", "env", "lean", str(source_path)],
                    "exit": code,
                    "wall_seconds_metadata_only": wall,
                    "log": "01-full-pinned-source-compile.log",
                    "first_error": first_error_line(output),
                    "diagnostic_class": normalized_diagnostic(output),
                    "first_error_line_number": error_line,
                    "enclosing_declaration": failing_decl,
                }
            ],
            "concrete_oracle_rejected": None,
            "statement_bridge_rejected": None,
            "mk_all_rejected": None,
            "full_canonical_build_rejected": None if survived else True,
            "semantic_mutation_survived_canonical_verification": survived,
            "runner_version": env["runner_version"],
            "runner_image": f"{env['image_os']}/{env['image_version']}",
            "raw_log_paths": ["01-full-pinned-source-compile.log"],
            "third_party_dependency_files_touched": 0,
            "proof_repairs_performed": 0,
        }
    finally:
        source_path.write_text(comparator_text, encoding="utf-8")
        clean_comparator_outputs(source_path)


def canonical_internal_baseline(formalization: Path, out: Path) -> dict[str, Any]:
    stages = (
        Stage("mk_all_check", "baseline", ("lake", "exe", "mk_all", "--check")),
        build_stage("full_formalization_build", "baseline", "Formalization"),
    )
    results = [
        run_stage(stage, cwd=formalization, log_dir=out, ordinal=i)
        for i, stage in enumerate(stages, start=1)
    ]
    if any(item["exit"] != 0 for item in results):
        raise ExperimentError("internal frozen baseline is not canonical-green")
    if not results[0]["mk_all_no_update_necessary"]:
        raise ExperimentError("internal baseline mk_all did not report No update necessary")
    if not results[1]["full_build_completed_8808_jobs"]:
        raise ExperimentError("internal baseline did not complete the expected 8808-job build")
    return {"success": True, "stages": results}


def comparator_baseline(
    formalization: Path, comparator_text: str, source_path: Path, out: Path
) -> dict[str, Any]:
    source_path.write_text(comparator_text, encoding="utf-8")
    clean_comparator_outputs(source_path)
    code, wall, output = compile_comparator(
        formalization, source_path, out / "comparator-baseline.log"
    )
    if code != 0:
        raise ExperimentError(f"pinned comparator baseline is not green:\n{output}")
    return {
        "success": True,
        "exit": code,
        "wall_seconds_metadata_only": wall,
        "log": "comparator-baseline.log",
    }


def markdown(result: dict[str, Any]) -> str:
    lines = [
        "# S2d Semantic/Index Mutation Execution Summary",
        "",
        f"- apparatus commit: `{result['experiment_commit']}`",
        f"- predeclaration head: `{result['predeclaration_head']}`",
        f"- predeclaration merge: `{result['predeclaration_merge']}`",
        f"- frozen internal baseline: `{result['internal_baseline']}`",
        f"- comparator: `{result['comparator']['commit']}` / `{result['comparator']['blob']}`",
        "",
        "| mutation | artifact | outcome | first rejection stratum | first failing declaration/check | source elaborated |",
        "|---|---|---|---|---|---|",
    ]
    for obs in result["observations"]:
        lines.append(
            f"| {obs['mutation_id']} | {obs['artifact']} | {obs['outcome']} | "
            f"{obs['first_rejection_stratum'] or 'none'} | "
            f"{obs['first_failing_module_or_declaration'] or 'none'} | "
            f"{obs['mutation_source_elaborated']} |"
        )
    lines += [
        "",
        f"- semantic rejections: **{result['semantic_rejection_count']}**",
        f"- canonical/full-source survivors: **{result['semantic_survival_count']}**",
        "- proof repairs performed: **0**",
        "- third-party/dependency source touches: **0**",
        "",
        "Interpretation is limited to the three prospectively frozen one-unit semantic/index perturbations.",
        "A surviving mutation means a changed target remained machine-checkable; it is not evidence that statement fidelity was preserved.",
        "Timing fields are apparatus metadata only and are not semantic-robustness or maintenance metrics.",
    ]
    return "\n".join(lines) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    args = parser.parse_args()

    repo = args.repo_root.resolve()
    formalization = repo / "formalization"
    out = args.output_dir.resolve()
    out.mkdir(parents=True, exist_ok=True)

    experiment_commit = git(repo, "rev-parse", "HEAD")
    predeclared = validate_predeclaration(repo)
    validate_internal_source_baseline(repo)
    env = environment_metadata(formalization)

    baseline_dir = out / "baselines"
    baseline_dir.mkdir(parents=True, exist_ok=True)
    internal_baseline_result = canonical_internal_baseline(formalization, baseline_dir)

    comparator_git = out / "comparator-git"
    comparator_text, comparator_identity = fetch_comparator(comparator_git)
    comparator_source = out / "comparator-work" / "Erdos678Comparator.lean"
    comparator_source.parent.mkdir(parents=True, exist_ok=True)
    comparator_baseline_result = comparator_baseline(
        formalization, comparator_text, comparator_source, baseline_dir
    )

    observations: list[dict[str, Any]] = []
    for mutation in MUTATIONS:
        mutation_dir = out / mutation.id
        observations.append(
            run_internal_mutation(
                repo,
                formalization,
                mutation,
                mutation_dir / "internal",
                env,
            )
        )
        observations.append(
            run_comparator_mutation(
                formalization,
                comparator_text,
                mutation,
                mutation_dir / "comparator",
                comparator_source,
                env,
            )
        )

    validate_internal_source_baseline(repo)
    if tracked_formalization_diff(repo):
        raise ExperimentError(
            f"formalization working tree not clean after S2d: {tracked_formalization_diff(repo)}"
        )

    final_reset = run(
        ["lake", "build", "Formalization"],
        cwd=formalization,
        timeout=1800,
    )
    (out / "final-reset-full-build.log").write_text(
        final_reset.stdout or "", encoding="utf-8"
    )
    if final_reset.returncode != 0:
        raise ExperimentError("final baseline restoration build failed")
    if "Build completed successfully (8808 jobs)" not in (final_reset.stdout or ""):
        raise ExperimentError("final baseline restoration did not confirm the 8808-job graph")

    if len(observations) != 6:
        raise ExperimentError(f"expected exactly six observations, got {len(observations)}")
    if any(obs["proof_repairs_performed"] != 0 for obs in observations):
        raise ExperimentError("S2d repair prohibition was violated")
    if any(obs["non_mutation_files_touched"] != 0 for obs in observations):
        raise ExperimentError("non-mutation source touch invariant violated")
    if any(obs["third_party_dependency_files_touched"] != 0 for obs in observations):
        raise ExperimentError("third-party/dependency source touch invariant violated")

    rejection_count = sum(obs["outcome"] == "semantic_rejection" for obs in observations)
    survival_count = sum(obs["outcome"] == "semantic_mutation_survived" for obs in observations)

    result = {
        "schema_version": 1,
        "stage": "S2d-semantic-index-mutation-resistance",
        "status": "executed-success",
        "experiment_commit": experiment_commit,
        "predeclaration_head": PREDECLARATION_HEAD,
        "predeclaration_merge": PREDECLARATION_MERGE,
        "predeclaration_verification": {
            "exact_head_run": PREDECLARATION_EXACT_HEAD_RUN,
            "exact_head_job": PREDECLARATION_EXACT_HEAD_JOB,
            "postmerge_run": PREDECLARATION_POSTMERGE_RUN,
            "postmerge_job": PREDECLARATION_POSTMERGE_JOB,
        },
        "predeclared_file_identity": predeclared,
        "internal_baseline": INTERNAL_BASELINE,
        "environment": env,
        "internal_baseline_verification": internal_baseline_result,
        "comparator": comparator_identity,
        "comparator_baseline_verification": comparator_baseline_result,
        "mutation_count": len(MUTATIONS),
        "planned_observation_count": 6,
        "observation_count": len(observations),
        "observations": observations,
        "semantic_rejection_count": rejection_count,
        "semantic_survival_count": survival_count,
        "proof_repairs_performed": 0,
        "third_party_dependency_files_touched_total": 0,
        "interpretation_scope": "three-predeclared-type-correct-semantic-index-perturbations-only",
        "timing_is_semantic_robustness_metric": False,
        "timing_is_maintenance_metric": False,
        "hidden_chain_of_thought_required": False,
    }
    (out / "result.json").write_text(
        json.dumps(result, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    summary = markdown(result)
    (out / "summary.md").write_text(summary, encoding="utf-8")
    print(summary)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ExperimentError, subprocess.TimeoutExpired) as exc:
        print(f"S2d experiment failed closed: {exc}", file=sys.stderr)
        raise SystemExit(2)
