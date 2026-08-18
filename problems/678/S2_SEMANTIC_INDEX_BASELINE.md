# Erdős #678 — S2d Semantic/Index Mutation Baseline

## Status

**EXECUTED / CREDITED ARTIFACT VALIDATED / PENDING PR INTEGRATION.**

S2d evaluates only the three prospectively frozen, type-correct one-unit semantic/index perturbations declared in `S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md` and `S2_SEMANTIC_INDEX_MUTATIONS.yaml`. It measures where existing encoded controls first reject those perturbations. It does not measure repair effort and it does not establish general semantic robustness or architecture superiority.

## Predeclaration provenance

The mutation protocol and manifest were frozen before harness creation and before any S2d mutation outcome was observed.

- frozen internal source baseline: `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`;
- predeclaration final head: `5aaef5a667ee11cc526beae587cf9ab799727f7e`;
- predeclaration exact-head verification: run `32073161789`, job `95520595880`;
- predeclaration merge: `2db145226bf530f406e734129fd8a451a2ab3899`;
- predeclaration post-merge verification: run `32073820006`, job `95522556326`;
- protocol SHA-256: `04e5b4051650636847df979bde1a16c46018cf46f73c62a9763a4a88605699f6`;
- manifest SHA-256: `d624e93eb51f9229f5d5304365cf39b777f2ee813b9798f939ca26788d1d103f`.

Both predeclaration verification points recorded the exact intended commit, `No update necessary`, and a successful 8808-job canonical build.

## Immutable comparator

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- source blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- source SHA-256: `186a651174c7f8f7ef1e7d7d86f262ff51889a55c6767ca116b08a009fe8a4db`.

The comparator remains an ephemeral external fetch and is not vendored.

## Measurement-validity episode: excluded first pilot

The first S2d execution run `32074822049`, job `95525626029`, completed computationally and uploaded artifact `9303487756` with SHA-256 `815e676189486afa15876589043e563f9a1d69d18a27c72e766c660993e40faf`. An independent download reproduced that digest exactly.

The run is **excluded in full from scientific credit**. Post-run instrumentation audit found that the comparator theorem

`main_theorem : MainTheoremStatement`

was assigned the generic logical class `local_lemma_or_regression`, although the frozen S2d interpretation contract treats the proof of `MainTheoremStatement` as a `strong_theorem` rejection. Because first-rejection classification is a primary S2d output, accepting the run and editing its label post hoc would violate the fail-closed measurement discipline.

The correction changed only the classifier so that `main_theorem` and equivalent strong-theorem names map to `strong_theorem`. **No mutation, baseline, protocol, semantic check, proof source, or observed result was changed.** The complete six-observation set was then rerun from pristine baselines. No observation from the excluded pilot is credited.

## Credited experiment

The credited rule was fixed before the rerun: only the `pull_request`-event workflow that explicitly checks out the exact PR head receives scientific credit. Push-event duplicates are operational only.

- exact credited apparatus head: `a82ae53b57a9f97844013a9b2e96a9182cee241d`;
- credited run: `32076614547`;
- credited job: `95531085803`;
- trigger: `pull_request`;
- runner: `2.336.0`;
- image: `ubuntu24/20260810.271.1`;
- Lean: `4.33.0`;
- Mathlib: `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- artifact ID: `9303987121`;
- GitHub artifact SHA-256: `29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881`;
- artifact size: `74,518` bytes;
- independent downloaded-ZIP SHA-256 recomputation: **exact match**.

The exact raw `result.json` and per-stage logs are retained inside artifact `9303987121`. `S2_SEMANTIC_INDEX_BASELINE.json` is the compact persisted scientific ledger derived from that validated artifact.

## Baseline validation

Before mutation execution, the credited apparatus verified:

- frozen protocol and manifest byte identity against both the predeclaration head and merged predeclaration commit;
- exact internal frozen source baseline over the tracked formalization scope;
- exact Lean/Mathlib/PNT+ identities;
- internal baseline `lake exe mk_all --check` returned `No update necessary`;
- internal baseline full build completed successfully with **8808 jobs**;
- pinned comparator baseline compiled successfully;
- exact comparator commit/blob/source digest;
- pristine source restoration between observations.

After the six observations, the final internal source restoration build again completed successfully with the 8808-job graph.

## Frozen mutation outcomes

| mutation | artifact | mutation source elaborated? | first rejection | first failing check/declaration | diagnostic class |
|---|---|---:|---|---|---|
| I1 canonical start left shift | internal | yes | `L1_concrete_semantic_oracle` | `ConcreteTests` oracle | tactic failure / false proposition |
| I1 canonical start left shift | comparator | yes | local lemma/regression | `lcmInterval_ge_choose` | unsolved goals |
| I2 long block drops final term | internal | no | `L0_mutation_source_elaboration` | `Erdos678Final` mutated theorem source | type mismatch |
| I2 long block drops final term | comparator | yes | strong theorem | `main_theorem` | unsolved goals |
| I3 separation strengthened by one | internal | no | `L0_mutation_source_elaboration` | `Erdos678Final` mutated endpoint source | application type mismatch |
| I3 separation strengthened by one | comparator | no | canonical corollary | `erdos_678_kmn_infinite` | unsolved goals |

Aggregate credited result:

- planned observations: **6**;
- executed observations: **6**;
- semantic rejections: **6**;
- mutations surviving all required checks: **0**;
- proof repairs: **0**;
- non-mutation project-source touches: **0**;
- third-party/dependency source touches: **0**.

## What each mutation actually established

### I1 — canonical block-start shift left by one

Internally, the mutated primitive definition `erdosM n k := intervalLCM n k` itself still elaborated. The first rejection occurred only when the independent concrete oracle module was built: `ConcreteTests.lean:35` reported that `decide` proved the mutated proposition false. Thus the length/index convention was not protected merely by type correctness at the primitive definition; the explicit numerical regression layer supplied the first rejection.

In the comparator, the shifted `lcmInterval` definition also elaborated, but the complete pinned file first failed at local invariant theorem `lcmInterval_ge_choose` (line 2299) with unsolved goals. Therefore both artifacts rejected I1, but through different encoded controls.

### I2 — remove the final term from the long block

Internally, changing the strong theorem statement from `intervalLCM y (k+1)` to `intervalLCM y k` immediately made the existing theorem proof incompatible with its upstream result. The mutated `Erdos678Final` module failed at line 126 with a type mismatch, so rejection occurred at `L0`.

In the comparator, the mutated `MainTheoremStatement` declaration itself remained well-formed. The full source first failed when theorem `main_theorem` attempted to prove the modified statement, at line 2008 with unsolved goals. Under the corrected predeclared logical classifier this is a **strong-theorem rejection**, not a generic local-lemma rejection.

### I3 — strengthen canonical separation by one

I3 was intentionally included as a possible semantic-survival control: if `n+k≤m` were strengthened to `n+(k+1)≤m` and the changed theorem remained provable, that outcome would demonstrate the distinction between theorem checking and target fidelity.

It did **not** survive in either artifact. Internally the changed canonical endpoint failed in `Erdos678Final` at line 179 with an application type mismatch when the strengthened separation evidence was fed to a downstream bridge expecting the original relation. In the comparator, `erdos_678_kmn_infinite` itself failed at line 2506 with unsolved goals.

The absence of a survivor is a result of this frozen mutation set; it does not prove that all nearby semantic statement drift would be rejected.

## Scientific interpretation

The strongest defensible S2d result is:

> **All three prospectively frozen one-unit semantic/index perturbations were rejected in both artifacts, but the first encoded rejection point depended on the logical mutation and artifact structure.**

Two more specific observations are justified:

1. **Independent numerical oracles add distinct statement-fidelity value.** For I1, the internal primitive semantic mutation was type-correct and its source module built successfully; rejection first occurred in the dedicated concrete regression layer.
2. **Machine checking is not a single undifferentiated gate.** The same family of semantic drift surfaced at a concrete oracle, local invariant, strong theorem proof, or canonical endpoint depending on the perturbation and artifact.

No ordinal ranking such as “L1 is better than strong theorem” is allowed across the two artifacts. The internal artifact has explicit staged modules; the comparator is a monolithic source whose first error is classified by enclosing declaration. These are descriptive control locations, not a shared numerical robustness scale.

## What S2d does not establish

S2d does **not** establish:

- general semantic-robustness superiority of either artifact;
- general architecture superiority;
- probability that arbitrary statement drift will be detected;
- human debugging or repair time;
- cognitive effort;
- proof complexity;
- maintainability;
- upgrade robustness;
- causal benefit of modular decomposition.

The experiment covers exactly three predeclared matched one-unit perturbations. All broader claims require additional evidence.

## Integration gate

The substantive S2d evidence is validated but is not yet integrated. PR #35 must now be synchronized with this baseline and state/evidence documents. Its **final** head must pass canonical exact-head Lean Verification; only then may it merge. The exact resulting `main` commit must then pass post-merge canonical verification. A documentation closure gate should record those integration facts before S2e begins.

`DEC-012` remains binding: none of this authorizes work on another Erdős problem.
