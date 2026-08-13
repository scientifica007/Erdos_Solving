# Research State Protocol

This document defines how the repository is used as external working memory for mathematical research.

## Required state fields

For every active problem, the state must identify:

- canonical statement status;
- problem-level official status;
- current phase and substage;
- blind/reference access status;
- candidate-proof status;
- proof-freeze status;
- known lemmas;
- rejected paths and reasons;
- current next action.

## Research object IDs

Use stable IDs for important reasoning objects:

- `DEC-###` — project decisions;
- `LEMMA-<problem>-###` — mathematical lemmas;
- `PATH-<problem>-X` — explored path;
- `ATTEMPT-<problem>-###` — candidate proof attempts;
- `AUDIT-<problem>-###` — audit passes;
- `FREEZE-<problem>-###` — frozen proof snapshots.

## Phase gates

### Gate 1 — Statement lock
The canonical statement is recorded verbatim and its authority is explicit.

### Gate 2 — Blind exploration
No forbidden reference material has been consulted. Exploratory claims remain provisional.

### Gate 3 — Candidate proof
Every inference has a mathematical justification; unresolved gaps are explicitly listed.

### Gate 4 — Independent audit
A second pass attempts to falsify the candidate proof, especially hidden regularity assumptions, quantifier errors, boundary cases, and misuse of known results.

### Gate 5 — Proof freeze
The candidate proof is copied to a frozen record. Later historical knowledge must not rewrite it retroactively.

### Gate 6 — Historical comparison
Only after freeze may the historical/reference proof be examined. Similarity is classified as identical, equivalent, partially overlapping, or distinct only when evidence supports the classification.

### Gate 7 — Formalization
Formalization is a separate validation layer. A formalized statement is not a formalized proof.

## Checkpoint rule

After every material transition, update `PROJECT_STATE.md`. The next session should be able to resume from that file without relying on conversational memory.

## Integrity rule

If new information reveals that a previous stage was contaminated or misclassified, do not rewrite history silently. Record the correction as a new decision/state update and preserve the previous record.
