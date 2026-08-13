# Project State

This file is the operational memory checkpoint for the project. Read it before resuming research work.

## Global operating rules

- Work directly on `main` unless the user explicitly requests otherwise.
- Do not treat GitHub as proof of truth by itself; repository state is the working record, not mathematical validation.
- Never call an AI-generated argument a proof until it has passed the required audit and proof-freeze gates.
- Distinguish problem-level status from variants, known sub-results, formalized statements, and formalized proofs.
- During a blind challenge, do not consult the historical solution, solution discussions, or papers specifically proving the target statement before proof freeze.

## Current project

current_phase: 2
current_stage: blind-independent-solving
current_problem: 1125
problem_status: open-for-blind-work
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

## Current #1125 state

canonical_statement: locked
statement_source: user-supplied canonical text
current_substage: structural-analysis
candidate_proof: none
known_lemmas:
  - LEMMA-1125-001: strict descent implies midpoint amplification
  - LEMMA-1125-002: fixed-step recurrence alone does not force monotonicity
rejected_paths:
  - PATH-1125-A: naive midpoint contradiction
  - PATH-1125-B: fixed arithmetic progression reduction
next_action: derive a global constraint from interaction of arbitrary positive step sizes

## Last checkpoint

The current research log is `problems/1125/research-log.md`.
No historical/reference proof has been consulted during the current blind phase.
