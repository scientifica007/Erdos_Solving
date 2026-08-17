# Erdős #678 — S2d Semantic/Index Mutation Resistance Protocol

## Status

**PREDECLARED / NOT YET EXECUTED.**

This protocol is fixed before any S2d mutation is executed, before any mutation harness is implemented, and before any S2d outcome is observed. The experiment concerns archived Erdős #678 only.

## Research question

When small, type-correct **semantic/index perturbations** are injected at matched logical interfaces, where is the first observable rejection in the internal reconstruction and in the pinned public comparator? If a perturbed statement remains machine-checkable, does the artifact expose that semantic target drift anywhere before canonical verification succeeds?

S2d measures **semantic/index mutation rejection depth** under a small predeclared mutation set. It does not measure general proof quality, human debugging time, theorem difficulty, maintainability, or architecture superiority.

## Historical motivation

The experiment is motivated by a concrete failure retained in `FORMALIZATION_CORRECTION_2026-08-14.md`.

The rejected construction treated the block underlying `M(t,k+1)` as `[t,t+k]`, while the actual Erdős convention is `[t+1,t+k+1]`. The two blocks have the same cardinality but are shifted by one. The error therefore survived ordinary symbolic manipulation until exact interval semantics were audited.

The project subsequently introduced:

- a length-based interval API in `Formalization/Erdos678/Intervals.lean`;
- explicit statement bridges between the length API and `Finset.Ioc`;
- independent concrete LCM oracles and a retained negative regression in `ConcreteTests.lean`;
- an off-by-one-safe final translation layer in `Erdos678Final.lean`.

S2d asks which of these controls actually reject controlled semantic drift and at what logical layer.

## Immutable baselines

### Internal artifact

- repository: `scientifica007/Erdos_Solving`;
- baseline commit: `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`;
- status at baseline: S2c documentation closure merged and post-merge verified;
- S2c closure PR: `#33`;
- S2c closure exact-head run/job: `32070637072` / `95512851767`;
- S2c closure post-merge run/job: `32071325525` / `95514986697`;
- Lean: `4.33.0`;
- Mathlib input/resolved: `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical verification: `lake exe mk_all --check` followed by the full `Formalization` build.

### Public comparator

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- source: `src/latest/ErdosProblems/Erdos678.lean`;
- source blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- source is fetched ephemerally and is never vendored;
- compilation environment: the same pinned Lean/Mathlib/PNT+ environment used for S1/S2b/S2c comparator checks.

## Design principle: type-correct semantic mutations

Every S2d mutation changes a natural-number index or interval boundary while remaining syntactically and type correct at the edited expression. No mutation is an identifier typo, missing import, malformed term, or deliberately ill-typed edit.

A failure at the mutated theorem/definition may still occur because its existing proof no longer proves the changed proposition. That is a valid semantic rejection and is precisely what S2d measures.

The exact machine-readable mutation definitions are frozen in `S2_SEMANTIC_INDEX_MUTATIONS.yaml`. No mutation may be added, removed, weakened, strengthened, or reclassified after any S2d outcome is observed unless the whole observed run is declared exploratory/excluded and the complete revised experiment is rerun prospectively.

## Predeclared matched mutation set

### I1 — canonical block-start shift left by one

**Semantic perturbation:** replace the canonical block `n+1,...,n+k` by the same-length block `n,...,n+k-1`.

Internal mutation:

- file: `formalization/Formalization/Erdos678/Intervals.lean`;
- declaration: `erdosM`;
- original: `intervalLCM (n + 1) k`;
- mutated: `intervalLCM n k`.

Comparator mutation:

- file: pinned `src/latest/ErdosProblems/Erdos678.lean`;
- declaration: `lcmInterval`;
- original: `(Finset.Ioc n (n + k)).lcm id`;
- mutated: `(Finset.Ico n (n + k)).lcm id`.

`Finset.Ioc n (n+k)` is `{n+1,...,n+k}` while `Finset.Ico n (n+k)` is `{n,...,n+k-1}`. Thus the two textual edits implement the same one-step left shift and preserve block length.

This is the closest controlled replay of the historical indexing failure.

### I2 — long block loses its final term

**Semantic perturbation:** at the strong theorem interface, replace the long block of `k+1` terms by a block of `k` terms with the same start.

Internal mutation:

- file: `formalization/Formalization/Erdos678/Erdos678Final.lean`;
- declaration: `cambie_lcm_ratio_eventually_with_large_start`;
- original long-block expression: `intervalLCM y (k + 1)`;
- mutated long-block expression: `intervalLCM y k`;
- only the occurrence in the theorem statement is changed; proof text remains byte-for-byte unchanged.

Comparator mutation:

- file: pinned `src/latest/ErdosProblems/Erdos678.lean`;
- declaration: `MainTheoremStatement`;
- original long block: `Finset.Icc y (y + k)`;
- mutated long block: `Finset.Icc y (y + k - 1)`.

Both edits delete exactly the last element of the `k+1`-term long block while preserving its first element.

### I3 — canonical separation strengthened by one

**Semantic perturbation:** replace `n + k ≤ m` by `n + (k+1) ≤ m` at a canonical unbounded/infinitude endpoint.

Internal mutation:

- file: `formalization/Formalization/Erdos678/Erdos678Final.lean`;
- declaration: `erdos678_unbounded_witnesses`;
- original: `n + k ≤ m`;
- mutated: `n + (k + 1) ≤ m`;
- only the theorem proposition occurrence is changed; proof text remains unchanged.

Comparator mutation:

- file: pinned `src/latest/ErdosProblems/Erdos678.lean`;
- declaration: `erdos_678_kmn_infinite`;
- original set condition: `n + k ≤ m`;
- mutated set condition: `n + (k + 1) ≤ m`;
- only the theorem proposition occurrence is changed; proof text remains unchanged.

I3 is deliberately included as a **semantic-survival control**. The strong Cambie interfaces already expose a strict separation of the form `y > x + k`, so a one-step stronger translated natural-number separation may remain provable. If it survives canonical verification, the correct result is `semantic-mutation-survived`, not an apparatus failure and not evidence that the canonical target was preserved. This control tests the distinction between proof correctness and statement fidelity.

## Mutation procedure

Every artifact × mutation observation starts from a pristine immutable baseline.

For each observation:

1. validate the exact baseline commit/blob and source SHA identities;
2. validate Lean/Mathlib/PNT+ identity;
3. establish the predeclared baseline verification target as green;
4. locate the exact original snippet and require exactly the predeclared occurrence count before editing;
5. apply only the frozen semantic/index replacement;
6. verify that no other project/dependency source changed;
7. run the predeclared staged verification sequence without making repairs;
8. stop at the first semantic rejection for the primary rejection-depth metric, while retaining diagnostics;
9. if all staged checks remain green, run the full canonical verification and record `semantic-mutation-survived-canonical-verification` if it is green;
10. reset completely to the pristine baseline before the next observation.

**No repair phase is part of S2d.** S2d measures detection/rejection, not repair effort. Any attempt to edit a proof after mutation invalidates that observation.

## Internal staged verification sequence

The harness must run only stages relevant to the mutation, in the following fixed logical order. A skipped stage because it is upstream of the mutation is recorded explicitly as `not_applicable`, not silently omitted.

Logical rejection strata:

- `L0_mutation_source_elaboration` — build/elaborate the module containing the changed definition/theorem;
- `L1_concrete_semantic_oracle` — `Formalization.Erdos678.ConcreteTests` when the primitive interval semantics can affect it (mandatory for I1; not applicable for I2/I3);
- `L2_local_endpoint_regression` — the nearest existing test module for the mutated logical endpoint (`Erdos678FinalTests` for I2/I3; source-level theorem diagnostics count as L0 if rejection occurs earlier);
- `L3_statement_bridge` — build `Formalization.Erdos678.ExternalStatementBridge` and `ExternalStatementBridgeTests` when downstream of the mutation;
- `L4_canonical_import_graph` — `lake exe mk_all --check`;
- `L5_full_canonical_build` — full `Formalization` build.

For I1 the source module `Intervals` is L0, `ConcreteTests` is L1, final/bridge targets follow as downstream layers. For I2/I3 the mutation is already in `Erdos678Final`, so `Intervals`/`ConcreteTests` are upstream and are not used to create an artificial earlier checkpoint.

## Comparator staged verification sequence

The comparator is one monolithic project-owned source file. It cannot be assigned artificial module boundaries matching the internal decomposition.

For each comparator mutation:

1. compile the complete pinned mutated `Erdos678.lean` in the common environment;
2. if compilation fails, record the first error line and the enclosing declaration as the first rejection point;
3. classify that declaration into the same logical strata where possible: primitive definition, local lemma/regression, strong theorem, canonical corollary, or whole-artifact completion;
4. if the full source compiles, record `semantic-mutation-survived-comparator-compilation`.

No prefix truncation or synthetic file splitting is allowed, because that would change the comparator artifact and create incomparable boundaries.

## Primary metrics

For each of the six artifact × mutation observations record:

- baseline identity validation: pass/fail;
- mutation snippet identity/occurrence validation: pass/fail;
- mutated files: exact list;
- non-mutation files touched: must be zero;
- mutation source itself typechecks/elaborates: yes/no where separable;
- first rejection stratum;
- first failing module/declaration;
- first diagnostic line and normalized diagnostic class;
- number of staged checks passed before rejection;
- whether the concrete independent oracle rejected the mutation, where applicable;
- whether statement-bridge checks rejected the mutation, where applicable;
- whether `mk_all --check` rejected the mutation, where reached;
- whether full canonical verification rejected the mutation, where reached;
- semantic mutation survived all canonical verification: boolean.

Secondary metadata:

- wall time per stage for apparatus diagnostics only;
- runner version/image;
- exact temporary source digest after mutation;
- exact baseline source digest;
- Lean/Mathlib/PNT+ pins;
- comparator commit/blob;
- raw stderr/stdout excerpts stored in the experiment artifact.

Wall time is **not** interpreted as semantic robustness or maintenance cost.

## Rejection-depth interpretation

The ordinal layer number is meaningful only within the predeclared logical sequence. It is not treated as a continuous quantitative score and is not averaged across mutations.

Report all six observations individually. Comparisons between the modular internal artifact and monolithic comparator are descriptive. A rejection in an internal dedicated regression module and a rejection later in a monolithic comparator file may support a statement about **where the encoded controls surfaced this particular mutation**, not general architecture superiority.

A mutation that survives every check is scientifically important. It demonstrates that theorem proving can certify a changed but still true statement; target fidelity then depends on statement locks, external specification, or explicit regression assertions rather than type checking alone.

## Success criteria

S2d is scientifically successful if:

- protocol and manifest are frozen before harness implementation and before outcomes;
- all baseline/source identities validate;
- all six predeclared mutations are attempted exactly once in the credited run unless the whole run is excluded for an apparatus/provenance defect;
- no proof repair or post-observation mutation redesign occurs;
- every rejection and every survival is retained;
- mutation application touches only the predeclared source occurrence;
- third-party/dependency sources remain untouched;
- exact diagnostics and provenance are retained in machine-readable output;
- conclusions remain scoped to these three semantic/index perturbations.

A scientifically valid outcome may contain early rejections, late rejections, or canonical survivors in any combination.

## Failure/exclusion taxonomy

- `apparatus_failure` — wrong baseline, wrong occurrence count, fetch/parser/instrumentation error, or missing required provenance;
- `infrastructure_failure` — runner/network/toolchain availability failure unrelated to the semantic mutation;
- `semantic_rejection` — existing proof/regression/canonical verification fails after the type-correct mutation;
- `semantic_mutation_survived` — all required checks remain green after mutation;
- `non_comparable` — the predeclared semantic equivalence of a matched mutation pair is invalidated before outcome interpretation.

No individual observation may be removed because it rejects too early, too late, or survives unexpectedly. A protocol defect found after observation requires excluding the complete affected credited run and prospectively rerunning a corrected full set.

## Interpretation limits

S2d does not establish:

- general semantic robustness;
- general maintainability;
- human error-detection time;
- cognitive difficulty;
- proof complexity;
- causal superiority of modularity or monolithic structure;
- upgrade robustness;
- correctness of statements not covered by the canonical external specification.

It can establish only the observed rejection/survival behavior of these three frozen one-unit semantic/index perturbations under the pinned artifacts and verification layers.

## Required output

The eventual S2d execution must produce:

- one machine-readable JSON result containing exact provenance and all six observations;
- one Markdown baseline report derived from that JSON;
- raw staged command logs/diagnostics for every observation;
- exact predeclaration commit, apparatus commit, run/job/artifact identities;
- source digests before/after every mutation;
- explicit audit that only the frozen mutation source occurrence changed;
- explicit classification of rejections versus canonical survivors.

## Gate to execution

The protocol and manifest must be committed, integrated through exact-head canonical CI, merged, and post-merge verified **before** any S2d mutation harness is created or any mutation is executed.

Only after that gate may the apparatus branch be created from the verified predeclaration baseline.

`DEC-012` remains in force: S2d authorizes work only on archived Erdős #678 and does not authorize another problem.
