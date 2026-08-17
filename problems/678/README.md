# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b CLOSED. S2c CLOSED / CLOSURE VERIFIED. S2d EXECUTED / ARTIFACT VALIDATED / PENDING PR INTEGRATION.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let `M(n,k) = lcm{n+1,...,n+k}`. The final Lean graph includes `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and the stronger Cambie construction. The analytic dependency is pinned to `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

## S1 / S2a / S2b / S2c

- **S1:** common-environment executable differential verification against the pinned Aristotle/Alexeev formalization; closed and machine-verified.
- **S2a:** dependency-surface metrics are boundary-sensitive; closed.
- **S2b:** no stable wall-clock winner under the pinned common environment, with materially different CPU/memory profiles; closed. A computationally green pilot was excluded when required provenance was missing.
- **S2c:** three prospectively frozen API-reference mutations produced a mixed/interface-dependent repair-locality result; no uniform winner; closed through PR #32 + closure PR #33 and exact-main post-merge verification.

## S2d — semantic/index mutation resistance — EXECUTED / VALIDATED

### Historical motivation

The retained 2026-08-14 correction records a type-correct semantic indexing error: an attempted construction treated the block for `M(t,k+1)` as `[t,t+k]`, while the canonical convention is `[t+1,t+k+1]`. S2d prospectively replays bounded one-unit semantic/index drift rather than identifier breakage.

### Frozen design

The protocol and mutation set were integrated and post-merge verified through PR #34 **before** apparatus creation:

- protocol: `S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`;
- manifest: `S2_SEMANTIC_INDEX_MUTATIONS.yaml`;
- frozen internal source baseline: `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`;
- predeclaration final head: `5aaef5a667ee11cc526beae587cf9ab799727f7e`;
- predeclaration merge: `2db145226bf530f406e734129fd8a451a2ab3899`.

Exactly three matched mutation pairs were frozen:

1. **I1 — canonical block-start shift left by one.** Same-length block moves from `n+1..n+k` to `n..n+k-1`.
2. **I2 — long block loses its final term.** The `k+1`-term long block becomes `k` terms with the same start.
3. **I3 — separation strengthened by one.** `n+k≤m` becomes `n+(k+1)≤m`; this was intentionally allowed to survive if the changed target remained true.

No repair phase is allowed. Each observation starts from a pristine baseline and records first semantic rejection or complete survival.

### Excluded first pilot

Run `32074822049`, job `95525626029`, completed computationally but is excluded **as a whole**. Post-run audit showed an instrumentation error in a primary metric: comparator theorem `main_theorem : MainTheoremStatement` was labeled `local_lemma_or_regression` instead of the frozen `strong_theorem` class.

The run was not relabeled and credited post hoc. Only the classifier was corrected; no mutation, baseline, protocol, proof source, or semantic check changed. All six observations were rerun from pristine baselines.

### Credited experiment

The credit rule was fixed before the rerun: only the `pull_request`-event workflow checking out the exact PR head is credited.

- apparatus head: `a82ae53b57a9f97844013a9b2e96a9182cee241d`;
- run: `32076614547`;
- job: `95531085803`;
- runner/image: `2.336.0`, `ubuntu24/20260810.271.1`;
- artifact: `9303987121`;
- GitHub SHA-256: `29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881`;
- independently downloaded artifact SHA-256: **exact match**.

The apparatus first revalidated the frozen internal baseline (`mk_all = No update necessary`, full **8808-job** build) and the pinned comparator baseline. It restored pristine source state between observations and again completed the 8808-job graph after the experiment.

### Credited outcomes

| mutation | artifact | source elaborated? | first rejection | first failing check/declaration |
|---|---|---:|---|---|
| I1 start shift | internal | yes | `L1_concrete_semantic_oracle` | `ConcreteTests` |
| I1 start shift | comparator | yes | local invariant/regression | `lcmInterval_ge_choose` |
| I2 drop final term | internal | no | `L0_mutation_source_elaboration` | mutated strong endpoint source |
| I2 drop final term | comparator | yes | strong theorem | `main_theorem` |
| I3 strengthen separation | internal | no | `L0_mutation_source_elaboration` | mutated canonical endpoint source |
| I3 strengthen separation | comparator | no | canonical corollary | `erdos_678_kmn_infinite` |

Aggregate:

- observations: **6/6**;
- semantic rejections: **6**;
- survivors: **0**;
- proof repairs: **0**;
- third-party/dependency source touches: **0**.

### Scientific interpretation

The strongest defensible conclusion is:

> **All three prospectively frozen one-unit semantic/index perturbations were rejected in both artifacts, but the first encoded rejection point depended on the mutation and artifact structure.**

I1 is especially informative internally: the mutated primitive definition `erdosM` still elaborated, and the first rejection came from an **independent concrete numerical oracle**. This is direct evidence that such regression oracles can add statement-fidelity protection beyond local type correctness.

I3, despite being designed as a possible semantic-survival control, did not survive in either artifact. This does not establish that every nearby changed-but-true target would be rejected.

No cross-artifact ordinal ranking is justified. Internal `L0..L5` stages and comparator monolithic declaration classes are structurally different observables. S2d does **not** establish general semantic robustness, architecture superiority, human debugging speed, proof complexity, maintainability, or upgrade robustness.

Validated report: `S2_SEMANTIC_INDEX_BASELINE.md/.json`. Exact raw `result.json` and per-stage logs remain in GitHub Actions artifact `9303987121`.

## Current integration gate

PR #35 contains the apparatus and validated S2d evidence. The final PR head, after evidence synchronization, must pass canonical exact-head Lean Verification. Merge is allowed only if green, and the exact resulting `main` commit must then pass post-merge verification. A documentation-only closure should record those integration facts before S2e begins.

## AI-for-science relevance

The process now contains four distinct methodology episodes:

1. **S2a:** reproducibility does not rescue a proxy whose ownership/dependency boundary is incomparable.
2. **S2b:** computational success does not rescue missing predeclared provenance.
3. **S2c:** a prospective comparison may legitimately yield a mixed result that should be retained.
4. **S2d:** semantic drift can be rejected by different encoded controls; additionally, a computationally green experiment must still be excluded when its primary rejection classifier is wrong.

## Public artifact and stop rule

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored.

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
