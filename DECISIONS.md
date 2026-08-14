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
