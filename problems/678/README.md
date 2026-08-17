# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 COMPLETE / VERIFIED. S2 ACTIVE. S2a COMPLETE / INTEGRATED / POST-MERGE + CLOSURE VERIFIED. S2b ACTIVE / PROTOCOL DEFINED / EXPERIMENT PENDING.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let `M(n,k) = lcm{n+1,...,n+k}`. The final Lean graph includes `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and the stronger preceding Cambie construction.

The analytic dependency is pinned to `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`, consumed through the machine-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

## Scientific classification

- mathematical author/result: Stijn Cambie / known solution;
- independent mathematical attempt: rejected;
- project mode: external-proof reconstruction;
- formal artifact: independent Lean reimplementation;
- new mathematical proof claim: **no**;
- first Lean formalization claim: **no**;
- prior public formalization: Aristotle + Boris Alexeev;
- executable differential verification: **yes**.

## S1 — CLOSED

Run `32028006457` built the internal canonical graph with **8808 jobs** and compiled `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` `Erdos678.lean` unchanged inside this repository's Lean 4.33 / Mathlib / PNT+ environment. Machine bridges align interval semantics, Formal-Conjectures-style eventual existence, unbounded/infinite lengths, and real-factor `C ≥ 1` semantics.

PR #22 and closure PR #27 both passed exact-head/post-merge canonical verification. S1 closure main commit `7aff8d8d8680e90b34be64650c68c0fc778749fc` passed run `32045885504` with exact provenance, `No update necessary`, and 8808 jobs.

## S2a — dependency surface — CLOSED

Protocol: `S2_DEPENDENCY_SURFACE_PROTOCOL.md`.

Analyzer: `experiments/s2_dependency_surface.py`.

Durable result: `S2_DEPENDENCY_SURFACE_BASELINE.md` and `S2_DEPENDENCY_SURFACE_BASELINE.json`.

Executed identity:

- internal experiment commit: `4685fca552ae4a0270dfa3823d46fde48efa5ade`;
- experiment run/job: `32047324807` / `95438118197` — **SUCCESS**;
- comparator commit/blob: `6f906fef432892db5c910c48ad1a3728dd42cdac` / `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- generated artifact digest: `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`.

Integration identity:

- PR #28 exact head `3d4e35c15eb07938dfcb3fb5de29e8d51f1e767e` passed run `32047808010`;
- merge `37deb850f894d32863970aca6b07e876f89e813d` passed post-merge run `32048513043`;
- closure PR #29 exact head `0a1d1cf84c87c5a3b40d6a118e733cda5807a4a7` passed run `32050225638`;
- closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed run `32050862725`, job `95449629511`;
- final closure provenance: `verified_commit=c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5`, `No update necessary`, **8808 jobs**.

Canonical-result baseline:

| Structural metric | Erdos_Solving | Public comparator |
|---|---:|---:|
| reachable local modules | 46 | 10 |
| local import edges | 58 | 10 |
| max local import depth | 33 | 4 |
| external-frontier modules | 14 | 27 |
| artifact-owned modules | 46 | 1 |
| artifact-owned source lines | 5546 | 2546 |
| third-party repository-local support modules | 0 | 9 |
| third-party repository-local support source lines | 0 | 6943 |

### S2a interpretation

The principal finding is **boundary sensitivity**: module/file/frontier counts can measure packaging and ownership choices as well as proof decomposition. Internally PNT+ is an external Lake dependency; the comparator repository physically contains nine reachable PNT+ modules. Raw counts are not proof-complexity or architecture-quality rankings.

## S2b — controlled build behavior — ACTIVE

Protocol: `S2_BUILD_BEHAVIOR_PROTOCOL.md`.

Measurement runner: `experiments/s2_build_behavior.py`.

The experiment is predeclared before timing:

- six independent fresh `ubuntu-24.04` paired-runner replicates;
- alternating order: internal-first / comparator-first;
- one common Lean 4.33 / Mathlib v4.33 / PNT+ pinned Lake environment;
- comparator commit/blob validated before measurement and source copied byte-for-byte only into runner-local temporary workspace;
- dependency/network/toolchain/cache preparation excluded from artifact timing;
- **cold** = artifact-owned generated outputs removed while dependencies remain prepared;
- **warm** = unchanged immediate repeat of the identical target;
- metrics: wall time, user CPU, system CPU, maximum RSS, exit status, and Lake `Built` progress observations;
- all observations retained; only predeclared infrastructure failures may be retried/excluded with classification.

Internal target: `Formalization.Erdos678.Erdos678Final`.

Comparator target in the common environment: `Formalization.Erdos678Benchmark.Comparator` generated at runtime from the exact public comparator blob.

S2b has **not yet produced credited timing evidence**. No speed/efficiency/architecture claim is allowed before all six replicates are validated and consolidated.

## AI-for-science relevance

S2a established that a metric can be perfectly reproducible yet scientifically invalid if the automated system measures an unexamined boundary. S2b operationalizes the correction: environment setup, source ownership, cache state, order effects, replicate policy, and interpretation limits are fixed **before** observing timings.

## Public artifact

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored. No repository ruleset was detected immediately after public transition; protecting `main` remains a governance task before accepting outside contributions.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
