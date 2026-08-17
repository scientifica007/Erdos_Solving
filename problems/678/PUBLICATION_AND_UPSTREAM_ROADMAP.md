# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

Two candidate contribution tracks remain distinct:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal auditable case study covering invalid reasoning, formal rejection, reconstruction, dependency closure, interface repair, regression discipline, state management, attribution, CI-provenance correction, public-artifact closure, and metric-validity controls.

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

### S2a — dependency-surface baseline — EXECUTED / INTEGRATION PENDING

Protocol: `S2_DEPENDENCY_SURFACE_PROTOCOL.md`.

Analyzer: `experiments/s2_dependency_surface.py`.

Result: `S2_DEPENDENCY_SURFACE_BASELINE.md/.json`.

Execution:

- exact internal commit `4685fca552ae4a0270dfa3823d46fde48efa5ade`;
- run `32047324807`, job `95438118197` — **SUCCESS**;
- comparator `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator entry blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- generated artifact digest `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`.

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

The key finding is **metric boundary sensitivity**, not superiority. PNT+ is an external Lake dependency internally, while the comparator physically carries nine reachable PNT+ modules in its repository tree. Thus a raw repository/module/frontier count conflates proof decomposition, dependency packaging, and source ownership.

S2a therefore establishes a control requirement for the rest of S2: every experiment must identify which failures, files, modules, or timings belong to project-owned proof code versus external/repository-local dependency support.

S2a becomes closed only after its PR passes canonical exact-head Lean CI, merges, and `main` verifies. **S2b does not begin before then.**

### S2b — controlled build behavior — NEXT AFTER S2a INTEGRATION

Measure cold/warm build time and resource use with repeated runs, explicit cache state, fixed runner/toolchain identities, and separate phases for internal graph and pinned comparator. Do not use historical wall-clock times as controlled evidence.

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

The case does **not** show AI discovering #678. Its value is the observable process record: false generalization, machine rejection, retained negative knowledge, explicit reconstruction mode, interface decomposition, pinned dependency closure, recovered side conditions, state/build synchronization, differential verification, verification-credit correction, infrastructure/proof-failure classification, public-artifact closure, and now metric-boundary validation.

S2a adds a specific AI-for-science lesson: **an automated metric can be reproducible but scientifically invalid if it measures an unexamined proxy boundary**. Ownership and dependency-packaging rules must be explicit before comparative numbers are interpreted.

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

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; our independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; unchanged public-comparator compilation; matching selected standard-axiom footprint; public Apache-2.0 artifact; exact-head/post-merge S1 evidence; reproducible S2a structural baseline under explicit ownership boundaries.

**Supported interpretation:** independent formal replication has differential-verification value; the process record is a useful long-horizon AI-assisted formalization case; execution-provenance and metric-boundary auditing are scientifically relevant.

**Requires later S2/S4 evidence:** lower dependency coupling in practice, easier maintenance, better upgrade robustness, earlier semantic-drift detection, smaller repair blast radius, faster/more resource-efficient builds, causal benefit of state protocols.

**Unsupported:** new solution of #678, new independent mathematical proof, first Lean formalization, general architecture superiority, autonomous AI authorship percentage, causal claim that one AI technique produced success.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a dependency surface:** EXECUTED / PR INTEGRATION PENDING.
  - **S2b build behavior:** NOT STARTED; next only after S2a integration.
  - **S2c repair locality:** NOT STARTED.
  - **S2d mutation resistance:** NOT STARTED.
  - **S2e upgrade robustness:** NOT STARTED.
  - **S2f independent audit:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. No ruleset was detected immediately after public transition. Before accepting outside contributions, protect `main` so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

The S2a workflow also surfaced a non-blocking environment-drift warning: the current pinned checkout action targets Node 20 and GitHub forces it onto Node 24. This should be handled as an infrastructure maintenance item, not mixed into dependency-surface conclusions.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
