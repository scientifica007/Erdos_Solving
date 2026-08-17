# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

The repository contains two related but separable candidate contributions:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof, differentially verified against the existing Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal, auditable case study covering invalid independent reasoning, formal rejection, reconstruction, dependency closure, interface repair, regression discipline, state management, scientific attribution, verification-provenance correction, and public-release controls.

The mathematical theorem remains known work by Stijn Cambie. We do not claim a new solution, a new independent mathematical proof, or formalization priority.

## Track A — Formal verification / proof-engineering output

### Working title

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

### Established contribution after S1 experiment

Executed evidence already establishes that:

- our length-based `erdosM` semantics are machine-bridged to the public `Finset.Ioc n (n+k)` convention;
- our theorem derives the Formal-Conjectures-style eventual-nonempty endpoint;
- valid-pair semantics expose unbounded and infinitely many admissible block lengths;
- the positive-natural multiplicative-factor theorem is machine-lifted to every real `C ≥ 1`;
- `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` compiled **unchanged** in our pinned Lean 4.33 / Mathlib / PNT+ environment;
- selected endpoints from both artifacts expose the same standard axiom footprint: `propext`, `Classical.choice`, `Quot.sound`.

Primary S1 experiment evidence: run `32028006457`, job `95381414710`.

This supports a differential-verification claim. It does not establish architecture superiority, performance superiority, lower maintenance cost, or genealogical independence.

### Strongest candidate technical differentiator

Our analytic boundary uses

`prime_between -> Claim4RelativePrimeProvider`

which directly matches the short multiplicative-prime interval needed by the combinatorial construction. The public comparator routes through a local `pi_alt`/prime-counting asymptotic layer, although its PNT+ source also contains `prime_between`.

The research question is not logical strength. It is whether the direct application-shaped boundary measurably reduces dependency/API coupling or repair cost.

### S2 experiments required before stronger engineering claims

After S1 is integrated:

1. generate direct/transitive dependency graphs for matched endpoints;
2. measure cold/warm build time and resource use under a controlled protocol;
3. perform controlled interface edits and measure repair locality;
4. run historical interval/index mutation tests on both representations where feasible;
5. run one controlled Mathlib upgrade experiment;
6. have an independent reviewer audit statement/assumption boundaries.

Do not infer “better architecture” from file count or narrative structure alone.

## Track B — AI-assisted scientific-production output

### Working title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

Possible subtitle:

**Target fidelity, failure memory, dependency closure, execution-provenance controls, and public-artifact closure**

### Core contribution

The case does not show AI discovering #678. It provides an auditable record of a workflow that:

- generated or endorsed a false scaling generalization after a genuine finite witness;
- detected and retracted invalid mathematics;
- retained rejected paths as negative knowledge/regressions;
- explicitly changed mode from independent exploration to reference-proof reconstruction;
- decomposed a long research-level proof into producer/consumer interfaces;
- replaced a deep analytic assumption boundary with a pinned machine-checked PNT+ dependency;
- recovered information lost by an earlier theorem interface at the final indexing layer;
- treated canonical build reachability and documentation state as part of verification;
- performed cross-artifact statement/environment/axiom comparison rather than relying on prose equivalence;
- detected **verification-credit drift**, narrowed the claim, and repaired CI to record the commit actually built;
- treated public release as a scientific closure stage requiring secret hygiene, least-privilege CI, dependency provenance, redistribution boundaries, explicit licensing, and a verified public transition.

### S4 empirical extension required for a strong AI-for-science paper

After S1/S2 evidence is stable:

1. reconstruct a machine-readable episode log from observable git/CI history;
2. annotate failure/intervention classes using only externally observable artifacts;
3. run restart tests with/without state/roadmap artifacts;
4. run failure-memory tests with/without negative-regression artifacts;
5. record model id, invocation count, cost, wall clock, tool calls, and human-intervention category prospectively for controlled experiments;
6. do **not** publish hidden chain-of-thought; publish hypotheses, actions, artifacts, corrections, and outcomes instead.

## Track C — Upstream/community contribution

### C1 — PNT boundary probe

Test a minimal refactor of the public #678 artifact from the `pi_alt`-shaped route toward the already available `prime_between` consequence. Measure whether the patch actually reduces proof/dependency complexity before proposing it upstream.

### C2 — Statement-semantics bridge

Potentially reusable machine-checked bridges now cover:

- length-based interval semantics ↔ public `Finset.Ioc` semantics;
- eventual nonempty valid-pair formulation;
- unbounded/infinite admissible good-length semantics;
- positive natural factor ↔ arbitrary real `C ≥ 1` strong theorem.

### C3 — Regression contribution

Candidate reusable regressions include known positive examples, the retained machine-refuted candidate, off-by-one interval mutations, and final-index translation tests.

### C4 — Contact and attribution

Before upstream submission, cite Stijn Cambie as mathematical author; cite Aristotle and Boris Alexeev as prior formal authors; notify relevant maintainers where appropriate; describe this project as an independent formal reconstruction, not independent mathematical discovery.

## Shared reproducibility and public-artifact package

The repository is now **Public** and project-owned material is licensed under **Apache License 2.0**. The public artifact includes or will include:

- immutable repository commit/release;
- exact Lean toolchain and Mathlib revision;
- exact PNT+ revision;
- canonical `mk_all --check` and build commands;
- final theorem and bridge theorem names;
- `#print axioms` outputs;
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md`;
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`;
- `experiments/run_public_comparator_common_env.sh`;
- `PUBLIC_RELEASE_AUDIT_2026-08-17.md`;
- root `LICENSE` and `THIRD_PARTY_NOTICES.md`;
- dependency/metric/mutation results once S2 exists;
- machine-readable process-event data once S4 exists;
- provenance and limitations statements.

The comparator remains an immutable external fetch rather than vendored material because no repository license was detected for it during the audit.

## Claim ladder

### Level 0 — established / machine-checked / executed

- Cambie solved the mathematics.
- Aristotle/Alexeev produced a prior Lean formalization.
- Our independent Lean reimplementation builds successfully.
- Our PNT boundary directly consumes `prime_between`.
- Our interval semantics are machine-bridged to the public convention.
- Our Formal Conjectures eventual-nonempty reading is machine-derived.
- Admissible good lengths have explicit unbounded/infinite semantic endpoints.
- Our strong theorem is machine-lifted to every real `C ≥ 1`.
- The pinned public comparator source compiled unchanged in our pinned environment.
- Selected endpoints on both sides had matching standard axiom footprints in that environment.

### Level 1 — supported interpretation

- the second implementation has differential-verification value;
- the process record is a useful long-horizon AI-assisted formalization case;
- the `prime_between` adapter is a plausible upstream component;
- the verification-credit correction is an empirical example of why execution logs should dominate metadata labels for commit-level proof credit;
- the public-release process is an auditable example of treating security/provenance/licensing as scientific artifact closure rather than post-hoc administration.

### Level 2 — requires controlled experiments

- easier maintenance;
- better upgrade robustness;
- lower dependency coupling in practice;
- earlier semantic-drift detection;
- lower repair locality/blast radius;
- state protocol causally improves agent restart performance;
- faster or more resource-efficient builds.

### Level 3 — unsupported / prohibited from current evidence

- new solution of #678;
- new independent mathematical proof;
- first Lean formalization;
- general superiority of our architecture;
- autonomous AI authorship percentage;
- causal claim that a specific AI technique produced the success.

## Stage plan and current checkpoint

### S0 — dossier freeze — COMPLETE

Initial scientific positioning and comparison anchors are frozen.

### S1 — common-environment differential verification — EXPERIMENT COMPLETE / FINAL PUBLIC INTEGRATION PENDING

The scientific experiment is complete: run `32028006457` successfully built the internal bridge/canonical graph and compiled the pinned public comparator source unchanged in the same pinned environment, with matched selected-endpoint axiom footprints.

The public transition is also complete:

- license-only PR #26 merged Apache-2.0 to `main` at `87cf560451ef5aa4714069d52a3851c1f8547f70`;
- GitHub reports `visibility: public` and `license: Apache-2.0`;
- public-runner availability was restored: reopening PR #22 launched diagnostic run `32043331012`, which entered the canonical Lean build rather than failing before the first step;
- no repository rulesets were detected immediately after the transition.

Because state synchronization after the public transition changes the PR head, `32043331012` is diagnostic rather than the final S1 integration-credit run.

S1 closes only when:

1. the **actual final PR #22 head** passes the hardened commit-explicit canonical gate;
2. the logged checked-out commit equals the credited PR head;
3. PR #22 merges;
4. the merged `main` head passes post-merge verification.

Branch/ruleset protection for `main` should be configured in the GitHub UI before accepting outside contributions; this is a repository-governance task, not a mathematical gate.

### S2 — metric and mutation suite — NOT STARTED

Do not start until S1 integration closes.

### S3 — upstream probe — NOT STARTED

After S2 evidence, test the smallest useful upstream contribution first.

### S4 — AI episode dataset — NOT STARTED

Convert repository history into structured observable episodes and run prospective controls.

### S5 — manuscript decision — NOT STARTED

Only after S1–S4 decide whether evidence supports one combined paper, two outputs, paper + upstream contribution, or artifact/technical report only.

## Stop condition

All work in this roadmap concerns the already completed Erdős #678 artifact and its scientific evaluation.

It does **not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
