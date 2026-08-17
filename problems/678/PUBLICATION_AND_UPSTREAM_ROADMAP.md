# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

The repository contains two potentially publishable contributions:

1. an independently engineered Lean reconstruction of Cambie's proof that can be compared directly with the existing Aristotle/Alexeev formalization;
2. a longitudinal case study of AI-assisted scientific production, including failed reasoning, formal rejection, proof reconstruction, state management, regression discipline, dependency closure, verification-credit correction, and CI-gated integration.

These should be developed as related but separable outputs.

---

## Track A — Formal verification / proof-engineering output

### Working title

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Alternative subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

### Core claim

Not a new mathematical theorem and not the first formalization.

The contribution is an independent Lean reimplementation with:

- a substantially different module architecture;
- a direct `PrimeNumberTheoremAnd.prime_between` boundary;
- explicit producer/consumer contracts for the CRT/Claim 5 pipeline;
- dedicated positive/negative regressions;
- an explicit final paper-index -> Erdős-index translation layer;
- reproducible canonical-build checkpoints and an explicitly audited commit-credit policy.

### Required experiments before submission

1. Build both artifacts under a common Lean/Mathlib release on the same runner.
2. Define a canonical common #678 predicate/interval semantics.
3. Prove bridge theorems from our artifact to the external predicate and, where useful, add a comparator-side adapter.
4. Run `#print axioms` on matched endpoints.
5. Generate direct/transitive dependency graphs.
6. Measure cold/warm build time and resource use on the same machine.
7. Run controlled interface edits to measure repair locality.
8. Run historical mutation tests for interval/index errors.
9. Run one Mathlib upgrade experiment.
10. Have an independent reviewer audit assumption and statement boundaries.

### Strongest candidate technical result

The direct adapter

`prime_between -> Claim4RelativePrimeProvider`

matches the actual combinatorial requirement more closely than routing through a prime-counting asymptotic statement. The public formalizer Boris Alexeev has explicitly remarked that `prime_between` would have been better for #678.

The immediate research question is therefore not whether this changes logical strength—it does not—but whether it reduces dependency/API coupling and proof maintenance cost.

### Appropriate form

Possible forms, depending on experimental depth:

- technical report / arXiv note with artifact;
- short formalization/proof-engineering paper;
- artifact-focused submission or workshop paper;
- upstream engineering note if the empirical differences are too small for a standalone paper.

Do not select a venue until the controlled comparison is complete.

---

## Track B — AI-assisted scientific-production output

### Working title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

Alternative subtitle:

**Target fidelity, failure memory, dependency closure, and CI-gated scientific production**

### Core claim

The contribution is not that AI discovered the theorem. It is that the project provides an auditable multi-day record of an AI-assisted research workflow that:

- generated/endorsed a mathematically false generalization after finding a true finite witness;
- detected and retracted it;
- retained the failure as reusable knowledge;
- changed scientific mode after consulting a known proof;
- reconstructed a long research-level proof through explicit interfaces;
- closed an external analytic dependency formally;
- recovered information lost by an earlier abstraction;
- prevented build-graph and stale-CI false completion;
- later detected that PR run metadata had been overinterpreted as literal exact-head checkout, reclassified the evidence, and repaired the workflow;
- converted operational failures into protocol-level safeguards.

### Research questions

- Which failure types appear in long-horizon AI formalization beyond tactic-level proof failure?
- Which externally stored artifacts best preserve target fidelity after context resets?
- Does negative-regression memory reduce repeated mathematical hallucination?
- Do contract-scoped proof interfaces reduce repair blast radius?
- Does commit-explicit CI measurably reduce false verification-credit claims?
- How should scientific attribution change when an AI project switches from discovery to reference-proof reconstruction?

### Required empirical extension

The current #678 archive is retrospective. Strong publication requires prospective controlled tests:

1. reconstruct a machine-readable episode log from observable git/CI history;
2. run restart tests with/without state/roadmap files;
3. run failure-memory tests with/without the negative-regression ledger;
4. run edit-locality tests on modular/monolithic variants;
5. record model id, invocation count, cost, wall clock, tool calls, and human-intervention category prospectively;
6. avoid collecting or publishing hidden chain-of-thought—log externally observable hypotheses/actions/results instead.

### Relationship to current literature

The case is directly comparable with work on Formal Conjectures and benchmark statement auditing, AI-driven formal proof search on Erdős problems, LeanMarathon and long-horizon state/dependency failure modes, FormalScience and semantic drift, Aristotle case studies distinguishing verified local work from true theorem closure, and multi-route formalizations used for cross-checking.

The #678 contribution is strongest where it provides concrete, repository-level evidence for mechanisms discussed more abstractly in those works.

---

## Track C — Upstream/community contribution

This track should proceed even if neither paper is submitted.

### C1. Compare the PNT boundary

Prepare a minimal patch or standalone lemma showing the `prime_between` route to the short multiplicative prime interval required by #678.

The current public comparator already vendors a `prime_between` theorem with the required signature, so the upstream experiment can be a local refactor rather than a new dependency. Before proposing it upstream, measure whether it actually simplifies the public artifact.

### C2. Statement-semantics bridge

The first bridge now exists in `ExternalStatementBridge.lean`, proving our length-based interval representation equal to the public `Finset.Ioc` representation and exposing the eventual-nonempty endpoint. Extend only as evidence requires to relations among eventual nonempty valid-pair sets, unbounded valid block lengths, infinite valid triples, and non-infinitude of valid pairs at a fixed `k` reading.

### C3. Regression contribution

Package known positive examples, the machine-refuted candidate retained by our project, off-by-one mutation examples, and final-index translation tests.

### C4. Contact and attribution

Before publishing a direct comparison or sending a substantial upstream patch:

- cite Stijn Cambie as mathematical author;
- cite Aristotle and Boris Alexeev as prior formal authors;
- notify/contact maintainers where appropriate;
- describe our work as independent formal reconstruction, not independent mathematical proof discovery.

---

## Shared reproducibility package

A future public artifact should contain, at minimum:

- immutable repository commit or release;
- Lean toolchain version;
- Mathlib revision/version;
- exact PNT+ revision/source snapshot;
- commands to regenerate/check canonical imports;
- commands to build the full target;
- final theorem names;
- `#print axioms` outputs;
- comparison workflows/scripts/metrics;
- mutation/regression suite;
- machine-readable process-event log;
- provenance statement;
- limitations statement;
- license information for all reused/comparison material.

The current repository is private. **Do not change repository visibility or publish a snapshot without explicit user authorization.**

---

## Claim ladder

### Level 0 — established or directly machine-checked

- Cambie solved the mathematics.
- Aristotle/Alexeev formalized it first in Lean.
- Our independent Lean reconstruction builds successfully.
- Our reconstruction uses `prime_between` directly at its PNT boundary.
- Our artifact has a modular, regression-heavy architecture.
- our `erdosM` representation has a machine-checked bridge to the public `Finset.Ioc` interval convention;
- our bridge exposes the Formal-Conjectures-style eventual-nonempty endpoint with standard Lean axioms only.

### Level 1 — supported interpretation

- the second implementation provides differential-verification value;
- the process record is a useful long-horizon AI-assisted formalization case;
- the PNT adapter is a plausible reusable/upstream component;
- the CI checkout correction is a concrete example of why execution evidence must dominate metadata labels.

### Level 2 — requires experiments

- both artifacts rebuild successfully in the new S1b same-runner experiment;
- our architecture is easier to maintain;
- our architecture is more robust to upgrades;
- our direct PNT interface reduces repair cost;
- our regressions detect semantic drift earlier than the comparator;
- our state protocol improves restart performance.

### Level 3 — do not claim from current evidence

- superior proof architecture in general;
- causal proof that a particular AI method caused success;
- autonomous AI authorship percentages;
- new mathematical discovery;
- formalization priority.

---

## Concrete deliverables

1. `SCIENTIFIC_COMPARATIVE_STUDY.md`
2. `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md`
3. `S1_EQUIVALENCE_EXPERIMENT.md`
4. `SCIENTIFIC_EVIDENCE_LEDGER.yaml`
5. this roadmap
6. `CAMBIE_PROOF_ANALYSIS.md`
7. `FORMALIZATION_CORRECTION_2026-08-14.md`
8. `LEAN_FORMALIZATION_ROADMAP.md`
9. root `LESSONS_LEARNED_678_ADDENDUM.md`
10. `.github/workflows/erdos678-comparison.yml`

Together these form the evolving scientific dossier.

---

## Recommended sequencing and current checkpoint

### Stage S0 — dossier freeze — COMPLETE

The initial comparative dossier is frozen against explicit internal/external references.

### Stage S1 — common-environment differential verification — IN PROGRESS

S1a semantic normalization is machine-checked. Run `32033822601` successfully built the bridge and 8808-job canonical graph, but log inspection showed it checked the PR integration-tree merge commit rather than the literal PR head. That evidence is deliberately reclassified rather than overstated.

PR #24 therefore also corrects the canonical workflow to checkout the PR head explicitly. S1 closes only after:

- a green canonical run whose log records the final PR head as the checked-out commit; and
- a green `Erdős #678 Differential Reproducibility` run that rebuilds our normalized endpoint and the pinned public comparator on the same Ubuntu runner / Lean 4.33 toolchain.

### Stage S2 — metric and mutation suite — NOT STARTED

Collect maintenance, dependency, build, and semantic-drift measurements after S1 closes.

### Stage S3 — upstream probe — NOT STARTED

Test the smallest useful community contribution first: PNT adapter / statement bridge / regressions.

### Stage S4 — AI episode dataset — NOT STARTED

Convert repository history into structured observable episodes and run prospective restart/failure-memory experiments.

### Stage S5 — manuscript decision — NOT STARTED

Only after S1-S4 decide whether the evidence supports one combined paper, two papers/notes, one paper plus upstream contribution, or an artifact/technical report only.

---

## Stop condition

All work in this roadmap concerns the already completed Erdős #678 artifact and its scientific evaluation.

It does **not** authorize selection, exploration, or formalization of another Erdős problem. The `DEC-012` user gate remains in force.
