# Paper 1 — CPP 2027 submission candidate

This directory contains the venue-specific **CPP 2027 Submission Candidate v1** for the Erdős #678 formal-verification/proof-engineering paper.

## Status

- Target venue: **14th ACM SIGPLAN International Conference on Certified Programs and Proofs (CPP 2027)**.
- Review format: ACM `acmart`, `sigplan,10pt,anonymous,review`.
- Candidate date: 2026-08-20.
- Candidate state: source-complete and locally compiled; **not submitted to HotCRP**.
- Full scientific master: `../PAPER_1_FORMAL_VERIFICATION.md` remains the long-form source of record.
- P4 adversarial review: `../PAPER_1_ADVERSARIAL_REVIEW_2026-08-20.md`.

The CPP candidate is a venue-specific compression of the reviewed master. It does not introduce new mathematics, new experimental results, or stronger claims.

## Build

A normal TeX installation with `acmart` and BibTeX is sufficient:

```bash
./build.sh
```

The source intentionally uses the official CPP review class line:

```tex
\documentclass[sigplan,10pt,anonymous,review]{acmart}
\settopmatter{printfolios=true,printccs=false,printacmref=false}
```

The locally audited build on 2026-08-20 produced **7 PDF pages total**, including bibliography and a clearly marked appendix. This is comfortably below the CPP 2027 limit of 12 main-paper pages even before applying the venue's exclusions for bibliography and clearly marked appendices.

## Scientific content retained in the main paper

Compression is not allowed to move the following reviewer-critical material exclusively to the supplement:

1. statement-fidelity and indexing semantics;
2. S1 differential-verification scope and provenance limits;
3. S2 comparator fairness and bounded interpretation, including the favorable S2b CPU/memory contrast and the absence of a stable wall-clock winner;
4. threats to validity, single-case scope, and non-causal interpretation of architecture/resource differences;
5. explicit formalization choices, rejected alternatives, Lean-specific observations, and lessons for future formalizations.

Protocol internals, full 40-character revisions, run/artifact indexes, and machine-readable evidence maps may live in the supplement because the main paper states their scientific meaning independently.

## Double-blind discipline

`main.tex` contains no author, affiliation, email, ORCID, repository-owner username, or project repository URL. Related public artifacts remain cited normally, as required by lightweight double-blind review.

Before upload, the final PDF and supplement archive must be rerun through the anonymity checks recorded in `SUBMISSION_CANDIDATE_AUDIT.md` and the fail-closed supplement builder.

## AI-use disclosure

The candidate contains an explicit main-text disclosure because AI assistance interacted with repository analysis, evidence synthesis, venue/literature auditing, and manuscript drafting. The disclosure does not list AI systems as authors and states that human authors retain responsibility for originality, accuracy, and integrity.

## Remaining human/external submission gates

These are intentionally not guessed or fabricated in the repository:

- final author list and author order for HotCRP metadata before the abstract deadline;
- affiliations/contact data required by the submission system but omitted from the anonymous PDF;
- confirmation that no concurrent submission conflicts exist at submission time;
- final human approval of authorship/contribution/competing-interest metadata;
- generation and manual spot-check of the anonymous supplement archive from the exact submission commit;
- actual HotCRP upload/submission;
- later permanent non-anonymous archival identifier/DOI when appropriate.

No Paper 2 work and no other Erdős problem are authorized by this directory.
