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

Durable result: three prospectively frozen API-reference mutations produced a mixed/interface-dependent result; no uniform repair-locality or maintainability winner. S2c is fully closure-verified.

### S2d — semantic/index mutation resistance — INTEGRATED / POST-MERGE VERIFIED / CLOSURE IN PROGRESS

#### Question and frozen design

S2d asks where small type-correct semantic/index perturbations are first rejected, motivated by the historical off-by-one interval failure `[t,t+k]` versus `[t+1,t+k+1]`.

The protocol and manifest were frozen and integrated through predeclaration PR #34 before apparatus creation. Three matched mutation pairs were fixed:

1. **I1** canonical same-length block shifted left by one;
2. **I2** long `k+1` block loses its final term;
3. **I3** `n+k≤m` strengthened to `n+(k+1)≤m` as a possible semantic-survival control.

No proof repair is allowed; each observation starts from a pristine baseline.

#### Measurement-validity correction

First run `32074822049` completed computationally but is excluded in full because the comparator logical-layer classifier mislabeled `main_theorem : MainTheoremStatement` as a generic local lemma instead of a strong theorem. Since first rejection classification is a primary metric, the result was not edited post hoc.

Only the classifier was corrected. The frozen mutations, baseline, checks, and proof sources were unchanged, and the complete six-observation experiment was rerun.

#### Credited evidence

Credited exact-head PR-event run:

- apparatus head `a82ae53b57a9f97844013a9b2e96a9182cee241d`;
- run `32076614547`, job `95531085803`;
- artifact `9303987121`;
- SHA-256 `29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881`;
- independent downloaded digest: exact match;
- 6 observations, 6 semantic rejections, 0 survivors, 0 proof repairs, 0 dependency-source touches.

| mutation | internal first rejection | comparator first rejection |
|---|---|---|
| I1 start shift | concrete numerical oracle after mutated primitive source elaborated | `lcmInterval_ge_choose` local invariant |
| I2 drop final term | mutated strong endpoint source type mismatch | `main_theorem` strong theorem |
| I3 strengthen separation | mutated canonical endpoint source application mismatch | `erdos_678_kmn_infinite` canonical corollary |

#### Defensible interpretation

**Established for these mutations:** all three frozen one-unit semantic/index perturbations were rejected by both artifacts, with mutation- and structure-dependent first rejection locations.

**Specific useful evidence:** I1 shows that the internal concrete numerical regression layer catches a semantic convention shift that remains syntactically/type-correct at the primitive definition itself.

**Not established:** general semantic-robustness superiority, general architecture superiority, a common ordinal rejection-depth ranking across modular versus monolithic artifacts, human debugging advantage, maintainability, or upgrade robustness.

The I3 survival control did not survive in either artifact. That outcome is retained; it does not imply every nearby changed-but-true target would be rejected.

Full report: `S2_SEMANTIC_INDEX_BASELINE.md/.json`. Exact raw logs/result remain in artifact `9303987121`.

#### Verified integration

PR #35 final head `1a5728574f3d2c5101851becfb2500400aa395bd` passed canonical Lean Verification run `32078084197`, job `95535434320`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**.

PR #35 merged as `891d7b9e51c3ecc1313ee2de8d2a98036841b128`. The exact resulting `main` commit passed push run `32102682942`, job `95606121109`, again with matching `verified_commit`, `No update necessary`, and **8808 jobs**.

The substantive S2d experiment/evidence integration is therefore complete and post-merge verified.

#### Closure gate

Documentation-only PR #36 is now the remaining gate. It must:

1. contain only state/evidence documentation changes;
2. pass canonical exact-head Lean Verification on its final head;
3. merge only with that verified head unchanged;
4. pass post-merge verification on the exact resulting `main` commit.

Only after those conditions are met is S2d `CLOSURE VERIFIED` and S2e permitted to enter predeclaration.

### S2e — upgrade robustness — PLANNED / BLOCKED

Run isolated Lean/Mathlib upgrade probes and measure failure/repair surfaces with project-owned versus dependency-support attribution. **Do not start until S2d documentation closure is verified.**

### S2f — independent audit — PLANNED

After S2 quantitative evidence stabilizes, have an independent reviewer inspect statement, metric, assumption, dependency, and interpretation boundaries.

## Track B — AI-assisted scientific production

Candidate title:

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

S2 now contributes four concrete methodology episodes:

- **S2a:** a reproducible metric may still be scientifically misleading when its proxy boundary is incomparable;
- **S2b:** a computationally green experiment may be scientifically inadmissible when predeclared provenance is missing;
- **S2c:** a prospectively defined comparison may yield a mixed result that should be preserved rather than redesigned after observation;
- **S2d:** type-correct semantic drift can be rejected at different encoded control locations, and a computationally successful run must still be discarded when a primary classifier is instrumented incorrectly.

These are externally auditable through protocols, commits, CI runs, artifacts, corrections, excluded pilots, and persisted evidence; hidden chain-of-thought is unnecessary.

## Track C — upstream/community contribution

After S2 evidence stabilizes:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure effects before proposing upstream;
- consider compact statement-normalization lemmas;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; independent Lean reimplementation; machine-checked statement bridges; executable differential verification; S2a boundary-sensitive structural control; S2b resource-profile baseline with no stable wall-time winner; S2c mixed repair-locality baseline; S2d six-observation semantic/index mutation baseline with all three frozen perturbations rejected in both artifacts and layer-dependent detection; verified integration of the S2d evidence through PR #35 and its exact post-merge `main` commit.

**Supported interpretation:** independent numerical/regression controls can add statement-fidelity value beyond primitive type correctness in the observed I1 mutation; measurement provenance/classification auditing is scientifically consequential.

**Still requires later evidence:** general semantic robustness, general maintainability, human repair/debugging effort, upgrade robustness, causal explanations for S2b resource differences, causal benefit of state protocols.

**Unsupported:** new solution, new independent mathematical proof, first Lean formalization, general architecture superiority, universal speed advantage, general maintainability superiority, general semantic-robustness superiority, autonomous AI authorship percentage.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2b:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2c:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2d:** COMPLETE / INTEGRATED / POST-MERGE VERIFIED / CLOSURE IN PROGRESS.
  - **S2e:** NOT STARTED / BLOCKED BY S2d CLOSURE VERIFICATION.
  - **S2f:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
