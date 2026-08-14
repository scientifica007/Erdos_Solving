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
current_phase: cambie-claim5
current_stage: large-prime-range
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
current_substage: B1-prime-greater-than-k
full_claim5_status: not-proved
full_erdos678_formalization_status: not-proved

ci_status: green
ci_blocker: none
consolidation_gate_status: passed
arithmetic_core_status: passed
latest_arithmetic_green_run: 31829795250
next_action: formalize Claim 5 prime range `p > k` (Roadmap B1)

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
  - Claim 5: prime-by-prime arithmetic identity — active reconstruction target
  - B1 `p > k` — current
  - B2 `sqrt(k) < p <= k` — not started
  - B3 `p <= sqrt(k)` — not started
  - Claim 4: CRT-density combinatorial lemma — not started
  - CRT residue construction for `x,y` — not started
  - quantitative size estimate — not started
  - prime-density dependency — not formalized

## Current formalization state

environment:
  - Lean: 4.33.0
  - Lake: 5.0.0
  - Mathlib: configured through the project lockfile
  - authoritative machine check: GitHub Actions
  - canonical check command: `lake build`

live_modules:
  - `Formalization/Erdos678/Intervals.lean`
  - `Formalization/Erdos678/ConcreteTests.lean`
  - `Formalization/Erdos678/ValuationBasic.lean`
  - `Formalization/Erdos678/ProductValuation.lean`
  - `Formalization/Erdos678/LCMValuation.lean`
  - `Formalization/Erdos678/ReciprocalLCMValuation.lean`
  - `Formalization/Erdos678/ValuationCounting.lean`

machine_checked_components:
  - length-based consecutive interval API
  - canonical `erdosM n k = lcm(n+1,...,n+k)` abstraction
  - abstraction agreement with independent explicit LCM oracles for the positive and negative regression cases
  - concrete positive witness and domain condition
  - concrete negative regression witness
  - equality of nonzero naturals from equality of all prime `padicValNat` values
  - multiplicativity/additivity wrapper for `padicValNat` under prime/nonzero hypotheses
  - finite-product `padicValNat` theorem for nonzero finite sets
  - finite-LCM `padicValNat` theorem via Mathlib `Finset.factorization_lcm`
  - exact product-over-LCM valuation formula via `Finset.lcm_dvd_prod` and `padicValNat.div_of_dvd`
  - prime-power divisibility-counting primitive for finite sets and consecutive intervals
  - finite-support theorem: counts vanish above the supremum of `p`-adic valuations

not_started_components:
  - Cambie Claim 5 prime range `p > k`
  - Cambie Claim 5 prime range `sqrt(k) < p <= k`
  - Cambie Claim 5 prime range `p <= sqrt(k)`
  - Cambie Claim 5 assembly
  - Claim 4
  - CRT construction
  - final quantitative theorem

safety_checks:
  - repository search found no `sorry`
  - repository search found no `axiom`
  - repository search found no `native_decide`

## Formalization Consolidation Gate — PASSED

Completed sequence:

1. C1 — repaired `PROJECT_STATE.md`.
2. C2 — established `LEAN_FORMALIZATION_ROADMAP.md` as the sole active execution roadmap and marked the old test plan superseded.
3. C3 — replaced ambiguous endpoint-offset intervals with a length-based API.
4. C4 — defined canonical `erdosM` and connected it to independent explicit positive/negative regression oracles.
5. C5 — cleaned the live Lean tree and removed version-suffixed/superseded experiment modules from production paths.
6. C6 — made the canonical Lake build graph authoritative; GitHub Actions no longer manually enumerates Lean files.
7. C7 — proved finite-product `padicValNat` additivity with the exact Mathlib hypotheses.
8. C8 — restored green CI; GitHub Actions run `31827146122` passed the canonical build graph.
9. C9 — checkpoint recorded and Phase A started.

## Phase A — Arithmetic Core — PASSED

- A1 finite-LCM valuation: machine-checked; true integration validated by run `31828058986` after importing the module from the canonical root.
- A2 reciprocal-LCM factor: machine-checked after normalizing `id`; corrected run `31829283998` passed.
- A3 prime-power divisibility counting and finite-support bound: machine-checked in run `31829795250`.

## Reusable lessons

- **Length-first interval API:** when an endpoint ambiguity has already caused a proof failure, represent consecutive blocks by `(start, length)`, not by an ambiguous endpoint offset.
- **Build-graph liveness:** a Lean module is live only if it is reachable from the canonical Lake build graph and therefore checked automatically by CI. A successful build before root import is not validation of a newly created module.
- **Kernel-checked closed regressions:** use kernel-checked `decide` for closed computational regressions when practical rather than `native_decide`, which expands the trusted computing base to the compiler.
- **API-driven proof repair:** when Mathlib rejects a guessed theorem name or rewrite shape, inspect the actual library API and reformulate the proof rather than stacking speculative rewrites.
- **Thin-wrapper policy:** prefer existing Mathlib structural theorems such as `Finset.factorization_lcm`, `Finset.lcm_dvd_prod`, and `padicValNat.div_of_dvd` over rebuilding standard number theory by bespoke induction.

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
