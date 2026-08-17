# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 COMPLETE / VERIFIED. S2 ACTIVE. S2a dependency-surface baseline COMPLETE / INTEGRATED / POST-MERGE VERIFIED. S2b NOT STARTED.**
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
- experiment run: `32047324807`;
- experiment job: `95438118197`;
- comparator commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- generated artifact digest: `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`.

Integration identity:

- PR: `#28`;
- exact PR head: `3d4e35c15eb07938dfcb3fb5de29e8d51f1e767e`;
- canonical exact-head run: `32047808010` — **SUCCESS**;
- merge commit: `37deb850f894d32863970aca6b07e876f89e813d`;
- post-merge run: `32048513043` — **SUCCESS**;
- execution provenance: `verified_commit=37deb850f894d32863970aca6b07e876f89e813d`;
- import graph check: `No update necessary`;
- canonical build: **8808 jobs**.

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

### Interpretation

The verified artifacts have very different decomposition/packaging topologies. Internally, #678 is distributed across 46 project-owned reachable modules and PNT+ is an external Lake dependency. The comparator concentrates #678 in one artifact-owned source module while nine reachable PNT+ modules are physically present in the comparator repository.

The principal S2a finding is therefore **boundary sensitivity**: module/file/frontier counts can measure packaging and ownership choices as well as proof decomposition. Raw counts cannot be treated as proof-complexity or architecture-quality rankings.

Consequently:

- `46 vs 1` does not mean one proof is intrinsically more complex;
- `14 vs 27` external-frontier modules is not a direct coupling ranking because PNT+ is resolved on different sides of the repository boundary;
- source lines and declaration counts are implementation statistics only.

Later S2 experiments must use matched interface mutations, explicit cache/package state, and ownership-aware failure classification.

## S2b — controlled build behavior — NEXT

S2b has not started. After this documentation-only S2a closure PR passes canonical exact-head CI, merges, and `main` verifies, S2b will measure controlled cold/warm build behavior with fixed runner/toolchain identities, explicit cache state, repeated runs, and separate attribution of artifact-owned versus dependency-support work. Historical wall-clock times are not accepted as controlled evidence.

## AI-for-science relevance

S2a contributes a methodological failure-prevention rule to the case study: a metric can be perfectly reproducible and still scientifically invalid if the automated system measures the wrong boundary. Metric definition, ownership classification, and packaging normalization are part of the scientific method, not post-processing details.

## Public artifact

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored. No repository ruleset was detected immediately after public transition; protecting `main` remains a governance task before accepting outside contributions.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
