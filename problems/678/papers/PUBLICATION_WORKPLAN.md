# Erdős #678 — Two-Paper Publication Workplan

**Document status:** active publication plan  
**Established:** 2026-08-19  
**Scope:** Erdős Problem #678 only  
**Governing constraint:** `DEC-012` remains binding; this plan does not authorize work on another Erdős problem.  
**Integration policy:** substantive publication-state changes follow `DEC-011` (dedicated branch/PR, exact-head verification, merge unchanged, exact-main post-merge verification).

## 1. Purpose

This document governs the preparation of two distinct scientific papers from the completed mathematical and scientific-evaluation work on Erdős Problem #678.

The papers share an evidence substrate but make different scientific contributions:

1. **Paper 1 — Formal Verification / Proof Engineering**  
   `PAPER_1_FORMAL_VERIFICATION.md`
2. **Paper 2 — AI-Assisted Scientific Production**  
   `PAPER_2_AI_ASSISTED_SCIENCE.md`

The publication program should avoid turning the two papers into duplicate narratives. Paper 1 is centered on the Lean reconstruction, statement fidelity, differential verification, and proof-engineering evaluation. Paper 2 is centered on long-horizon AI-assisted scientific production, provenance, workflow governance, failure handling, and scientific-credit control.

## 2. Execution strategy

The default execution order is:

`P0 → P1 → P2 → P3 → P4 → P5 → P6 → P7 → P8 → P9 → P10 → P11`

Paper 1 should be advanced to a submission candidate before full drafting of Paper 2. The reason is methodological: Paper 1 is closer to submission readiness, and stabilizing its mathematical claims, terminology, bibliography, and reproducibility package reduces duplication and claim drift in Paper 2.

Parallel work is acceptable only for tasks that do not create narrative divergence, such as bibliography collection or mechanical evidence indexing.

## 3. Phase P0 — Freeze scope and claim boundaries

### Objective
Establish the scientific identity of each paper before full prose drafting.

### Paper 1 boundary
Primary contribution:
- independent Lean reconstruction of Cambie’s 2024 solution to Erdős #678;
- formal statement bridges and fidelity checks;
- differential verification against an existing Lean formalization in a common environment;
- bounded proof-engineering evaluation through S1 and S2a–S2e.

Must not claim:
- a new mathematical solution;
- a new mathematical proof;
- the first Lean formalization;
- general architecture superiority;
- universal speed advantage;
- general maintainability superiority;
- general compatibility or incompatibility conclusions beyond the tested environments.

### Paper 2 boundary
Primary contribution:
- an auditable case study of long-horizon AI-assisted formal scientific production;
- analysis of failure modes, provenance, evidence admissibility, experimental governance, state synchronization, and scientific-credit control;
- separation of machine verification, empirical observation, scientific inference, and attribution.

Must not claim:
- autonomous AI authorship percentages;
- causal effects of governance controls without causal evidence;
- exact model invocation counts, token counts, inference costs, human-hours, or prompt histories that were not prospectively captured;
- general conclusions about all AI-assisted mathematics from a single case.

### Exit criterion
Each paper has a frozen contribution statement, prohibited-claim list, and explicit relationship to the other paper.

## 4. Phase P1 — Build a Claim–Evidence Matrix

### Objective
Map every central publishable claim to auditable evidence before writing persuasive prose around it.

### Required fields
For each claim record:
- claim ID;
- paper;
- proposed wording;
- claim class: `established`, `bounded-observation`, `hypothesis`, or `unsupported`;
- primary evidence source;
- secondary corroboration, if any;
- admissible scope;
- known limitation;
- intended manuscript section;
- status.

### Evidence sources
Expected evidence includes:
- Lean theorem declarations and tests;
- statement bridges and axiom audits;
- canonical CI runs and job IDs;
- S1 differential-verification records;
- S2a dependency-surface records;
- S2b build-behavior protocol/results;
- S2c repair-locality protocol/results;
- S2d semantic-perturbation protocol/results;
- S2e upgrade-robustness protocol/results;
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`;
- `PROJECT_STATE.md`;
- publication synchronization documents;
- archived artifacts, hashes, exclusions, and correction records.

### Rule
No central abstract/introduction/results claim may remain without an evidence classification.

### Exit criterion
All expected headline claims for both papers are traceable to evidence or explicitly marked unsupported and removed from publication prose.

## 5. Phase P2 — Literature, novelty, and venue audit

### Objective
Establish defensible novelty and select realistic publication venues using current literature and current venue policies.

### Paper 1 literature map
Cover at minimum:
- Cambie’s mathematical solution;
- prior Lean formalization(s), including Aristotle/Boris Alexeev;
- Lean formalization of open/conjectural mathematics;
- independent formal reconstruction;
- proof comparison and differential verification;
- formal proof engineering and reproducibility.

### Paper 2 literature map
Cover at minimum:
- AI theorem proving and formal mathematics agents;
- human–AI theorem formalization workflows;
- long-horizon agentic scientific work;
- provenance and reproducibility in AI-assisted science;
- evaluation leakage, semantic drift, and failure recovery;
- AI disclosure and scientific authorship/credit policies;
- empirical case-study methodology where relevant.

### Venue work
For each paper:
- identify 2–3 realistic venues;
- verify current scope and submission rules;
- verify page/format limits;
- verify artifact/reproducibility expectations;
- verify AI-use disclosure requirements;
- identify whether a preprint is compatible with submission policy.

### Exit criterion
Each paper has a literature map, novelty statement, and ranked venue shortlist backed by current source verification.

## 6. Phase P3 — Draft Paper 1, complete first manuscript

### Recommended writing order
1. contribution paragraph;
2. mathematical problem and theorem statement;
3. statement fidelity and provenance;
4. reconstruction architecture;
5. S1 differential verification;
6. S2 evaluation sections;
7. reproducibility and artifacts;
8. related work;
9. limitations/threats to validity;
10. introduction;
11. abstract;
12. conclusion.

### Drafting rule
The abstract and introduction should not be finalized before the results and limitations stabilize.

### Exit criterion
A complete end-to-end Paper 1 Draft 1 exists and can be reviewed by an external researcher without relying on repository context not explained in the manuscript.

## 7. Phase P4 — Adversarial scientific review of Paper 1

### Objective
Review Paper 1 as a skeptical expert reviewer rather than as its author.

### Required challenge questions
- Is “independent reconstruction” precisely justified?
- Are statement-equivalence claims formally and textually supported?
- Is the comparator treatment scientifically fair?
- Are S2a–S2e results interpreted only within their declared scope?
- Are excluded runs and apparatus defects disclosed where relevant?
- Is mathematical credit to Cambie explicit and unambiguous?
- Is prior formalization acknowledged correctly?
- Is any wording stronger than the evidence ledger permits?
- Are limitations visible in the main text rather than hidden only in appendices?

### Exit criterion
No unresolved high-severity claim, attribution, reproducibility, or validity objection remains.

## 8. Phase P5 — Paper 1 reproducibility package

### Objective
Create a publication-grade reproduction path independent of mutable narrative state.

### Required package elements
- exact release commit;
- Lean version;
- Mathlib revision;
- PNT+ revision;
- canonical build command/path;
- expected build result;
- theorem/statement entry points;
- S1/S2 evidence index;
- artifact manifest and hashes where applicable;
- exclusions/corrections register;
- license statement;
- immutable archival target if available.

### Desired archival strengthening
Prefer an immutable release/archive identifier (for example a DOI-backed archive) before final submission when practical.

### Exit criterion
An external reader can determine exactly what to check, what to run, and what result should be observed.

## 9. Phase P6 — Paper 1 Submission Candidate

### Objective
Convert the scientifically reviewed draft into a venue-specific submission package.

### Tasks
- venue template/format;
- bibliography verification;
- figure/table finalization;
- appendices and supplementary material;
- theorem notation consistency;
- author/contribution statements;
- AI-use disclosure as required by venue policy;
- artifact availability statement;
- final claim–evidence audit;
- final reference and link audit.

### Exit criterion
`Paper 1 — Submission Candidate v1` is complete.

## 10. Phase P7 — Build a publication-grade case dataset for Paper 2

### Objective
Separate the empirical record of the AI-assisted case study from retrospective narrative.

### Include only auditable fields
Candidate fields include:
- recorded timestamps;
- project phases and state transitions;
- failed candidate paths;
- corrections;
- excluded runs and reasons;
- CI run/job IDs;
- mutation cases;
- candidate matrices;
- dependency blockers;
- repair classifications;
- artifact IDs and hashes;
- protocol versions;
- human-intervention categories where directly evidenced;
- decisions and governance changes.

### Explicitly unavailable / prohibited-to-invent fields
Do not fabricate or estimate as measured facts:
- token counts;
- total model invocations;
- inference cost;
- complete prompt histories;
- precise human-hours;
- AI-vs-human line attribution;
- autonomous AI-authorship percentage;
- standardized repair time where not prospectively measured.

### Exit criterion
A dataset manifest exists that can be interpreted without relying on hidden model reasoning or chain-of-thought.

## 11. Phase P8 — Draft Paper 2, complete first manuscript

### Recommended structure
1. research questions;
2. case selection and scope;
3. evidence and instrumentation model;
4. workflow chronology;
5. failure taxonomy;
6. verification and governance controls;
7. empirical results;
8. bounded interpretations;
9. lessons for long-horizon AI-assisted science;
10. related work;
11. threats to validity;
12. conclusion.

### Core thesis to test against evidence
> Reliable long-horizon AI-assisted formal science is a scientific-workflow governance problem as much as a theorem-proving problem.

A second formulation that may be used where appropriate:
> Verification of mathematical propositions is necessary but insufficient; scientific production also requires governance of provenance, admissibility, and credit.

### Exit criterion
A complete Paper 2 Draft 1 exists with explicit separation between observed evidence, inference, and hypothesis.

## 12. Phase P9 — Decide whether Paper 2 needs additional strengthening experiments

### Objective
Avoid running experiments merely because more experiments are possible.

Potential strengthening work includes:
- restart/recovery experiment;
- independent human audit;
- broader mutation coverage;
- additional prospective telemetry in future projects.

### Decision rule
Run additional work only if it addresses a concrete research question, venue requirement, or material reviewer risk.

### Exit criterion
Every additional experiment is either justified and completed or explicitly classified as unnecessary/optional for the chosen submission target.

## 13. Phase P10 — Cross-paper overlap and publication-ethics audit

### Objective
Ensure the two papers remain independently defensible publications.

### Review dimensions
- contribution overlap;
- repeated prose;
- reused figures/tables;
- self-citation and cross-reference strategy;
- duplicated empirical results;
- attribution consistency;
- terminology consistency;
- preprint/submission chronology;
- disclosure of companion-paper relationship.

### Rule
Paper 2 may use Paper 1 as the mathematical/formal case substrate, but must not simply republish Paper 1’s proof-engineering contribution under an AI-workflow framing.

### Exit criterion
Each paper has a distinct contribution, clear cross-reference strategy, and no material duplicate-publication risk.

## 14. Phase P11 — Final submission sequence

### Default sequence
1. finalize and submit/preprint Paper 1;
2. update Paper 2’s companion-paper references to the true status of Paper 1 (`preprint`, `submitted`, `accepted`, etc.);
3. finalize Paper 2;
4. run final venue-policy and disclosure audit;
5. submit Paper 2;
6. preserve reviewer-response provenance for both papers.

### Exit criterion
Both manuscripts have independently reproducible submission packages and tracked reviewer-response workflows.

## 15. Current project position

As of establishment of this plan:

- Erdős #678 mathematics is closed and machine-checked;
- S1 and S2a–S2e scientific evaluation are complete;
- the proof is frozen;
- both manuscript scaffold files exist on `main`;
- publication narrative synchronization has been completed through the 2026-08-18 evidence cutoff;
- no new Erdős problem is authorized under `DEC-012`;
- **current publication phase: P0 — scope and claim-boundary freeze**;
- P1 Claim–Evidence Matrix has not yet been completed;
- P2 current literature/venue audit has not yet been completed;
- neither paper is yet a submission candidate.

## 16. Immediate next action

Execute **P0 and P1 for both papers together** before expanding manuscript prose.

The first concrete deliverable should be a two-paper Claim–Evidence Matrix that:
- fixes the contribution boundaries;
- enumerates the headline claims;
- connects each claim to the evidence ledger and primary artifacts;
- records limitations and prohibited overclaims;
- provides the admissible vocabulary for abstracts, introductions, and conclusions.

Only after this matrix is stable should the project proceed to P2 and then full drafting of Paper 1.
