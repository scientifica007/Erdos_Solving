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
- For interval-based arguments, interval endpoints and interval length are part of the mathematics and must be formalized before algebraic simplification.
- A Lean file is considered part of the live formalization only when it is reachable from the canonical build graph and machine-checked by CI.

## Current project

current_problem: 678
current_phase: formalization-consolidation
current_stage: consolidation-gate
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: analyzed

current_target: Cambie-Claim-5
current_substage: consolidation-C1-to-C9
full_claim5_status: not-proved
full_erdos678_formalization_status: not-proved

ci_status: red
ci_blocker: Claim5_ProductValuation2-parser
consolidation_gate_status: in-progress
next_action: execute the Formalization Consolidation Gate before adding new Claim 5 mathematics

## Current #678 mathematical state

canonical_statement: locked

verified_results:
  - positive witness: `M(36,8) > M(47,9)` — machine-checked
  - domain condition: `47 >= 36 + 8` — machine-checked
  - negative regression: `¬ (M(495,8) > M(504,9))` — machine-checked

rejected_paths:
  - scaling identity `M(t*n,k) = t*M(n,k)` — false
  - proposed `t` / `Q=P/M` infinitude construction — rejected
  - proposed witness `(495,504,8)` — false
  - interval identification `[t,t+k]` for `M(t,k+1)` — false; the correct interval is `[t+1,t+k+1]`

current_reference_structure:
  - Claim 5: prime-by-prime arithmetic identity — current formalization target after consolidation
  - Claim 4: CRT-density combinatorial lemma — not started
  - CRT residue construction for `x,y` — not started
  - quantitative size estimate — not started
  - prime-density dependency — not formalized

## Current formalization state

environment:
  - Lean: 4.33.0
  - Lake: 5.0.0
  - Mathlib: configured through the current project lockfile
  - authoritative machine check: GitHub Actions

machine_checked_components:
  - concrete positive witness
  - concrete negative regression witness
  - Claim 5 core definitions/equality-by-prime-valuations scaffold
  - multiplicativity wrapper for `padicValNat` under the required prime/nonzero hypotheses

in_progress_components:
  - finite-product valuation lemma

not_started_components:
  - finite-LCM valuation theorem
  - reciprocal-LCM valuation theorem
  - Cambie Claim 5 prime-range cases
  - Cambie Claim 5 assembly
  - Claim 4
  - CRT construction
  - final quantitative theorem

## Formalization Consolidation Gate

The current mandatory sequence is:

1. C1 — repair `PROJECT_STATE.md`.
2. C2 — establish one canonical Lean formalization roadmap; mark the old test plan superseded.
3. C3 — replace ambiguous interval-offset abstractions with a length-based interval API.
4. C4 — define canonical `M(n,k)` from that interval API and connect it to independent explicit witness tests.
5. C5 — clean the live Lean tree; remove version-suffixed experimental files from the production path.
6. C6 — make the canonical Lake build graph cover every live formalization file.
7. C7 — rebuild the finite-product valuation lemma using robust explicit APIs.
8. C8 — restore `main` to green CI.
9. C9 — record the checkpoint and set the next target to finite-LCM valuation.

No new Claim 5 mathematics should be added before C8 passes.

## Historical #214 checkpoint

The previous active benchmark before #678 was #214.

status: independent-audit-failed
candidate_proof: retracted
rejected_path: `PATH-214-A` — red-square construction with one vertex `p in S`; invalid color-pattern inference

The previous freeze was incorrect because the alleged red square contained `p in S`, so it was not monochromatic red. The invalid frozen proof remains in Git history for provenance.

## Completed benchmark outcomes

- #1125: blind proof attempt failed; reference comparison completed; lessons preserved.
- #275: independent proof audited and frozen before reference access; later classified as equivalent core mechanism.
- #303: blind attempt failed/incomplete; reference proof by Brown–Rödl identified; lessons preserved.
- #246: rejected as benchmark under the literal published statement; integrity issue preserved.
- #214: independent candidate proof retracted after audit failure; history preserved.
