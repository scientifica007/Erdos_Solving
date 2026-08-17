# Erdős #678 — S2c Repair-Locality Protocol

## Status

**PREDECLARED / NOT YET EXECUTED.**

This protocol is fixed before any S2c mutation is executed or any S2c repair observation is collected. The experiment concerns archived Erdős #678 only.

## Research question

Under matched, semantics-preserving **API symbol-break mutations** at comparable logical layers, how broadly do project-owned references have to change before each formal artifact returns to its pre-mutation verified theorem set?

This is deliberately narrower than a general maintainability experiment. S2c measures **symbol/API repair locality and blast radius**. It does not measure mathematical difficulty, proof quality, developer time, semantic robustness, or architecture superiority.

Semantic/index/off-by-one mutations are excluded from S2c and reserved for S2d.

## Immutable baselines

### Internal artifact

- repository: `scientifica007/Erdos_Solving`;
- baseline commit: `cc55073fceddb51e3fa2c1854f797fe989523985`;
- Lean: `4.33.0`;
- Mathlib input/resolved: `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical verification entry: full `Formalization` graph after `lake exe mk_all --check`.

### Public comparator

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- source: `src/latest/ErdosProblems/Erdos678.lean`;
- source blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- source is fetched ephemerally and is never vendored;
- compilation environment: the same pinned internal Lean/Mathlib/PNT+ Lake environment used in S1/S2b.

## Why symbol-break mutations

A declaration rename without a compatibility alias:

1. preserves the theorem's proposition and proof body;
2. creates a deterministic API break at a named logical boundary;
3. forces every downstream static reference to be repaired;
4. does not change mathematical truth or index semantics;
5. can be applied to both artifacts without inventing artifact-specific proof obligations.

Therefore the repair surface is observable without conflating it with theorem proving. The resulting evidence is about reference locality, not proof robustness.

## Predeclared matched mutation set

The exact machine-readable mutation manifest is `S2_REPAIR_LOCALITY_MUTATIONS.yaml`. No mutation may be added, removed, or reclassified after repair observations are seen without declaring the original run exploratory and rerunning the complete revised set.

### R1 — analytic-input closure boundary

Internal:

- declaration: `claim4RelativePrimeProviderOfPNT`;
- file: `Formalization/Erdos678/Claim4RelativePrimePNT.lean`;
- mutated name: `s2c_claim4RelativePrimeProviderOfPNT`.

Comparator:

- declaration: `density_proof`;
- file: pinned `Erdos678.lean`;
- mutated name: `s2c_density_proof`.

Matched role: each declaration converts the externally verified prime-distribution input into the project-local analytic interface consumed by the later Cambie construction.

### R2 — eventual large-k witness-construction boundary

Internal:

- declaration: `claim4_exists_cambie_lcm_ratio_eventually_of_pnt`;
- file: `Formalization/Erdos678/Claim4RelativePrimePNT.lean`;
- mutated name: `s2c_claim4_exists_cambie_lcm_ratio_eventually_of_pnt`.

Comparator:

- declaration: `exists_xy_for_large_k`;
- file: pinned `Erdos678.lean`;
- mutated name: `s2c_exists_xy_for_large_k`.

Matched role: each is the large-`k` existence/construction interface directly consumed by the artifact's final strong-theorem layer. Their statements are not textually identical; the experiment matches **logical role**, not proposition syntax. This limitation must remain visible in interpretation.

### R3 — strong public theorem boundary

Internal:

- declaration: `cambie_lcm_ratio_eventually_with_large_start_real`;
- file: `Formalization/Erdos678/ExternalStatementBridge.lean`;
- mutated name: `s2c_cambie_lcm_ratio_eventually_with_large_start_real`.

Comparator:

- declaration: `main_theorem_given_pnt`;
- file: pinned `Erdos678.lean`;
- mutated name: `s2c_main_theorem_given_pnt`.

Matched role: each is the unconditional real-factor strong endpoint exposed above the PNT discharge and consumed by downstream statement/corollary/audit code. The internal declaration is a statement-normalized bridge, whereas the comparator declaration is native to its monolithic source; this packaging difference is part of the measured API surface and must not be silently normalized away.

## Mutation and repair procedure

Every mutation is executed independently from a pristine copy of its immutable baseline.

For each side and mutation:

1. validate exact baseline commit/blob and toolchain identities;
2. establish a green baseline compilation before mutation;
3. rename **only the declaration site**, with no compatibility alias and no downstream edits;
4. compile the predeclared verification target and require a nonzero exit caused by unresolved old-symbol references;
5. record the first failing project-owned file/module and all unresolved-old-symbol diagnostics available from the build;
6. repair only by replacing downstream project-owned references from the old name to the predeclared new name;
7. do not alter the renamed declaration's proposition or proof body except for the declaration identifier itself;
8. compile again and require success;
9. for the internal artifact, finish with `lake exe mk_all --check` and the full `Formalization` build;
10. record exact changed-reference sites and repair metrics;
11. reset fully to the immutable baseline before the next mutation.

If declaration-only mutation unexpectedly compiles successfully because no downstream static reference exists, record `no-observable-break` rather than inventing a repair. Such a case remains part of the result.

## Allowed repair scope

Allowed:

- project-owned source references to the renamed declaration;
- project-owned test/audit references to the renamed declaration.

Forbidden:

- changing theorem propositions;
- changing proof bodies for mathematical reasons;
- adding aliases or compatibility shims;
- changing Mathlib/PNT+/other third-party source;
- changing the comparator outside its single pinned temporary source;
- changing build configuration to hide a failure;
- touching unrelated references merely to reduce or increase measured counts.

Any forbidden touch invalidates that mutation replicate.

## Ownership classes

Every changed location is classified before aggregation as one of:

- `production_project_owned` — theorem/definition source in the artifact's proof implementation;
- `verification_project_owned` — tests, `#check`, `#print axioms`, or audit-only code;
- `third_party_or_dependency` — forbidden to modify and expected to remain zero;
- `experiment_harness` — measurement apparatus, excluded from repair-surface counts.

For the comparator, its pinned `Erdos678.lean` is `production_project_owned` for purposes of this external comparison even though it is not owned by this repository. Vendored PNT+ support in the comparator repository is third-party support and must not be touched.

## Primary metrics

Recorded separately for every mutation and artifact:

- mutation produced expected compile failure: boolean;
- first failing project-owned file/module;
- number of downstream reference sites repaired, excluding declaration site;
- number of distinct production project-owned files/modules repaired;
- number of distinct verification project-owned files/modules repaired;
- number of changed production lines containing repaired references;
- number of changed verification lines containing repaired references;
- total project-owned reference-repair lines;
- third-party/dependency files touched: must be zero;
- successful repaired compile: boolean;
- successful final canonical verification: boolean where applicable.

Secondary descriptive fields:

- unresolved-symbol diagnostic count when reliably parseable;
- reference-site line numbers;
- declaration-site line number;
- first-rejection target/module;
- whether all repairs are pure identifier substitutions;
- wall time only as apparatus metadata, **not** a repair-cost metric.

## Aggregation

With only three predeclared logical layers, S2c is a small controlled case study rather than a statistical benchmark. Report all mutation-level values individually. Median/sum summaries may be included only as convenience and may not replace the raw table.

Because the comparator packages almost all #678 proof code in one source module, **file count is never interpreted alone**. Reference-site count, verification/production classification, and exact line locations accompany every file/module count.

## Success criteria

S2c is scientifically successful if:

- all baseline identities validate;
- every mutation follows the predeclared declaration-only break;
- every observed repair is recorded without performance/appearance-based exclusion;
- no third-party/dependency source is touched;
- repaired artifacts regain their predeclared verification target;
- machine-readable results retain exact provenance;
- conclusions remain scoped to API/reference repair locality.

S2c may still produce a valid negative/null result—for example similar reference blast radii at all three layers.

## Failure and exclusion rules

Classify failures as:

- `apparatus_failure` — identity, fetch, parser, or instrumentation failure;
- `infrastructure_failure` — runner/network/toolchain availability issue;
- `mutation_not_observable` — declaration rename creates no failing downstream reference;
- `repair_failure` — legal identifier-only repairs do not restore verification;
- `non_comparable` — the matched logical-role assumption is shown to be invalid before interpreting repair counts.

No individual mutation may be dropped because its result is inconvenient. A protocol defect discovered after execution requires documenting the affected run as excluded/exploratory and rerunning the full corrected mutation set.

## Interpretation limits

S2c does not establish:

- general maintainability;
- human repair time or cognitive difficulty;
- semantic robustness;
- mathematical proof complexity;
- upgrade robustness;
- architecture superiority.

It can establish only the observed API/reference repair blast radius for these three predeclared matched logical boundaries under the pinned artifacts.

## Required output

The executed experiment must produce:

- one machine-readable JSON result containing baseline identities and all six side×mutation observations;
- one Markdown baseline report derived from that JSON;
- exact experiment commit/run/job/artifact identities;
- declaration and repaired-reference line locations;
- a retained copy of the predeclared mutation manifest;
- explicit zero/nonzero third-party-touch audit.

## Gate to S2d

S2d must not start until S2c evidence is integrated through exact-head canonical CI, merge, and post-merge verification on `main`.

`DEC-012` remains in force: this protocol authorizes no work on another Erdős problem.
