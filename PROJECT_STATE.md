# Project State

This file is the operational memory checkpoint for the project. Read it before resuming research work.

## Global operating rules

- Work directly on `main` unless the user explicitly requests otherwise.
- Do not treat GitHub as proof of truth by itself; repository state is the working record, not mathematical validation.
- Never call an AI-generated argument a proof until it has passed the required audit and proof-freeze gates.
- Distinguish problem-level status from variants, known sub-results, formalized statements, and formalized proofs.
- During a blind challenge, do not consult the historical solution, solution discussions, or papers specifically proving the target statement before proof freeze.
- If a candidate proof fails audit, revoke its freeze explicitly and record the failure; never silently overwrite the history.

## Current project

current_phase: 2
current_stage: blind-independent-solving
current_problem: 303
problem_status: proved-at-problem-level
blind_mode: true
reference_solution_accessed: false
proof_frozen: false

## Phase model

0. Discovery / Triage
1. Foundation / Canonicalization
2. Blind Independent Solving
3. Candidate Proof
4. Independent Audit
5. Proof Freeze
6. Historical Comparison
7. Formalization
8. Final Classification

A phase may only advance when its exit criteria are satisfied.

## Current #303 state

canonical_statement: locked
statement_source: benchmark README; status and statement verified from erdosproblems.com
selection_reason: third benchmark; short finite-colouring/Diophantine statement; problem-level PROVED (LEAN); mathematically distinct from #1125 and #275
current_substage: invariant-hunt
candidate_proof: none
known_lemmas: []
rejected_paths: []
reference_findings: []
comparison_record: pending
next_action: identify a coloring-invariant or algebraic/Ramsey reduction before attempting detailed casework

## Last checkpoint

The current research log is `problems/303/research-log.md`.
Blind mode is ON. Historical proof, solution discussion, and formal proof have not been consulted.
