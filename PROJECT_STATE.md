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

current_phase: 6
current_stage: historical-comparison-after-retracted-proof
current_problem: 1125
problem_status: proved-by-laczkovich
blind_mode: false
reference_solution_accessed: true
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
current_substage: historical-comparison
candidate_proof: retracted
known_lemmas:
  - LEMMA-1125-001: strict descent implies midpoint amplification
  - LEMMA-1125-002: fixed-step recurrence alone does not force monotonicity
  - LEMMA-1125-003: arbitrary positive rational steps remain available on affine rational orbits
rejected_paths:
  - PATH-1125-A: naive midpoint contradiction
  - PATH-1125-B: fixed arithmetic progression reduction
  - PATH-1125-C: incorrect increment-monotonicity proof; revoked after algebraic audit

reference_findings:
  - FormalConjectures/1125 points to an AI-assisted Lean proof by Aristotle and Stefano Rocca.
  - The formal proof explicitly describes the architecture as dyadic induction, a covering lemma on I(alpha), interpolation estimates, and Pell approximants for sqrt(2).
  - The reconstructed modern proof uses a finite-interval estimate f(0) <= f(n) + 10K/n, then transfers it to irrational additive orbits, proves monotonicity there, and finally applies an affine rescaling using alpha = sqrt(2).
  - Pell convergents supply the required controlled approximants to sqrt(2).
  - Historical attribution is Laczkovich (1984); the modern Lean file should be treated as a formal reconstruction, not automatically as a line-by-line transcript of the 1984 paper.

comparison_record: problems/1125/comparison/historical-reconstruction.md
next_action: preserve the failed blind attempt unchanged, summarize the gap between our local lemmas and the global Laczkovich mechanism, then assess whether a second independent attempt should be made on a mathematically simpler proved problem.

## Last checkpoint

The current research log is `problems/1125/research-log.md`.
The previously claimed proof freeze has been explicitly revoked. No valid independent proof of the full theorem has been obtained.
