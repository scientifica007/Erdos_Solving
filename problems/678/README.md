# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b CLOSED. S2c CLOSED / CLOSURE VERIFIED. S2d PREDECLARED / NOT EXECUTED.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let `M(n,k) = lcm{n+1,...,n+k}`. The final Lean graph includes `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and the stronger preceding Cambie construction. The analytic dependency is pinned to `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` and consumes machine-checked `prime_between`.

## Scientific classification

- mathematical author/result: Stijn Cambie / known solution;
- project mode: external-proof reconstruction;
- formal artifact: independent Lean reimplementation;
- new mathematical proof claim: **no**;
- first Lean formalization claim: **no**;
- prior public formalization: Aristotle + Boris Alexeev;
- executable differential verification: **yes**.

## S1 — CLOSED

Run `32028006457` built the internal canonical graph and compiled the pinned public comparator unchanged inside this repository's Lean 4.33 / Mathlib / PNT+ environment. PR #22 and closure PR #27 completed exact-head and post-merge verification.

## S2a — dependency surface — CLOSED

S2a established that raw module/file/frontier counts are **boundary-sensitive** because PNT+ lies on different repository ownership boundaries in the two artifacts. The result is a measurement control, not an architecture ranking.

## S2b — controlled build behavior — CLOSED

The credited run `32053575928` completed six paired replicates. Cold wall time showed no stable winner (`159.575 s` internal versus `156.280 s` comparator median; paired differences changed sign), while CPU and memory profiles differed materially under the pinned common environment. The first green pilot remains excluded because required runner-version provenance was absent. PR #30 and closure PR #31 completed verified integration.

## S2c — repair locality — CLOSED / CLOSURE VERIFIED

S2c prospectively froze three matched declaration-rename mutations before its harness and observations. All six artifact×mutation observations produced the expected unresolved-symbol break and all six legal identifier-only repairs returned green, with zero third-party/dependency edits.

Raw repaired-reference counts were:

| mutation | internal | comparator |
|---|---:|---:|
| R1 analytic closure | 3 = 2 production + 1 verification | 1 production |
| R2 eventual construction | 2 = 1 production + 1 verification | 1 production |
| R3 strong endpoint | 2 verification, 0 production | 3 production |

The defensible conclusion is **mixed and interface-layer dependent**: no uniform repair-locality or maintainability advantage is observed.

PR #32 integrated the substantive S2c evidence. Documentation closure PR #33 final head `3439b58f1e05e2cb21ee1c9374857eb3b4197163` passed canonical run `32070637072`, job `95512851767`, then merged as `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`. That exact merge passed post-merge run `32071325525`, job `95514986697`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**. S2c is fully closed.

## S2d — semantic/index mutation resistance — PREDECLARED / NOT EXECUTED

### Historical motivation

The 2026-08-14 correction retained a concrete semantic failure: an attempted construction treated the block for `M(t,k+1)` as `[t,t+k]`, whereas the canonical Erdős convention requires `[t+1,t+k+1]`. This is a one-step interval-index shift, not a type error.

The internal artifact now contains multiple controls aimed at this class of drift:

- `Intervals.lean` defines a length-based API and explicitly documents the off-by-one hazard;
- `ConcreteTests.lean` contains independent explicit LCM oracles and preserves the false `(495,504,8)` candidate as a negative regression;
- `ExternalStatementBridge.lean` proves equivalence between `erdosM` and the `Finset.Ioc` convention;
- `Erdos678Final.lean` performs the final off-by-one-safe translation.

### Frozen research question

Under small, matched, type-correct index perturbations, **where is the first observable semantic rejection**, and can a changed-but-still-true target survive all machine checks?

### Frozen mutations

The predeclared set contains exactly three mutation pairs, each applied independently to pristine baselines:

1. **I1 — canonical block-start shift left by one.**
   - Internal: `erdosM n k` changes from `intervalLCM (n+1) k` to `intervalLCM n k`.
   - Comparator: `lcmInterval n k` changes from `Ioc n (n+k)` to `Ico n (n+k)`.
   - Both represent the same-length block shifted left by one; this is the closest replay of the historical failure.

2. **I2 — long block loses its final term.**
   - Internal strong endpoint: `intervalLCM y (k+1)` becomes `intervalLCM y k`.
   - Comparator `MainTheoremStatement`: `Icc y (y+k)` becomes `Icc y (y+k-1)`.
   - Both remove exactly one final term from the long block.

3. **I3 — separation strengthened by one.**
   - Canonical condition changes from `n+k≤m` to `n+(k+1)≤m` at matched unbounded/infinitude endpoints.
   - This is intentionally a **semantic-survival control**. If it remains provable, that is retained as evidence that machine checking can certify a changed but still true statement and therefore cannot replace statement-fidelity controls.

Full definitions are frozen in:

- `S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`;
- `S2_SEMANTIC_INDEX_MUTATIONS.yaml`.

### Rejection layers

For the modular internal artifact, rejection is classified prospectively across:

`L0 mutation source` → `L1 concrete oracle` → `L2 endpoint regression` → `L3 statement bridge` → `L4 mk_all` → `L5 full canonical build`.

The comparator remains monolithic; it is compiled as the pinned complete source, and the first error line/enclosing declaration is classified by logical layer. No synthetic splitting is allowed.

### No repair and no outcome yet

S2d contains **no repair phase**. The mutation is applied, staged checks run, and the first rejection—or complete survival—is recorded. No proof edit is allowed after mutation.

At this checkpoint:

- harness: **not created**;
- mutations executed: **0/6**;
- outcomes observed: **none**.

The current predeclaration-only branch must pass exact-head canonical CI, merge, and pass post-merge verification on the exact resulting `main` commit before apparatus creation or execution is permitted.

## AI-for-science relevance

The case now has four methodological layers:

1. S2a: reproducibility does not rescue an invalid proxy boundary.
2. S2b: green computation does not rescue missing predeclared provenance.
3. S2c: a predeclared comparison may legitimately yield a mixed result that defeats a simple architecture narrative.
4. S2d: machine rejection depth and statement fidelity are distinct; a semantic mutation may fail early, fail late, or remain a different but machine-checked theorem.

## Public artifact

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
