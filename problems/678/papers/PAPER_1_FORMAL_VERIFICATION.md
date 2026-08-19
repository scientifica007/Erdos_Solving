# Paper 1 — Formal Verification / Proof Engineering

## Working title

**Independent Lean Reconstruction and Differential Verification of Cambie’s Solution to Erdős Problem #678**

Alternative working title:

**Reconstructing and Stress-Testing a Formal Proof of Erdős Problem #678 in Lean**

## Manuscript status

- Status: **scaffold opened; not yet submission-ready**
- Evidence cutoff for the initial manuscript: **2026-08-18**
- Mathematical status: closed and machine-checked
- Scientific evaluation status: S1 and S2a–S2e closed
- Scope: Erdős #678 only
- Governance: `DEC-012` remains binding; this manuscript does not authorize work on another Erdős problem

## Contribution boundary

This paper is about **formal verification, proof engineering, differential verification, reproducibility, and bounded scientific evaluation**.

It must not claim:

- a new mathematical solution to Erdős #678;
- a new independent mathematical proof;
- the first formalization of the result;
- general architecture superiority;
- general maintainability superiority;
- a universal speed advantage;
- general Lean/Mathlib upgrade compatibility or incompatibility.

The successful mathematics is attributed to **Stijn Cambie (2024)**. The repository records an independent Lean reimplementation after switching from failed independent exploration to external-proof reconstruction. A public Aristotle/Boris Alexeev formal artifact predates this reconstruction.

## Central paper claim

A defensible core claim is:

> We provide an independently structured Lean reconstruction of Cambie’s proof of Erdős Problem #678, connect it explicitly to external statement conventions, differentially verify it against an unchanged pinned public formal artifact in a common environment, and evaluate selected structural, build, repair-locality, semantic-mutation, and forward-version properties under prospectively controlled protocols.

This is an **epistemic and proof-engineering contribution**, not a novelty claim about the underlying mathematics.

## Candidate abstract

**TODO — write only after the related-work and venue audit are complete.**

The abstract should cover, in order:

1. the mathematical result and attribution to Cambie;
2. the independent Lean reconstruction;
3. statement/semantic bridges and exact theorem endpoint;
4. S1 common-environment differential verification;
5. the bounded S2a–S2e evaluation program;
6. the most important mixed/null/boundary findings;
7. reproducibility and exact-head / exact-main verification discipline;
8. explicit limitation that no new mathematics or first-formalization claim is made.

## 1. Introduction

### 1.1 Problem context

- State Erdős Problem #678 precisely.
- Explain the intended varying-`k` / infinite-family conclusion.
- Give the historical solution attribution.

### 1.2 Why formal reconstruction is scientifically useful

- Independent implementation can reveal hidden assumptions and statement mismatches.
- Machine checking alone is insufficient if the wrong statement, wrong tree, or wrong dependency configuration receives credit.
- Formal artifacts can be compared experimentally without turning raw engineering measurements into mathematical novelty claims.

### 1.3 Contributions

Proposed contribution list:

1. Independent Lean reconstruction of Cambie’s argument under pinned dependencies.
2. Explicit bridges between repository interval conventions and public comparator conventions.
3. Machine-checked unbounded-witness / infinitude endpoint.
4. Common-environment differential verification against a pinned unchanged public comparator.
5. Exact-head and exact-main provenance discipline for proof credit.
6. A prospectively controlled S2 evaluation spanning dependency surface, build behavior, repair locality, semantic/index mutations, and two exact forward-version candidates.
7. Conservative interpretation of mixed, null, excluded, and dependency-boundary outcomes.

## 2. Mathematical background

### 2.1 Erdős #678 statement

**TODO:** present the canonical mathematical statement and all indexing conventions.

### 2.2 Cambie’s proof architecture

Present the proof at mathematical level without reproducing repository-internal implementation details unnecessarily.

Suggested decomposition:

- interval LCM/product identities;
- Claim 5 valuation decomposition;
- Claim 4 CRT/density construction;
- sharp prime-window input;
- PNT-derived relative-prime provider;
- large-`k` growth condition;
- strong parameterized theorem;
- final index translation and infinitude.

### 2.3 Attribution and prior formal artifact

Clearly distinguish:

- mathematical authorship;
- prior public formalization;
- this repository’s independent Lean reimplementation;
- later differential verification.

## 3. Formalization architecture

### 3.1 Canonical interval API

Explain why interval length/start conventions are explicit mathematical interfaces rather than cosmetic implementation details.

### 3.2 Producer/consumer proof contracts

Describe the major interfaces:

- Claim 4 density / CRT producers;
- pair/triple residue interfaces;
- Claim 5 consumer contracts;
- prime-window / relative-prime providers;
- PNT bridge;
- strong theorem endpoint;
- final canonical Erdős endpoint.

### 3.3 Analytic dependency closure

Document the pinned `PrimeNumberTheoremAnd` dependency and why it replaced an opaque/custom analytic assumption.

### 3.4 Strong theorem before benchmark corollary

Explain the value of proving the parameterized `C`-level inequality before specializing to the benchmark statement.

### 3.5 Infinitude through unbounded witnesses

Explain the formal encoding of infinitely many good lengths via an unbounded-witness theorem.

## 4. Statement fidelity and semantic bridges

### 4.1 Internal versus public interval semantics

Document the explicit equivalence bridge between the repository’s length-based interval definition and the comparator’s `Finset.Ioc` convention.

### 4.2 Formal-Conjectures-style endpoint

Explain the bridge to eventual nonemptiness / unbounded or infinite good lengths.

### 4.3 Real-factor strong theorem bridge

Document the public-facing theorem normalization used in S1.

### 4.4 Axiom audit

Report the selected endpoint axiom dependencies exactly as recorded by S1.

## 5. Differential verification (S1)

### 5.1 Comparator and common environment

- comparator: `plby/lean-proofs` at the pinned commit recorded by S1;
- unchanged comparator compilation;
- common Lean/Mathlib environment;
- pinned PNT+ environment for the internal artifact.

### 5.2 What differential verification establishes

Bounded supported conclusions:

- independent Lean reimplementation;
- compatible statement bridges;
- successful compilation of both artifacts under the controlled common setup;
- selected endpoint axiom agreement.

### 5.3 Verification-credit correction

Include the episode in which a green run initially supported a weaker provenance claim than its metadata suggested.

Scientific lesson:

> Proof verification and verification-credit provenance are separate objects that both require audit.

## 6. Scientific evaluation program (S2)

### 6.1 S2a — dependency surface

Report the controlled structural counts, but emphasize the key finding:

> dependency-surface metrics are ownership- and packaging-boundary sensitive and cannot be interpreted directly as proof complexity or architecture quality.

### 6.2 S2b — controlled build behavior

Report:

- prospectively controlled paired replicates;
- the excluded provenance-defective pilot;
- credited wall/CPU/memory observations;
- absence of a stable wall-clock winner;
- materially different CPU/memory profiles;
- no general speed claim.

### 6.3 S2c — repair locality

Report:

- three frozen API-reference mutations;
- six observations;
- all legal repairs returned green;
- mixed/interface-dependent repair-reference blast radius;
- no uniform maintainability winner.

### 6.4 S2d — semantic/index mutation evaluation

Report:

- three prospectively frozen one-unit perturbations across two artifacts;
- six semantic rejections;
- zero survivors;
- zero proof repairs;
- excluded classifier-defective pilot;
- first rejection locations differ by mutation/artifact.

### 6.5 S2e — exact forward-version robustness candidates

Report the two exact frozen candidates only:

- U1 compiler-only Lean RC candidate;
- U2 Lean + root Mathlib RC candidate.

Bounded result:

- U1 reaches D1 then encounters Mathlib/transitive dependency-owned source failures;
- U2 reaches D0 then stops at package resolution;
- no eligible project-owned repair surface was reached;
- zero repair batches;
- no general compatibility or maintainability conclusion.

## 7. Reproducibility and scientific-credit discipline

### 7.1 Canonical build graph

The theorem must be reachable from the canonical generated import graph to receive project credit.

### 7.2 Exact-head verification

The final PR head, not merely a nearby commit or synthetic integration tree, is the unit of pre-merge verification.

### 7.3 Merge unchanged and exact-main verification

Document the repository rule:

> exact PR head CI → merge unchanged → exact resulting `main` verification.

### 7.4 Exclusion rules

Explain why computational success can still be scientifically inadmissible if required provenance, logical classification, or complete-set aggregation is defective.

## 8. Results summary

**TODO:** build a compact publication table with one row per S1/S2 stage and columns:

- question;
- protocol frozen before observation?;
- credited run/artifact;
- excluded runs;
- bounded result;
- unsupported generalization.

## 9. Related work

**TODO — requires current literature audit before drafting.**

At minimum compare against:

- Cambie’s mathematical solution;
- the prior Aristotle/Boris Alexeev Lean artifact;
- formal-conjecture / statement-fidelity work;
- differential verification or independent formal reconstruction precedents;
- recent long-horizon Lean formalization and proof-engineering studies.

Do not assert priority without source-level verification.

## 10. Threats to validity

- single theorem case;
- external-proof reconstruction mode;
- artifacts differ structurally and in dependency packaging;
- bounded mutation set;
- bounded version-candidate set;
- CI runner and ecosystem effects;
- measurements do not isolate human repair effort;
- no causal architecture superiority inference.

## 11. Discussion

Suggested themes:

- statement fidelity is an independent verification obligation;
- build-graph reachability is part of proof credit;
- provenance defects can invalidate otherwise successful computation;
- mixed/null results should remain in the scientific record;
- dependency ownership must be separated from project proof defects;
- formal verification papers can make epistemic contributions without claiming new mathematics.

## 12. Conclusion

**TODO:** concise conclusion limited to established evidence.

## Data and artifact availability

Repository: public, Apache-2.0.

Publication-grade release still needs an immutable archival snapshot / DOI or equivalent long-term identifier.

## Internal evidence sources

Primary sources for drafting:

- `PROJECT_STATE.md`
- `problems/678/README.md`
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md`
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `problems/678/S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- `problems/678/S2A_CLOSURE_NOTE.md`
- `problems/678/S2_UPGRADE_ROBUSTNESS_RESULT.md`
- stage-specific S2 protocols, baselines, result files, and excluded-run records
- `problems/678/PUBLICATION_NARRATIVE_SYNC_2026-08-19.md`

## Submission-readiness checklist

- [ ] verify current venue scope and formatting requirements;
- [ ] perform publication-grade literature search and priority audit;
- [ ] decide target venue before freezing length/structure;
- [ ] write exact mathematical statement and notation section;
- [ ] produce claim-to-evidence table;
- [ ] produce S1/S2 summary table/figure;
- [ ] verify every numerical value against the evidence ledger/artifacts;
- [ ] create immutable archival release/DOI;
- [ ] draft abstract only after contribution wording is stable;
- [ ] complete bibliography with primary sources;
- [ ] perform independent human technical review;
- [ ] audit AI-use disclosure against target venue policy;
- [ ] final claim-boundary audit before submission.
