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

Three prospectively frozen one-unit semantic/index perturbations were all rejected in both artifacts, with mutation- and structure-dependent first rejection locations. Credited run `32076614547` produced 6 semantic rejections, 0 survivors, 0 proof repairs, and 0 dependency-source touches. Closure merge `5039d464f6196e6e4ede2b600723b8616aeeee4` passed exact-main run `32103947182` / job `95609642835` with `No update necessary` and 8808 jobs.

### S2e — upgrade robustness — CLOSED / CLOSURE VERIFIED

#### Scientific question

For exact frozen forward Lean/Mathlib candidates, determine where compatibility first fails, whether the blocker belongs to package/dependency support or project-owned source, and—only for eligible project-owned failures—what bounded semantic-preserving repair surface is needed.

This is an internal-artifact version-transition experiment, not a cross-artifact ranking and not a general maintainability benchmark.

#### Frozen baseline and candidates

Baseline `5039d464f6196e6e4ede2b600723b8616aeeee4`:

- Lean `v4.33.0`;
- Mathlib `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical graph **8808 jobs**.

Candidates prospectively frozen through PR #38:

1. **U1 compiler-only:** Lean `v4.34.0-rc1`, baseline Mathlib/PNT and manifest identities fixed, no `lake update`.
2. **U2 root Lean + Mathlib RC:** Lean `v4.34.0-rc1`, exact Mathlib `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11`, PNT+ fixed at `2667e414...`.

The design froze D0–D6 detection, failure ownership classes, third-party repair prohibition, 12-batch/10-file/250-line project repair budget, immutable regressions, and canonical theorem-header fingerprints before candidate observation.

#### Governance episodes

S2e produced several useful methodology episodes before a credited result:

- PR #42 / run `32114757196`: excluded before candidates because baseline full build exceeded a 2400 s instrumentation timeout.
- PR #45 / run `32139077608`: excluded before candidates after the replacement 7200 s instrumentation timeout also proved unsuitable.
- PR #48 / run `32161655865`: excluded in full because the primary-owner classifier omitted D1 package-resolution failures.
- PR #51 / run `32168529883`: candidate jobs were coherent but the complete-set run was excluded because the prospectively required aggregate artifact was not produced; manual artifact transport received HTTP 401 before the combiner.
- PR #52 / run `32170073082`: synthetic-only transport audit; pinned official artifact download plus hardened combiner passed. No Lean candidate was executed.

The candidate versions, scientific stages, ownership taxonomy, repair contract, and interpretation rules were not redesigned after these observations.

#### Credited result

Credited complete-set detection:

- execution carrier PR #53, intentionally closed without merge;
- exact workflow head `dfb7d1122e0e482626c9849f0e083ecbe71e58be`;
- run **`32170243744`**;
- U1 job `95819384522`;
- U2 job `95819384599`;
- aggregate job `95822552072`.

Complete artifact `9337321640` has SHA-256 `90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`; independent re-download/re-hash matched. It contains 40 retained files and passes aggregate ownership/provenance validation with zero apparatus failures and zero repair outputs.

**U1:** D0/D1 green; all three D2 sentinels and D3 fail first in Mathlib/transitive dependency code. Deepest green `D1`; primary owner `mathlib_or_transitive_dependency`; no project-owned proof failure reached.

**U2:** D0 green; D1 package resolution fails before project compilation. Deepest green `D0`; primary owner `package_resolution`.

**Repair phase:** prospectively **not applicable** because neither candidate reaches an eligible project-owned failure. Zero repair batches were attempted. Consequently S2e has no repair-surface metric for these two candidates, and none should be inferred.

#### Integration and closure

Persistent evidence:

- `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`;
- `S2_UPGRADE_ROBUSTNESS_RESULT.md/.json`;
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`;
- raw complete artifact `9337321640`.

Evidence PR #55 merged as `a0dffadfbba22325103170a8222d8adb10ffe6e9` after exact-head verification, and that exact merge passed post-merge run `32175057976` / job `95834940169`.

Closure PR #57 merged unchanged as `872be99ac79e3d905dd6d696e626d424331a1faa`. That exact `main` commit passed post-merge run `32177665772` / job `95843195690` with matching `verified_commit`, pinned dependencies, `No update necessary`, and **8808 jobs**.

#### Durable bounded result

For these two exact forward candidates, the archived artifact is blocked at package/dependency boundaries before an eligible project-owned compatibility-repair surface is reached. This is a supply-chain/version-boundary observation for the frozen configurations, not a proof-quality or general maintainability result.

S2e is fully closed. S2 is complete.

## Track B — AI-assisted scientific production

Candidate title:

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

Auditable methodology episodes now include:

- **S2a:** reproducible metrics can be scientifically misleading under incomparable ownership boundaries;
- **S2b:** computational success can still be scientifically inadmissible when predeclared provenance is absent;
- **S2c:** prospective comparisons may yield mixed results that must be retained;
- **S2d:** type-correct semantic drift can be caught by independent controls, and a primary classifier defect can invalidate a green run;
- **S2e:** runtime/provenance/aggregation instrumentation failures were separated from compatibility outcomes, and the credited result terminated legitimately at dependency/package boundaries with no eligible repair phase.

These episodes are externally auditable through protocols, commits, CI runs, artifacts, corrections, exclusions, and persisted evidence; hidden chain-of-thought is unnecessary.

## Track C — upstream/community contribution

Potential future upstream/community work is not part of the completed S2 closure. Any such work should be separately authorized and scoped before execution.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; independent Lean reimplementation; machine-checked statement bridges; executable differential verification; closure-verified S2a/S2b/S2c/S2d results; and closure-verified S2e exact-candidate dependency/package boundary results.

**Still requires new evidence:** compatibility of any Lean/Mathlib/PNT tuple other than the two frozen S2e candidates; compatibility or repair cost of a future coordinated release; general semantic robustness; general maintainability; human repair/debugging effort; expected future upgrade cost; causal explanations for S2b resource differences; causal benefit of state protocols.

**Unsupported:** new solution, new independent mathematical proof, first Lean formalization, general architecture superiority, universal speed advantage, general maintainability superiority, general Lean/Mathlib incompatibility, autonomous AI authorship percentage.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** COMPLETE.
  - **S2a:** COMPLETE / CLOSURE VERIFIED.
  - **S2b:** COMPLETE / CLOSURE VERIFIED.
  - **S2c:** COMPLETE / CLOSURE VERIFIED.
  - **S2d:** COMPLETE / CLOSURE VERIFIED.
  - **S2e:** COMPLETE / CLOSURE VERIFIED.
- **Next scientific gate:** AWAIT EXPLICIT USER AUTHORIZATION.

## Stop condition

All completed work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
