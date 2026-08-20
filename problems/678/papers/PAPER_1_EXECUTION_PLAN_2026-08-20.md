# Paper 1 — Execution Plan — 2026-08-20

**Paper:** `PAPER_1_FORMAL_VERIFICATION.md`  
**Scope:** Erdős Problem #678 only  
**Master manuscript architecture:** `PAPER_1_FORMAL_VERIFICATION.md` as frozen at commit `54c5c2b89eedc2dcb63c08aa23cf2ed8fc5e1c2d`  
**Publication evidence authority:** `../reproducible/CLAIM_EVIDENCE_MATRIX.json`, `../reproducible/papers/PAPER_1_CLAIMS.json`, `../reproducible/papers/SHARED_FACT_BASE.md`, and `../SCIENTIFIC_EVIDENCE_LEDGER.yaml`  
**Plan date:** 2026-08-20

## 1. Purpose

This document records the execution plan for Paper 1 after completion of the Erdős #678 reproducibility package. It converts the historical manuscript scaffold into an evidence-governed publication workflow without changing the mathematical result, the Lean proof, the dependency pins, or the completed S1/S2 experiments.

Paper 1 is a formal-verification and proof-engineering paper. Its scientific object is the independently structured Lean reconstruction of Stijn Cambie's 2024 proof, together with statement-fidelity checks, controlled differential verification, bounded proof-engineering experiments, and auditable reproducibility/provenance.

## 2. Fixed manuscript identity

### 2.1 Primary contribution

The primary contribution is:

> Independent Lean reconstruction, statement fidelity, differential verification, reproducibility, and bounded proof-engineering evaluation for Cambie's solution of Erdős Problem #678.

The successful mathematics is attributed to **Stijn Cambie (2024)**. The project formalization is an **independent Lean reimplementation** of that mathematics. A public Aristotle/Boris Alexeev Lean artifact predates the project reconstruction.

### 2.2 Non-negotiable prohibited claims

Paper 1 must not claim:

- a new mathematical solution to Erdős #678;
- a new independent mathematical proof of the result;
- the first Lean formalization of the result;
- general architectural superiority;
- universal speed superiority;
- general maintainability superiority;
- general semantic-robustness superiority;
- general Lean/Mathlib compatibility or incompatibility beyond the frozen tested candidates.

These restrictions are not rhetorical caution. They are the direct result of the claim/evidence classification and the bounded design of S2a–S2e.

## 3. Interpretation rule: bounded advantages are not general superiority

The manuscript must report favorable bounded observations fully rather than hiding them behind generic caveats. At the same time, it must preserve their experimental scope.

The governing rule is:

> **A measured advantage or contrast under a frozen protocol is publishable evidence; it is not, by itself, a proof of general architectural superiority.**

In particular, S2b found no stable wall-clock winner across six credited paired replicates, while the internal reconstruction had a substantially lower median total CPU time and a lower median peak RSS in the pinned common environment:

- internal cold wall median: `159.575 s`;
- comparator cold wall median: `156.280 s`;
- paired wall-time difference range: `[-10.68 s, 11.73 s]`;
- internal total CPU median: `241.155 s`;
- comparator total CPU median: `486.475 s`;
- internal max-RSS median: `7,183,766 KiB`;
- comparator max-RSS median: `7,828,930 KiB`.

The paper should therefore describe a **materially different resource profile in the pinned experiment**, not a universal speed result.

Likewise:

- S2a supports boundary sensitivity of dependency-surface counts, not an architecture ranking;
- S2c supports mixed/interface-dependent repair locality, not a maintainability ranking;
- S2d supports rejection of all six frozen semantic/index observations in both artifacts, not a general robustness ranking;
- S2e supports exact dependency/package-boundary observations for U1/U2, not a general upgrade-compatibility result.

## 4. Publication phases and current state

### P0 — scope and claim boundary

**Status: complete.**

The contribution boundary and prohibited claims are frozen in the manuscript scaffold and machine-readable claim package.

### P1 — claim–evidence matrix

**Status: complete.**

Paper 1 has an explicit allowlist of eleven central claim IDs. Unsupported novelty/superiority claims are explicitly registered as publication-disallowed.

### P2 — literature, novelty, and venue audit

**Status: complete on 2026-08-20 for Paper 1.**

The audit is recorded in `PAPER_1_LITERATURE_NOVELTY_VENUE_AUDIT_2026-08-20.md`.

Its central positioning conclusion is deliberately non-priority-based: prior work exists for major mathematical formalization, proof reconstruction, end-to-end verification, statement benchmarks, blueprints, and multi-route cross-checking. Paper 1's contribution is the particular combination of independently structured reconstruction, explicit semantic bridging, common-environment differential verification, prospectively frozen bounded proof-engineering experiments, and exact verification-credit provenance. No first-of-kind claim is made.

Venue ranking:

1. **Journal of Automated Reasoning (JAR)** — primary full-paper target;
2. **CPP 2027** — accelerated conference option, conditional on fitting the scientific argument into the 12-page main-paper limit without hiding material limitations;
3. **ITP 2027** — strong conditional fallback once its paper CFP and submission rules are officially published.

### P3 — Paper 1 Draft 1

**Status: execution target of this plan.**

The manuscript is to be converted from scaffold to an end-to-end Draft 1 using the scaffold's section order as the master architecture.

Drafting order:

1. contribution statement;
2. exact mathematical problem and theorem endpoint;
3. reconstruction architecture;
4. statement fidelity and semantic bridges;
5. S1 differential verification;
6. S2a–S2e evaluation;
7. reproducibility and verification-credit discipline;
8. results summary table;
9. related work based on P2;
10. threats to validity;
11. discussion;
12. introduction;
13. abstract;
14. conclusion.

### P4 — adversarial scientific review

**Status: next gate after Draft 1 is integrated.**

P4 must challenge attribution, statement equivalence, comparator fairness, experimental scope, exclusions, numerical provenance, and any wording that might overstate S2.

### P5 — reproducibility package

**Repository-level status: complete and integrated-postmerge-verified.**

The curated package is `../reproducible/`. A publication-grade immutable external archive/DOI remains desirable before final submission.

### P6 — submission candidate

**Status: not started.**

Venue-specific formatting, author metadata, disclosure text, bibliography finalization, archival identifier, and final claim audit belong here.

## 5. Draft 1 architecture

The baseline scaffold section order remains authoritative:

1. Introduction
2. Mathematical background
3. Formalization architecture
4. Statement fidelity and semantic bridges
5. Differential verification (S1)
6. Scientific evaluation program (S2)
7. Reproducibility and scientific-credit discipline
8. Results summary
9. Related work
10. Threats to validity
11. Discussion
12. Conclusion

The manuscript must remain understandable without requiring the reader to infer repository-internal context.

## 6. Evidence discipline

Every headline statement in the abstract, introduction, results, and conclusion must map to one or more Paper 1 allowlisted claim IDs:

- `C-MATH-001`
- `C-FORMAL-001`
- `C-FORMAL-002`
- `C-FORMAL-003`
- `C-VERIFY-001`
- `C-S1-001`
- `C-S2A-001`
- `C-S2B-001`
- `C-S2C-001`
- `C-S2D-001`
- `C-S2E-001`

Run IDs, artifact IDs, hashes, environment versions, and exact numerical observations must be taken from `SCIENTIFIC_EVIDENCE_LEDGER.yaml` or the corresponding frozen stage result, never reconstructed from memory.

The three publication-disallowed claims remain:

- `C-UNSUPPORTED-NEW-SOLUTION`
- `C-UNSUPPORTED-FIRST-FORMALIZATION`
- `C-UNSUPPORTED-GENERAL-SUPERIORITY`

## 7. Venue strategy

### Primary: Journal of Automated Reasoning

JAR is the default target for the full scientific version because its scope explicitly includes formal proof assistants, formalization of mathematics, and verification case studies that yield lessons about tools. The journal's current author guidance also supports supplementary information and requires a Data Availability Statement for original research. The draft abstract is kept within the current 150–250 word range and uses 4–6 keywords.

### Accelerated option: CPP 2027

CPP 2027 is a strong topical match and explicitly seeks certified mathematical theorems, proof-assistant work, formalization design choices, comparisons, and lessons for future formalization. Its paper deadline is 2026-09-10. The 12-page main-paper limit creates a real compression risk for a manuscript with S1 plus five S2 stages and visible threats-to-validity discussion. CPP should be selected only if an adversarial review confirms that the claim boundaries and essential limitations remain visible after compression.

### Conditional option: ITP 2027

ITP is a natural community venue for formalized mathematics and proof engineering. As of this audit, the 2027 paper CFP/rules are not sufficiently frozen to base formatting decisions on them. It remains a conditional option rather than a current submission target.

## 8. AI-use and authorship discipline

AI systems are not manuscript authors. Any final submission must follow the selected venue's current disclosure policy and preserve human accountability for the submitted text and scientific claims.

For JAR, current Springer guidance states that LLMs do not satisfy authorship criteria and generative LLM use should be documented in Methods or a suitable alternative section. CPP 2027 follows the ACM authorship/AI policy and requires authors to accept responsibility for generated material and the accuracy of the submission.

The Draft 1 therefore contains a disclosure placeholder rather than inventing author/contribution metadata before the target submission package is frozen.

## 9. Exit criteria for this execution cycle

This cycle is complete when:

- P2 audit is recorded with primary/current sources and a ranked venue shortlist;
- `PAPER_1_FORMAL_VERIFICATION.md` is a complete end-to-end Draft 1 with no substantive TODO sections;
- the S1/S2 table includes the bounded result and unsupported generalization for every stage;
- bounded positive S2b resource observations are reported numerically without a general superiority claim;
- related work makes no unverified priority claim;
- the publication workplan reflects the actual P0–P5 state;
- the documentation-only change passes exact-head canonical CI;
- the verified head is merged unchanged;
- the resulting exact `main` SHA receives `erdos678/post-merge-verification = success`.

After these criteria are met, the next scientific gate is **P4 — adversarial scientific review of Paper 1**.
