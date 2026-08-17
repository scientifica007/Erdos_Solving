# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

The repository contains two related but separable candidate contributions:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof, now differentially verified against the existing Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal, auditable case study covering invalid independent reasoning, formal rejection, reconstruction, dependency closure, interface repair, regression discipline, state management, scientific attribution, verification-provenance correction, and public-release controls.

The mathematical theorem remains known work by Stijn Cambie. We do not claim a new solution, a new independent mathematical proof, or formalization priority.

---

## Track A — Formal verification / proof-engineering output

### Working title

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

### Established contribution after S1 experiment

The project now has executable evidence that:

- our length-based `erdosM` semantics are machine-bridged to the public `Finset.Ioc n (n+k)` convention;
- our theorem derives the Formal-Conjectures-style eventual-nonempty endpoint;
- our valid-pair semantics expose unbounded and infinitely many admissible block lengths;
- our positive-natural multiplicative-factor theorem is machine-lifted to every real `C ≥ 1`, matching the public strong-theorem parameter domain;
- the pinned current public Aristotle/Alexeev source `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` compiles **unchanged** in this repository's pinned Lean 4.33 / Mathlib / PNT+ environment;
- selected endpoints from both artifacts expose the same standard axiom footprint: `propext`, `Classical.choice`, `Quot.sound`.

Primary S1 execution evidence: run `32028006457`, job `95381414710`.

This supports a differential-verification claim. It does not yet establish architecture superiority, performance superiority, lower maintenance cost, or genealogical independence.

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

---

## Track B — AI-assisted scientific-production output

### Working title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

Possible subtitle:

**Target fidelity, failure memory, dependency closure, execution-provenance controls, and public-artifact closure**

### Core contribution

The case does not show AI discovering #678. It provides an auditable record of an AI-assisted workflow that:

- generated or endorsed a mathematically false scaling generalization after a genuine finite witness;
- detected and retracted invalid mathematics;
- retained rejected paths as negative knowledge/regressions;
- explicitly changed mode from independent exploration to reference-proof reconstruction;
- decomposed a long research-level proof into producer/consumer interfaces;
- replaced a deep analytic assumption boundary with a pinned machine-checked PNT+ dependency;
- recovered information lost by an earlier theorem interface at the final indexing layer;
- treated canonical build reachability and documentation state as part of verification;
- performed cross-artifact statement/environment/axiom comparison rather than relying on prose equivalence;
- later detected **verification-credit drift**: PR metadata had been interpreted more strongly than the actual checkout semantics justified;
- reclassified that evidence and repaired the workflow to record the commit actually built;
- treated public release as a separate scientific closure stage requiring secret hygiene, least-privilege CI, dependency provenance, redistribution boundaries, and an explicit project-license decision.

The verification-credit episode is documented in `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md` and `AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`.

### Research questions

- Which failure classes occur in long-horizon AI formalization beyond tactic failure?
- Which externalized artifacts preserve statement fidelity across context resets?
- Does negative-regression memory reduce repeated invalid reasoning?
- Do contract-scoped interfaces reduce repair blast radius?
- How often do CI metadata labels diverge from the execution provenance needed for scientific credit?
- Which controls are needed to transform a private machine-checked development into a safely reusable public research artifact?
- How should attribution change when a project switches from discovery to external-proof reconstruction?

### S4 empirical extension required for a strong AI-for-science paper

After formal-comparison S1/S2 evidence is stable:

1. reconstruct a machine-readable episode log from observable git/CI history;
2. annotate failure/intervention classes using only externally observable artifacts;
3. run restart tests with/without state/roadmap artifacts;
4. run failure-memory tests with/without negative-regression artifacts;
5. record model id, invocation count, cost, wall clock, tool calls, and human-intervention category prospectively for any new controlled experiment;
6. do **not** publish hidden chain-of-thought; publish hypotheses, actions, artifacts, corrections, and outcomes instead.

---

## Track C — Upstream/community contribution

This track should proceed even if a standalone paper is not justified.

### C1 — PNT boundary probe

Test a minimal refactor of the public #678 artifact from the `pi_alt`-shaped route toward the already available `prime_between` consequence. Measure whether the patch actually reduces proof/dependency complexity before proposing it upstream.

### C2 — Statement-semantics bridge

The repository now contains machine-checked bridges for:

- length-based interval semantics ↔ public `Finset.Ioc` semantics;
- eventual nonempty valid-pair formulation;
- unbounded/infinite admissible good-length semantics;
- positive natural factor ↔ arbitrary real `C ≥ 1` strong theorem.

Potential upstream value is a compact statement-normalization layer that makes variant readings explicit and prevents recurrence of the fixed-`k`/varying-`k` ambiguity.

### C3 — Regression contribution

Candidate reusable regressions include:

- known positive examples;
- the project-retained machine-refuted candidate;
- off-by-one interval mutations;
- final-index translation tests.

### C4 — Contact and attribution

Before public comparison or upstream patch submission:

- cite Stijn Cambie as mathematical author;
- cite Aristotle and Boris Alexeev as prior formal authors;
- contact/notify relevant maintainers where appropriate;
- describe this project as an independent formal reconstruction, not independent mathematical discovery.

---

## Shared reproducibility and public-artifact package

The public artifact should include:

- immutable repository commit/release;
- exact Lean toolchain and Mathlib revision;
- exact PNT+ revision;
- commands for `mk_all --check` and canonical build;
- final theorem and bridge theorem names;
- `#print axioms` outputs;
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md`;
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`;
- `experiments/run_public_comparator_common_env.sh`;
- `PUBLIC_RELEASE_AUDIT_2026-08-17.md`;
- root `THIRD_PARTY_NOTICES.md`;
- project-owned root license selected by the repository owner;
- dependency/metric/mutation results once S2 exists;
- machine-readable process-event data once S4 exists;
- provenance and limitations statements;
- licenses/notices for all redistributed material.

The user has explicitly authorized preparation for and intends a public visibility transition. At the current checkpoint the repository is still private, and the project-owned root license remains an owner decision. No public release is considered scientifically closed until the post-transition exact-head PR check and post-merge `main` verification succeed.

---

## Claim ladder

### Level 0 — established / machine-checked / executed

- Cambie solved the mathematics.
- Aristotle/Alexeev produced a prior Lean formalization.
- Our independent Lean reimplementation builds successfully.
- Our PNT boundary directly consumes `prime_between`.
- Our artifact has a modular, regression-heavy architecture.
- our interval semantics are machine-bridged to the public convention;
- our Formal Conjectures eventual-nonempty reading is machine-derived;
- admissible good lengths have explicit unbounded/infinite semantic endpoints;
- our strong theorem is machine-lifted to every real `C ≥ 1`;
- the pinned public comparator source compiled unchanged in our pinned environment;
- selected endpoints on both sides had matching standard axiom footprints in that environment.

### Level 1 — supported interpretation

- the second implementation has differential-verification value;
- the process record is a useful long-horizon AI-assisted formalization case;
- the `prime_between` adapter is a plausible upstream component;
- the verification-credit correction is an empirical example of why execution logs should dominate metadata labels for commit-level proof credit;
- the public-release preflight is an auditable example of treating security/provenance/licensing as scientific artifact closure rather than post-hoc administration.

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

---

## Current deliverables

The scientific dossier now contains:

1. `SCIENTIFIC_COMPARATIVE_STUDY.md`;
2. `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md`;
3. `AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`;
4. this roadmap;
5. `SCIENTIFIC_EVIDENCE_LEDGER.yaml`;
6. `DIFFERENTIAL_VERIFICATION_PROTOCOL.md`;
7. `S1_DIFFERENTIAL_VERIFICATION_RESULT.md`;
8. `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`;
9. `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`;
10. `PUBLICATION_READINESS_LICENSE_AUDIT.md`;
11. `PUBLIC_RELEASE_AUDIT_2026-08-17.md`;
12. `experiments/run_public_comparator_common_env.sh`;
13. `CAMBIE_PROOF_ANALYSIS.md`;
14. `FORMALIZATION_CORRECTION_2026-08-14.md`;
15. `LEAN_FORMALIZATION_ROADMAP.md`;
16. root `LESSONS_LEARNED_678_ADDENDUM.md`;
17. root `THIRD_PARTY_NOTICES.md`.

---

## Stage plan and current checkpoint

### S0 — dossier freeze — COMPLETE

Initial scientific positioning and comparison anchors are frozen.

### S1 — common-environment differential verification — EXPERIMENT COMPLETE / PUBLIC-TRANSITION INTEGRATION PENDING

**Scientific experiment complete:** run `32028006457` successfully built the internal bridge/canonical graph and compiled the pinned current public comparator source unchanged in the same pinned environment, with matched selected-endpoint axiom footprints.

**Persistent-artifact integration pending:** the active S1 branch includes semantic consolidation, execution-provenance correction, public-CI hardening, third-party notices, and the public-release preflight.

While the repository remains private, new GitHub Actions jobs cannot start because of the account billing/spending condition. The user has chosen public visibility as the intended resolution rather than weakening the verification gate.

S1 closes only when:

1. the repository owner chooses the project-owned root license;
2. the user changes the repository to public;
3. GitHub Actions/branch protections are reviewed after the transition;
4. the actual final S1 PR head passes the corrected commit-explicit canonical gate;
5. the merged `main` head passes post-merge verification.

### S2 — metric and mutation suite — NOT STARTED

Do not start until S1 integration closes. Then measure maintenance, dependency, build, and semantic-drift hypotheses.

### S3 — upstream probe — NOT STARTED

After S2 evidence, test the smallest useful upstream contribution first.

### S4 — AI episode dataset — NOT STARTED

Convert repository history into structured observable episodes and run prospective controls.

### S5 — manuscript decision — NOT STARTED

Only after S1–S4 decide whether evidence supports one combined paper, two outputs, paper + upstream contribution, or artifact/technical report only.

---

## Stop condition

All work in this roadmap concerns the already completed Erdős #678 artifact and its scientific evaluation.

It does **not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
