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
current_stage: historical-comparison-after-blind-failure
current_problem: 303
problem_status: proved-at-problem-level
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

## Current #303 state

canonical_statement: locked
statement_source: user-supplied canonical text
selection_reason: third benchmark; short finite-colouring/Diophantine statement; problem-level PROVED (LEAN); mathematically distinct from #1125 and #275
current_substage: historical-comparison
candidate_proof: none
known_lemmas:
  - LEMMA-303-001: algebraic parametrization via (b-a)(c-a)=a^2
  - LEMMA-303-002: it suffices to find n with c(n)=c(n+1)=c(n(n+1))
rejected_paths:
  - PATH-303-A: monochromatic unit square in exponent lattice is false for arbitrary finite grid colourings
  - PATH-303-B: direct polynomial van der Waerden invocation is not justified for the required zero-based configuration
reference_findings:
  - Brown–Rödl (1991) prove a general reciprocal-transfer theorem for homogeneous partition-regular systems.
  - Apply their theorem to the homogeneous linear equation x0=x1+x2, whose distinct monochromatic solvability follows from Rado's theorem.
  - Compactness plus the lcm construction converts a monochromatic solution in y_i to a monochromatic solution in z_i=S/y_i of the reciprocal equation.
comparison_record: problems/303/comparison.md
final_classification: blind-failure-reference-proved
next_action: consolidate lessons from #303 and update the project's benchmark-selection rules.

## Last checkpoint

The current research log is `problems/303/research-log.md`.
The blind attempt is explicitly closed as incomplete; its record must not be rewritten with hindsight.
The reference comparison is complete in `problems/303/comparison.md`.
