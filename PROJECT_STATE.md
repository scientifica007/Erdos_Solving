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
current_problem: 275
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

## Current #275 state

canonical_statement: locked
statement_source: official problem statement, reproduced verbatim in problems/275/README.md
selection_reason: easier benchmark than #1125; short finite combinatorial statement; problem-level PROVED (LEAN)
current_substage: structural-exploration
candidate_proof: none
known_lemmas: []
rejected_paths:
  - PATH-275-A: density/counting alone appears insufficient
  - PATH-275-B: parity reduction incomplete because odd and even moduli interact differently
  - PATH-275-C: minimal-counterexample idea not yet formalized

reference_findings: []

comparison_record: pending
next_action: continue blind exploration toward a recursive reduction from r congruences to fewer congruences.

## Last checkpoint

The current research log is `problems/275/research-log.md`.
The benchmark selection used only problem-level status and statement information. Historical proof, formal proof, and solution discussion have not been consulted.
