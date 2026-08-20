# CPP 2027 Submission Candidate v1 — P6 audit

**Audit date:** 2026-08-20  
**Baseline full master:** Paper 1 Draft 2 after P4  
**Venue-specific candidate:** `main.tex` + `references.bib`  
**Submission state:** not submitted

## 1. Venue decision

CPP 2027 is selected as the active Paper 1 target for P6. The decision is based on current official CPP 2027 rules and fit:

- abstract deadline: 2026-09-03 AoE;
- paper deadline: 2026-09-10 AoE;
- explicit topics include certified mathematical theorems and proof assistants including Lean;
- review criteria explicitly request formalization design choices, alternatives/rejections, comparison with related libraries, proof-assistant feedback, and lessons for future formalizations;
- 12-page main-paper limit in ACM SIGPLAN `acmart` format;
- lightweight double-blind review;
- supplementary material is strongly encouraged and must be uploaded as an archive rather than supplied only by URL.

Primary venue source audited: `https://popl27.sigplan.org/home/CPP-2027` on 2026-08-20.

The Journal of Automated Reasoning is retained only as a fallback. The paper must not be concurrently submitted to JAR while an active CPP submission exists.

## 2. Compression audit

The P4-reviewed long-form manuscript is approximately 59 KB of Markdown. P6 created a venue-specific ACM source rather than mechanically truncating the master.

The candidate was compiled with the official review class:

```tex
\documentclass[sigplan,10pt,anonymous,review]{acmart}
\settopmatter{printfolios=true,printccs=false,printacmref=false}
```

Local build result on 2026-08-20:

- PDF pages total: **7**;
- total includes bibliography and clearly marked appendix;
- overfull hboxes after final typographic pass: **0**;
- therefore the candidate is safely below the 12-page main-paper cap even under the stricter count that includes material the CFP formally excludes.

The main paper remains self-contained. The supplement carries audit depth, not essential qualifications that would change the interpretation of the reported results.

## 3. Reviewer-critical content retained in main text

The following survived compression in explicit form:

- exact mathematical problem shape and unbounded-witness endpoint;
- Cambie attribution and prior Aristotle/Boris Alexeev formalization credit;
- theorem-level interval/`Finset.Ioc` fidelity bridge and off-by-one rationale;
- strong-theorem-before-benchmark design choice;
- Claim 4 producer / Claim 5 consumer contract choice;
- analytic dependency closure through pinned PNT+;
- S1 comparator/provenance scope;
- S2a packaging-boundary warning;
- S2b timed unit, prepared-dependency boundary, six paired observations, no stable wall-clock winner, and the CPU/RSS contrast;
- S2c mixed repair locality and absence of human-time inference;
- S2d 6/6 rejection result with no general robustness ranking;
- S2e exact-candidate dependency/package boundaries;
- exact-head/exact-main verification-credit mechanism;
- exclusions/admissibility distinction;
- explicit threats to validity;
- formalization choices, rejected alternatives, Lean-specific observations, and future-formalization lessons.

## 4. Claim-boundary audit

PASS. The candidate does not assert:

- a new solution to Erdős #678;
- a new mathematical proof;
- first Lean formalization;
- general architecture superiority;
- universal speed superiority;
- general maintainability superiority;
- general semantic-robustness superiority;
- general future-version compatibility or zero future repair cost.

Positive bounded evidence is not suppressed. In particular, S2b still reports the internal median total CPU value `241.155 s` against comparator `486.475 s` and lower median maximum RSS, while also reporting the sign-changing wall-clock differences and no stable wall-clock winner.

## 5. Bibliography audit

The candidate bibliography was regenerated as BibTeX and rechecked against the P4-audited source list. It preserves:

- Cambie's 2024 mathematical source;
- Flyspeck;
- formalized perfectoid spaces;
- Liquid Tensor Experiment;
- Formal Conjectures;
- LeanArchitect with corrected ITP 2026 author order/pages/DOI;
- end-to-end Keller verification;
- de Finetti formalization;
- Lean-on-Vampire proof reconstruction;
- the pinned prior Aristotle/Boris Alexeev artifact;
- the pinned Formal Conjectures #678 artifact.

Exact 40-character artifact revisions are intentionally moved to the supplement/manifest where they can be represented without line-breaking pressure. The main paper uses unambiguous commit prefixes plus citations.

## 6. Double-blind audit

PASS for the current source.

Automated source scan found no:

- `scientifica007` token;
- project GitHub repository URL;
- `\\author`, `\\affiliation`, `\\email`, or `\\orcid` metadata;
- non-anonymous author identity in the PDF source.

Public prior work remains cited normally, consistent with lightweight double-blind review. Final author names/order belong in HotCRP metadata and must be supplied by the human authors before the abstract deadline; they are not inferred from repository ownership.

## 7. AI-use policy/disclosure audit

CPP 2027 follows ACM authorship/AI policy and explicitly permits AI-assisted preparation subject to non-plagiarism, non-misrepresentation/non-falsification, substantive human contribution, and author responsibility.

Current ACM 2026 policy distinguishes AI used in the research lifecycle from AI used only for writing assistance: research-lifecycle uses directly relevant to conclusions should be described in the methods, while writing-only assistance no longer necessarily requires disclosure. This project's assistance interacted with repository analysis, evidence synthesis, literature/venue auditing, and manuscript preparation, so the candidate takes the conservative route and discloses the workflow in the main paper rather than hiding it in review-mode acknowledgements.

The disclosure states that AI systems are not authors and that human authors remain accountable for originality, accuracy, and integrity. No AI-authorship percentage or unsupported autonomy metric is asserted.

## 8. Data/supplement strategy

CPP requires uploaded supplementary material to be an archive rather than merely a URL. The candidate therefore describes a self-contained supplement and includes a fail-closed builder.

The anonymous supplement is intended to expose:

- exact theorem endpoints;
- exact Lean/Mathlib/PNT+ pins;
- positive/negative semantic regressions;
- comparator revision/digest;
- claim/evidence matrix;
- S1/S2 evidence index and archived identifiers;
- validation/build instructions.

The builder refuses to create an anonymous archive if configured identity tokens are found. A permanent non-anonymous repository/archive identifier or DOI is useful for publication provenance but is not a blocking requirement for the anonymous review PDF under current CPP rules; it can be attached after the double-blind stage or at the final archival release.

## 9. Remaining human/external gates

P6 technical candidate preparation is complete when this branch passes repository CI. Actual submission still requires human-controlled facts/actions that are deliberately not invented:

1. final author names and order in HotCRP before the abstract deadline;
2. required contact/affiliation metadata in the submission system;
3. authorship/contribution/competing-interest confirmation;
4. recheck that no concurrent-submission conflict exists;
5. build the anonymous supplement from the exact submission commit and manually inspect its contents;
6. build the final PDF from the same exact submission commit;
7. submit/upload through HotCRP;
8. preserve the resulting submission identifier and exact submitted artifact hashes.

## 10. P6 verdict

**Technical Submission Candidate v1: PASS.**  
**Actual CPP submission: NOT YET PERFORMED.**

No mathematics, Lean source, dependency pin, S1/S2 protocol, or frozen scientific result was changed by P6.
