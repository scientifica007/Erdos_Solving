# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

Two candidate contribution tracks remain distinct:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal auditable case study covering invalid reasoning, formal rejection, reconstruction, dependency closure, interface repair, regression discipline, state management, attribution, CI-provenance correction, and public-artifact closure.

The mathematical theorem is known work by Stijn Cambie. We do not claim a new solution, an independent new mathematical proof, or formalization priority.

## S0/S1 — CLOSED

S0 dossier freeze and S1 common-environment differential verification are complete. S1 run `32028006457` built the internal graph with 8808 jobs and compiled the pinned public comparator unchanged in our Lean 4.33 / Mathlib / PNT+ environment. PR #22 passed exact-head run `32043807200`, merged as `358cd541...`, and passed post-merge run `32044314748` attempt 2. Closure PR #27 merged as `7aff8d8d...` and passed post-merge run `32045885504`.

These results establish differential-verification compatibility and exact integration provenance. They do not establish architecture superiority.

## Track A — formal verification / proof engineering

### Candidate paper title

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

### Main technical differentiator to test

Our analytic boundary uses `prime_between -> Claim4RelativePrimeProvider`, directly matching the short multiplicative-prime interval needed by the construction. The public comparator routes through a local `pi_alt`/prime-counting layer even though its PNT+ source also contains `prime_between`.

The S2 question is not logical strength. It is whether these architectural choices measurably affect dependency surface, repair locality, mutation resistance, build behavior, or upgrade robustness.

## S2 — metric and mutation suite — ACTIVE

### S2a — dependency-surface baseline — ACTIVE

Protocol: `S2_DEPENDENCY_SURFACE_PROTOCOL.md`.

Analyzer: `experiments/s2_dependency_surface.py`.

The first S2 experiment measures module/import structure under explicit ownership and packaging boundaries. The canonical-result profile compares:

- `Formalization.Erdos678.Erdos678Final`;
- `ErdosProblems.Erdos678` from `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`, entry blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.

S2a records reachable local modules/edges/depth, external frontier, raw source-line and top-level declaration-command counts, and full auditable module/edge lists.

A key validity control is the ownership split:

- `artifact_owned`;
- `repository_local_support`;
- `third_party_repository_local_support`.

This is required because PNT+ is an external Lake dependency in this repository but appears physically under `src/latest/PrimeNumberTheoremAnd` in the comparator repository. A naive raw file count would therefore measure packaging as if it were proof complexity.

**S2a claim limit:** structural graph counts may describe decomposition and packaging. They do not prove lower coupling, simpler mathematics, easier maintenance, faster builds, or greater robustness.

### S2b — controlled build behavior — PLANNED

After S2a baseline is frozen, measure cold/warm build time and resource use with repeated runs and explicit cache state.

### S2c — repair locality — PLANNED

Apply bounded interface mutations and record touched modules/lines/theorems required to restore each artifact.

### S2d — semantic mutation resistance — PLANNED

Replay interval/index mutations inspired by the historical off-by-one failure and record where each representation rejects them.

### S2e — upgrade robustness — PLANNED

Run an isolated Lean/Mathlib upgrade probe and measure failure/repair surface.

### S2f — independent audit — PLANNED

After quantitative results stabilize, have an independent reviewer inspect statement, assumption, metric, and dependency boundaries.

No claim such as “better architecture”, “easier maintenance”, “faster”, or “more robust” is allowed before the corresponding controlled evidence exists.

## Track B — AI-assisted scientific production

### Candidate paper title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

The case does **not** show AI discovering #678. Its value is the observable process record: false generalization, machine rejection, retained negative knowledge, explicit reconstruction mode, interface decomposition, pinned dependency closure, recovered side conditions, state/build synchronization, differential verification, verification-credit correction, infrastructure/proof-failure classification, and public-artifact closure.

S2 adds another research-process dimension: **metric design and validity controls**. A reproducible metric can still be scientifically invalid if ownership, packaging, or source boundaries are conflated. S2a records those choices explicitly before interpreting the numbers.

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

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; our independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; unchanged public-comparator compilation in our pinned environment; matching selected standard-axiom footprint; public Apache-2.0 artifact; exact-head and post-merge S1 integration evidence.

**Supported interpretation:** independent formal replication has differential-verification value; the process record is a useful long-horizon AI-assisted formalization case; the direct PNT boundary is a plausible upstream target; execution-provenance and metric-boundary auditing are scientifically relevant.

**Requires S2/S4 experiments:** easier maintenance, better upgrade robustness, lower dependency coupling, earlier semantic-drift detection, smaller repair blast radius, causal benefit of state protocols, faster/more resource-efficient builds.

**Unsupported:** new solution of #678, new independent mathematical proof, first Lean formalization, general architecture superiority, autonomous AI authorship percentage, causal claim that one AI technique produced success.

## Stage plan

- **S0 — dossier freeze:** COMPLETE.
- **S1 — differential verification + public integration:** COMPLETE / VERIFIED.
- **S2 — metric and mutation suite:** ACTIVE.
  - **S2a dependency surface:** ACTIVE / implementation prepared, execution next.
  - S2b–S2f: planned.
- **S3 — upstream probe:** NOT STARTED; after S2 evidence.
- **S4 — AI episode dataset / prospective controls:** NOT STARTED.
- **S5 — manuscript decision:** NOT STARTED.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. No ruleset was detected immediately after public transition. Before accepting outside contributions, protect `main` through GitHub so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
