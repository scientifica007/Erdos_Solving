# Paper 1 — P6 CPP 2027 Submission-Candidate Execution — 2026-08-20

**Scope:** Erdős Problem #678, Paper 1 only  
**Phase:** P6 — Submission Candidate  
**Authorized:** 2026-08-20  
**Baseline main SHA:** `ba126120a3981e2fe3028da37cd9b5d8ee7786d1`  
**P4 state at entry:** complete / PASS / exact-main verified  
**P5 state at entry:** repository-level reproducibility package complete

This record supersedes the pre-authorization `P6 — not started` snapshot in `PUBLICATION_WORKPLAN.md` for the execution state of P6. It does not modify the mathematical proof, Lean source, dependency pins, S1/S2 experiments, Paper 2, or any other Erdős problem.

## P6 objective

Convert the adversarially reviewed full Paper 1 draft into a venue-specific submission candidate while preserving claim boundaries, reproducibility, and double-blind review requirements.

## Venue decision

**Active target: CPP 2027.**  
**Fallback: Journal of Automated Reasoning.**

The CPP route is selected because the current official CFP explicitly includes certified mathematical theorems and Lean, asks reviewers to assess formalization design choices/alternatives and lessons for future formalizations, and has a live September 2026 submission window. The JAR route is retained only as a fallback; concurrent submission is prohibited.

Current official CPP 2027 deadlines audited on 2026-08-20:

- abstract: 2026-09-03 AoE;
- paper: 2026-09-10 AoE.

## P6 execution gates

| Gate | Requirement | State |
|---|---|---|
| P6-G1 | current venue/policy audit | **complete** |
| P6-G2 | venue-specific ACM source | **complete** |
| P6-G3 | actual compression/page audit | **complete — 7 total PDF pages** |
| P6-G4 | formalization-choice/alternative coverage | **complete** |
| P6-G5 | bibliography recheck and BibTeX conversion | **complete** |
| P6-G6 | claim-boundary audit | **complete** |
| P6-G7 | double-blind source audit | **complete for candidate source** |
| P6-G8 | AI-use policy/disclosure audit | **complete** |
| P6-G9 | anonymous supplement manifest/builder | **complete as fail-closed tooling; final archive waits for exact submission commit** |
| P6-G10 | repository exact-head CI | **pending until PR head exists** |
| P6-G11 | merge unchanged + exact-main verification | **pending until G10 succeeds** |
| P6-G12 | human submission metadata + HotCRP upload | **external/human gate; not performed** |

## Candidate artifacts

`problems/678/papers/cpp2027/` contains:

- `main.tex` — anonymous CPP paper source;
- `references.bib` — venue-specific bibliography;
- `build.sh` — standard PDF build driver;
- `README.md` — candidate status/build/submission gates;
- `SUBMISSION_CANDIDATE_AUDIT.md` — page, policy, claims, bibliography, anonymity, and AI-use audit;
- `SUBMISSION_METADATA.json` — machine-readable venue/submission state with human metadata explicitly unresolved rather than guessed;
- `ANONYMOUS_SUPPLEMENT_MANIFEST.json` — exact environment/endpoints/evidence authorities;
- `build_anonymous_supplement.py` — fail-closed supplement packager.

## Scientific boundary

The venue-specific candidate continues to state:

- Cambie owns the successful mathematics;
- Aristotle/Boris Alexeev prior public Lean formalization predates this project;
- the project contribution is a separately structured Lean reimplementation/reconstruction, statement fidelity, differential verification, bounded proof-engineering evaluation, and provenance discipline;
- S2b's CPU/memory contrast is bounded evidence and is not generalized into universal speed or architectural superiority;
- S2c is mixed;
- S2d establishes rejection of six frozen observations only;
- S2e stops at dependency/package boundaries before project-owned repair is measurable.

## Remaining non-automatable submission inputs

The anonymous PDF correctly omits author identity. Before the abstract deadline, the human submitter must supply the final author list/order and required HotCRP contact metadata. The repository must not infer those facts from repository ownership.

At final upload time the human submitter must also confirm authorship/contribution/competing-interest facts, absence of a concurrent-submission conflict, and the exact anonymous supplement contents.

## Exit criterion

P6 technical candidate preparation closes only after:

1. exact PR-head package + canonical Lean CI succeeds;
2. the verified head is merged unchanged;
3. the exact resulting `main` SHA publishes `erdos678/post-merge-verification = success`.

That closure does **not** mean that a HotCRP submission has been made. Actual submission remains a separate externally observable action.
