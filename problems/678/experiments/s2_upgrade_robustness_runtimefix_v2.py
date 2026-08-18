#!/usr/bin/env python3
"""Second instrumentation-only runtime repair for frozen Erdős #678 S2e.

Two complete S2e detection attempts were excluded before U1/U2 because the
mandatory baseline ``lake build Formalization`` exceeded harness-local timeouts
(2400s, then 7200s).  The frozen protocol requires an exact, green baseline but
does not require that baseline validation be cold/no-cache; timing is apparatus
metadata only.

This wrapper therefore accelerates *only* the disposable baseline-validation
worktree with the official Mathlib cache before the frozen mk_all/full-build
checks.  Candidate worktrees are created after baseline validation and receive
no cache prefetch from this wrapper.  It also raises lake-build subprocess
headroom so an otherwise valid candidate compile is not truncated by the old
instrumentation cutoff.

A later excluded complete-set run exposed one classifier defect in the frozen
core: ``candidate_primary_owner`` skipped D1, so a retained D1
``package_resolution`` failure was emitted with a null top-level primary owner.
This wrapper corrects only that classifier wiring; it does not change D1 setup,
resolution commands, candidate identities, or any compatibility stage.

Candidate identities, D0--D6, sentinels, package-resolution rules, ownership
taxonomy, repair scope/budgets, statement-fidelity guards, and interpretation
rules remain entirely in the integrated frozen core apparatus.
"""

from __future__ import annotations

import importlib.util
import sys
from contextlib import contextmanager
from pathlib import Path
from typing import Any, Callable, Iterator, Sequence

WRAPPER_REL = "problems/678/experiments/s2_upgrade_robustness_runtimefix_v2.py"
CORE_REL = "problems/678/experiments/s2_upgrade_robustness.py"
MIN_LAKE_BUILD_TIMEOUT_SECONDS = 18_000
BASELINE_CACHE_TIMEOUT_SECONDS = 1_800


def load_core() -> Any:
    core_path = Path(__file__).with_name("s2_upgrade_robustness.py")
    spec = importlib.util.spec_from_file_location("erdos678_s2e_core_runtime_v2", core_path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load frozen S2e core apparatus: {core_path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def primary_owner_with_d1(
    detection: dict[str, Any],
    owner_classes: set[str] | frozenset[str],
    fallback: Callable[[dict[str, Any]], str | None],
) -> str | None:
    """Return the protocol primary owner while repairing only the omitted D1 case.

    D0 is an apparatus/provenance validity gate and is rejected by the
    complete-set combiner if it is not green.  For a valid D0 followed by a D1
    failure, the frozen D1 failure owner is the primary scientific owner.  All
    D2--D6 behavior delegates unchanged to the integrated core classifier.
    """

    d1 = detection.get("D1")
    if isinstance(d1, dict) and d1.get("status") == "failed":
        owner = d1.get("failure", {}).get("owner")
        return owner if owner in owner_classes else "ambiguous"
    return fallback(detection)


def main() -> int:
    core = load_core()

    original_command_with_log = core.command_with_log
    original_validate_baseline = core.validate_baseline
    original_baseline_worktree = core.baseline_worktree
    original_candidate_primary_owner = core.candidate_primary_owner

    def command_with_runtime_headroom(
        cmd: Sequence[str], *args: Any, **kwargs: Any
    ) -> Any:
        command = list(cmd)
        if command[:2] == ["lake", "build"]:
            requested = kwargs.get("timeout")
            if requested is None or int(requested) < MIN_LAKE_BUILD_TIMEOUT_SECONDS:
                kwargs["timeout"] = MIN_LAKE_BUILD_TIMEOUT_SECONDS
        return original_command_with_log(cmd, *args, **kwargs)

    def validate_baseline_with_private_cache(repo: Path, temp_root: Path, output: Path) -> Any:
        @contextmanager
        def baseline_only_cached_worktree(
            repo_arg: Path, parent: Path, name: str
        ) -> Iterator[Path]:
            with original_baseline_worktree(repo_arg, parent, name) as work:
                if name == "baseline":
                    formalization = work / "formalization"
                    log_path = output / "baseline" / "cache_prefetch.log"
                    measured = original_command_with_log(
                        ["lake", "exe", "cache", "get"],
                        cwd=formalization,
                        log_path=log_path,
                        timeout=BASELINE_CACHE_TIMEOUT_SECONDS,
                        network_retries=2,
                    )
                    if measured["returncode"] != 0:
                        raise core.ExperimentError(
                            "baseline-only Mathlib cache prefetch failed; see cache_prefetch.log"
                        )
                    status = core.run(
                        ["git", "status", "--porcelain", "--untracked-files=no"],
                        cwd=work,
                    )
                    if status.returncode != 0 or (status.stdout or "").strip():
                        raise core.ExperimentError(
                            "baseline cache prefetch changed tracked repository files"
                        )
                    core.write_json(
                        output / "baseline" / "cache_prefetch.json",
                        {
                            "status": "green",
                            "scope": "disposable-baseline-worktree-only",
                            "command": ["lake", "exe", "cache", "get"],
                            "candidate_cache_prefetch": False,
                            "attempts": measured["attempts"],
                        },
                    )
                yield work

        previous = core.baseline_worktree
        core.baseline_worktree = baseline_only_cached_worktree
        try:
            return original_validate_baseline(repo, temp_root, output)
        finally:
            core.baseline_worktree = previous

    def candidate_primary_owner_with_d1(detection: dict[str, Any]) -> str | None:
        return primary_owner_with_d1(
            detection,
            core.OWNER_CLASSES,
            original_candidate_primary_owner,
        )

    core.command_with_log = command_with_runtime_headroom
    core.validate_baseline = validate_baseline_with_private_cache
    core.candidate_primary_owner = candidate_primary_owner_with_d1
    core.APPARATUS = WRAPPER_REL
    return int(core.main())


if __name__ == "__main__":
    raise SystemExit(main())
