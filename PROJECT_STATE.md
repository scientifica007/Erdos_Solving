# Project State

This file is the operational memory checkpoint for the project. Read it before resuming research work.

## Global operating rules

- Work directly on `main` unless the user explicitly requests otherwise.
- Do not treat GitHub as proof of truth by itself; repository state is the working record, not mathematical validation.
- Never call an AI-generated argument a proof until it has passed the required audit and proof-freeze gates.
- Distinguish problem-level status from variants, known sub-results, formalized statements, and formalized proofs.
- During a blind challenge, do not consult the historical solution, solution discussions, or papers specifically proving the target statement before proof freeze.
- If a candidate proof fails audit, revoke its freeze explicitly and record the failure; never silently overwrite the history.
- A benchmark with a defective or ambiguous canonical statement is paused before proof search.
- For coloring arguments, audit must verify the color of every constituent of every claimed monochromatic object.

## Current project

current_phase: 4
current_stage: independent-audit-failed
current_problem: 214
problem_status: proved-at-problem-level
blind_mode: true
reference_solution_accessed: false
proof_frozen: false

## Current #214 state

canonical_statement: locked
current_substage: candidate-proof-retracted
candidate_proof: retracted
known_lemmas: []
rejected_paths:
  - PATH-214-A: red-square construction with one vertex p in S; invalid color-pattern inference
reference_findings: []
comparison_record: pending
next_action: either restart blind solving from the counterexample to PATH-214-A or explicitly close the blind attempt; do not open reference solution until a valid freeze or explicit failure declaration.

## Audit failure

The previous freeze was incorrect. The alleged red square contained p in S, so it was not monochromatic red. Freeze was revoked. The invalid frozen proof remains in Git history for provenance.

## Completed benchmark outcomes

- #1125: blind proof attempt failed; reference comparison completed; lessons preserved.
- #275: independent proof audited and frozen before reference access; later classified as equivalent core mechanism.
- #303: blind attempt failed/incomplete; reference proof by Brown–Rödl identified; lessons preserved.
- #246: rejected as benchmark under the literal published statement; integrity issue preserved.
