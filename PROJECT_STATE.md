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
statement_source: user-supplied canonical text
selection_reason: third benchmark; short finite-colouring/Diophantine statement; problem-level PROVED (LEAN); mathematically distinct from #1125 and #275
current_substage: structural-reduction
candidate_proof: none
known_lemmas:
  - LEMMA-303-001: algebraic parametrization via (b-a)(c-a)=a^2
  - LEMMA-303-002: it suffices to find n with c(n)=c(n+1)=c(n(n+1))
rejected_paths:
  - PATH-303-A: monochromatic unit square in exponent lattice is false for arbitrary finite grid colourings
  - PATH-303-B: fixed refined-colouring plus Schur/Brauer has not closed the product dependency
reference_findings: []
comparison_record: pending
next_action: solve the finite-colouring configuration (n,n+1,n(n+1)) without consulting reference material

## Last checkpoint

The current research log is `problems/303/research-log.md`.
Blind mode is ON. Historical proof, solution discussion, and formal proof have not been consulted.
