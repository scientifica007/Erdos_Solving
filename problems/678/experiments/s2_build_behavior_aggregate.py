#!/usr/bin/env python3
"""Aggregate exactly six validated S2b paired build-behavior replicates."""

from __future__ import annotations

import argparse
import json
import math
import statistics
import sys
from pathlib import Path
from typing import Any

EXPECTED_REPLICATES = {
    1: "internal-first",
    2: "comparator-first",
    3: "internal-first",
    4: "comparator-first",
    5: "internal-first",
    6: "comparator-first",
}
EXPECTED_COMPARATOR_COMMIT = "6f906fef432892db5c910c48ad1a3728dd42cdac"
EXPECTED_COMPARATOR_BLOB = "f2331e8bcc71bc36cce7724a0c54fafd8d64d480"
EXPECTED_LEAN = "4.33.0"
EXPECTED_PNT = "2667e414c38e5a5dc9aa1946f16f13001e5cd3ed"
EXPECTED_MATHLIB_INPUT = "v4.33.0"
EXPECTED_SCOPE = "artifact-owned-cold-and-warm-lake-build-behavior-common-environment"


class AggregateError(RuntimeError):
    pass


def load_result(path: Path) -> dict[str, Any]:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as exc:
        raise AggregateError(f"cannot read result {path}: {exc}") from exc
    if data.get("schema_version") != 1:
        raise AggregateError(f"unsupported schema in {path}")
    if data.get("metric_scope") != EXPECTED_SCOPE:
        raise AggregateError(f"metric scope mismatch in {path}")
    return data


def sample_stats(values: list[float]) -> dict[str, float]:
    if len(values) != 6:
        raise AggregateError(f"expected 6 observations, got {len(values)}")
    med = statistics.median(values)
    abs_dev = [abs(x - med) for x in values]
    mad = statistics.median(abs_dev)
    q1, _, q3 = statistics.quantiles(values, n=4, method="inclusive")
    return {
        "n": 6,
        "median": med,
        "minimum": min(values),
        "maximum": max(values),
        "mad": mad,
        "q1": q1,
        "q3": q3,
        "iqr": q3 - q1,
    }


def index_measurements(data: dict[str, Any]) -> dict[str, dict[str, Any]]:
    items = data.get("measurements")
    if not isinstance(items, list) or len(items) != 2:
        raise AggregateError("each replicate must contain exactly two artifact measurements")
    indexed = {item["artifact"]: item for item in items}
    if set(indexed) != {"internal", "comparator"}:
        raise AggregateError("artifact set must be exactly internal/comparator")
    for artifact, item in indexed.items():
        for condition in ("cold", "warm"):
            measurement = item.get(condition)
            if not isinstance(measurement, dict):
                raise AggregateError(f"missing {artifact}/{condition}")
            if measurement.get("exit_code") != 0 or measurement.get("process_return_code") != 0:
                raise AggregateError(f"nonzero build status in {artifact}/{condition}")
    return indexed


def validate(results: list[dict[str, Any]]) -> tuple[str, list[dict[str, Any]]]:
    if len(results) != 6:
        raise AggregateError(f"expected exactly six result files, got {len(results)}")

    by_rep: dict[int, dict[str, Any]] = {}
    commits: set[str] = set()
    for data in results:
        rep = int(data["replicate"])
        if rep in by_rep:
            raise AggregateError(f"duplicate replicate {rep}")
        if rep not in EXPECTED_REPLICATES:
            raise AggregateError(f"unexpected replicate {rep}")
        if data.get("order_label") != EXPECTED_REPLICATES[rep]:
            raise AggregateError(f"order mismatch for replicate {rep}")
        expected_order = ["internal", "comparator"] if EXPECTED_REPLICATES[rep] == "internal-first" else ["comparator", "internal"]
        if data.get("order") != expected_order:
            raise AggregateError(f"artifact order mismatch for replicate {rep}")

        comparator = data.get("comparator", {})
        if comparator.get("commit") != EXPECTED_COMPARATOR_COMMIT:
            raise AggregateError(f"comparator commit mismatch in replicate {rep}")
        if comparator.get("blob") != EXPECTED_COMPARATOR_BLOB:
            raise AggregateError(f"comparator blob mismatch in replicate {rep}")

        env = data.get("environment", {})
        if env.get("lean_version") != EXPECTED_LEAN:
            raise AggregateError(f"Lean mismatch in replicate {rep}")
        if env.get("pnt_revision") != EXPECTED_PNT:
            raise AggregateError(f"PNT mismatch in replicate {rep}")
        if env.get("mathlib_input_revision") != EXPECTED_MATHLIB_INPUT:
            raise AggregateError(f"Mathlib mismatch in replicate {rep}")

        index_measurements(data)
        commits.add(data["internal_commit"])
        by_rep[rep] = data

    if set(by_rep) != set(EXPECTED_REPLICATES):
        raise AggregateError(f"replicate set mismatch: {sorted(by_rep)}")
    if len(commits) != 1:
        raise AggregateError(f"mixed apparatus commits: {sorted(commits)}")
    return next(iter(commits)), [by_rep[i] for i in range(1, 7)]


def aggregate(results: list[dict[str, Any]]) -> dict[str, Any]:
    commit, ordered = validate(results)
    series: dict[str, dict[str, dict[str, list[float]]]] = {
        a: {c: {m: [] for m in ("wall_seconds", "user_seconds", "sys_seconds", "max_rss_kib", "lake_built_progress_lines")} for c in ("cold", "warm")}
        for a in ("internal", "comparator")
    }
    observations: list[dict[str, Any]] = []
    paired: list[dict[str, float | int]] = []

    for data in ordered:
        rep = int(data["replicate"])
        idx = index_measurements(data)
        rep_record: dict[str, Any] = {
            "replicate": rep,
            "order": data["order_label"],
            "runner_image_os": data["environment"].get("runner_image_os"),
            "runner_image_version": data["environment"].get("runner_image_version"),
            "runner_version": data["environment"].get("runner_version"),
            "cpu_count": data["environment"].get("cpu_count"),
            "mem_total_kib": data["environment"].get("mem_total_kib"),
        }
        for artifact in ("internal", "comparator"):
            rep_record[artifact] = {}
            for condition in ("cold", "warm"):
                m = idx[artifact][condition]
                rep_record[artifact][condition] = {k: m[k] for k in series[artifact][condition]}
                for metric in series[artifact][condition]:
                    series[artifact][condition][metric].append(float(m[metric]))
        icold = float(idx["internal"]["cold"]["wall_seconds"])
        ccold = float(idx["comparator"]["cold"]["wall_seconds"])
        paired.append({
            "replicate": rep,
            "internal_minus_comparator_cold_wall_seconds": icold - ccold,
            "internal_over_comparator_cold_wall_ratio": icold / ccold if ccold else math.inf,
        })
        observations.append(rep_record)

    summaries: dict[str, Any] = {}
    for artifact in ("internal", "comparator"):
        summaries[artifact] = {}
        for condition in ("cold", "warm"):
            summaries[artifact][condition] = {
                metric: sample_stats(values) for metric, values in series[artifact][condition].items()
            }

    return {
        "schema_version": 1,
        "metric_scope": EXPECTED_SCOPE,
        "apparatus_commit": commit,
        "replicate_count": 6,
        "orders": [EXPECTED_REPLICATES[i] for i in range(1, 7)],
        "observations": observations,
        "summaries": summaries,
        "paired_cold_wall": paired,
        "interpretation_limits": [
            "descriptive paired GitHub-hosted-runner evidence only",
            "warm measurements are no-change incremental checks, not compilation speed",
            "no general architecture-superiority inference",
            "no maintainability or repair-locality inference",
        ],
    }


def f3(value: Any) -> str:
    return f"{float(value):.3f}"


def markdown(data: dict[str, Any]) -> str:
    lines = [
        "# Erdős #678 — S2b controlled build-behavior baseline",
        "",
        f"Apparatus commit: `{data['apparatus_commit']}`",
        "",
        "## Six paired observations — wall seconds",
        "",
        "| rep | order | internal cold | comparator cold | internal warm | comparator warm | cold Δ (I−C) | cold ratio I/C |",
        "|---:|---|---:|---:|---:|---:|---:|---:|",
    ]
    pair_by_rep = {p["replicate"]: p for p in data["paired_cold_wall"]}
    for obs in data["observations"]:
        rep = obs["replicate"]
        pair = pair_by_rep[rep]
        lines.append(
            f"| {rep} | {obs['order']} | {f3(obs['internal']['cold']['wall_seconds'])} | "
            f"{f3(obs['comparator']['cold']['wall_seconds'])} | {f3(obs['internal']['warm']['wall_seconds'])} | "
            f"{f3(obs['comparator']['warm']['wall_seconds'])} | "
            f"{f3(pair['internal_minus_comparator_cold_wall_seconds'])} | "
            f"{f3(pair['internal_over_comparator_cold_wall_ratio'])} |"
        )

    lines += ["", "## Predeclared wall-time summaries", "", "| artifact | condition | median | min | max | MAD | IQR |", "|---|---|---:|---:|---:|---:|---:|"]
    for artifact in ("internal", "comparator"):
        for condition in ("cold", "warm"):
            s = data["summaries"][artifact][condition]["wall_seconds"]
            lines.append(
                f"| {artifact} | {condition} | {f3(s['median'])} | {f3(s['minimum'])} | {f3(s['maximum'])} | {f3(s['mad'])} | {f3(s['iqr'])} |"
            )

    lines += [
        "",
        "## Interpretation boundary",
        "",
        "These are descriptive paired observations under one pinned Lean/Mathlib/PNT+ environment on six fresh GitHub-hosted runners. Cold means artifact-owned generated outputs were removed after dependency preparation. Warm means an immediate unchanged rebuild of the same target. Warm time is therefore an incremental/no-change check, not compilation speed.",
        "",
        "This baseline alone does not establish general architecture superiority, proof complexity, maintainability, repair locality, or robustness across toolchains/machines/cache regimes.",
        "",
    ]
    return "\n".join(lines)


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser()
    p.add_argument("results", nargs="+", type=Path)
    p.add_argument("--output-json", required=True, type=Path)
    p.add_argument("--output-md", required=True, type=Path)
    return p.parse_args()


def main() -> int:
    args = parse_args()
    results = [load_result(path) for path in args.results]
    data = aggregate(results)
    args.output_json.parent.mkdir(parents=True, exist_ok=True)
    args.output_md.parent.mkdir(parents=True, exist_ok=True)
    args.output_json.write_text(json.dumps(data, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    args.output_md.write_text(markdown(data), encoding="utf-8")
    print(args.output_md.read_text(encoding="utf-8"))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except AggregateError as exc:
        print(f"S2b aggregate error: {exc}", file=sys.stderr)
        raise SystemExit(2)
