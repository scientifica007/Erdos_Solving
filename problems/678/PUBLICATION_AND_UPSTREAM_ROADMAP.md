# Erdős #678 — Publication and Upstream Roadmap

## Objective

Convert the completed #678 work into the maximum defensible external value without reopening the mathematics or overstating novelty.

The repository currently contains two potentially publishable contributions:

1. an independently engineered Lean reconstruction of Cambie's proof that can be compared directly with the existing Aristotle/Alexeev formalization;
2. a longitudinal case study of AI-assisted scientific production, including failed reasoning, formal rejection, proof reconstruction, state management, regression discipline, dependency closure, and CI-gated integration.

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
- reproducible canonical-build and exact-head CI checkpoints.

### Required experiments before submission

1. Port the public `plby/lean-proofs` #678 artifact and our artifact to a **common Lean/Mathlib/PNT+ version**.
2. Define a canonical common #678 predicate.
3. Prove bridge theorems from both artifacts to that predicate.
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

Do not select a venue until the common-environment comparison is complete.

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
- converted operational failures into protocol-level safeguards.

### Research questions

- Which failure types appear in long-horizon AI formalization beyond tactic-level proof failure?
- Which externally stored artifacts best preserve target fidelity after context resets?
- Does negative-regression memory reduce repeated mathematical hallucination?
- Do contract-scoped proof interfaces reduce repair blast radius?
- Does exact-head CI measurably reduce false verification claims?
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

The case is directly comparable with work on:

- Formal Conjectures and benchmark statement auditing;
- AI-driven formal proof search on Erdős problems;
- LeanMarathon and long-horizon state/dependency failure modes;
- FormalScience and semantic drift;
- Aristotle case studies distinguishing verified local work from true theorem closure;
- multi-route formalizations used for cross-checking.

The #678 contribution is strongest where it provides concrete, repository-level evidence for mechanisms discussed more abstractly in those works.

---

## Track C — Upstream/community contribution

This track should proceed even if neither paper is submitted.

### C1. Compare the PNT boundary

Prepare a minimal patch or standalone lemma showing the `prime_between` route to the short multiplicative prime interval required by #678.

Before proposing it upstream, measure whether it actually simplifies the public artifact.

### C2. Statement-semantics bridge

Create a compact formal module proving relations among:

- eventual nonempty valid-pair sets;
- unbounded valid block lengths;
- infinite valid triples;
- non-infinitude of valid pairs at a fixed `k` reading.

This can help Formal Conjectures and future benchmark consumers avoid reintroducing statement ambiguity.

### C3. Regression contribution

Package:

- known positive examples;
- the machine-refuted candidate retained by our project;
- off-by-one mutation examples;
- final-index translation tests.

These can be useful even if the larger architecture is not upstreamed.

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
- exact PNT+ revision;
- commands to regenerate/check canonical imports;
- commands to build the full target;
- final theorem names;
- `#print axioms` outputs;
- comparison scripts/metrics;
- mutation/regression suite;
- machine-readable process-event log;
- provenance statement;
- limitations statement;
- license information for all reused/comparison material.

The current repository is private. **Do not change repository visibility or publish a snapshot without explicit user authorization.**

---

## Claim ladder

External communication should use a claim ladder so evidence and rhetoric stay aligned.

### Level 0 — already established

- Cambie solved the mathematics.
- Aristotle/Alexeev formalized it first in Lean.
- Our independent Lean reconstruction builds successfully.
- Our reconstruction uses `prime_between` directly at its PNT boundary.
- Our artifact has a modular, regression-heavy architecture.

### Level 1 — supported interpretation

- the second implementation provides differential-verification value;
- the process record is a useful long-horizon AI-assisted formalization case;
- the PNT adapter is a plausible reusable/upstream component.

### Level 2 — requires experiments

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

## Concrete deliverables from the current archive

The following are now available inside `problems/678/`:

1. `SCIENTIFIC_COMPARATIVE_STUDY.md` — formal/mathematical positioning and testable comparison hypotheses.
2. `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` — AI-process case study, failure taxonomy, research questions, threats to validity, and experimental extensions.
3. this roadmap — separation of publication, empirical, and upstream tracks.
4. existing `CAMBIE_PROOF_ANALYSIS.md` — detailed mathematical architecture.
5. existing `FORMALIZATION_CORRECTION_2026-08-14.md` — concrete failed-path correction evidence.
6. existing `LEAN_FORMALIZATION_ROADMAP.md` — longitudinal execution state.
7. root `LESSONS_LEARNED_678_ADDENDUM.md` — reusable lessons and final postmortem.

Together these form the initial scientific dossier.

---

## Recommended sequencing

### Stage S0 — dossier freeze

Freeze this comparative dossier against exact internal and external commits.

### Stage S1 — common-environment differential verification

This is the highest-priority technical experiment because it converts "two proofs exist" into a formally comparable pair.

### Stage S2 — metric and mutation suite

Collect maintenance, dependency, build, and semantic-drift measurements.

### Stage S3 — upstream probe

Test the smallest useful community contribution first: PNT adapter / statement bridge / regressions.

### Stage S4 — AI episode dataset

Convert repository history into structured observable episodes and run prospective restart/failure-memory experiments.

### Stage S5 — manuscript decision

Only after S1-S4 decide whether the evidence supports:

- one combined paper;
- two papers/notes;
- one paper plus upstream contribution;
- or an artifact/technical report only.

This avoids deciding the publication narrative before the comparison evidence exists.

---

## Stop condition

All work in this roadmap concerns the already completed Erdős #678 artifact and its scientific evaluation.

It does **not** authorize selection, exploration, or formalization of another Erdős problem. The `DEC-012` user gate remains in force.