# Decision Register

Decisions are append-only records of project-level rules. Do not silently reinterpret them.

## DEC-001 — Canonical statement authority
The user's explicitly supplied statement is the canonical statement for a blind experiment when it is declared as such. Secondary paraphrases must not silently replace it.

## DEC-002 — Blind separation
For a blind challenge, historical/reference proofs, solution discussions, and papers specifically proving the target statement are forbidden until the candidate proof is frozen and audited.

## DEC-003 — Problem-level status hierarchy
A solved variant, known theorem, or formalized sub-result does not make the parent Erdős problem solved. Problem-level status must be checked independently.

## DEC-004 — Main-only workflow
The repository uses `main` as the sole working branch unless the user explicitly requests branching.

## DEC-005 — Proof threshold
A plausible argument is not a proof. Proof status requires a completed argument, explicit gap audit, and proof freeze.

## DEC-006 — External-memory checkpoint
`PROJECT_STATE.md` is the authoritative operational checkpoint for resuming work. It must be updated when the active problem, phase, blind status, proof status, or next action changes materially.

## DEC-007 — Failed-path preservation
Rejected mathematical paths remain recorded with reasons. They are not silently deleted or converted into successful arguments.

## DEC-008 — Documentation synchronization gate
A material change to the active problem, phase, proof status, reference-access status, canonical build graph, CI status, blocker, or next action is incomplete until `PROJECT_STATE.md`, the active roadmap, and every README presenting that state are synchronized in the same change or in an immediately following documentation-only change.

No mathematical or implementation phase may advance while these documents materially contradict the repository head.

## DEC-009 — CI truth and build-graph liveness
The current CI status recorded by the project must reflect the canonical build graph at the code state being credited. A green run does not validate a newly created Lean file unless that file is reachable from `Formalization.lean` in that run.

When the canonical head is red, state documents must say `red`, identify the blocker, and forbid crediting dependent theorems as machine-checked.

## DEC-010 — Historical snapshot labeling
Stage-specific records may preserve historically correct statements such as `blind mode: ON` or `candidate under audit`, but once superseded they must carry an explicit `HISTORICAL SNAPSHOT` or `SUPERSEDED` notice pointing to the authoritative final outcome. Historical chronology is preserved; operational ambiguity is not.

## DEC-011 — Green-main pull-request workflow

This decision supersedes `DEC-004`, following the user's explicit approval on 2026-08-14.

- `main` is the stable integration branch, not the routine working branch.
- Every substantive code or mathematical change is developed on a dedicated branch and presented through a pull request.
- The exact pull-request head must pass the canonical required check before merge.
- State documents and the decision record must be synchronized in the same pull request before merge.
- Direct writes to `main` are reserved for an explicitly authorized emergency correction.
- Repository-level branch protection should enforce this policy when the administrative interface is available; the policy remains binding even if that setting has not yet been enabled.
- A previously verified green commit is cited explicitly as the recovery checkpoint; history is not rewritten merely to create a label.

## DEC-012 — Explicit user gate after Erdős #678

Following the user's explicit instruction on 2026-08-17, completion of Erdős #678 does **not** authorize automatic selection, activation, exploration, or formalization of another Erdős problem.

- #678 remains the current archived checkpoint until the user explicitly authorizes moving to another problem.
- No other benchmark may be selected as active, resumed, researched, or formalized without that explicit authorization.
- Repository hygiene and verification work needed to close or preserve #678 may continue without reopening its mathematics.
- Candidate problems may not be pre-activated under the label of planning or preparation; any transition to a new mathematical target requires explicit user permission first.
