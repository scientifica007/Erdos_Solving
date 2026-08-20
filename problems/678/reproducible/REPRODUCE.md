# Reproducing Erdős #678

## Purpose

This document is the human-readable reproduction path. The executable entry point is `scripts/reproduce.sh`.

## Preconditions

A clean clone of this repository with:

- Git;
- Python 3;
- the Lean toolchain manager (`elan`/`lake`) available;
- network access sufficient for the pinned Lean dependencies if they are not already cached.

No local modification of the canonical #678 Lean files is required.

## Step 1 — choose an immutable repository commit

For publication or independent audit, check out the exact commit being evaluated rather than a moving branch name.

Example:

```bash
git checkout <exact-commit>
```

The merged package commit itself is an immutable Git object and can serve as the repository-level v1 freeze. A DOI-backed archive may be added later for publication persistence.

## Step 2 — run the package validator

```bash
python3 problems/678/reproducible/scripts/verify_package.py
```

This verifies:

- JSON schema-level invariants used by this package;
- the exact Lean toolchain string;
- resolved Mathlib and PNT+ revisions in `lake-manifest.json`;
- existence of the canonical theorem declarations;
- existence and semantic tokens of positive/negative regressions;
- evidence paths;
- paper claim references;
- absence of duplicated `.lean` proof sources inside the reproducibility package.

## Step 3 — verify the canonical Lean graph

```bash
cd formalization
lake exe mk_all --check
```

The expected canonical state is `No update necessary`.

This check matters because a Lean file that is not reachable from the generated canonical import graph does not receive project-level verification credit.

## Step 4 — build the full formalization

```bash
lake build Formalization
```

The historical closed #678 graph completed as 8808 jobs under the pinned environment. That number is retained as reference metadata, not as a strict invariant: the reproduction criterion is successful completion of the canonical current graph at the checked-out commit.

## Step 5 — inspect the canonical endpoints

Primary theorem endpoints:

- `Erdos678.erdos678_unbounded_witnesses`;
- `Erdos678.erdos678_good_lengths_infinite`;
- `Erdos678.erdos678_formalConjectures_eventual_nonempty`;
- `Erdos678.cambie_lcm_ratio_eventually_with_large_start_real`.

See `formalization/FORMALIZATION_AND_DEPENDENCIES.md` for locations and dependency structure.

## Step 6 — inspect the regressions

The reproduction package requires the repository to retain both:

- the positive witness `erdosM 36 8 > erdosM 47 9`;
- the rejection `¬ (erdosM 495 8 > erdosM 504 9)`.

These are not the infinitude proof. They are independent concrete semantic checks that preserve both successful and failed early reasoning.

## Step 7 — reproduce the scientific claim boundary

Read:

- `CLAIM_EVIDENCE_MATRIX.json`;
- `evidence/EVIDENCE_INDEX.json`;
- `evaluation/SCIENTIFIC_EVALUATION_SUMMARY.md`.

A valid reproduction of the paper-facing result includes not only a green theorem build but also the correct attribution and bounded interpretation of S1/S2 evidence.

## One-command path

From the repository root:

```bash
bash problems/678/reproducible/scripts/reproduce.sh
```

The final success marker is:

```text
ERDOS678 REPRODUCTION SUCCESS
```

If any metadata, dependency, theorem, regression, or build check fails, the script exits nonzero and must not print the success marker.
