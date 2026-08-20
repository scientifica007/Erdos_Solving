# Erdős #678 — Two-Paper Publication Workplan

**Document status:** active publication plan — synchronized 2026-08-20  
**Established:** 2026-08-19  
**Scope:** Erdős Problem #678 only  
**Governing constraint:** `DEC-012` remains binding; this plan does not authorize work on another Erdős problem.  
**Integration policy:** substantive publication-state changes follow `DEC-011` (dedicated branch/PR, exact-head verification, merge unchanged, exact-main post-merge verification).

## 1. Purpose

This document governs preparation of two distinct scientific papers from the completed mathematical and scientific-evaluation work on Erdős Problem #678.

1. **Paper 1 — Formal Verification / Proof Engineering**  
   `PAPER_1_FORMAL_VERIFICATION.md`
2. **Paper 2 — AI-Assisted Scientific Production**  
   `PAPER_2_AI_ASSISTED_SCIENCE.md`

The papers share an evidence substrate but have different scientific objects. Paper 1 is centered on the Lean reconstruction, statement fidelity, differential verification, bounded proof-engineering evaluation, and reproducibility. Paper 2 is centered on long-horizon AI-assisted scientific production, provenance, workflow governance, failure handling, and scientific-credit control.

Paper 1 should reach a submission candidate before full drafting of Paper 2.

## 2. Current phase summary

As of 2026-08-20:

| Phase | Status | Notes |
|---|---|---|
| P0 — scope/claim boundaries | **complete** | Contribution boundary and prohibited claims frozen. |
| P1 — Claim–Evidence Matrix | **complete** | Machine-readable matrix and paper-specific allowlists integrated. |
| P2 — literature/novelty/venue audit | **complete for Paper 1** | Recorded in `PAPER_1_LITERATURE_NOVELTY_VENUE_AUDIT_2026-08-20.md`. Paper 2 P2 remains future work. |
| P3 — Paper 1 Draft 1 | **complete as Draft 1 in this publication cycle** | End-to-end draft exists; next gate is adversarial review. |
| P4 — adversarial review | **next** | Must be completed before submission-candidate work. |
| P5 — Paper 1 reproducibility package | **repository-level complete** | `problems/678/reproducible/` is integrated-postmerge-verified; external archival DOI/snapshot remains for final submission strengthening. |
| P6 — Paper 1 submission candidate | **not started** | Venue-specific package follows P4. |
| P7–P11 — Paper 2/final sequence | **not started** | Remain gated behind Paper 1 progress. |

The execution record for the current Paper 1 cycle is `PAPER_1_EXECUTION_PLAN_2026-08-20.md`.

## 3. Phase P0 — Freeze scope and claim boundaries

### Objective
Establish the scientific identity of each paper before persuasive prose is written.

### Paper 1 boundary
Primary contribution:

- independent Lean reconstruction of Cambie's 2024 solution to Erdős #678;
- formal statement bridges and fidelity checks;
- differential verification against a prior Lean formalization in a common environment;
- bounded proof-engineering evaluation through S1 and S2a–S2e;
- reproducibility and verification-credit provenance.

Paper 1 must not claim:

- a new mathematical solution;
- a new mathematical proof;
- the first Lean formalization;
- general architecture superiority;
- universal speed superiority;
- general maintainability superiority;
- general semantic-robustness superiority;
- general compatibility or incompatibility beyond the tested environments/candidates.

### Bounded-advantages rule

A favorable bounded observation must be reported accurately but must not be generalized beyond its protocol. For example, S2b found substantially lower median total CPU time and lower median peak RSS for the internal artifact in the pinned common environment, but no stable wall-clock winner. The manuscript therefore reports a resource-profile contrast rather than general speed superiority.

### Paper 2 boundary
Primary contribution:

- auditable case study of long-horizon AI-assisted formal scientific production;
- failure modes, provenance, evidence admissibility, experimental governance, state synchronization, and scientific-credit control;
- separation of machine verification, empirical observation, scientific inference, and attribution.

Paper 2 must not invent AI-authorship percentages, missing telemetry, causal effects without causal evidence, or general conclusions from one case.

**Status:** complete.

## 4. Phase P1 — Claim–Evidence Matrix

### Objective
Map every central publishable claim to auditable evidence before finalizing abstract/introduction/results prose.

Canonical sources:

- `problems/678/reproducible/CLAIM_EVIDENCE_MATRIX.json`;
- `problems/678/reproducible/papers/PAPER_1_CLAIMS.json`;
- `problems/678/reproducible/papers/PAPER_2_CLAIMS.json`;
- `problems/678/reproducible/papers/SHARED_FACT_BASE.md`;
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`.

No central claim may bypass this classification.

**Status:** complete.

## 5. Phase P2 — Literature, novelty, and venue audit

### Objective
Establish defensible positioning and select realistic venues using current primary literature and current venue policies.

### Paper 1 result

Paper 1's audit was completed on 2026-08-20 and records:

- Cambie's mathematical source;
- prior Aristotle/Boris Alexeev public Lean artifact;
- current Formal Conjectures #678 context;
- precedents in major formalized mathematics, statement fidelity, proof reconstruction, multiple-route cross-checking, end-to-end verification, and blueprint/proof-engineering infrastructure;
- a non-priority novelty statement;
- current venue rules and AI/artifact policies.

Defensible positioning:

> The contribution is the combination studied in this case: independently structured Lean reconstruction, explicit semantic bridging, controlled differential verification against a pinned prior artifact, prospectively frozen bounded proof-engineering experiments, and exact verification-credit provenance. No first-of-kind claim is made.

### Paper 1 venue ranking

1. **Journal of Automated Reasoning** — primary full-paper target.
2. **CPP 2027** — accelerated option; current paper deadline 2026-09-10 and 12-page main-paper limit require a compression-risk review.
3. **ITP 2027** — strong conditional fallback once its official paper CFP/rules are published.

### Paper 2 literature/venue audit

Still pending and must be performed separately before full Paper 2 drafting.

**Status:** complete for Paper 1; pending for Paper 2.

## 6. Phase P3 — Draft Paper 1

### Drafting rule
The baseline scaffold `PAPER_1_FORMAL_VERIFICATION.md` at commit `54c5c2b89eedc2dcb63c08aa23cf2ed8fc5e1c2d` is the master manuscript architecture.

Required section order:

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

### Draft 1 requirements

- exact mathematical statement and quantifier interpretation;
- clear Cambie attribution and prior-formalization credit;
- theorem endpoint names and semantic bridge explanation;
- S1 method and bounded meaning;
- all S2a–S2e results, including exclusions where material;
- positive S2b CPU/memory contrast reported numerically without general superiority language;
- current related-work synthesis with no unsupported priority claim;
- visible threats to validity;
- reproducibility/data availability section;
- venue-policy-compatible draft abstract and keyword set;
- AI-use disclosure placeholder for later venue-specific finalization.

**Status:** Draft 1 complete on 2026-08-20; integration verification is part of the current publication change.

## 7. Phase P4 — Adversarial scientific review of Paper 1

### Objective
Review Draft 1 as a skeptical expert reviewer.

Required questions:

- Is “independent reconstruction” narrowly and defensibly defined?
- Is Cambie's mathematical authorship unmistakable?
- Is prior Aristotle/Boris Alexeev formalization credited fairly?
- Are statement-equivalence claims supported by exact Lean bridges?
- Does S1 establish only what the protocol supports?
- Are S2a–S2e results interpreted strictly within scope?
- Are favorable S2b numbers visible without becoming a general speed claim?
- Are excluded pilots/corrections disclosed where scientifically relevant?
- Are dependency ownership and packaging effects clear?
- Does any sentence imply first-of-kind priority without evidence?
- Are limitations visible in the main text?
- Can an external researcher understand the paper without reconstructing repository history?

### Exit criterion
No unresolved high-severity attribution, statement-fidelity, reproducibility, numerical, comparator-fairness, or validity objection remains.

**Status:** next phase.

## 8. Phase P5 — Paper 1 reproducibility package

The publication-facing package is already implemented at

`problems/678/reproducible/`.

It includes:

- exact Lean/Mathlib/PNT+ environment;
- canonical build commands;
- theorem/statement endpoints;
- positive and negative regressions;
- Claim–Evidence Matrix;
- S1/S2 evidence index;
- paper-specific claim allowlists;
- package verification script;
- one-command reproduction path;
- exact-main verification status mechanism.

Current repository-level status: **integrated-postmerge-verified**.

Remaining P5 strengthening before final submission:

- freeze the exact submission/release commit;
- create or select an immutable external archival identifier/DOI when practical/required;
- ensure venue-specific supplementary packaging is self-contained.

## 9. Phase P6 — Paper 1 Submission Candidate

### Objective
Convert the adversarially reviewed full draft into a venue-specific submission package.

Tasks include:

- final venue decision;
- target template and length constraints;
- bibliography metadata verification;
- figure/table finalization;
- appendices/supplementary material;
- author/contribution/competing-interest metadata;
- final AI-use disclosure under then-current venue policy;
- Data Availability Statement;
- archival identifier;
- final claim/evidence and link audit.

If CPP 2027 is selected, P6 must include an explicit compression audit proving that the 12-page main paper remains self-contained and does not hide material limitations. If JAR remains primary, the full scientific structure should be preserved.

**Status:** not started.

## 10. Phase P7 — Publication-grade case dataset for Paper 2

Build an auditable dataset of recorded project phases, corrections, exclusions, CI identities, mutation cases, artifacts/hashes, protocol versions, and directly evidenced intervention categories.

Do not fabricate token counts, total model invocations, inference cost, complete prompt history, precise human-hours, AI-vs-human line attribution, or autonomous AI-authorship percentages.

**Status:** not started.

## 11. Phase P8 — Draft Paper 2

Paper 2's scientific object is the long-horizon AI-assisted workflow, not a repackaging of Paper 1's proof-engineering contribution. Full drafting remains gated on Paper 1 progress and Paper 2's own P2 audit.

**Status:** not started.

## 12. Phase P9 — Decide on Paper 2 strengthening experiments

Run additional work only when it addresses a concrete research question, reviewer risk, or venue requirement. More experiments are not automatically better evidence.

**Status:** not started.

## 13. Phase P10 — Cross-paper overlap and publication-ethics audit

Audit contribution overlap, repeated prose/results, self-citation, companion-paper status, attribution consistency, reused figures/tables, and disclosure requirements.

Paper 2 may use Paper 1 as the mathematical/formal substrate but must remain a distinct scientific contribution.

**Status:** not started.

## 14. Phase P11 — Final submission sequence

Default sequence:

1. finalize and submit/preprint Paper 1;
2. synchronize Paper 2's reference to the true Paper 1 status;
3. finalize Paper 2;
4. run final policy/disclosure audit;
5. submit Paper 2;
6. preserve reviewer-response provenance.

**Status:** not started.

## 15. Immediate next action

After the current Draft 1 documentation change passes exact-head CI, is merged unchanged, and receives exact-main `erdos678/post-merge-verification = success`, the next scientific action is:

> **P4 — adversarial scientific review of Paper 1.**

Do not begin P6 venue-specific submission packaging until P4 closes all high-severity claim, attribution, comparator-fairness, reproducibility, and validity objections.
