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
