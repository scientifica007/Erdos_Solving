# Erdős #678 — Publication and Upstream Roadmap

## Objective

Maximize defensible external value from #678 without reopening the mathematics or overstating novelty.

Two distinct contribution tracks remain:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal, auditable case study of failure rejection, reconstruction, provenance control, metric design, reproducibility, and scientific claim calibration.

Cambie's theorem is known mathematics. We do not claim a new solution, independent new mathematical proof, or formalization priority.

## Track A — formal verification / proof engineering

Candidate title:

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

The analytic boundary remains a concrete technical differentiator: our development uses `prime_between -> Claim4RelativePrimeProvider`; the public comparator routes through a `pi_alt`/prime-counting layer. S2 measures consequences rather than assuming superiority from source layout.

## S0/S1 — CLOSED

S1 run `32028006457` established common-environment differential verification. Exact-head/post-merge integration closed through PR #22 and closure PR #27. S1 closure commit `7aff8d8d8680e90b34be64650c68c0fc778749fc` passed run `32045885504` with exact provenance, `No update necessary`, and 8808 jobs.

## S2 — ACTIVE

### S2a — dependency surface — CLOSED

S2a's durable result is `S2_DEPENDENCY_SURFACE_BASELINE.md/.json`. It established that dependency-surface metrics are **boundary-sensitive**: PNT+ is an external Lake dependency internally but repository-local source in the comparator tree. Raw module/file/frontier counts therefore mix proof decomposition, packaging, and ownership.

S2a closed through PR #28 and closure PR #29. Closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed run `32050862725`, job `95449629511`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

### S2b — controlled build behavior — CLOSED / VERIFIED

Protocol: `S2_BUILD_BEHAVIOR_PROTOCOL.md`.

Measurement runner: `experiments/s2_build_behavior.py`.

Strict aggregator: `experiments/s2_build_behavior_aggregate.py`.

Baseline: `S2_BUILD_BEHAVIOR_BASELINE.md/.json`.

#### Measurement-validity episode

Pilot apparatus `a349010e295afa52d040feacbb2d02d5c081c548`, run `32052134207`, completed 6/6 jobs but is excluded **as a whole** because every result omitted `runner_version`, violating a predeclared provenance invariant. No observation was selected by performance.

The runner was changed to fail closed on absent runner/image identity. Credited apparatus `c2ef703c954e462096162a3b4a59a5e0f8d48488`, run `32053575928`, then completed **6/6 replicates successfully, with zero retries and zero exclusions**.

All six artifacts validated the same:

- runner `2.336.0`, image `ubuntu24/20260810.271.1`;
- Lean `4.33.0`;
- Mathlib input `v4.33.0`, resolved `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- comparator commit/blob `6f906fef...` / `f2331e8b...`;
- exact apparatus SHA;
- zero build exit codes;
- downloaded artifact SHA-256 digests matching GitHub.

#### Wall-clock finding

Cold medians:

- internal: `159.575 s`;
- comparator: `156.280 s`.

Paired `internal − comparator` differences are `[-1.54, +9.66, -8.70, -10.68, +11.73, +10.13] s`. The sign changes and range exceeds the median difference (`+4.06 s`). Therefore **S2b does not establish a stable wall-clock winner**.

Warm medians are `4.42 s` versus `4.34 s`, but warm is a no-change incremental check, not compilation speed.

#### Resource-profile finding

Cold medians:

| Metric | Internal | Comparator |
|---|---:|---:|
| user CPU | 176.105 s | 480.580 s |
| system CPU | 64.840 s | 5.990 s |
| total CPU | 241.155 s | 486.475 s |
| max RSS | 7,183,766 KiB | 7,828,930 KiB |
| Lake `Built` lines | 46 | 1 |

Directions are consistent in all six replicates. Internal/comparator user-CPU ratios are about `0.341–0.388`; RSS ratios `0.917–0.918`; system-CPU ratios about `10.5–11.1`. The paired median total-CPU ratio is `0.503`.

**Defensible S2b interpretation:** after normalizing dependency/toolchain environment, the two proof layouts have similar/noisy wall time but materially different CPU-user/system and memory profiles. This is execution-profile evidence, not universal speed or architecture superiority.

A causal explanation—modular process/file overhead versus monolithic elaboration cost—is plausible but remains an inference for later work.

#### Integration evidence

PR #30 exact head `e52e85d9b328a9cbc2349a6b61e23187dcc72fb5` passed canonical run `32055813783`. It merged as `c9900f9e2590f3101fc24f3f894f43b6fcf4e03c`; the exact merge commit passed post-merge run `32058421851`, job `95473817638`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**.

The substantive S2b evidence is therefore integrated and machine-verified. This documentation-only closure synchronization is the final DEC-008 bookkeeping gate before S2c activation.

### S2c — repair locality — NEXT

Apply matched bounded mutations at carefully selected project-owned interfaces and measure the repair surface: touched project-owned modules, declarations, lines, proof obligations, and dependency-support involvement. Predefine mutations and success criteria before observing repair behavior. Do not use S2b timing differences as a proxy for maintenance cost.

S2c must begin with a predeclared protocol that fixes at least:

- the exact internal and comparator commits/blobs used as immutable baselines;
- mutation families and semantic intent before observing repair effort;
- a matched mutation contract so both artifacts are perturbed at comparable logical interfaces rather than arbitrary line locations;
- what counts as a successful repair and what files/modules may be touched;
- project-owned versus third-party/dependency-support attribution;
- repair metrics: changed project-owned files/modules, changed lines, declarations/proof obligations touched, build failures encountered, and verification steps;
- rules for abandoned/non-comparable mutations and failure classification;
- machine-readable evidence and exact commit provenance.

### S2d — semantic mutation resistance — PLANNED

Replay controlled interval/index mutations inspired by the historical off-by-one failure and record the earliest rejection layer under matched semantic perturbations.

### S2e — upgrade robustness — PLANNED

Run isolated Lean/Mathlib upgrade probes and measure failure/repair surfaces with project-owned versus dependency-support attribution.

### S2f — independent audit — PLANNED

After quantitative S2 results stabilize, have an independent reviewer inspect statement, metric, assumption, dependency, and interpretation boundaries.

## Track B — AI-assisted scientific production

Candidate title:

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

The case does **not** show AI discovering #678. Its value is the observable process record: false generalization, machine rejection, retained negative knowledge, reconstruction mode, interface decomposition, pinned dependency closure, side-condition recovery, state/build synchronization, differential verification, verification-credit correction, infrastructure/proof-failure classification, public-artifact closure, metric-boundary validation, and prospective experiment definition.

S2 now contributes two unusually concrete methodology episodes:

- **S2a:** a metric can be reproducible yet scientifically invalid if ownership/dependency boundaries make the proxy incomparable;
- **S2b:** a workflow can be computationally green yet scientifically inadmissible if a predeclared provenance field is missing. The full pilot was discarded and rerun after the instrumentation became fail-closed.

These are publishable as observable process/evidence episodes without exposing hidden chain-of-thought.

### S4 empirical extension

After S2 stabilizes, derive a machine-readable episode dataset and annotate observable failure/intervention classes, restart/state controls, negative-memory effects, tool/model identities, cost/time, and human interventions. Do not publish hidden model chain-of-thought.

## Track C — upstream/community contribution

After S2 evidence:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure actual proof/build effects before proposing upstream;
- consider compact statement-normalization lemmas for upstream use;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

The comparator remains an immutable external fetch rather than vendored material because no repository license was detected for it during the audit.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; unchanged public-comparator compilation; matching selected standard-axiom footprint; public Apache-2.0 artifact; S1 differential verification; S2a boundary-sensitive structural baseline; S2b six-replicate common-environment build/resource baseline with exact-head and post-merge verification.

**Supported interpretation:** independent formal replication has differential-verification value; execution provenance and metric-boundary auditing are scientifically relevant; under the recorded S2b environment the artifacts exhibit different CPU/memory profiles without a stable wall-time winner.

**Still requires later evidence:** easier maintenance, smaller repair blast radius, earlier semantic-drift rejection, better upgrade robustness, causal explanations for S2b resource differences, causal benefit of project state protocols.

**Unsupported:** new solution, new independent mathematical proof, first Lean formalization, general architecture superiority, universal speed advantage, autonomous AI authorship percentage.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2b:** COMPLETE / INTEGRATED / POST-MERGE VERIFIED; closure synchronization in progress.
  - **S2c:** NOT STARTED; next after this closure synchronization is integrated and verified.
  - **S2d:** NOT STARTED.
  - **S2e:** NOT STARTED.
  - **S2f:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. No ruleset was detected immediately after public transition. Protect `main` before accepting outside contributions so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
