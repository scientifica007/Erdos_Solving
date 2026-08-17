#!/usr/bin/env python3
"""Controlled paired build measurements for archived Erdős #678 S2b.

This script deliberately measures artifact-owned Lake rebuild behavior inside
one pinned Erdos_Solving environment.  It does not measure network/setup time
and it does not make architecture-superiority claims.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import shutil
import statistics
import subprocess
import sys
import time
from pathlib import Path
from typing import Any

EXPECTED_LEAN_VERSION = "4.33.0"
EXPECTED_PNT_REV = "2667e414c38e5a5dc9aa1946f16f13001e5cd3ed"
EXPECTED_MATHLIB_INPUT = "v4.33.0"
EXPECTED_COMPARATOR_COMMIT = "6f906fef432892db5c910c48ad1a3728dd42cdac"
EXPECTED_COMPARATOR_BLOB = "f2331e8bcc71bc36cce7724a0c54fafd8d64d480"
COMPARATOR_REPO = "https://github.com/plby/lean-proofs.git"
COMPARATOR_PATH = "src/latest/ErdosProblems/Erdos678.lean"

INTERNAL_TARGET = "Formalization.Erdos678.Erdos678Final"
COMPARATOR_TARGET = "Formalization.Erdos678Benchmark.Comparator"


class ExperimentError(RuntimeError):
    pass


def run_checked(cmd: list[str], *, cwd: Path, capture: bool = True) -> subprocess.CompletedProcess[str]:
    proc = subprocess.run(
        cmd,
        cwd=cwd,
        text=True,
        stdout=subprocess.PIPE if capture else None,
        stderr=subprocess.STDOUT if capture else None,
        check=False,
    )
    if proc.returncode != 0:
        output = proc.stdout or ""
        raise ExperimentError(f"command failed ({proc.returncode}): {' '.join(cmd)}\n{output}")
    return proc


def git(repo_root: Path, *args: str) -> str:
    return run_checked(["git", *args], cwd=repo_root).stdout.strip()


def read_manifest(formalization: Path) -> tuple[str, str, str]:
    data = json.loads((formalization / "lake-manifest.json").read_text(encoding="utf-8"))
    packages = {p["name"]: p for p in data["packages"]}
    pnt = packages["PrimeNumberTheoremAnd"]
    mathlib = packages["mathlib"]
    return pnt["rev"], mathlib["inputRev"], mathlib["rev"]


def lean_version(formalization: Path) -> str:
    output = run_checked(["lean", "--version"], cwd=formalization).stdout.strip()
    m = re.search(r"Lean \(version ([^,]+)", output)
    if not m:
        raise ExperimentError(f"could not parse Lean version: {output}")
    return m.group(1)


def runner_version() -> str:
    roots = [Path("/home/runner/runners"), Path("/opt/actions-runner")]
    for root in roots:
        if not root.exists():
            continue
        candidates = sorted(root.rglob("Runner.Listener"))
        for candidate in candidates[:5]:
            try:
                proc = subprocess.run(
                    [str(candidate), "--version"],
                    text=True,
                    stdout=subprocess.PIPE,
                    stderr=subprocess.STDOUT,
                    timeout=5,
                    check=False,
                )
                text = proc.stdout.strip()
                if proc.returncode == 0 and text:
                    return text.splitlines()[-1].strip()
            except (OSError, subprocess.TimeoutExpired):
                pass
        for child in sorted(root.iterdir()):
            if re.fullmatch(r"\d+\.\d+\.\d+", child.name):
                return child.name
    return "unknown"


def mem_total_kib() -> int | None:
    try:
        for line in Path("/proc/meminfo").read_text(encoding="utf-8").splitlines():
            if line.startswith("MemTotal:"):
                return int(line.split()[1])
    except OSError:
        return None
    return None


def environment_metadata(formalization: Path) -> dict[str, Any]:
    pnt_rev, mathlib_input, mathlib_rev = read_manifest(formalization)
    version = lean_version(formalization)
    if version != EXPECTED_LEAN_VERSION:
        raise ExperimentError(f"Lean identity mismatch: {version} != {EXPECTED_LEAN_VERSION}")
    if pnt_rev != EXPECTED_PNT_REV:
        raise ExperimentError(f"PNT identity mismatch: {pnt_rev} != {EXPECTED_PNT_REV}")
    if mathlib_input != EXPECTED_MATHLIB_INPUT:
        raise ExperimentError(f"Mathlib identity mismatch: {mathlib_input} != {EXPECTED_MATHLIB_INPUT}")

    return {
        "lean_version": version,
        "pnt_revision": pnt_rev,
        "mathlib_input_revision": mathlib_input,
        "mathlib_resolved_revision": mathlib_rev,
        "runner_os_context": os.getenv("RUNNER_OS", "unknown"),
        "runner_arch_context": os.getenv("RUNNER_ARCH", "unknown"),
        "runner_image_os": os.getenv("ImageOS", "unknown"),
        "runner_image_version": os.getenv("ImageVersion", "unknown"),
        "runner_version": runner_version(),
        "uname": run_checked(["uname", "-a"], cwd=formalization).stdout.strip(),
        "cpu_count": os.cpu_count(),
        "mem_total_kib": mem_total_kib(),
    }


def fetch_comparator(repo_root: Path, formalization: Path, work: Path) -> dict[str, str]:
    gitdir = work / "comparator-git"
    source_out = formalization / "Formalization" / "Erdos678Benchmark" / "Comparator.lean"
    if work.exists():
        shutil.rmtree(work)
    gitdir.mkdir(parents=True)

    run_checked(["git", "init", "-q"], cwd=gitdir)
    run_checked(["git", "remote", "add", "origin", COMPARATOR_REPO], cwd=gitdir)
    run_checked(
        ["git", "fetch", "--depth=1", "--filter=blob:none", "origin", EXPECTED_COMPARATOR_COMMIT],
        cwd=gitdir,
    )
    actual_commit = run_checked(["git", "rev-parse", "FETCH_HEAD"], cwd=gitdir).stdout.strip()
    actual_blob = run_checked(
        ["git", "rev-parse", f"FETCH_HEAD:{COMPARATOR_PATH}"], cwd=gitdir
    ).stdout.strip()
    if actual_commit != EXPECTED_COMPARATOR_COMMIT:
        raise ExperimentError(f"comparator commit mismatch: {actual_commit}")
    if actual_blob != EXPECTED_COMPARATOR_BLOB:
        raise ExperimentError(f"comparator blob mismatch: {actual_blob}")

    source_bytes = subprocess.check_output(
        ["git", "show", f"FETCH_HEAD:{COMPARATOR_PATH}"], cwd=gitdir
    )
    source_out.parent.mkdir(parents=True, exist_ok=True)
    source_out.write_bytes(source_bytes)

    return {
        "repository": COMPARATOR_REPO,
        "commit": actual_commit,
        "blob": actual_blob,
        "source_path": COMPARATOR_PATH,
        "temporary_module": str(source_out.relative_to(repo_root)),
        "source_bytes": str(len(source_bytes)),
    }


def output_namespaces(formalization: Path, artifact: str) -> list[Path]:
    if artifact == "internal":
        relative = Path("Formalization") / "Erdos678"
    elif artifact == "comparator":
        relative = Path("Formalization") / "Erdos678Benchmark"
    else:
        raise ValueError(artifact)

    roots = [
        formalization / ".lake" / "build" / "lib" / "lean",
        formalization / ".lake" / "build" / "ir",
    ]
    return [root / relative for root in roots]


def remove_artifact_outputs(formalization: Path, artifact: str) -> list[str]:
    removed: list[str] = []
    for path in output_namespaces(formalization, artifact):
        if path.exists():
            removed.append(str(path.relative_to(formalization)))
            if path.is_dir():
                shutil.rmtree(path)
            else:
                path.unlink()
    if not removed:
        raise ExperimentError(
            f"cold cleanup for {artifact} removed nothing; prebuild/output-layout invariant failed"
        )
    return removed


def target_for(artifact: str) -> str:
    if artifact == "internal":
        return INTERNAL_TARGET
    if artifact == "comparator":
        return COMPARATOR_TARGET
    raise ValueError(artifact)


def prebuild(formalization: Path, artifact: str, log_dir: Path) -> None:
    target = target_for(artifact)
    proc = subprocess.run(
        ["lake", "build", target],
        cwd=formalization,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )
    (log_dir / f"prebuild-{artifact}.log").write_text(proc.stdout or "", encoding="utf-8")
    if proc.returncode != 0:
        raise ExperimentError(f"prebuild failed for {artifact}; see prebuild-{artifact}.log")
    existing = [p for p in output_namespaces(formalization, artifact) if p.exists()]
    if not existing:
        raise ExperimentError(f"prebuild produced no recognized output namespace for {artifact}")


def parse_time_metrics(path: Path) -> dict[str, Any]:
    text = path.read_text(encoding="utf-8").strip()
    try:
        data = json.loads(text)
    except json.JSONDecodeError as exc:
        raise ExperimentError(f"could not parse time metrics {path}: {text}") from exc
    data["wall_seconds"] = float(data["wall_seconds"])
    data["user_seconds"] = float(data["user_seconds"])
    data["sys_seconds"] = float(data["sys_seconds"])
    data["max_rss_kib"] = int(data["max_rss_kib"])
    data["exit_code"] = int(data["exit_code"])
    return data


def timed_build(
    formalization: Path,
    artifact: str,
    condition: str,
    replicate: int,
    order_index: int,
    out_dir: Path,
) -> dict[str, Any]:
    target = target_for(artifact)
    stem = f"r{replicate}-{order_index}-{artifact}-{condition}"
    log_path = out_dir / f"{stem}.log"
    time_path = out_dir / f"{stem}.time.json"
    fmt = (
        '{"wall_seconds":%e,"user_seconds":%U,"sys_seconds":%S,'
        '"max_rss_kib":%M,"exit_code":%x}'
    )
    cmd = ["/usr/bin/time", "-f", fmt, "-o", str(time_path), "lake", "build", target]
    started = time.time()
    with log_path.open("w", encoding="utf-8") as log:
        proc = subprocess.run(
            cmd,
            cwd=formalization,
            text=True,
            stdout=log,
            stderr=subprocess.STDOUT,
            check=False,
        )
    finished = time.time()
    metrics = parse_time_metrics(time_path)
    log_text = log_path.read_text(encoding="utf-8")
    built_lines = sum(1 for line in log_text.splitlines() if "Built " in line)
    result = {
        "artifact": artifact,
        "condition": condition,
        "target": target,
        "replicate": replicate,
        "order_index": order_index,
        "process_return_code": proc.returncode,
        "started_unix": started,
        "finished_unix": finished,
        "lake_built_progress_lines": built_lines,
        "log_file": log_path.name,
        "time_file": time_path.name,
        **metrics,
    }
    if proc.returncode != 0 or metrics["exit_code"] != 0:
        raise ExperimentError(f"timed build failed: {stem}; see {log_path}")
    return result


def measure_artifact(
    formalization: Path,
    artifact: str,
    replicate: int,
    order_index: int,
    out_dir: Path,
) -> dict[str, Any]:
    removed = remove_artifact_outputs(formalization, artifact)
    cold = timed_build(formalization, artifact, "cold", replicate, order_index, out_dir)
    warm = timed_build(formalization, artifact, "warm", replicate, order_index, out_dir)
    return {"artifact": artifact, "removed_output_namespaces": removed, "cold": cold, "warm": warm}


def markdown_summary(data: dict[str, Any]) -> str:
    lines = [
        "# S2b replicate summary",
        "",
        f"- experiment commit: `{data['internal_commit']}`",
        f"- replicate: `{data['replicate']}`",
        f"- order: `{' -> '.join(data['order'])}`",
        f"- comparator: `{data['comparator']['commit']}` / `{data['comparator']['blob']}`",
        f"- Lean: `{data['environment']['lean_version']}`",
        f"- runner image: `{data['environment']['runner_image_os']}` / `{data['environment']['runner_image_version']}`",
        "",
        "| artifact | condition | wall s | user s | sys s | max RSS KiB | Built lines |",
        "|---|---|---:|---:|---:|---:|---:|",
    ]
    by_name = {item["artifact"]: item for item in data["measurements"]}
    for artifact in data["order"]:
        item = by_name[artifact]
        for condition in ("cold", "warm"):
            m = item[condition]
            lines.append(
                f"| {artifact} | {condition} | {m['wall_seconds']:.3f} | "
                f"{m['user_seconds']:.3f} | {m['sys_seconds']:.3f} | "
                f"{m['max_rss_kib']} | {m['lake_built_progress_lines']} |"
            )
    lines.extend(
        [
            "",
            "Interpretation boundary: this is one paired hosted-runner replicate under the S2b protocol. "
            "It is not an architecture-superiority claim. Warm measurements are no-change incremental checks, not compilation-speed measurements.",
            "",
        ]
    )
    return "\n".join(lines)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", required=True, type=Path)
    parser.add_argument("--replicate", required=True, type=int, choices=range(1, 7))
    parser.add_argument(
        "--order",
        required=True,
        choices=("internal-first", "comparator-first"),
    )
    parser.add_argument("--output-dir", required=True, type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    repo_root = args.repo_root.resolve()
    formalization = repo_root / "formalization"
    out_dir = args.output_dir.resolve()
    out_dir.mkdir(parents=True, exist_ok=True)

    internal_commit = git(repo_root, "rev-parse", "HEAD")
    github_sha = os.getenv("GITHUB_SHA")
    if github_sha and internal_commit != github_sha:
        raise ExperimentError(f"checked-out commit {internal_commit} != GITHUB_SHA {github_sha}")

    env = environment_metadata(formalization)
    work = Path(os.getenv("RUNNER_TEMP", "/tmp")) / f"erdos678-s2b-r{args.replicate}"
    comparator = fetch_comparator(repo_root, formalization, work)

    # Validate that both Lake target shapes are resolvable and populate the complete
    # prerequisite environment before any timed region.
    prebuild(formalization, "internal", out_dir)
    prebuild(formalization, "comparator", out_dir)

    order = ["internal", "comparator"] if args.order == "internal-first" else ["comparator", "internal"]
    measurements = []
    for index, artifact in enumerate(order, start=1):
        measurements.append(measure_artifact(formalization, artifact, args.replicate, index, out_dir))

    result = {
        "schema_version": 1,
        "metric_scope": "artifact-owned-cold-and-warm-lake-build-behavior-common-environment",
        "internal_commit": internal_commit,
        "replicate": args.replicate,
        "order_label": args.order,
        "order": order,
        "environment": env,
        "internal": {"target": INTERNAL_TARGET},
        "comparator": comparator,
        "measurements": measurements,
        "interpretation_limits": [
            "descriptive paired hosted-runner evidence only",
            "warm is no-change incremental behavior, not compilation speed",
            "no general architecture-superiority inference",
            "no maintenance or repair-locality inference",
        ],
    }

    json_path = out_dir / "result.json"
    md_path = out_dir / "summary.md"
    json_path.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    md_path.write_text(markdown_summary(result), encoding="utf-8")
    print(md_path.read_text(encoding="utf-8"))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except ExperimentError as exc:
        print(f"S2b experiment error: {exc}", file=sys.stderr)
        raise SystemExit(2)
