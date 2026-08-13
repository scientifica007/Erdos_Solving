# Project State

This file is the operational memory checkpoint for the project. Read it before resuming research work.

## Global operating rules

- Work directly on `main` unless the user explicitly requests otherwise.
- Do not treat GitHub as proof of truth by itself; repository state is the working record, not mathematical validation.
- Never call an AI-generated argument a proof until it has passed the required audit and proof-freeze gates.
- Distinguish problem-level status from variants, known sub-results, formalized statements, and formalized proofs.
- During a blind challenge, do not consult the historical solution, solution discussions, or papers specifically proving the target statement before proof freeze.
- If a candidate proof fails audit, revoke its freeze explicitly and record the failure; never silently overwrite the history.
- A benchmark with a defective or ambiguous canonical statement is paused before proof search; do not silently repair the statement from memory or from a reference proof.

## Current project

current_phase: 2
current_stage: blind-independent-solving
current_problem: 225
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

## Current #225 state

canonical_statement: locked
statement_source: benchmark README; problem-level statement verified from erdosproblems.com
selection_reason: fourth benchmark; cleaner than #246, one-line construction problem, problem-level PROVED (LEAN), no specialized machinery expected for the blind attempt
current_substage: initial-construction-search
candidate_proof: none
known_lemmas: []
rejected_paths: []
reference_findings: []
comparison_record: pending
next_action: find an explicit entire non-linear function preserving rationality in both directions

## Benchmark #246 status

#246 has been rejected as a benchmark under the currently published literal statement because $a=1,b=3$ satisfies $(a,b)=1$ but gives only subset sums with ternary digits in $\{0,1\}$, contradicting completeness. The issue is recorded in `problems/246/research-log.md`. No historical proof was used to manufacture a repair.

## Previous completed benchmark outcomes

- #1125: blind proof attempt failed; reference comparison completed; lessons preserved.
- #275: independent proof audited and frozen before reference access; later classified as equivalent core mechanism.
- #303: blind attempt failed/incomplete; reference proof by Brown–Rödl identified; lessons preserved.

## Last checkpoint

The current research log is `problems/225/research-log.md`.
Blind mode is ON. Historical solution, solution discussion, and formal proof for #225 have not been consulted.
