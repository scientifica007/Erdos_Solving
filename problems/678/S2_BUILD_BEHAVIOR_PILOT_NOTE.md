# S2b Pilot Note — excluded from credited timing baseline

## Identity

- pilot apparatus commit: `a349010e295afa52d040feacbb2d02d5c081c548`;
- workflow run: `32052134207`;
- matrix jobs: 6/6 completed successfully;
- planned order pattern: internal-first / comparator-first alternating across replicates 1–6;
- comparator commit/blob: `6f906fef432892db5c910c48ad1a3728dd42cdac` / `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.

## Why this run is excluded

The predeclared S2b protocol requires the actual GitHub runner version, runner image identity, and toolchain/dependency identities to be recorded for every credited result. The pilot artifacts correctly recorded the runner image, Lean, Mathlib, PNT+, commit/blob, CPU, and memory identities, but `runner_version` was `unknown` in every `result.json`.

The GitHub job log did expose the runner software version at job startup, showing that the missing value was an instrumentation deficiency rather than an unknown execution environment. Nevertheless, the protocol required the value to be captured in the result evidence itself. The six timing observations are therefore **not admitted to the scientific baseline**.

No result was excluded for being fast, slow, favorable, or unfavorable. The entire pilot run is excluded as one apparatus version because a predeclared identity invariant failed uniformly.

## Corrective action

`problems/678/experiments/s2_build_behavior.py` was revised after the pilot to recover the runner version from process metadata / supported environment fallbacks and to **fail closed** if the runner version or image identity cannot be recorded. All six predeclared replicates must be rerun on the corrected apparatus commit before S2b receives timing credit.

## Methodological significance

This is retained as process evidence for the AI-for-science case study. A workflow can be green and every build can succeed while the resulting measurements remain scientifically inadmissible because required provenance metadata is incomplete. Success of computation and validity of measurement are separate gates.

`DEC-012` remains in force; this pilot concerns archived Erdős #678 only.
