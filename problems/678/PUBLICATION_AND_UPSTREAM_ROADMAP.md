# Erdős #678 — Publication and Upstream Roadmap

## Objective

Maximize defensible external value from #678 without reopening the mathematics or overstating novelty. Cambie's theorem is known mathematics; the project contributes an independent Lean reimplementation, auditable verification/evaluation artifacts, and a longitudinal AI-assisted scientific-production case study.

## Track A — formal verification / proof engineering

### S1 — CLOSED

Common-environment differential verification against the pinned Aristotle/Alexeev formalization is complete and closure-verified.

### S2a — dependency surface — CLOSED

Durable result: structural metrics are dependency/ownership-boundary sensitive and cannot be interpreted as architecture quality without boundary normalization.

### S2b — controlled build behavior — CLOSED

Durable result: no stable wall-clock winner in six paired runs under the pinned common environment; CPU/memory profiles differ materially. A computationally green pilot was excluded when predeclared provenance was absent.

### S2c — repair locality — CLOSED

Durable result: three prospectively frozen API-reference mutations produced a mixed/interface-dependent result; no uniform repair-locality or maintainability winner.

### S2d — semantic/index mutation resistance — CLOSED / CLOSURE VERIFIED

Three prospectively frozen one-unit semantic/index perturbations were all rejected in both artifacts, with mutation- and structure-dependent first rejection locations. I1 provides direct evidence that the internal independent concrete numerical regression layer detects a semantic convention drift that remains type-correct at the primitive definition.

The first computationally successful pilot was excluded in full after a primary comparator-classification instrumentation defect was found; only the classifier was corrected and the complete frozen set was rerun.

Credited run `32076614547`, job `95531085803`, produced 6 semantic rejections, 0 survivors, 0 proof repairs, and 0 dependency-source touches. Substantive integration PR #35 and documentation closure PR #36 both passed exact-head and exact-main post-merge verification.

Closure PR #36 final head `46b52c2c8ed1c4dd0623974c82c367071618f71b` passed run `32103456742`, job `95608318715`, then merged as `5039d464f6196e6b47494f0a6fae869e3362d082`. That exact main commit passed run `32103947182`, job `95609642835`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**. S2d is fully closed.

### S2e — upgrade robustness — PREDECLARED / NOT EXECUTED

#### Scientific question

For exact frozen forward Lean/Mathlib candidates, determine where compatibility first fails, whether the blocker belongs to dependency support or project-owned source, and—only for eligible project-owned failures—what bounded semantic-preserving repair surface restores the predeclared verification targets.

This is an internal-artifact version-transition experiment, not a new cross-artifact ranking and not a general maintainability benchmark.

#### Baseline

S2e starts from exact S2d closure merge `5039d464f6196e6b47494f0a6fae869e3362d082` with:

- Lean `v4.33.0`;
- Mathlib `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical baseline build: **8808 jobs**.

#### Frozen candidates

1. **U1 — compiler-only forward pressure**
   - Lean `v4.34.0-rc1`;
   - baseline Mathlib/PNT source and manifest identities fixed;
   - no `lake update`.

2. **U2 — root Lean + Mathlib release-candidate upgrade**
   - Lean `v4.34.0-rc1`;
   - Mathlib exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11`, provenance tag `v4.34.0-rc1`;
   - PNT+ remains exact `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

At predeclaration time PNT+ `main` is the same baseline commit and has not supplied a newer coordinated 4.34 provider revision. S2e therefore does not invent, vendor, or automatically patch such a provider. A PNT/dependency-support blocker is retained as a supply-chain/version-boundary result, not a proof-quality defect.

#### Detection taxonomy and stages

No repair occurs before the complete no-repair detection pass.

- D0 candidate identity/provenance;
- D1 package graph/manifest resolution;
- D2 all three project-owned Mathlib-only sentinels (`Intervals`, `ValuationBasic`, `Claim4Density`);
- D3 external PNT+ support boundary;
- D4 project PNT boundary `Claim4RelativePrimePNT` when D3 is green;
- D5 canonical #678 endpoint `Erdos678Final` when D3 is green;
- D6 `mk_all --check` + full canonical `Formalization` build.

Primary ownership classes are frozen as apparatus/provenance, package resolution, Lean toolchain, Mathlib/transitive dependency, PNT dependency support, project-owned, or ambiguous.

#### Repair discipline

Dependency-source edits are prohibited. Project-owned repair is eligible only after no-repair detection and under one cumulative budget per candidate:

- maximum **12 batches**;
- maximum **10 project-owned files**;
- maximum **250 aggregate additions + deletions**.

Key verification files remain byte-identical, and canonical semantic endpoint headers are fingerprinted and must remain unchanged. A full candidate blocked at PNT support may still yield interpretable Mathlib-only sentinel/repair evidence; no workaround is introduced to force the PNT-dependent stack green.

#### Predeclaration artifacts

- `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`.

At this checkpoint **no S2e harness exists and neither U1 nor U2 has been executed**. Apparatus creation is forbidden until this predeclaration passes exact-head CI, merges, and the exact resulting main commit passes post-merge verification.

### S2f — independent audit — PLANNED

After S2 quantitative evidence stabilizes, have an independent reviewer inspect statement, metric, assumption, dependency, and interpretation boundaries.

## Track B — AI-assisted scientific production

Candidate title:

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

Methodology episodes now include:

- **S2a:** reproducible metrics can be scientifically misleading under incomparable ownership boundaries;
- **S2b:** computational success can still be scientifically inadmissible when predeclared provenance is absent;
- **S2c:** prospective comparisons may yield mixed results that must be retained;
- **S2d:** type-correct semantic drift is caught at different encoded controls, and a primary measurement-classifier defect invalidates a green run;
- **S2e design:** upgrade evidence must separate dependency-support lag from project-owned compatibility repair before repair counts are interpreted.

These are externally auditable through protocols, commits, CI runs, artifacts, corrections, excluded pilots, and persisted evidence; hidden chain-of-thought is unnecessary.

## Track C — upstream/community contribution

After S2 evidence stabilizes:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure effects before proposing upstream;
- consider compact statement-normalization lemmas;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; independent Lean reimplementation; machine-checked statement bridges; executable differential verification; closure-verified S2a boundary-sensitive structural control; closure-verified S2b resource baseline with no stable wall-time winner; closure-verified S2c mixed repair-locality baseline; closure-verified S2d six-observation semantic/index baseline with all three frozen perturbations rejected in both artifacts.

**Prospectively defined but not yet evidenced:** U1/U2 upgrade-compatibility outcomes, dependency-support blockers, and bounded project-owned repair surface under S2e.

**Still requires later evidence:** general semantic robustness, general maintainability, human repair/debugging effort, expected future upgrade cost, causal explanations for S2b resource differences, causal benefit of state protocols.

**Unsupported:** new solution, new independent mathematical proof, first Lean formalization, general architecture superiority, universal speed advantage, general maintainability superiority, general semantic-robustness superiority, autonomous AI authorship percentage.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2b:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2c:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2d:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2e:** PREDECLARED / NOT EXECUTED / PENDING PREDECLARATION INTEGRATION.
  - **S2f:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
