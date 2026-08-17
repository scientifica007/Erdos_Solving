#!/usr/bin/env python3
"""Execute the predeclared Erdős #678 S2c API/reference repair-locality experiment.

The experiment performs declaration-name breaks only.  It never changes theorem
statements or mathematical proof bodies, and it never edits third-party source.
Timing is retained only as apparatus metadata and is not a repair-cost metric.
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
from typing import Any

INTERNAL_BASELINE = "cc55073fceddb51e3fa2c1854f797fe989523985"
PREDECLARATION_COMMIT = "a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1"
EXPECTED_LEAN = "4.33.0"
EXPECTED_MATHLIB_INPUT = "v4.33.0"
EXPECTED_MATHLIB_RESOLVED = "db584cd6d46c92f209a44c0f1c829460d327499d"
EXPECTED_PNT = "2667e414c38e5a5dc9aa1946f16f13001e5cd3ed"
COMPARATOR_REPO = "https://github.com/plby/lean-proofs.git"
COMPARATOR_COMMIT = "6f906fef432892db5c910c48ad1a3728dd42cdac"
COMPARATOR_PATH = "src/latest/ErdosProblems/Erdos678.lean"
COMPARATOR_BLOB = "f2331e8bcc71bc36cce7724a0c54fafd8d64d480"
PROTOCOL = "problems/678/S2_REPAIR_LOCALITY_PROTOCOL.md"
MANIFEST = "problems/678/S2_REPAIR_LOCALITY_MUTATIONS.yaml"


class ExperimentError(RuntimeError):
    pass


@dataclass(frozen=True)
class SideMutation:
    file: str
    old: str
    new: str


@dataclass(frozen=True)
class Mutation:
    id: str
    role: str
    internal: SideMutation
    comparator: SideMutation


MUTATIONS = [
    Mutation(
        "R1-analytic-closure",
        "external-prime-distribution-to-project-local-analytic-interface",
        SideMutation(
            "formalization/Formalization/Erdos678/Claim4RelativePrimePNT.lean",
            "claim4RelativePrimeProviderOfPNT",
            "s2c_claim4RelativePrimeProviderOfPNT",
        ),
        SideMutation(
            COMPARATOR_PATH,
            "density_proof",
            "s2c_density_proof",
        ),
    ),
    Mutation(
        "R2-eventual-construction",
        "sufficiently-large-k-witness-construction-consumed-by-final-theorem-layer",
        SideMutation(
            "formalization/Formalization/Erdos678/Claim4RelativePrimePNT.lean",
            "claim4_exists_cambie_lcm_ratio_eventually_of_pnt",
            "s2c_claim4_exists_cambie_lcm_ratio_eventually_of_pnt",
        ),
        SideMutation(
            COMPARATOR_PATH,
            "exists_xy_for_large_k",
            "s2c_exists_xy_for_large_k",
        ),
    ),
    Mutation(
        "R3-strong-public-endpoint",
        "unconditional-real-factor-strong-endpoint-with-downstream-consumers",
        SideMutation(
            "formalization/Formalization/Erdos678/ExternalStatementBridge.lean",
            "cambie_lcm_ratio_eventually_with_large_start_real",
            "s2c_cambie_lcm_ratio_eventually_with_large_start_real",
        ),
        SideMutation(
            COMPARATOR_PATH,
            "main_theorem_given_pnt",
            "s2c_main_theorem_given_pnt",
        ),
    ),
]


def run(
    cmd: list[str], *, cwd: Path, timeout: int | None = None
) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        cmd,
        cwd=cwd,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
        timeout=timeout,
    )


def checked(cmd: list[str], *, cwd: Path, timeout: int | None = None) -> str:
    p = run(cmd, cwd=cwd, timeout=timeout)
    if p.returncode != 0:
        raise ExperimentError(f"command failed ({p.returncode}): {' '.join(cmd)}\n{p.stdout}")
    return p.stdout


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
    m = re.search(r"Lean \(version ([^,]+)", text)
    if not m:
        raise ExperimentError(f"could not parse Lean version: {text}")
    return m.group(1)


def validate_environment(formalization: Path) -> dict[str, Any]:
    ids = read_manifest_identities(formalization)
    version = parse_lean_version(formalization)
    expected = {
        "mathlib_input": EXPECTED_MATHLIB_INPUT,
        "mathlib_resolved": EXPECTED_MATHLIB_RESOLVED,
        "pnt_revision": EXPECTED_PNT,
    }
    if version != EXPECTED_LEAN:
        raise ExperimentError(f"Lean mismatch: {version} != {EXPECTED_LEAN}")
    for key, value in expected.items():
        if ids[key] != value:
            raise ExperimentError(f"{key} mismatch: {ids[key]} != {value}")
    return {
        "lean": version,
        **ids,
        "runner_os": os.getenv("RUNNER_OS", "unknown"),
        "runner_arch": os.getenv("RUNNER_ARCH", "unknown"),
        "runner_name": os.getenv("RUNNER_NAME", "unknown"),
        "image_os": os.getenv("ImageOS", "unknown"),
        "image_version": os.getenv("ImageVersion", "unknown"),
        "cpu_count": os.cpu_count(),
    }


def validate_predeclaration(repo: Path) -> dict[str, str]:
    # Ensure the protocol/manifest used by the apparatus are byte-identical to
    # the versions frozen before any S2c observation.
    result: dict[str, str] = {}
    for path in (PROTOCOL, MANIFEST):
        current = (repo / path).read_bytes()
        frozen = subprocess.check_output(["git", "show", f"{PREDECLARATION_COMMIT}:{path}"], cwd=repo)
        if current != frozen:
            raise ExperimentError(f"predeclared file changed after freeze: {path}")
        result[path] = sha256_bytes(current)
    return result


def validate_internal_source_baseline(repo: Path) -> None:
    paths = [
        "formalization/Formalization/Erdos678",
        "formalization/Formalization.lean",
        "formalization/lakefile.toml",
        "formalization/lake-manifest.json",
        "formalization/lean-toolchain",
    ]
    p = run(["git", "diff", "--quiet", INTERNAL_BASELINE, "--", *paths], cwd=repo)
    if p.returncode != 0:
        detail = checked(["git", "diff", "--stat", INTERNAL_BASELINE, "--", *paths], cwd=repo)
        raise ExperimentError(f"internal proof/dependency source differs from frozen baseline:\n{detail}")


def fetch_comparator(work: Path) -> tuple[bytes, dict[str, str]]:
    if work.exists():
        shutil.rmtree(work)
    work.mkdir(parents=True)
    checked(["git", "init", "-q"], cwd=work)
    checked(["git", "remote", "add", "origin", COMPARATOR_REPO], cwd=work)
    checked(
        ["git", "fetch", "--depth=1", "--filter=blob:none", "origin", COMPARATOR_COMMIT],
        cwd=work,
    )
    commit = checked(["git", "rev-parse", "FETCH_HEAD"], cwd=work).strip()
    blob = checked(["git", "rev-parse", f"FETCH_HEAD:{COMPARATOR_PATH}"], cwd=work).strip()
    if commit != COMPARATOR_COMMIT or blob != COMPARATOR_BLOB:
        raise ExperimentError(f"comparator identity mismatch: {commit}/{blob}")
    source = subprocess.check_output(["git", "show", f"FETCH_HEAD:{COMPARATOR_PATH}"], cwd=work)
    return source, {"commit": commit, "blob": blob, "source_sha256": sha256_bytes(source)}


def code_mask(text: str) -> str:
    """Return a same-length mask with Lean comments/strings blanked, newlines kept.

    Handles nested /- -/ comments, -- line comments, quoted strings, and character
    literals well enough for identifier-location accounting.  Characters inside
    non-code regions become spaces so original offsets/line numbers remain valid.
    """
    out = list(text)
    i = 0
    n = len(text)
    block_depth = 0
    in_string = False
    in_char = False
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
        if in_string or in_char:
            if c != "\n":
                out[i] = " "
            if escaped:
                escaped = False
            elif c == "\\":
                escaped = True
            elif in_string and c == '"':
                in_string = False
            elif in_char and c == "'":
                in_char = False
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
        # Lean character literals are uncommon in these sources.  Treat a quote
        # followed by one character and another quote as a literal; otherwise it
        # may be identifier syntax and remains code.
        if c == "'" and i + 2 < n and text[i + 2] == "'":
            out[i] = " "
            in_char = True
            i += 1
            continue
        i += 1
    return "".join(out)


def identifier_spans(text: str, name: str) -> list[tuple[int, int]]:
    mask = code_mask(text)
    pattern = re.compile(rf"(?<![A-Za-z0-9_']){re.escape(name)}(?![A-Za-z0-9_'])")
    return [(m.start(), m.end()) for m in pattern.finditer(mask)]


def line_of(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def declaration_span(text: str, name: str) -> tuple[int, int]:
    mask = code_mask(text)
    pattern = re.compile(
        rf"\b(?:noncomputable\s+def|def|theorem|lemma)\s+({re.escape(name)})(?![A-Za-z0-9_'])"
    )
    matches = list(pattern.finditer(mask))
    if len(matches) != 1:
        raise ExperimentError(f"expected one declaration for {name}, found {len(matches)}")
    return matches[0].span(1)


def replace_spans(text: str, spans: list[tuple[int, int]], replacement: str) -> str:
    result = text
    for start, end in reversed(spans):
        result = result[:start] + replacement + result[end:]
    return result


def classify_internal_file(path: Path) -> str:
    return "verification_project_owned" if path.name.endswith("Tests.lean") else "production_project_owned"


def internal_sources(repo: Path) -> list[Path]:
    root = repo / "formalization" / "Formalization" / "Erdos678"
    return sorted(root.glob("*.lean"))


def find_internal_references(repo: Path, old: str) -> list[dict[str, Any]]:
    refs: list[dict[str, Any]] = []
    for path in internal_sources(repo):
        text = path.read_text(encoding="utf-8")
        for start, _ in identifier_spans(text, old):
            refs.append(
                {
                    "path": str(path.relative_to(repo)),
                    "line": line_of(text, start),
                    "ownership": classify_internal_file(path),
                }
            )
    return refs


def compile_internal(formalization: Path, log_path: Path) -> tuple[int, float, str]:
    started = time.monotonic()
    p = run(["lake", "build", "Formalization"], cwd=formalization, timeout=1800)
    wall = time.monotonic() - started
    log_path.write_text(p.stdout or "", encoding="utf-8")
    return p.returncode, wall, p.stdout or ""


def canonical_internal(formalization: Path, prefix: Path) -> tuple[bool, dict[str, Any]]:
    mk = run(["lake", "exe", "mk_all", "--check"], cwd=formalization, timeout=1200)
    (prefix.parent / f"{prefix.name}-mk-all.log").write_text(mk.stdout or "", encoding="utf-8")
    build_code, wall, build_out = compile_internal(
        formalization, prefix.parent / f"{prefix.name}-full-build.log"
    )
    return mk.returncode == 0 and build_code == 0, {
        "mk_all_exit": mk.returncode,
        "mk_all_no_update_necessary": "No update necessary" in (mk.stdout or ""),
        "full_build_exit": build_code,
        "full_build_wall_seconds_metadata_only": wall,
        "full_build_completed_8808_jobs": "Build completed successfully (8808 jobs)" in build_out,
    }


def compile_comparator(formalization: Path, source: Path, log_path: Path) -> tuple[int, float, str]:
    started = time.monotonic()
    p = run(["lake", "env", "lean", str(source)], cwd=formalization, timeout=1800)
    wall = time.monotonic() - started
    log_path.write_text(p.stdout or "", encoding="utf-8")
    return p.returncode, wall, p.stdout or ""


def first_error_line(output: str) -> str | None:
    for line in output.splitlines():
        low = line.lower()
        if "error:" in low or "unknown identifier" in low:
            return line.strip()
    return None


def unresolved_count(output: str, old: str) -> int:
    return sum(
        1
        for line in output.splitlines()
        if old in line and ("unknown identifier" in line.lower() or "error:" in line.lower())
    )


def run_internal_mutation(
    repo: Path, formalization: Path, mutation: Mutation, out: Path
) -> dict[str, Any]:
    spec = mutation.internal
    declaration_path = repo / spec.file
    original_map = {p: p.read_text(encoding="utf-8") for p in internal_sources(repo)}
    decl_original = original_map[declaration_path]
    dspan = declaration_span(decl_original, spec.old)
    decl_line = line_of(decl_original, dspan[0])

    refs_before = find_internal_references(repo, spec.old)
    declaration_matches = [r for r in refs_before if r["path"] == spec.file and r["line"] == decl_line]
    if len(declaration_matches) != 1:
        raise ExperimentError(f"could not isolate declaration occurrence for {mutation.id}/internal")
    downstream_before = list(refs_before)
    downstream_before.remove(declaration_matches[0])

    try:
        declaration_path.write_text(replace_spans(decl_original, [dspan], spec.new), encoding="utf-8")
        mutated_old_refs = find_internal_references(repo, spec.old)
        if len(mutated_old_refs) != len(downstream_before):
            raise ExperimentError(f"declaration-only mutation changed unexpected occurrence count: {mutation.id}")

        code, wall, output = compile_internal(formalization, out / "mutated-failure.log")
        observable = len(downstream_before) > 0
        if observable and code == 0:
            raise ExperimentError(f"expected internal mutation failure but build succeeded: {mutation.id}")
        if not observable and code != 0:
            raise ExperimentError(f"unreferenced internal rename unexpectedly failed: {mutation.id}")

        repaired_sites: list[dict[str, Any]] = []
        touched_files: set[Path] = set()
        if observable:
            for path in internal_sources(repo):
                text = path.read_text(encoding="utf-8")
                spans = identifier_spans(text, spec.old)
                if not spans:
                    continue
                for start, _ in spans:
                    repaired_sites.append(
                        {
                            "path": str(path.relative_to(repo)),
                            "line": line_of(text, start),
                            "ownership": classify_internal_file(path),
                        }
                    )
                path.write_text(replace_spans(text, spans, spec.new), encoding="utf-8")
                touched_files.add(path)

        remaining = find_internal_references(repo, spec.old)
        if remaining:
            raise ExperimentError(f"old internal references remain after legal repair: {mutation.id}: {remaining}")

        repaired_ok, canonical = canonical_internal(formalization, out / "repaired")
        if not repaired_ok:
            raise ExperimentError(f"repaired internal artifact did not regain canonical verification: {mutation.id}")

        production_sites = [x for x in repaired_sites if x["ownership"] == "production_project_owned"]
        verification_sites = [x for x in repaired_sites if x["ownership"] == "verification_project_owned"]
        production_files = sorted({x["path"] for x in production_sites})
        verification_files = sorted({x["path"] for x in verification_sites})

        diff_names = git(repo, "diff", "--name-only", "--", "formalization").splitlines()
        allowed = {
            str(p.relative_to(repo)) for p in touched_files | {declaration_path}
        }
        unexpected = sorted(set(filter(None, diff_names)) - allowed)
        if unexpected:
            raise ExperimentError(f"unexpected tracked formalization edits: {unexpected}")

        return {
            "artifact": "internal",
            "mutation_id": mutation.id,
            "logical_role": mutation.role,
            "declaration": {"path": spec.file, "old": spec.old, "new": spec.new, "line": decl_line},
            "downstream_reference_sites_before": downstream_before,
            "mutation_observable": observable,
            "mutated_compile_exit": code,
            "mutated_compile_wall_seconds_metadata_only": wall,
            "first_error": first_error_line(output),
            "unresolved_old_symbol_diagnostic_count": unresolved_count(output, spec.old),
            "repair_sites": repaired_sites,
            "downstream_reference_sites_repaired": len(repaired_sites),
            "distinct_production_files_or_modules_repaired": len(production_files),
            "production_files_or_modules_repaired": production_files,
            "distinct_verification_files_or_modules_repaired": len(verification_files),
            "verification_files_or_modules_repaired": verification_files,
            "changed_production_reference_lines": len({(x['path'], x['line']) for x in production_sites}),
            "changed_verification_reference_lines": len({(x['path'], x['line']) for x in verification_sites}),
            "total_project_owned_reference_repair_lines": len({(x['path'], x['line']) for x in repaired_sites}),
            "third_party_dependency_files_touched": 0,
            "all_repairs_pure_identifier_substitutions": True,
            "repaired_compile_success": repaired_ok,
            "final_canonical_verification_success": repaired_ok,
            "canonical": canonical,
        }
    finally:
        for path, text in original_map.items():
            path.write_text(text, encoding="utf-8")
        # Re-establish pristine source/build alignment for the next independent mutation.
        reset_log = out / "reset-baseline.log"
        reset_code, _, reset_out = compile_internal(formalization, reset_log)
        if reset_code != 0:
            raise ExperimentError(f"failed to restore internal baseline after {mutation.id}:\n{reset_out}")


def comparator_code_references(text: str, old: str) -> list[dict[str, Any]]:
    return [
        {"path": COMPARATOR_PATH, "line": line_of(text, start), "ownership": "production_project_owned"}
        for start, _ in identifier_spans(text, old)
    ]


def run_comparator_mutation(
    formalization: Path, original: str, mutation: Mutation, out: Path, source_path: Path
) -> dict[str, Any]:
    spec = mutation.comparator
    dspan = declaration_span(original, spec.old)
    decl_line = line_of(original, dspan[0])
    all_refs = comparator_code_references(original, spec.old)
    declaration_candidates = [r for r in all_refs if r["line"] == decl_line]
    if len(declaration_candidates) != 1:
        raise ExperimentError(f"could not isolate comparator declaration occurrence: {mutation.id}")
    downstream = list(all_refs)
    downstream.remove(declaration_candidates[0])

    mutated = replace_spans(original, [dspan], spec.new)
    source_path.write_text(mutated, encoding="utf-8")
    remaining_spans = identifier_spans(mutated, spec.old)
    if len(remaining_spans) != len(downstream):
        raise ExperimentError(f"comparator declaration-only mutation occurrence mismatch: {mutation.id}")

    code, wall, output = compile_comparator(formalization, source_path, out / "mutated-failure.log")
    observable = bool(downstream)
    if observable and code == 0:
        raise ExperimentError(f"expected comparator mutation failure but compile succeeded: {mutation.id}")
    if not observable and code != 0:
        raise ExperimentError(f"unreferenced comparator rename unexpectedly failed: {mutation.id}")

    repair_sites = [
        {"path": COMPARATOR_PATH, "line": line_of(mutated, start), "ownership": "production_project_owned"}
        for start, _ in remaining_spans
    ]
    repaired = replace_spans(mutated, remaining_spans, spec.new)
    source_path.write_text(repaired, encoding="utf-8")
    if identifier_spans(repaired, spec.old):
        raise ExperimentError(f"old comparator references remain after repair: {mutation.id}")
    repaired_code, repaired_wall, repaired_output = compile_comparator(
        formalization, source_path, out / "repaired.log"
    )
    if repaired_code != 0:
        raise ExperimentError(f"repaired comparator compile failed: {mutation.id}\n{repaired_output}")

    source_path.write_text(original, encoding="utf-8")
    return {
        "artifact": "comparator",
        "mutation_id": mutation.id,
        "logical_role": mutation.role,
        "declaration": {"path": COMPARATOR_PATH, "old": spec.old, "new": spec.new, "line": decl_line},
        "downstream_reference_sites_before": downstream,
        "mutation_observable": observable,
        "mutated_compile_exit": code,
        "mutated_compile_wall_seconds_metadata_only": wall,
        "first_error": first_error_line(output),
        "unresolved_old_symbol_diagnostic_count": unresolved_count(output, spec.old),
        "repair_sites": repair_sites,
        "downstream_reference_sites_repaired": len(repair_sites),
        "distinct_production_files_or_modules_repaired": 1 if repair_sites else 0,
        "production_files_or_modules_repaired": [COMPARATOR_PATH] if repair_sites else [],
        "distinct_verification_files_or_modules_repaired": 0,
        "verification_files_or_modules_repaired": [],
        "changed_production_reference_lines": len({x["line"] for x in repair_sites}),
        "changed_verification_reference_lines": 0,
        "total_project_owned_reference_repair_lines": len({x["line"] for x in repair_sites}),
        "third_party_dependency_files_touched": 0,
        "all_repairs_pure_identifier_substitutions": True,
        "repaired_compile_success": True,
        "final_canonical_verification_success": True,
        "repaired_compile_wall_seconds_metadata_only": repaired_wall,
    }


def markdown(data: dict[str, Any]) -> str:
    lines = [
        "# S2c Repair-Locality Execution Summary",
        "",
        f"- experiment commit: `{data['experiment_commit']}`",
        f"- frozen internal baseline: `{data['internal_baseline']}`",
        f"- comparator: `{data['comparator']['commit']}` / `{data['comparator']['blob']}`",
        f"- predeclaration commit: `{data['predeclaration_commit']}`",
        "",
        "| mutation | artifact | observable break | repaired refs | production modules/files | verification modules/files | repair lines | third-party touches | repaired green |",
        "|---|---|---|---:|---:|---:|---:|---:|---|",
    ]
    for obs in data["observations"]:
        lines.append(
            f"| {obs['mutation_id']} | {obs['artifact']} | {obs['mutation_observable']} | "
            f"{obs['downstream_reference_sites_repaired']} | "
            f"{obs['distinct_production_files_or_modules_repaired']} | "
            f"{obs['distinct_verification_files_or_modules_repaired']} | "
            f"{obs['total_project_owned_reference_repair_lines']} | "
            f"{obs['third_party_dependency_files_touched']} | "
            f"{obs['repaired_compile_success']} |"
        )
    lines += [
        "",
        "Interpretation is intentionally limited to the predeclared symbol/API reference-repair blast radius.",
        "File count is not interpreted alone because the comparator packages the proof primarily in one source module.",
        "Timing fields in JSON/logs are apparatus metadata only and are not repair-effort measurements.",
    ]
    return "\n".join(lines) + "\n"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--repo-root", type=Path, required=True)
    ap.add_argument("--output-dir", type=Path, required=True)
    args = ap.parse_args()
    repo = args.repo_root.resolve()
    formalization = repo / "formalization"
    out = args.output_dir.resolve()
    out.mkdir(parents=True, exist_ok=True)

    experiment_commit = git(repo, "rev-parse", "HEAD")
    predeclared_hashes = validate_predeclaration(repo)
    validate_internal_source_baseline(repo)
    env = validate_environment(formalization)

    # Establish a green internal baseline once before any mutation observation.
    baseline_code, baseline_wall, baseline_out = compile_internal(
        formalization, out / "internal-baseline.log"
    )
    if baseline_code != 0:
        raise ExperimentError("internal baseline is not green")

    comparator_git = out / "comparator-git"
    comparator_bytes, comparator_identity = fetch_comparator(comparator_git)
    comparator_text = comparator_bytes.decode("utf-8")
    comparator_source = out / "Erdos678Comparator.lean"
    comparator_source.write_text(comparator_text, encoding="utf-8")
    comp_code, comp_wall, comp_out = compile_comparator(
        formalization, comparator_source, out / "comparator-baseline.log"
    )
    if comp_code != 0:
        raise ExperimentError(f"comparator baseline is not green:\n{comp_out}")

    observations: list[dict[str, Any]] = []
    for mutation in MUTATIONS:
        mdir = out / mutation.id
        (mdir / "internal").mkdir(parents=True, exist_ok=True)
        (mdir / "comparator").mkdir(parents=True, exist_ok=True)
        observations.append(run_internal_mutation(repo, formalization, mutation, mdir / "internal"))
        observations.append(
            run_comparator_mutation(
                formalization,
                comparator_text,
                mutation,
                mdir / "comparator",
                comparator_source,
            )
        )

    validate_internal_source_baseline(repo)
    if git(repo, "diff", "--name-only", "--", "formalization").strip():
        raise ExperimentError("formalization working tree not clean after S2c execution")

    result = {
        "schema_version": 1,
        "stage": "S2c-repair-locality",
        "status": "executed-success",
        "experiment_commit": experiment_commit,
        "predeclaration_commit": PREDECLARATION_COMMIT,
        "predeclared_file_sha256": predeclared_hashes,
        "internal_baseline": INTERNAL_BASELINE,
        "environment": env,
        "internal_baseline_compile": {
            "exit": baseline_code,
            "wall_seconds_metadata_only": baseline_wall,
            "build_completed_8808_jobs": "Build completed successfully (8808 jobs)" in baseline_out,
        },
        "comparator": comparator_identity,
        "comparator_baseline_compile": {
            "exit": comp_code,
            "wall_seconds_metadata_only": comp_wall,
        },
        "mutation_count": len(MUTATIONS),
        "observation_count": len(observations),
        "observations": observations,
        "third_party_dependency_files_touched_total": sum(
            x["third_party_dependency_files_touched"] for x in observations
        ),
        "interpretation_scope": "predeclared-symbol-api-reference-repair-locality-only",
        "timing_is_repair_cost_metric": False,
        "hidden_chain_of_thought_required": False,
    }
    (out / "result.json").write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    (out / "summary.md").write_text(markdown(result), encoding="utf-8")
    print(markdown(result))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ExperimentError, subprocess.TimeoutExpired) as exc:
        print(f"S2c experiment failed closed: {exc}", file=sys.stderr)
        raise SystemExit(2)
