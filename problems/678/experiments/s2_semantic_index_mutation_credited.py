#!/usr/bin/env python3
"""Credited S2d runner with corrected comparator logical-layer classifier.

Run 32074822049 revealed an instrumentation-only classification defect: the
comparator theorem `main_theorem`, whose type is `MainTheoremStatement`, was
bucketed as a generic local lemma.  The frozen mutations and all semantic checks
remain unchanged.  This wrapper corrects only that classifier and reruns the
complete six-observation experiment prospectively from pristine baselines.
"""

from __future__ import annotations

import subprocess
import sys

import s2_semantic_index_mutation as base

_ORIGINAL_CLASSIFIER = base.classify_comparator_declaration


def corrected_classifier(name: str | None) -> str:
    if name in {
        "MainTheoremStatement",
        "main_theorem",
        "main_theorem_given_pnt",
        "main_theorem_expanded",
    }:
        return "strong_theorem"
    return _ORIGINAL_CLASSIFIER(name)


base.classify_comparator_declaration = corrected_classifier


if __name__ == "__main__":
    try:
        raise SystemExit(base.main())
    except (base.ExperimentError, subprocess.TimeoutExpired) as exc:
        print(f"S2d experiment failed closed: {exc}", file=sys.stderr)
        raise SystemExit(2)
