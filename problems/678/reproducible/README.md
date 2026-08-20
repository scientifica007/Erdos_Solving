# Erdős #678 — Reproducible Research Package v1

This directory is the curated, reproducible entry point for the completed Erdős Problem #678 project.

It is intentionally **not** a replacement for `problems/678/`, which remains the historical research record: failed paths, corrections, excluded runs, experimental protocols, and closure evidence stay there. This package provides a stable map from the mathematical statement to the machine-checked formalization, verification evidence, scientific-evaluation claims, and the shared fact base for the two planned papers.

## What this package lets an independent reader do

A new researcher or AI agent should be able to:

1. identify the exact mathematical claim and its attribution;
2. inspect the proof architecture without first reading the full project history;
3. verify the Lean/Mathlib/PNT+ dependency pins;
4. locate the canonical theorem endpoints and regression tests;
5. run the canonical import-graph check and full Lean build;
6. trace publication claims to persistent evidence;
7. distinguish established results, bounded observations, hypotheses, and unsupported claims;
8. understand which historical runs were excluded and why.

## Quick start

From the repository root:

```bash
bash problems/678/reproducible/scripts/reproduce.sh
```

The script first validates the package metadata and source references, then runs the repository's canonical Lean checks:

```bash
cd formalization
lake exe mk_all --check
lake build Formalization
```

A successful run ends with `ERDOS678 REPRODUCTION SUCCESS`.

## Directory map

- `REPRODUCIBILITY_WORKPLAN.md` — R0–R7 construction and audit plan.
- `REPRODUCIBILITY_MANIFEST.json` — machine-readable environment, endpoints, evidence, and attribution metadata.
- `CLAIM_EVIDENCE_MATRIX.json` — central publication claim-to-evidence registry.
- `REPRODUCE.md` — human-readable reproduction procedure.
- `mathematics/` — canonical problem statement and proof map.
- `formalization/` — formalization architecture, entry points, and dependency description.
- `verification/` — statement-fidelity, regression, and CI/provenance interpretation.
- `evaluation/` — bounded S1/S2 scientific-evaluation summary.
- `evidence/` — machine-readable evidence index.
- `papers/` — shared fact base and paper-specific claim allowlists.
- `scripts/` — package consistency checker and end-to-end reproduction entry point.

## Source-of-truth rule

There is no duplicate Lean source tree here. The canonical proof remains under:

`formalization/Formalization/Erdos678/`

This package references and verifies that source instead of copying it. That prevents two proof trees from silently diverging.

## Scientific classification

- Mathematical result: known.
- Mathematical author: Stijn Cambie (2024).
- Successful project mode: external-proof reconstruction.
- Project contribution: independent Lean reimplementation, statement bridges, differential verification, reproducibility/provenance discipline, and bounded scientific evaluation.
- New mathematical proof claim: false.
- First formalization claim: false.

## Publication role

This package is the common evidentiary substrate for:

- Paper 1: formal verification / proof engineering;
- Paper 2: AI-assisted scientific production / workflow governance.

Paper prose may summarize or interpret this package, but central claims should remain traceable to `CLAIM_EVIDENCE_MATRIX.json` and the persistent evidence it references.

## Scope

This directory concerns archived Erdős #678 only. It does not activate or authorize work on any other Erdős problem.
