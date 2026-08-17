# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

Two candidate contribution tracks remain distinct:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal auditable case study covering invalid reasoning, formal rejection, reconstruction, dependency closure, interface repair, regression discipline, state management, attribution, CI-provenance correction, public-artifact closure, metric-validity controls, and prospective experiment design.

The mathematical theorem is known work by Stijn Cambie. We do not claim a new solution, an independent new mathematical proof, or formalization priority.

## S0/S1 — CLOSED

S0 dossier freeze and S1 differential verification are complete. S1 run `32028006457` built the internal graph with 8808 jobs and compiled the pinned public comparator unchanged in our Lean 4.33 / Mathlib / PNT+ environment. S1 closure commit `7aff8d8d8680e90b34be64650c68c0fc778749fc` passed post-merge run `32045885504`.

## Track A — formal verification / proof engineering

### Candidate paper title

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

### Main technical differentiator to test

Our analytic boundary uses `prime_between -> Claim4RelativePrimeProvider`. The public comparator routes through a local `pi_alt`/prime-counting layer even though its PNT+ source also contains `prime_between`.

S2 must determine whether architectural differences produce measurable effects; logical-strength or source-layout intuition alone is insufficient.

## S2 — metric and mutation suite — ACTIVE

### S2a — dependency-surface baseline — CLOSED / VERIFIED

Protocol: `S2_DEPENDENCY_SURFACE_PROTOCOL.md`.

Analyzer: `experiments/s2_dependency_surface.py`.

Result: `S2_DEPENDENCY_SURFACE_BASELINE.md/.json`.

Execution:

- exact internal experiment commit `4685fca552ae4a0270dfa3823d46fde48efa5ade`;
- run `32047324807`, job `95438118197` — **SUCCESS**;
- comparator `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator entry blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- generated artifact digest `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`.

Integration and closure:

- PR #28 exact head `3d4e35c15eb07938dfcb3fb5de29e8d51f1e767e` passed `32047808010`;
- merge `37deb850f894d32863970aca6b07e876f89e813d` passed post-merge `32048513043`;
- closure PR #29 exact head `0a1d1cf84c87c5a3b40d6a118e733cda5807a4a7` passed `32050225638`;
- closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed `32050862725`, job `95449629511`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**.

Measured canonical-result structure:

| Metric | Internal | Comparator |
|---|---:|---:|
| reachable local modules | 46 | 10 |
| local import edges | 58 | 10 |
| max local depth | 33 | 4 |
| external-frontier modules | 14 | 27 |
| artifact-owned modules | 46 | 1 |
| artifact-owned source lines | 5546 | 2546 |
| third-party repository-local modules | 0 | 9 |
| third-party repository-local lines | 0 | 6943 |

The key finding is **metric boundary sensitivity**, not superiority. PNT+ is an external Lake dependency internally, while the comparator physically carries nine reachable PNT+ modules in its repository tree. Thus raw repository/module/frontier counts conflate proof decomposition, dependency packaging, and source ownership.

### S2b — controlled build behavior — ACTIVE / PROTOCOL DEFINED

Protocol: `S2_BUILD_BEHAVIOR_PROTOCOL.md`.

Runner: `experiments/s2_build_behavior.py`.

Scientific question:

> Under one pinned Lean/Mathlib/PNT+ environment, how do the two #678 artifacts behave when their artifact-owned compilation outputs are cold versus immediately re-used warm?

The experiment design is fixed before observing timings:

- six independent fresh GitHub `ubuntu-24.04` runner replicates;
- each replicate measures both artifacts on the same runner;
- order alternates internal-first/comparator-first to control first-measurement effects;
- comparator source is fetched at commit `6f906fef432892db5c910c48ad1a3728dd42cdac`, validated by blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`, and exposed byte-for-byte as a temporary Lake module;
- both artifacts use the internal pinned Lean 4.33 / Mathlib v4.33 / PNT+ `2667e414...` environment, neutralizing the repository-local PNT packaging difference observed in S2a;
- checkout/network/toolchain/dependency/cache/prebuild work is outside artifact timing;
- internal cold cleanup deletes generated outputs in `Formalization/Erdos678` only;
- comparator cold cleanup deletes generated outputs in temporary `Formalization/Erdos678Benchmark` only;
- each cold build is followed by an unchanged warm build of the identical target;
- per invocation record wall time, user CPU, system CPU, max RSS, exit code, and Lake progress observations;
- retain all six observations; retry/exclude only predeclared infrastructure failures, never silent performance outliers;
- aggregate by median, range, MAD, IQR, and paired descriptive differences/ratios;
- upload raw logs, `/usr/bin/time` files, JSON, and Markdown per replicate.

**Interpretation control:** warm is a no-change incremental check, not compilation speed. S2b alone cannot establish maintainability, proof complexity, repair locality, or general architecture superiority.

The experiment is not credited until the pinned workflow executes the six replicates and every inclusion/exclusion decision is auditable.

### S2c — repair locality — PLANNED

Apply bounded matched interface mutations and record touched project-owned modules/lines/theorems required to restore each artifact. Dependency-support repairs must be classified separately.

### S2d — semantic mutation resistance — PLANNED

Replay interval/index mutations inspired by the historical off-by-one failure and record the earliest rejection layer under matched mutations.

### S2e — upgrade robustness — PLANNED

Run isolated Lean/Mathlib upgrade probes and measure failure/repair surface, distinguishing project-owned from third-party/dependency failures.

### S2f — independent audit — PLANNED

After quantitative results stabilize, have an independent reviewer inspect statement, metric, assumption, and dependency boundaries.

No claim such as “better architecture”, “easier maintenance”, “faster”, or “more robust” is allowed before the corresponding controlled evidence exists.

## Track B — AI-assisted scientific production

### Candidate paper title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

The case does **not** show AI discovering #678. Its value is the observable process record: false generalization, machine rejection, retained negative knowledge, explicit reconstruction mode, interface decomposition, pinned dependency closure, recovered side conditions, state/build synchronization, differential verification, verification-credit correction, infrastructure/proof-failure classification, public-artifact closure, metric-boundary validation, and prospective experiment definition before measurement.

S2a contributes the lesson that an automated metric can be reproducible but scientifically invalid if it measures an unexamined proxy boundary. S2b strengthens the process methodology by freezing cache semantics, order control, repetitions, exclusions, metrics, and interpretation boundaries **before** timing evidence is observed.

### S4 empirical extension

After S2 stabilizes, derive a machine-readable episode dataset, annotate observable failure/intervention classes, run state/restart and negative-memory controls, and prospectively record model/tool/cost/time metadata. Do not publish hidden chain-of-thought.

## Track C — upstream/community contribution

After S2 evidence:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure the actual effect before proposing upstream;
- consider upstreaming compact statement-normalization lemmas;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

The comparator remains an immutable external fetch rather than vendored material because no repository license was detected for it during the audit.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; our independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; unchanged public-comparator compilation; matching selected standard-axiom footprint; public Apache-2.0 artifact; exact-head/post-merge S1 evidence; reproducible, integrated, and closure-verified S2a structural baseline under explicit ownership boundaries.

**Supported interpretation:** independent formal replication has differential-verification value; the process record is a useful long-horizon AI-assisted formalization case; execution-provenance and metric-boundary auditing are scientifically relevant.

**Requires S2b/S2c/S2d/S2e/S4 evidence:** faster/more resource-efficient artifact-owned builds, easier maintenance, lower repair blast radius, earlier semantic-drift detection, better upgrade robustness, causal benefit of state protocols.

**Unsupported:** new solution of #678, new independent mathematical proof, first Lean formalization, general architecture superiority, autonomous AI authorship percentage, causal claim that one AI technique produced success.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a dependency surface:** COMPLETE / INTEGRATED / POST-MERGE + CLOSURE VERIFIED.
  - **S2b build behavior:** ACTIVE / PROTOCOL DEFINED / EXPERIMENT PENDING.
  - **S2c repair locality:** NOT STARTED.
  - **S2d mutation resistance:** NOT STARTED.
  - **S2e upgrade robustness:** NOT STARTED.
  - **S2f independent audit:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. No ruleset was detected immediately after public transition. Before accepting outside contributions, protect `main` so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

The S2a/CI runs also surface a non-blocking environment-drift warning: the current pinned checkout action targets Node 20 and GitHub forces it onto Node 24. This is infrastructure maintenance evidence, not a scientific S2 result.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
