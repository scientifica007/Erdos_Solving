# Erdős #678 — S2e Upgrade-Robustness Protocol

## 1. Scientific question

S2e asks a deliberately narrower question than “is this formalization maintainable?”:

> For two prospectively frozen forward Lean/Mathlib upgrade candidates, where does the current archived #678 artifact first become incompatible, which failures belong to external dependency support versus project-owned source, and—only when the failing layer is project-owned—what bounded semantic-preserving repair surface is required to restore the predeclared verification targets?

S2e measures **version-transition compatibility and bounded repair surface under these exact candidates**. It does not measure human repair time, general maintainability, proof complexity, or architecture superiority.

The experiment is internal-artifact focused. S2a–S2d already provide the cross-artifact comparison controls; adding the monolithic comparator here would confound upgrade attribution with packaging and dependency-boundary differences.

## 2. Freeze point and baseline identities

The S2e source baseline is the exact S2d closure merge:

- repository: `scientifica007/Erdos_Solving`;
- baseline commit: `5039d464f6196e6b47494f0a6fae869e3362d082`;
- baseline Lean: `leanprover/lean4:v4.33.0`;
- baseline Mathlib input: `v4.33.0`;
- baseline Mathlib resolved commit: `db584cd6d46c92f209a44c0f1c829460d327499d`;
- baseline PNT+: `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

Before any candidate is attempted, the apparatus must validate the baseline with:

1. exact checkout identity;
2. `lake exe mk_all --check` → `No update necessary`;
3. full `lake build Formalization` → 8808-job canonical graph under the baseline environment.

A failed baseline invalidates the entire S2e run; no candidate result is credited.

## 3. Upstream compatibility fact frozen before execution

At predeclaration time (2026-08-18):

- PNT+ `main` resolves to the **same** commit as the project baseline, `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- that PNT+ commit declares Lean `v4.33.0-rc1` and its own older Mathlib revision;
- no newer PNT+ provider revision is therefore available to predeclare as a coordinated 4.34 support upgrade.

This is not an observed S2e result. It is a design constraint fixed before execution. S2e must not invent, patch, or silently vendor an unverified PNT+ upgrade.

## 4. Frozen upgrade candidates

Exactly two candidates are permitted.

### U1 — compiler-only forward pressure

Purpose: isolate the effect of changing the Lean compiler/toolchain while keeping the dependency source/lock identities fixed.

Temporary candidate state:

- Lean: `leanprover/lean4:v4.34.0-rc1`;
- root Mathlib input: unchanged `v4.33.0`;
- resolved Mathlib source: unchanged baseline commit `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: unchanged `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- `lakefile.toml`: byte-for-byte baseline;
- `lake-manifest.json`: byte-for-byte baseline;
- only the temporary `lean-toolchain` is changed.

No `lake update` is allowed for U1. A dependency source that fails to compile under the newer compiler is classified as a dependency-support failure, not as project-owned proof breakage.

### U2 — coordinated root Lean + Mathlib release-candidate upgrade

Purpose: approximate the next normal root-project upgrade while keeping the external PNT provider frozen because no newer provider revision exists at predeclaration time.

Temporary candidate state:

- Lean: `leanprover/lean4:v4.34.0-rc1`;
- root Mathlib: exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11`;
- provenance tag: `v4.34.0-rc1`;
- PNT+: unchanged `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- project source: baseline `5039d464f6196e6b47494f0a6fae869e3362d082`.

The apparatus modifies only a temporary copy/worktree: it pins the root Mathlib requirement to the exact candidate commit, uses the candidate Lean toolchain, regenerates the temporary Lake manifest, and validates that the root Mathlib resolution is exactly `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` and PNT+ remains exactly `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

Candidate configuration/manifest edits are **experiment setup**, not project repair.

## 5. No floating identities

Execution must fail closed if any candidate identity differs from this protocol or `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`.

Forbidden substitutions include:

- `master`, `main`, `latest`, or a nightly alias in place of an exact frozen candidate;
- a different Lean 4.34 RC;
- a later Mathlib commit;
- a newly appearing PNT+ commit discovered after predeclaration;
- an automatically chosen dependency revision not recorded in the result.

A later upstream release may motivate a new experiment, but it cannot modify S2e after observation begins.

## 6. Experimental isolation

All candidate changes occur in runner-local temporary copies/worktrees. The repository branch under test remains unchanged.

For each candidate:

1. start from a fresh copy of baseline commit `5039d464f6196e6b47494f0a6fae869e3362d082`;
2. validate baseline source hashes for the files used by the protocol;
3. apply only the predeclared candidate configuration;
4. perform the **no-repair detection pass** completely before any source repair;
5. if and only if the repair rules below permit it, start a separate bounded repair phase from the same pristine candidate state;
6. preserve raw logs and diffs.

No candidate state may leak into another candidate.

## 7. No-repair detection stages

The first pass permits **zero project-source edits**. It records every permitted sentinel outcome, not merely the first error.

### D0 — candidate environment identity

Validate:

- exact Lean version;
- exact candidate configuration files;
- expected baseline/candidate source commit identities;
- runner image/version metadata.

A D0 failure is an apparatus/provenance failure and invalidates that candidate.

### D1 — package graph / manifest resolution

- U1: validate the baseline manifest remains byte-for-byte unchanged and resolves the frozen package commits.
- U2: regenerate the temporary manifest and validate exact root Mathlib and PNT+ commits.

Resolver/configuration failure is classified `package-resolution-blocked`; it is not a project proof failure.

### D2 — project-owned Mathlib-only sentinels

Attempt all three independently, even if one fails, provided D0/D1 succeeded:

1. `lake build Formalization.Erdos678.Intervals`;
2. `lake build Formalization.Erdos678.ValuationBasic`;
3. `lake build Formalization.Erdos678.Claim4Density`.

These modules import Mathlib but not PNT+. They provide project-owned compatibility evidence that remains interpretable even if the external PNT provider later blocks the full stack.

For each sentinel, record the first failing file and whether it lies in:

- project-owned source;
- Mathlib/transitive dependency source;
- toolchain/runtime infrastructure.

### D3 — external PNT+ support boundary

Run:

`lake build PrimeNumberTheoremAnd`

If the first substantive compile failure is under `.lake/packages/PrimeNumberTheoremAnd` or one of its dependency packages, classify the PNT-dependent portion of the candidate as `dependency-support-blocked` and **do not patch that dependency**.

### D4 — project PNT-boundary sentinel

Only when D3 is green, run:

`lake build Formalization.Erdos678.Claim4RelativePrimePNT`

This is the first frozen project target that explicitly imports `PrimeNumberTheoremAnd.Consequences`.

### D5 — canonical #678 endpoint

Only when D3 is green, run:

`lake build Formalization.Erdos678.Erdos678Final`

Record the first project-owned or dependency-owned failing file/declaration.

### D6 — canonical import/full graph

Only after preceding required dependency/project targets are green without repair, run:

1. `lake exe mk_all --check`;
2. `lake build Formalization`.

A complete no-repair survivor must pass both.

## 8. Failure ownership taxonomy

Every failure used scientifically must receive exactly one primary owner class:

- `apparatus_or_provenance` — identity, checkout, runner, or harness invariant;
- `package_resolution` — Lake graph/manifest resolution before source compilation;
- `lean_toolchain` — compiler/runtime failure not attributable to package/project source;
- `mathlib_or_transitive_dependency` — first substantive diagnostic in Mathlib or a transitive package other than PNT+;
- `pnt_dependency_support` — first substantive diagnostic in PNT+ source;
- `project_owned` — first substantive diagnostic under `formalization/Formalization/**`;
- `ambiguous` — ownership cannot be established from retained diagnostics.

`ambiguous` is retained as such; it must not be forced into a preferred category.

## 9. Repair phase eligibility

Repair is a **second phase**, never part of no-repair detection.

Third-party/dependency source edits are prohibited. There is no legal PNT+ source patch in S2e.

### 9.1 Mathlib-only repair track

If one or more D2 sentinels fail with owner `project_owned` while D0/D1 are valid, project-owned repair may attempt to make all three D2 sentinels green.

This track remains valid even if D3 is dependency-support-blocked.

### 9.2 PNT-dependent/full repair track

This track is permitted only if D3 is green. It may repair project-owned failures in D4/D5/D6.

If D3 is not green, the full candidate is recorded as dependency-support-blocked and no workaround, vendoring, source patch, or alternate PNT revision is allowed.

## 10. Legal project-owned repair scope

Repairs may modify only project-owned Lean sources under:

- `formalization/Formalization/Erdos678/**/*.lean`;
- `formalization/Formalization.lean` when an import-only adjustment is required.

The following are forbidden repair targets:

- `.lake/packages/**`;
- any third-party repository/source;
- `formalization/lakefile.toml`, `lean-toolchain`, or `lake-manifest.json` beyond the predeclared candidate setup;
- experiment protocols/manifests/results;
- test/regression files whose role is to verify semantic fidelity.

In particular, these verification files are immutable during repair:

- `Formalization/Erdos678/ConcreteTests.lean`;
- `Formalization/Erdos678/Erdos678FinalTests.lean`;
- `Formalization/Erdos678/ExternalStatementBridgeTests.lean`.

## 11. Statement-fidelity invariants during repair

A repair is invalid if it changes the proposition/type header of any frozen semantic endpoint.

Before execution, the harness must derive declaration-header fingerprints from the frozen baseline for at least:

- `cambie_lcm_ratio_eventually_with_large_start_real`;
- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`;
- `erdos678_formalConjectures_eventual_nonempty`.

The fingerprint covers the declaration header/type and excludes the proof body. After every repair batch and at final green, these fingerprints must remain identical to baseline.

The immutable regression files above must also remain byte-for-byte identical to baseline.

Proof bodies/imports may change only as required for compatibility. Changing the target theorem is never an upgrade repair.

## 12. Bounded repair policy

To prevent open-ended post-observation refactoring, each candidate has a fixed project-repair budget:

- maximum repair batches: **12**;
- maximum project-owned files touched: **10**;
- maximum aggregate source line churn: **250** additions + deletions;
- no full-file rewrites solely to evade line-count limits.

A repair batch addresses the currently retained project-owned compiler diagnostics with the smallest local semantic-preserving API/tactic/import change available. Broad refactoring, performance tuning, cleanup, style-only edits, and theorem-strength changes are forbidden.

If any budget is exceeded before the required targets become green, classify the repair result `project-repair-budget-exceeded`. Do not expand the budget after seeing the result.

The batch count and line churn are descriptive engineering measures only; they are not human effort or maintainability scores.

## 13. Repair execution order

For an eligible candidate:

1. restore pristine candidate state after no-repair detection;
2. repair D2 project-owned sentinel failures, if any, until all D2 sentinels are green or the budget is exhausted;
3. run D3 unchanged;
4. if D3 is dependency-support-blocked, stop the PNT-dependent track and retain the D2 repair result;
5. if D3 is green, progress D4 → D5 → D6, repairing only project-owned failures under the same cumulative budget;
6. after every batch, re-run all previously green project targets relevant to the track;
7. at final green, re-run immutable regression tests and statement-fidelity checks.

No successful repair may be cherry-picked from another candidate.

## 14. Required measurements

For each candidate, record:

### Identity/provenance

- baseline commit;
- candidate Lean identity;
- root Mathlib input and resolved commit;
- PNT+ commit;
- runner image/version;
- exact workflow/apparatus commit.

### No-repair outcomes

- D0–D6 status where applicable;
- all D2 sentinel outcomes;
- first failing file/declaration/diagnostic per attempted stage;
- primary owner class;
- deepest green stage;
- full no-repair survivor: yes/no.

### Repair outcomes

- repair eligibility;
- final class: `not_needed`, `repaired_green`, `dependency_support_blocked`, `project_repair_budget_exceeded`, or `apparatus_invalid`;
- repair batch count;
- project-owned files touched;
- hunks and additions/deletions;
- per-batch diff/log;
- third-party source files touched (must be zero);
- immutable regression files touched (must be zero);
- statement-header fingerprint changes (must be zero);
- final verification targets reached.

Timing is apparatus metadata only and is not an S2e outcome metric.

## 15. Crediting and exclusion rules

- A candidate is scientifically credited only if its provenance checks pass.
- Infrastructure/network failures may be retried and must be logged as such.
- A source compile failure is an outcome, not an infrastructure failure, and may not be silently retried away.
- No result is excluded because it is inconvenient, early, or dependency-blocked.
- If the apparatus misclassifies a primary measurement or violates the frozen candidate/repair contract, exclude the **entire affected run/candidate set**, fix only instrumentation, and rerun the complete frozen set from pristine baselines.
- Do not change candidate versions, budgets, stages, sentinels, or interpretation rules after the first S2e source-compatibility observation.

## 16. Interpretation boundaries

S2e may support claims such as:

- whether the current artifact survives U1/U2 without project repair;
- whether the next-root-stack probe is blocked first by external dependency support;
- which predeclared project-owned layers require compatibility repair;
- bounded project-owned repair surface for these exact candidates;
- whether immutable semantic regressions and canonical statement headers remain intact after legal repair.

S2e does **not** support:

- general maintainability superiority;
- expected future upgrade cost;
- human repair speed or difficulty;
- causal attribution from line count alone;
- general Lean/Mathlib compatibility claims beyond U1/U2;
- criticism of PNT+ maintainers if their project has not yet upgraded to the frozen candidate;
- architecture superiority.

A dependency-support blocker is a supply-chain/version-boundary observation, not a proof-quality defect.

## 17. Reproducibility artifact

The credited workflow must upload one exact artifact containing:

- machine-readable result JSON;
- Markdown summary;
- environment and package identity records;
- baseline validation logs;
- D0–D6 raw logs;
- pristine candidate configuration diffs;
- every legal repair batch diff/log if repair occurs;
- ownership classifications with diagnostic evidence;
- statement-header fingerprint records;
- final source diff and scope audit.

The apparatus itself must be created only **after** this predeclaration is integrated and post-merge verified.

## 18. Stop rule

S2e concerns archived Erdős #678 only. It neither reopens the mathematics nor authorizes another Erdős problem. `DEC-012` remains in force.
