# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

Two candidate contribution tracks remain distinct:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal auditable case study covering invalid reasoning, formal rejection, reconstruction, dependency closure, interface repair, regression discipline, state management, attribution, CI-provenance correction, and public-artifact closure.

The mathematical theorem is known work by Stijn Cambie. We do not claim a new solution, an independent new mathematical proof, or formalization priority.

## Established S1 contribution

S1 has now completed both its scientific experiment and repository integration.

The experiment run `32028006457` established that:

- our `erdosM` semantics are machine-bridged to public `Finset.Ioc` semantics;
- our theorem derives the Formal-Conjectures-style eventual-nonempty endpoint;
- valid block lengths have explicit unbounded/infinite endpoints;
- the natural-factor strong theorem is lifted to every real `C ≥ 1`;
- `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` compiles unchanged in our pinned Lean 4.33 / Mathlib / PNT+ environment;
- selected endpoints on both sides expose `[propext, Classical.choice, Quot.sound]` only.

The persistent S1 artifact passed exact-head PR verification on `1c6bea992033390ac4364033fafcd221694baf4c` in run `32043807200`, then merged as `358cd541ff81a2b59611b7addfc90ae17e03b36f`. Post-merge run `32044314748`, attempt 2, successfully checked that exact merge commit with `No update necessary` and a full 8808-job build.

Attempt 1 of the post-merge run failed while downloading Lean because of HTTP 502 and never entered proof checking. It is retained as an infrastructure-failure example, not mathematical evidence.

## Track A — formal verification / proof engineering

### Candidate paper title

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

### Main technical differentiator to test

Our analytic boundary uses

`prime_between -> Claim4RelativePrimeProvider`

which directly matches the short multiplicative-prime interval needed by the construction. The public comparator routes through a local `pi_alt`/prime-counting layer even though its PNT+ source also contains `prime_between`.

This is not yet evidence of superiority. The S2 question is whether the direct boundary measurably changes dependency surface, repair locality, or upgrade robustness.

## S2 — metric and mutation suite — NEXT

S2 is authorized only for the archived #678 artifact. It must produce controlled evidence before any Level-2 engineering claim.

Planned experiments:

1. **Dependency surface:** generate direct/transitive dependency graphs for matched internal/public endpoints and define comparable graph metrics.
2. **Build behavior:** measure controlled cold/warm build time and resource usage with repeated runs and recorded cache state.
3. **Repair locality:** apply bounded interface mutations and count touched modules/lines/theorems required to restore the build.
4. **Semantic mutation resistance:** replay interval/index mutations inspired by the historical off-by-one failure and record where each architecture rejects them.
5. **Upgrade robustness:** execute a controlled Mathlib/Lean upgrade probe in isolated branches and measure failure/repair surface.
6. **Independent audit:** have a reviewer inspect statement/assumption/dependency boundaries after quantitative results stabilize.

No claim such as “better architecture”, “easier maintenance”, “faster”, or “more robust” is allowed before these measurements exist.

## Track B — AI-assisted scientific production

### Candidate paper title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

The case does **not** show AI discovering #678. Its value is the observable process record:

- a false scaling generalization after a valid finite witness;
- exact machine rejection and preserved negative regressions;
- explicit switch from independent exploration to external-proof reconstruction;
- interface-based decomposition of a research proof;
- replacement of an analytic assumption boundary by a pinned machine-checked dependency;
- recovery of side-condition information lost at an abstraction boundary;
- documentation/build-graph synchronization as a verification obligation;
- executable comparison instead of prose equivalence;
- detection and correction of verification-credit drift;
- distinction between proof failure and infrastructure failures, including private billing blockage and a transient 502 post-merge download failure;
- licensing/security/provenance work as public-artifact closure.

### S4 empirical extension

After S2 stabilizes:

1. derive a machine-readable episode dataset from observable git/CI artifacts;
2. annotate failure and human-intervention categories;
3. run controlled restart tests with/without state artifacts;
4. run negative-memory tests with/without retained regressions;
5. prospectively record model id, invocation count, cost, wall clock, tool calls, and intervention category;
6. publish observable hypotheses/actions/artifacts/outcomes, never hidden chain-of-thought.

## Track C — upstream/community contribution

After S2 evidence:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure the actual effect before proposing upstream;
- consider upstreaming compact statement-normalization lemmas for interval/eventual-existence variants;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

The comparator remains an immutable external fetch rather than vendored material because no repository license was detected for it during the audit.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; our independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; public comparator unchanged compilation in our pinned environment; matching selected standard-axiom footprint; public Apache-2.0 artifact; exact-head and post-merge S1 integration evidence.

**Supported interpretation:** independent formal replication has differential-verification value; the process record is a useful long-horizon AI-assisted formalization case; the direct PNT boundary is a plausible upstream target; execution-provenance auditing is scientifically relevant.

**Requires S2/S4 experiments:** easier maintenance, better upgrade robustness, lower dependency coupling, earlier semantic-drift detection, smaller repair blast radius, causal benefit of state protocols, faster/more resource-efficient builds.

**Unsupported:** new solution of #678, new independent mathematical proof, first Lean formalization, general architecture superiority, autonomous AI authorship percentage, causal claim that one AI technique produced success.

## Stage plan

- **S0 — dossier freeze:** COMPLETE.
- **S1 — common-environment differential verification + public integration:** COMPLETE / VERIFIED.
- **S2 — metric and mutation suite:** NOT STARTED; next stage after this closure-sync PR itself is integrated.
- **S3 — upstream probe:** NOT STARTED; after S2 evidence.
- **S4 — AI episode dataset / prospective controls:** NOT STARTED.
- **S5 — manuscript decision:** NOT STARTED; decide output structure only after evidence from S1–S4.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. No ruleset was detected immediately after the visibility transition. Before accepting outside contributions, protect `main` through GitHub so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
