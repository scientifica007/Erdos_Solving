# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b EXECUTED / VALIDATED / PENDING PR INTEGRATION. S2c NOT STARTED.**
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

S2a produced `S2_DEPENDENCY_SURFACE_BASELINE.md/.json` and established the control that raw module/file/frontier counts are **boundary-sensitive**. Internally PNT+ is an external Lake dependency; the comparator repository physically contains nine reachable PNT+ modules. Raw repository counts therefore mix proof decomposition, packaging, and ownership.

S2a closed through PR #28 and closure PR #29. Final closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed run `32050862725`, job `95449629511`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

## S2b — controlled build behavior — EXECUTED / VALIDATED

Protocol: `S2_BUILD_BEHAVIOR_PROTOCOL.md`.

Measurement runner: `experiments/s2_build_behavior.py`.

Strict aggregator: `experiments/s2_build_behavior_aggregate.py`.

Baseline: `S2_BUILD_BEHAVIOR_BASELINE.md/.json`.

### Provenance discipline

Pilot run `32052134207` on apparatus `a349010e295afa52d040feacbb2d02d5c081c548` completed 6/6 jobs but is **excluded in full** because `runner_version` was missing from every result, violating a predeclared provenance invariant. No timing-based selection occurred.

The corrected apparatus fails closed on missing runner/image identity. Credited run `32053575928` on exact apparatus commit `c2ef703c954e462096162a3b4a59a5e0f8d48488` completed **6/6 paired replicates successfully, with zero retries and zero exclusions**. Every artifact records:

- Lean `4.33.0`;
- Mathlib `v4.33.0` / resolved `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- comparator commit/blob `6f906fef...` / `f2331e8b...`;
- runner `2.336.0`;
- image `ubuntu24/20260810.271.1`;
- CPU count 4;
- zero cold/warm build exit codes.

All six downloaded artifact ZIP digests matched GitHub.

### Wall-clock result

| rep | order | internal cold | comparator cold | Δ internal−comparator |
|---:|---|---:|---:|---:|
| 1 | internal-first | 160.80 s | 162.34 s | -1.54 s |
| 2 | comparator-first | 161.59 s | 151.93 s | +9.66 s |
| 3 | internal-first | 157.11 s | 165.81 s | -8.70 s |
| 4 | comparator-first | 149.56 s | 160.24 s | -10.68 s |
| 5 | internal-first | 158.35 s | 146.62 s | +11.73 s |
| 6 | comparator-first | 162.45 s | 152.32 s | +10.13 s |

Cold medians are `159.575 s` internal versus `156.280 s` comparator. Paired differences change sign and range from `-10.68` to `+11.73 s`; therefore **S2b does not establish a stable wall-clock winner**. Warm medians are `4.42 s` versus `4.34 s`, but warm is an unchanged incremental/no-op check, not compilation speed.

### Resource-profile result

| cold metric | internal median | comparator median |
|---|---:|---:|
| user CPU | 176.105 s | 480.580 s |
| system CPU | 64.840 s | 5.990 s |
| total CPU | 241.155 s | 486.475 s |
| max RSS | 7,183,766 KiB | 7,828,930 KiB |
| Lake `Built` lines | 46 | 1 |

The directions are consistent across all six runs: internal user CPU is about `34–39%` of comparator user CPU; internal RSS about `91.7–91.8%` of comparator; internal system CPU is about `10.5–11.1×` comparator. The paired median total-CPU ratio internal/comparator is `0.503`.

**Defensible conclusion:** under this exact common environment, wall time is similar/noisy but the two proof layouts exhibit materially different CPU-system/user and peak-memory profiles. A causal explanation in terms of modular process/file overhead versus monolithic elaboration is plausible but remains an inference, not an S2b result.

S2b does not establish general speed superiority, proof complexity, maintainability, repair locality, semantic-mutation resistance, or upgrade robustness.

## AI-for-science relevance

S2a showed that a reproducible metric can still be scientifically invalid when its boundary is wrong. S2b adds a second empirical control lesson: a green computation can still be inadmissible measurement if required provenance is missing. The pilot was discarded despite 6/6 computational success, apparatus provenance was made fail-closed, and only then were all six replicates rerun and credited.

## Next gate

S2b is **executed/validated but not integrated**. This branch must pass canonical exact-head Lean Verification, merge, and pass post-merge verification on `main`. Only then may S2c repair-locality experiments begin.

## Public artifact

The repository is Public and project-owned material is Apache-2.0. The comparator remains an immutable external fetch and is not vendored.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
