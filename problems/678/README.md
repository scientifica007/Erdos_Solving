# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-18): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b CLOSED. S2c CLOSED. S2d CLOSED / CLOSURE VERIFIED. S2e PREDECLARED / NOT EXECUTED.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let `M(n,k) = lcm{n+1,...,n+k}`. The final Lean graph includes `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and the stronger Cambie construction. The analytic dependency is pinned to `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

## Closed scientific stages

- **S1:** executable common-environment differential verification against Aristotle/Alexeev; closure-verified.
- **S2a:** dependency-surface counts are ownership/boundary sensitive; closure-verified.
- **S2b:** no stable wall-clock winner under the pinned common environment, with materially different CPU/memory profiles; closure-verified.
- **S2c:** repair-locality result is mixed/interface-dependent; no uniform maintainability winner; closure-verified.

## S2d — semantic/index mutation resistance — CLOSED / CLOSURE VERIFIED

Three one-unit semantic/index perturbations were frozen before apparatus creation: canonical block-start shift, long-block endpoint drop, and one-unit separation strengthening. The first computationally successful run `32074822049` was excluded in full after audit found a primary classifier defect. Only instrumentation was corrected; the frozen mutations/checks were not redesigned.

Credited run `32076614547`, job `95531085803`, on apparatus head `a82ae53b57a9f97844013a9b2e96a9182cee241d` produced **6/6 semantic rejections, 0 survivors, 0 proof repairs, and 0 dependency-source edits**. Artifact `9303987121` has SHA-256 `29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881`, independently revalidated.

| mutation | internal first rejection | comparator first rejection |
|---|---|---|
| I1 canonical start shift | concrete numerical oracle after mutated primitive source elaborated | `lcmInterval_ge_choose` |
| I2 long block drops final term | source type mismatch | strong theorem `main_theorem` |
| I3 stronger separation | source application/type mismatch | `erdos_678_kmn_infinite` |

The limited conclusion is that these three frozen perturbations were rejected in both artifacts, at structure- and mutation-dependent locations. I1 specifically demonstrates value from the internal independent numerical oracle beyond primitive type correctness. No general semantic-robustness, proof-complexity, maintainability, or architecture-superiority claim follows.

Substantive PR #35 final head `1a5728574f3d2c5101851becfb2500400aa395bd` passed run `32078084197` / job `95535434320`, merged as `891d7b9e51c3ecc1313ee2de8d2a98036841b128`, and that exact merge passed run `32102682942` / job `95606121109`.

Documentation closure PR #36 final head `46b52c2c8ed1c4dd0623974c82c367071618f71b` passed run `32103456742` / job `95608318715`, merged as `5039d464f6196e6b47494f0a6fae869e3362d082`, and that exact `main` commit passed run `32103947182` / job `95609642835`. Both closure verification points recorded matching `verified_commit`, `No update necessary`, and **8808 jobs**. S2d is fully closed.

Full S2d evidence:

- `S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`;
- `S2_SEMANTIC_INDEX_MUTATIONS.yaml`;
- `S2_SEMANTIC_INDEX_BASELINE.md/.json`.

## S2e — upgrade robustness — PREDECLARED / NOT EXECUTED

### Research question

For two exact forward Lean/Mathlib upgrade candidates, where does the archived internal #678 artifact first become incompatible, which failures are attributable to external dependency support versus project-owned source, and—only for eligible project-owned failures—what bounded semantic-preserving repair surface restores the frozen verification targets?

S2e is not a comparator benchmark and does not claim to measure general maintainability.

### Frozen baseline

- source: S2d closure merge `5039d464f6196e6b47494f0a6fae869e3362d082`;
- Lean: `leanprover/lean4:v4.33.0`;
- Mathlib input/resolved: `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical baseline graph: **8808 jobs**.

### Frozen candidates

**U1 — compiler-only forward pressure**

- Lean `v4.34.0-rc1`;
- baseline Mathlib input/resolved and PNT identities unchanged;
- baseline `lakefile.toml` and `lake-manifest.json` unchanged;
- no `lake update`.

**U2 — coordinated root Lean + Mathlib RC**

- Lean `v4.34.0-rc1`;
- Mathlib exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11`, provenance tag `v4.34.0-rc1`;
- PNT+ remains `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- temporary manifest regeneration must validate those exact resolutions.

At predeclaration time PNT+ `main` equals the same baseline commit and declares an older 4.33-era toolchain/dependency stack. Therefore no newer coordinated PNT provider is substituted. If that dependency boundary blocks U1/U2, S2e records `dependency-support-blocked` rather than patching third-party source or misclassifying it as a project proof defect.

### Frozen detection pipeline

No repair is allowed until the no-repair pass completes.

- **D0:** exact candidate environment/provenance;
- **D1:** package graph / manifest resolution;
- **D2:** all three independent project-owned Mathlib-only sentinels: `Intervals`, `ValuationBasic`, `Claim4Density`;
- **D3:** external `PrimeNumberTheoremAnd` support boundary;
- **D4:** project PNT-boundary target `Claim4RelativePrimePNT`, only if D3 is green;
- **D5:** `Erdos678Final`, only if D3 is green;
- **D6:** `mk_all --check` and full `Formalization` build.

Failures are classified prospectively as apparatus/provenance, package resolution, Lean toolchain, Mathlib/transitive dependency, PNT dependency support, project-owned, or ambiguous.

### Frozen repair discipline

Third-party/dependency source edits are forbidden. Project repair, when eligible, is limited to project-owned Lean sources, starts only after detection, and is bounded by:

- **12 repair batches**;
- **10 project-owned files**;
- **250 aggregate additions + deletions**.

`ConcreteTests.lean`, `Erdos678FinalTests.lean`, and `ExternalStatementBridgeTests.lean` are immutable. The declaration headers/types of `cambie_lcm_ratio_eventually_with_large_start_real`, `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and `erdos678_formalConjectures_eventual_nonempty` are fingerprinted and must remain unchanged.

Full prospective definitions:

- `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`.

### Execution gate

At this checkpoint:

- S2e harness: **not created**;
- U1 executed: **no**;
- U2 executed: **no**;
- upgrade observations: **none**.

The predeclaration-only branch must pass canonical exact-head CI, merge, and pass post-merge verification on the exact resulting `main` commit before apparatus creation or candidate execution is permitted.

## AI-for-science relevance

The methodology record now includes:

1. a reproducible proxy can still be scientifically invalid when boundaries differ (S2a);
2. computational success does not rescue missing provenance (S2b);
3. prospectively defined comparisons may legitimately produce mixed results (S2c);
4. semantic drift may be caught at different encoded controls, and primary classifier defects can invalidate a green run (S2d);
5. upgrade compatibility must distinguish project-owned repair from dependency-support lag before line-count or repair-surface claims are interpreted (S2e design).

## Public artifact and stop rule

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored.

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
