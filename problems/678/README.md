# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b CLOSED. S2c EXECUTED / ARTIFACT VALIDATED / PENDING PR INTEGRATION. S2d NOT STARTED.**
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

Run `32028006457` built the internal canonical graph and compiled the pinned public comparator unchanged inside this repository's Lean 4.33 / Mathlib / PNT+ environment. PR #22 and closure PR #27 completed exact-head and post-merge verification; S1 closure commit `7aff8d8d8680e90b34be64650c68c0fc778749fc` passed run `32045885504` with `No update necessary` and 8808 jobs.

## S2a — dependency surface — CLOSED

S2a produced `S2_DEPENDENCY_SURFACE_BASELINE.md/.json` and established that raw module/file/frontier counts are **boundary-sensitive**. Internally PNT+ is an external Lake dependency; the comparator repository physically contains nine reachable PNT+ modules. Raw repository counts therefore mix proof decomposition, packaging, and ownership.

S2a closed through PR #28 and closure PR #29. Final closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed run `32050862725`, job `95449629511`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

## S2b — controlled build behavior — CLOSED

The credited six-replicate run is `32053575928`, apparatus `c2ef703c954e462096162a3b4a59a5e0f8d48488`. Its core result is **no stable wall-clock winner** under the pinned common environment: cold medians are `159.575 s` internal versus `156.280 s` comparator, with paired differences spanning `-10.68..+11.73 s`. Resource profiles nevertheless differ materially: total CPU medians `241.155 s` versus `486.475 s`, and max RSS `7,183,766` versus `7,828,930 KiB`.

The first six-job pilot is excluded in full because required runner-version provenance was missing; the apparatus was made fail-closed and all six observations were rerun. PR #30 and closure PR #31 completed the integration. Final closure merge `cc55073fceddb51e3fa2c1854f797fe989523985` passed run `32060186755`, job `95479480527`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

Full protocol/result: `S2_BUILD_BEHAVIOR_PROTOCOL.md` and `S2_BUILD_BEHAVIOR_BASELINE.md/.json`.

## S2c — repair locality — EXECUTED / VALIDATED

### Scope

S2c deliberately measures only **symbol/API reference-repair locality**, not general maintainability. It uses semantics-preserving declaration-name breaks: theorem propositions and proof bodies stay unchanged; no alias is added; legal repair is exact downstream identifier substitution only.

The protocol and mutation manifest were frozen at `a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1` before the harness existed and before observations. The frozen files are:

- `S2_REPAIR_LOCALITY_PROTOCOL.md`;
- `S2_REPAIR_LOCALITY_MUTATIONS.yaml`.

### Matched logical layers

| ID | logical role | internal | comparator |
|---|---|---|---|
| R1 | analytic-input closure | `claim4RelativePrimeProviderOfPNT` | `density_proof` |
| R2 | eventual large-k construction | `claim4_exists_cambie_lcm_ratio_eventually_of_pnt` | `exists_xy_for_large_k` |
| R3 | strong public endpoint | `cambie_lcm_ratio_eventually_with_large_start_real` | `main_theorem_given_pnt` |

The match is by logical layer, not by textual proposition identity; this remains an interpretation limitation.

### Execution provenance

- frozen internal baseline: `cc55073fceddb51e3fa2c1854f797fe989523985`;
- experiment apparatus: `00d340d3ccdc13418615b6526e9b736d9f9e03e7`;
- run: `32062501296` — **SUCCESS**;
- job: `95486770197` — **SUCCESS**;
- comparator: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- artifact ID: `9299556049`;
- artifact SHA-256: `0369ec66c689572307660765b0c84cd86b6339f4f4d26a788c560ca11f7b7f4b`;
- independent post-run ZIP SHA-256 recomputation: **match**.

All six artifact×mutation cases first produced an unresolved-symbol failure and then returned to green after legal identifier-only repair. Third-party/dependency edits: **0**. Each internal repaired mutation additionally passed `lake exe mk_all --check` with `No update necessary` and a full **8808-job** build.

### Raw repair blast radius

| mutation | internal | comparator |
|---|---|---|
| R1 | 3 refs: 2 production + 1 verification | 1 production ref |
| R2 | 2 refs: 1 production + 1 verification | 1 production ref |
| R3 | 2 verification refs; **0 production refs** | 3 production refs |

Exact internal sites:

- R1: `Claim4RelativePrimePNT.lean:78`, `Erdos678Final.lean:112`, `Claim4RelativePrimePNTTests.lean:11`;
- R2: `CambieStrongTheorem.lean:25`, `Claim4RelativePrimePNTTests.lean:18`;
- R3: `ExternalStatementBridgeTests.lean:31,38` only.

Exact comparator downstream sites:

- R1: `Erdos678.lean:2449`;
- R2: `Erdos678.lean:2011`;
- R3: `Erdos678.lean:2461,2469,2514`.

### Scientific conclusion

The result is **mixed and interface-layer dependent**. R1/R2 have more static downstream references internally, partly because dedicated verification modules deliberately reference the API. R3 reverses at the production layer: the internal normalized endpoint has zero production consumer after declaration, while the comparator endpoint has three production consumers.

Therefore S2c does **not** establish that either architecture has uniformly smaller repair blast radius. Raw totals (`7` internal versus `5` comparator) are bookkeeping only, not a maintainability ranking. Production/verification separation matters: across these three mutations internal production references total `3` and verification references `4`; comparator production references total `5` under the predeclared classification.

The defensible result is:

> **API/reference repair locality varies by logical interface and by consumer class; no uniform repair-locality advantage is observed in the three predeclared matched mutations.**

Detailed validated evidence is in `S2_REPAIR_LOCALITY_BASELINE.md/.json`.

## AI-for-science relevance

The process now contains three controlled methodology episodes:

1. S2a: reproducible metrics can be scientifically misleading when dependency/ownership boundaries are wrong.
2. S2b: a green computation can still be inadmissible scientific evidence when predeclared provenance is missing.
3. S2c: a predeclared experiment can return a mixed result that resists a simple architectural narrative; the correct action is to retain the mixed result rather than redesign the metric after observation.

These episodes are externally auditable from commits, protocols, CI runs, artifacts, and corrections; hidden chain-of-thought is unnecessary.

## Next gate — S2d semantic/index mutation resistance

S2d has **not started**. First S2c must be synchronized, opened as a PR, pass exact-head canonical Lean Verification, merge, and pass post-merge verification on the exact `main` commit. Only then may S2d define its semantic/index mutation protocol prospectively.

## Public artifact

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
