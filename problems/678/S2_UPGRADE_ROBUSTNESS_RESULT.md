# Erdős #678 — S2e Upgrade Robustness Result

## Status

**EXECUTED / CREDITED COMPLETE-SET ARTIFACT INDEPENDENTLY VALIDATED.**

This document records the result of the two prospectively frozen S2e upgrade candidates defined by `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md` and `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`. S2e is internal-only: it does not compare against the external formalization, does not estimate general maintainability, and does not authorize post-observation candidate substitution.

The credited outcome is a **boundary result**, not a successful forward upgrade: U1 reaches D1 and then encounters Mathlib/transitive dependency incompatibility under the newer Lean compiler; U2 reaches D0 and then fails the frozen package-resolution step before project compilation. Neither exact candidate exposes a legal project-owned proof-repair surface.

## Frozen baseline and candidates

Source baseline:

- repository: `scientifica007/Erdos_Solving`;
- source commit: `5039d464f6196e6b47494f0a6fae869e3362d082`;
- Lean: `leanprover/lean4:v4.33.0`;
- Mathlib input: `v4.33.0`;
- resolved Mathlib: `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical import check: `No update necessary`;
- canonical full graph: **8808 jobs**.

Frozen candidates:

1. `U1-lean-4.34.0-rc1-compiler-only`: only the temporary Lean toolchain changes to `v4.34.0-rc1`; Mathlib, PNT+, lakefile, and manifest remain baseline-locked.
2. `U2-lean-mathlib-4.34.0-rc1-root-upgrade`: temporary Lean changes to `v4.34.0-rc1`, root Mathlib changes to exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` (tag provenance `v4.34.0-rc1`), and PNT+ remains fixed at `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

The protocol and matrix were frozen before apparatus creation or candidate execution. Their credited-run digests are:

- protocol SHA-256: `e81c6905693d7407dcf325bbe61e4709178b5f5479acac74cfcc41fe3bafbf96`;
- matrix SHA-256: `c774e472855bbc21765ef342e6b700d46b168e6337ed6cd4386d9dbe11927e3a`.

## Predeclaration and apparatus provenance

Predeclaration:

- final head: `c733ac4baae1a53b20d2e395eaab5c938683a74a`;
- exact-head Lean Verification: run `32105032799`, job `95612654549`;
- merge commit: `0fcefd7ea8cb3753a80a3f93c2498841b1938e55`;
- post-merge Lean Verification: run `32105520785`, job `95614030394`.

Core apparatus:

- frozen core file-introduction commit: `1b241344377d80e9cc4532ec1b92f884e71dc837`;
- apparatus integration PR #40;
- final apparatus head: `013815aa45f4ab2d3194eb2e78c6425dcd74f702`;
- exact-head verification: run `32113247262`, job `95637155718`;
- merge commit: `570f0eb6f27ce384bebbd6bce2d631c1c046fedd`;
- post-merge verification: run `32113963783`, job `95639244235`.

Runtime and measurement instrumentation were subsequently repaired only where fail-closed execution exposed apparatus defects. Candidate identities, D0–D6, package-resolution commands, ownership taxonomy, repair predicates, repair budgets, theorem fingerprints, and interpretation boundaries were not changed.

## Excluded execution episodes

Several complete rounds were excluded before scientific credit. Their observations are not pooled with the credited run.

- run `32114757196`: baseline full build exceeded the original 2400-second harness timeout before U1/U2 began;
- run `32139077608`: baseline again exceeded the enlarged timeout under the original cold runtime design before U1/U2 began;
- run `32161655865`: excluded because D1 `package_resolution` was retained inside U2 but the top-level primary-owner classifier returned `null`;
- run `32168529883`: U1/U2 jobs completed, but the mandatory complete-set aggregate artifact was not produced because a manual artifact downloader forwarded GitHub authorization across a redirect and received HTTP 401.

Each defect was handled as instrumentation only, with the whole affected candidate set excluded and rerun. No candidate definition or scientific interpretation was changed in response to an observed compatibility outcome.

A synthetic non-observational transport audit in PR #52 validated the replacement `actions/download-artifact` implementation pinned at `d3f86a106a0bac45b974a628896c90dbdf5c8093`. Audit run `32170073082`, aggregate job `95818872837`, returned `candidate_count=2,status=PASS`; no Lean upgrade candidate was executed in that audit.

## Credited complete-set execution

Execution carrier PR #53 was run from exact head:

`dfb7d1122e0e482626c9849f0e083ecbe71e58be`

Credited workflow:

- S2e run: `32170243744` — success;
- U1 job: `95819384522` — success;
- U2 job: `95819384599` — success;
- aggregate job: `95822552072` — success.

The same exact execution head independently passed canonical `Lean Verification`:

- run `32170243621`;
- job `95819384164`;
- exact `verified_commit=dfb7d1122e0e482626c9849f0e083ecbe71e58be`;
- pinned baseline Mathlib/PNT+ identities confirmed;
- `No update necessary`;
- `Build completed successfully (8808 jobs)`.

PR #53 is an execution carrier only and is closed without merge.

## Credited artifact and independent validation

Complete-set artifact:

- name: `erdos678-s2e-detection-complete-32170243744`;
- artifact ID: `9337321640`;
- size: `58,933` bytes;
- GitHub SHA-256: `90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`.

The artifact was downloaded independently after the workflow completed. The recomputed ZIP SHA-256 was exactly:

`90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`.

The archive contains 40 retained evidence files, including combined `result.json`, `SUMMARY.md`, `COMBINE_AUDIT.json`, and raw U1/U2 provenance, baseline, stage, diagnostic, and scope-audit records.

`COMBINE_AUDIT.json` reports:

- accepted candidates: exactly `U1` and `U2`;
- input apparatus failures: `0`;
- ownership validation: `PASS`;
- provenance mismatches: none;
- repair outputs present: `0`;
- aggregate status: `PASS`.

The raw candidate-result SHA-256 values match the combined manifest exactly:

- U1 raw `result.json`: `e142963b42bcc24d2361d54bbcbd5a29430c74c83a124ea2712f65bf810a9148`;
- U2 raw `result.json`: `2ebb741302ef11ba7dbaacfb501620185f64c9da4a64548075353ecd27138092`.

Both candidate baselines independently recorded Lean 4.33.0, the frozen Mathlib/PNT+ revisions, `No update necessary`, 8808 canonical jobs, identical frozen source hashes, and identical frozen endpoint-header fingerprints. Scope audits recorded empty tracked-repository diffs and no third-party repair permission.

## U1 — compiler-only candidate

Candidate: `U1-lean-4.34.0-rc1-compiler-only`.

The candidate setup changed only the temporary `lean-toolchain` from 4.33.0 to 4.34.0-rc1. The root lakefile and manifest remained byte-identical to baseline.

Stage outcome:

| stage | outcome | retained interpretation |
|---|---|---|
| D0 | green | exact candidate/source identity established |
| D1 | green | baseline-locked package graph retained |
| D2 — Intervals | failed | dependency source, `Batteries/Data/List/Basic.lean:577` |
| D2 — ValuationBasic | failed | dependency source, `Batteries/Data/Float/Basic.lean:16` |
| D2 — Claim4Density | failed | dependency source, `Batteries/Data/Float/Basic.lean:16` |
| D3 | failed | Mathlib/Batteries source under the newer compiler; retained diagnostic includes `Mathlib/Tactic/Linter/Whitespace.lean:49` |
| D4 | not applicable | D3 not green |
| D5 | not applicable | D3 not green |
| D6 | not applicable | required prior stages not all green |

U1 summary:

- deepest green stage: `D1`;
- full no-repair survivor: `false`;
- primary failure owner: `mathlib_or_transitive_dependency`;
- `dependency_support_blocked=true`;
- no project-owned D2 failure was observed;
- no legal third-party dependency repair is permitted by the protocol.

Therefore the exact compiler-only candidate reaches an **external dependency support boundary before establishing any project-owned proof incompatibility**.

## U2 — Lean + root Mathlib candidate

Candidate: `U2-lean-mathlib-4.34.0-rc1-root-upgrade`.

The candidate setup changed the temporary Lean toolchain to 4.34.0-rc1 and the root Mathlib revision to exact `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11`; PNT+ remained frozen at `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

Stage outcome:

| stage | outcome | retained interpretation |
|---|---|---|
| D0 | green | exact candidate/source identity established |
| D1 | failed | frozen package-resolution/manifest-regeneration step |
| D2 | not attempted | D1 not green |
| D3 | not applicable | D1 not green |
| D4 | not applicable | D1 not green |
| D5 | not applicable | D1 not green |
| D6 | not applicable | D1 not green |

The D1 record fixes the primary owner as `package_resolution`. Retained diagnostics show the exact root Mathlib candidate alongside a transitive dependency graph pinned by the project/PNT provider to different revisions, and the resolution/cache step fails before project compilation.

U2 summary:

- deepest green stage: `D0`;
- full no-repair survivor: `false`;
- primary failure owner: `package_resolution`;
- project source was never compiled under the candidate graph;
- no project-owned repair can legally be inferred or attempted from this branch.

Therefore U2 measures a **package-graph support boundary**, not a project-proof failure.

## Repair-phase disposition

The frozen protocol permits a separate repair phase only when the no-repair result exposes a legal project-owned repair surface.

Neither candidate does:

- U1 fails in Mathlib/transitive dependency source at D2 and D3. Editing dependency source or substituting an alternate dependency revision is forbidden. Its legal repair disposition is therefore dependency-support blocked with zero project patches.
- U2 fails D1 before source compilation. It never reaches a stage from which a project-owned proof repair can be defined legally.

No repair output is present in the credited aggregate, and no project or third-party source was modified during the credited detection.

### Frozen reporting-schema gap

The protocol's final repair-class enum contains `not_needed`, `repaired_green`, `dependency_support_blocked`, `project_repair_budget_exceeded`, and `apparatus_invalid`, but it has no dedicated final repair label for a valid `package_resolution` stop at D1.

This is recorded as a **secondary reporting-schema gap**. It is not corrected post observation, because changing the enum would change an interpretation rule after candidate outcomes were observed. U2 is therefore retained with its primary detection owner `package_resolution`, and the repair phase is recorded as **not entered / not legally eligible** rather than being misreported as `apparatus_invalid`.

## Scientific result

The strongest defensible S2e statement is:

> **For the two exact prospectively frozen Lean 4.34.0-rc1 upgrade candidates, compatibility stops before any project-owned proof repair surface is observed: the compiler-only candidate is blocked by baseline Mathlib/transitive dependency source compatibility, while the coordinated root-Mathlib candidate is blocked during package resolution before project compilation.**

Consequences supported by this experiment:

1. The baseline Erdős #678 artifact remains canonically green at its frozen Lean/Mathlib/PNT+ environment.
2. Simply running the baseline dependency graph under Lean 4.34.0-rc1 is not a supported upgrade path for this frozen graph; dependency source fails first.
3. Replacing only the root Mathlib requirement with the frozen 4.34.0-rc1 commit while keeping the frozen PNT+ provider does not produce a resolvable candidate graph under the protocol.
4. No bounded project-owned Lean repair effort can be measured for these exact candidates because neither exposes a legal project-owned failure boundary.

## What S2e does not establish

S2e does **not** establish:

- general Lean 4.34 / Mathlib 4.34 compatibility or incompatibility;
- expected cost of a future coordinated upgrade with a newer PNT+ provider;
- project maintainability;
- proof quality;
- architecture superiority;
- human debugging or repair time;
- probability of surviving arbitrary future upgrades;
- that project-owned proof code would require zero repair once the dependency graph becomes compatible.

The result applies only to U1 and U2 as frozen. In particular, a future coordinated PNT+/Mathlib/Lean release is a new experiment, not a continuation of this credited result.

## Evidence integration gate

This result file and its machine-readable companion must be integrated through a documentation/evidence PR whose final exact head passes canonical `Lean Verification`. After merge, the exact resulting `main` commit must pass canonical post-merge verification before S2e is marked closure-verified in the scientific ledger.

`DEC-012` remains binding: S2e evidence integration does not authorize work on another Erdős problem.
