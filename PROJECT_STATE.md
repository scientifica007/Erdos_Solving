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

current_phase: 8
current_stage: final-classification-complete
current_problem: 275
problem_status: proved-at-problem-level
blind_mode: false
reference_solution_accessed: true
proof_frozen: true

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
statement_source: official problem statement reproduced verbatim in problems/275/README.md
selection_reason: solved at problem level; short finite combinatorial statement; suitable calibration benchmark after #1125
current_substage: final-classification
candidate_proof: frozen-and-audited
known_lemmas:
  - LEMMA-275-001: nontrivial modulus admits a primitive root-of-unity encoding
  - LEMMA-275-002: an exponential polynomial with M distinct nonzero bases cannot have M consecutive zeros unless identically zero
  - LEMMA-275-003: the product encoding for r congruences has at most 2^r distinct bases
rejected_paths:
  - PATH-275-A: density/counting alone insufficient
  - PATH-275-B: parity reduction incomplete
  - PATH-275-C: minimal-counterexample reduction not completed

reference_findings:
  - The short 2020 proof by Balister, Bollobás, Morris, Sahasrabudhe and Tiba uses the same root-of-unity / finite-dimensional mechanism in polynomial form.
  - Our independent proof uses an equivalent exponential-polynomial formulation and a direct Vandermonde argument.
  - The original theorem was proved independently by Selfridge and Crittenden–Vanden Eynden.

final_classification: independent-rederivation-equivalent-core-mechanism
comparison_record: problems/275/comparison.md
lessons_record: problems/275/lessons-learned.md
next_action: use the successful #275 cycle to refine benchmark selection and proof classification; apply the new Invariant Hunt substage on the next benchmark.

## Last checkpoint

The current research log is `problems/275/research-log.md`.
The independent proof is frozen in `problems/275/frozen-proof.md` and passed `problems/275/audit.md`.
Historical/reference material was opened only after freeze.
The #1125 failed proof remains explicitly retracted in its own history and is preserved as a calibration failure.
