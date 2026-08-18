#!/usr/bin/env python3
"""Instrumentation-only timeout repair for the frozen Erdős #678 S2e apparatus.

The first S2e detection attempt (run 32114757196) was excluded before U1/U2
because the mandatory baseline ``lake build Formalization`` exceeded the core
harness's 2400-second subprocess timeout.  The S2e protocol does not freeze a
subprocess timeout and requires a green baseline before any candidate receives
credit.

This wrapper deliberately changes only the timeout supplied to ``lake build``
commands.  Candidate identities, D0--D6 stages, sentinels, ownership taxonomy,
repair scope/budgets, source-fidelity guards, and interpretation rules remain in
the already integrated core apparatus.
"""

from __future__ import annotations

import importlib.util
import sys
from pathlib import Path
from typing import Any, Sequence

WRAPPER_REL = "problems/678/experiments/s2_upgrade_robustness_timeoutfix.py"
CORE_REL = "problems/678/experiments/s2_upgrade_robustness.py"
MIN_LAKE_BUILD_TIMEOUT_SECONDS = 7200


def load_core() -> Any:
    core_path = Path(__file__).with_name("s2_upgrade_robustness.py")
    spec = importlib.util.spec_from_file_location("erdos678_s2e_core", core_path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load frozen S2e core apparatus: {core_path}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def main() -> int:
    core = load_core()
    original = core.command_with_log

    def command_with_extended_build_timeout(
        cmd: Sequence[str], *args: Any, **kwargs: Any
    ) -> Any:
        command = list(cmd)
        if command[:2] == ["lake", "build"]:
            requested = kwargs.get("timeout")
            if requested is None or int(requested) < MIN_LAKE_BUILD_TIMEOUT_SECONDS:
                kwargs["timeout"] = MIN_LAKE_BUILD_TIMEOUT_SECONDS
        return original(cmd, *args, **kwargs)

    # Keep the frozen core logic intact while making provenance point to the
    # instrumentation repair that is actually being executed.
    core.command_with_log = command_with_extended_build_timeout
    core.APPARATUS = WRAPPER_REL
    return int(core.main())


if __name__ == "__main__":
    raise SystemExit(main())
