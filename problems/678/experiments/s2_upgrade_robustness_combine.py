#!/usr/bin/env python3
"""Fail-closed combiner for parallel frozen S2e U1/U2 detection artifacts.

This file does not execute candidates. It accepts exactly one completed U1
artifact and one completed U2 artifact from the same workflow/apparatus commit,
rejects apparatus-invalid, ownership-invalid, or provenance-mismatched inputs,
and emits the single complete-set reproducibility artifact required for
scientific credit.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import shutil
from pathlib import Path
from typing import Any

EXPERIMENT = "erdos-678-s2e-upgrade-robustness"
BASELINE_COMMIT = "5039d464f6196e6b47494f0a6fae869e3362d082"
EXPECTED = {
    "U1": "U1-lean-4.34.0-rc1-compiler-only",
    "U2": "U2-lean-mathlib-4.34.0-rc1-root-upgrade",
}
OWNER_CLASSES = frozenset(
    {
        "apparatus_or_provenance",
        "package_resolution",
        "lean_toolchain",
        "mathlib_or_transitive_dependency",
        "pnt_dependency_support",
        "project_owned",
        "ambiguous",
    }
)


class CombineError(RuntimeError):
    pass


def sha256_file(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def failed_owner(short: str, label: str, stage: Any) -> str | None:
    if not isinstance(stage, dict) or stage.get("status") != "failed":
        return None
    owner = stage.get("failure", {}).get("owner")
    if owner not in OWNER_CLASSES:
        raise CombineError(f"{short} {label} failed without a valid owner: {owner}")
    return str(owner)


def expected_primary_owner(short: str, detection: dict[str, Any]) -> str | None:
    """Re-derive the frozen primary owner in D1→D6 order, fail-closed.

    D0 is a validity gate, not a creditable compatibility failure: any non-green
    D0 invalidates the candidate set.  Once D0 is green, the first retained
    failed scientific stage supplies the required primary owner.  D2 is kept in
    its prospectively frozen sentinel order.  D6 is checked as mk_all followed
    by the full build.
    """

    d0 = detection.get("D0")
    if not isinstance(d0, dict) or d0.get("status") != "green":
        raise CombineError(f"{short} D0 is not green; candidate provenance is invalid")

    d1 = detection.get("D1")
    owner = failed_owner(short, "D1", d1)
    if owner is not None:
        return owner
    if not isinstance(d1, dict) or d1.get("status") != "green":
        raise CombineError(f"{short} D1 is neither green nor a classified failure")

    d2 = detection.get("D2")
    if not isinstance(d2, list):
        raise CombineError(f"{short} D2 is not a list")
    for index, stage in enumerate(d2, start=1):
        owner = failed_owner(short, f"D2[{index}]", stage)
        if owner is not None:
            return owner

    for label in ("D3", "D4", "D5"):
        owner = failed_owner(short, label, detection.get(label))
        if owner is not None:
            return owner

    d6 = detection.get("D6")
    if isinstance(d6, dict):
        for key, label in (("mk_all", "D6:mk_all"), ("full_build", "D6:full_build")):
            owner = failed_owner(short, label, d6.get(key))
            if owner is not None:
                return owner

    survivor = detection.get("full_no_repair_survivor")
    if survivor is True:
        return None
    if survivor is not False:
        raise CombineError(f"{short} full_no_repair_survivor is not boolean")
    raise CombineError(f"{short} is a non-survivor but has no classified failed stage")


def validate_candidate_ownership(short: str, item: dict[str, Any]) -> None:
    detection = item.get("detection")
    if not isinstance(detection, dict):
        raise CombineError(f"{short} detection result missing")
    expected = expected_primary_owner(short, detection)
    observed = item.get("primary_failure_owner")
    if expected is None:
        if observed is not None:
            raise CombineError(
                f"{short} full survivor has unexpected primary owner: {observed}"
            )
    elif observed != expected:
        raise CombineError(
            f"{short} primary owner mismatch: observed={observed} expected={expected}"
        )


def load_candidate(short: str, root: Path) -> dict[str, Any]:
    failure = root / "APPARATUS_FAILURE.json"
    if failure.exists():
        raise CombineError(f"{short} contains APPARATUS_FAILURE.json")
    result_path = root / "result.json"
    if not result_path.is_file():
        raise CombineError(f"{short} result.json missing")
    result = json.loads(result_path.read_text(encoding="utf-8"))
    if result.get("experiment") != EXPERIMENT:
        raise CombineError(f"{short} experiment mismatch")
    if result.get("phase") != "detection":
        raise CombineError(f"{short} phase is not detection")
    provenance = result.get("provenance", {})
    if provenance.get("baseline_commit") != BASELINE_COMMIT:
        raise CombineError(f"{short} baseline provenance mismatch")
    baseline = result.get("baseline", {})
    if baseline.get("status") != "green":
        raise CombineError(f"{short} baseline is not green")
    candidates = result.get("candidates")
    if not isinstance(candidates, list) or len(candidates) != 1:
        raise CombineError(f"{short} must contain exactly one candidate")
    item = candidates[0]
    if item.get("candidate_id") != EXPECTED[short]:
        raise CombineError(
            f"{short} candidate mismatch: {item.get('candidate_id')} != {EXPECTED[short]}"
        )
    if "repair" in item:
        raise CombineError(f"{short} detection artifact unexpectedly contains repair output")
    validate_candidate_ownership(short, item)
    return result


def write_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--u1", type=Path, required=True)
    parser.add_argument("--u2", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    u1_root = args.u1.resolve()
    u2_root = args.u2.resolve()
    output = args.output.resolve()
    if output.exists():
        shutil.rmtree(output)
    output.mkdir(parents=True)

    try:
        results = {"U1": load_candidate("U1", u1_root), "U2": load_candidate("U2", u2_root)}
        p1 = results["U1"]["provenance"]
        p2 = results["U2"]["provenance"]
        common_keys = (
            "repository",
            "workflow_commit",
            "apparatus_commit",
            "baseline_commit",
            "predeclaration_head",
            "predeclaration_merge",
            "protocol_sha256",
            "matrix_sha256",
        )
        mismatches = [key for key in common_keys if p1.get(key) != p2.get(key)]
        if mismatches:
            raise CombineError(f"U1/U2 provenance mismatch: {mismatches}")

        limits1 = results["U1"].get("scientific_limits")
        limits2 = results["U2"].get("scientific_limits")
        if limits1 != limits2:
            raise CombineError("U1/U2 scientific-limit contract mismatch")

        raw_root = output / "raw_candidate_artifacts"
        shutil.copytree(u1_root, raw_root / "U1")
        shutil.copytree(u2_root, raw_root / "U2")

        combined_candidates = [
            results["U1"]["candidates"][0],
            results["U2"]["candidates"][0],
        ]
        combined = {
            "schema_version": 1,
            "experiment": EXPERIMENT,
            "phase": "detection-complete-frozen-set",
            "status": "executed-success",
            "credited_candidate_count": 2,
            "candidate_ids": [EXPECTED["U1"], EXPECTED["U2"]],
            "provenance": {key: p1.get(key) for key in common_keys},
            "baseline_validations": {
                "U1_job": results["U1"]["baseline"],
                "U2_job": results["U2"]["baseline"],
            },
            "candidates": combined_candidates,
            "source_result_sha256": {
                "U1": sha256_file(u1_root / "result.json"),
                "U2": sha256_file(u2_root / "result.json"),
            },
            "scientific_limits": limits1,
        }
        write_json(output / "result.json", combined)

        lines = [
            "# Erdős #678 — S2e Complete Frozen-Set Detection",
            "",
            f"- workflow commit: `{p1.get('workflow_commit')}`",
            f"- apparatus commit: `{p1.get('apparatus_commit')}`",
            f"- baseline commit: `{BASELINE_COMMIT}`",
            "- credited candidates: `2/2`",
            "",
        ]
        for short, item in zip(("U1", "U2"), combined_candidates, strict=True):
            detection = item["detection"]
            lines.extend(
                [
                    f"## {short}",
                    "",
                    f"- candidate: `{item['candidate_id']}`",
                    f"- full no-repair survivor: `{detection.get('full_no_repair_survivor')}`",
                    f"- deepest green stage: `{detection.get('deepest_green_stage')}`",
                    f"- primary failure owner: `{item.get('primary_failure_owner')}`",
                    "",
                ]
            )
        lines.extend(
            [
                "## Interpretation boundary",
                "",
                "This artifact combines only the two prospectively frozen S2e candidates. "
                "Dependency-support blockers are supply-chain/version-boundary observations, "
                "not proof-quality defects. Timing is apparatus metadata only.",
                "",
            ]
        )
        (output / "SUMMARY.md").write_text("\n".join(lines), encoding="utf-8")
        write_json(
            output / "COMBINE_AUDIT.json",
            {
                "status": "PASS",
                "accepted_candidates": ["U1", "U2"],
                "input_apparatus_failures": 0,
                "provenance_mismatches": [],
                "ownership_validation": "PASS",
                "repair_outputs_present": 0,
            },
        )
        print(json.dumps({"status": "PASS", "candidate_count": 2}, sort_keys=True))
        return 0
    except (CombineError, OSError, ValueError, KeyError) as exc:
        write_json(
            output / "COMBINE_FAILURE.json",
            {"status": "FAIL", "error": f"{type(exc).__name__}: {exc}"},
        )
        print(f"combine failure: {type(exc).__name__}: {exc}")
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
