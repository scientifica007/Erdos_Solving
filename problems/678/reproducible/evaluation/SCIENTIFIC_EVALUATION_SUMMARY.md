# Erdős #678 — Scientific Evaluation Summary

This file is a publication-facing summary of the completed S1/S2 program. It does not replace the stage protocols, raw artifacts, or `SCIENTIFIC_EVIDENCE_LEDGER.yaml`.

## S1 — differential verification

**Status:** complete / integrated / post-merge verified.

A pinned public Aristotle/Boris Alexeev formal artifact was compiled and compared in a controlled common environment with the internal reconstruction. Statement bridges and selected axiom footprints were audited.

**Supported:** executable differential verification and statement-level compatibility under the controlled setup.

**Not supported:** new mathematics, first-formalization priority, or proof-genealogy claims.

## S2a — dependency surface

**Status:** complete / closure verified.

Observed module/file/line/dependency counts are sensitive to ownership and packaging boundaries.

**Supported:** raw dependency-surface metrics require boundary normalization before interpretation.

**Not supported:** architecture quality or proof complexity inferred directly from raw counts.

## S2b — controlled build behavior

**Status:** complete / closure verified.

Six credited paired replicates produced no stable wall-clock winner. CPU and memory profiles differed materially under the pinned common environment. A computationally successful pilot was excluded because required runner provenance was absent.

**Supported:** bounded resource-profile observations for the credited environment and replicates.

**Not supported:** universal speed superiority or maintainability conclusions.

## S2c — repair locality

**Status:** complete / closure verified.

Three frozen API-reference mutations were applied across two artifacts. All six legal repairs returned green, but repair-reference blast radius was mixed and interface-dependent.

**Supported:** no uniform repair-locality winner was observed in the frozen experiment.

**Not supported:** general maintainability ranking.

## S2d — semantic/index mutation resistance

**Status:** complete / closure verified.

Three prospectively frozen one-unit semantic/index perturbations were evaluated across two artifacts. The credited set contains six semantic rejections, zero survivors, zero proof repairs, and zero dependency-source edits.

A prior computationally successful pilot was excluded because its primary logical classifier was defective; the frozen mutation set was rerun rather than relabeled post hoc.

**Supported:** all six credited frozen perturbation/artifact observations were rejected.

**Not supported:** general semantic-robustness superiority.

## S2e — exact forward-version robustness

**Status:** complete / closure verified.

Two exact forward candidates were frozen before observation:

- U1: Lean `v4.34.0-rc1` with baseline Mathlib/PNT graph locked;
- U2: Lean `v4.34.0-rc1` plus exact Mathlib RC commit with PNT+ retained.

Credited result:

- U1 reaches D1 then fails in Mathlib/transitive dependency source before project-owned proof incompatibility is established;
- U2 reaches D0 then stops at package resolution before project compilation;
- neither candidate reaches an eligible project-owned repair phase;
- zero project repair batches are credited.

**Supported:** exact-candidate dependency/package boundary observations.

**Not supported:** general Lean/Mathlib compatibility, future upgrade cost, general maintainability, or a claim that project proof code will need no repair after dependency support changes.

## Scientific-admissibility lesson

Across S1/S2, several runs or pilots were excluded despite successful computation because predeclared provenance, classification, aggregation, or instrumentation requirements were not satisfied.

The project therefore treats these as separate questions:

1. Did computation finish successfully?
2. Is the result scientifically admissible under the frozen protocol?
3. What bounded inference does the admitted result support?

A `success` answer to (1) does not automatically imply `yes` to (2) or justify an unrestricted answer to (3).

## Publication use

Paper 1 may use S1/S2 as formal-verification and proof-engineering evaluation evidence.

Paper 2 may use the same episodes as evidence about long-horizon AI-assisted scientific governance, provenance, failure ownership, and exclusion discipline.

Both papers must use the central `CLAIM_EVIDENCE_MATRIX.json` to avoid converting bounded observations into general claims.
