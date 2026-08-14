# Project State

> **Operational checkpoint synchronized on 2026-08-14.**
>
> Verified code-state basis: commit `61431b8881e481a56d06e00d702eabb6b64ae471`.
> Canonical pull-request CI run: `31847883886` — **SUCCESS**.
> The run passed `lake exe mk_all --check`, reached `Claim5Assembly.lean` and `Claim5AssemblyTests.lean`, and completed the canonical `lake build` with 8729 jobs.

This file is the authoritative operational memory checkpoint. It must agree with the reachable Lean graph and the latest credited CI evidence.

## Global operating rules

- `DEC-011` supersedes `DEC-004`: `main` is the stable integration branch; substantive work uses a dedicated branch and pull request.
- Do not merge a mathematical change unless the canonical Lean check is green for the exact pull-request head.
- State documents travel in the same pull request and must be synchronized before merge.
- Do not treat GitHub, a file name, or an AI-generated argument as proof by itself.
- Distinguish problem-level status, known sub-results, formalized statements, formalized proofs, external-proof reconstruction, and independent discovery.
- Preserve rejected paths, revoked freezes, contamination events, and negative regressions.
- For interval arguments, endpoints and length are mathematical data and must be fixed before algebra.
- A Lean module is live only when `lake exe mk_all --check` accepts the aggregator and the canonical build reaches the module.
- After every material transition, update this file, the active roadmap, and every README presenting current status.

## Current project

```yaml
current_problem: 678
current_phase: cambie-claim4
current_stage: claim4-crt-formalization
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: analyzed

current_target: formalize-claim4-crt-residue-construction
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked-under-explicit-residue-hypotheses
full_erdos678_formalization_status: not-proved

ci_status: green
canonical_ci_run: 31847883886
canonical_ci_commit: 61431b8881e481a56d06e00d702eabb6b64ae471
build_graph_audit: mk-all-check-passed
ci_blocker: none
next_action: formalize Claim 4 and construct residues satisfying the two verified Claim 5 interfaces
```

## Verified small-prime transition

The previous red graph contained two visible failures and one masked downstream failure. They were repaired without weakening theorem statements:

1. `SmallPrimeWindows.lean`: used the symmetry of the available equality.
2. `SmallPrimeValuation.lean`: replaced an opaque `omega` step over natural subtraction with `Nat.sub_pos_iff_lt`.
3. `SmallPrimeSup.lean`: supplied the exact finset and summand to `Finset.single_le_sum`, removing an unresolved metavariable.

Verification chronology:

- run `31844342803` first built the complete small-prime graph successfully;
- run `31844727128` correctly rejected an out-of-date hand-maintained aggregator after `mk_all-check` was enabled;
- run `31845035150` correctly rejected non-reducible direct `decide` tests for `padicValNat`;
- run `31845987598` accepted the generated aggregator, theorem-instantiation boundary tests, and the full canonical build.

## Trusted machine-checked state

The reachable graph now machine-checks:

- length-based consecutive intervals and canonical `erdosM`;
- positive witness `M(36,8) > M(47,9)` and negative regression for `(495,504,8)`;
- equality of nonzero naturals from all prime `padicValNat` values;
- finite-product, finite-LCM, and product-over-LCM valuation lemmas;
- prime-power divisibility counting primitives;
- Claim 5 large-prime range `p > k`;
- Claim 5 medium-prime range `p ≤ k < p²`;
- capped small-prime congruence, window, supremum, initial-LCM, and valuation lemmas;
- integrated theorem `claim5_small_prime_range`;
- concrete theorem-instantiation regressions at `e = 1` and `e = 0`;
- a negative congruence regression showing that the `y` residue hypothesis is active;
- explicit medium- and small-prime residue interfaces for the future Claim 4 / CRT layer;
- nonzero interval-product, interval-LCM, and exact quotient lemmas;
- the prime-by-prime assembled Claim 5 valuation identity;
- the final Claim 5 natural-number identity under the explicit residue hypotheses;
- a reachable assembled theorem-interface regression at `k = 2`.

## Claim 5 module state

| Module | Current classification |
|---|---|
| `SmallPrimeRange.lean` | reachable and machine-checked |
| `SmallPrimeInitialLCM.lean` | reachable and machine-checked |
| `SmallPrimeWindows.lean` | repaired, reachable, and machine-checked |
| `SmallPrimeValuation.lean` | repaired, reachable, and machine-checked |
| `SmallPrimeSup.lean` | repaired, reachable, and machine-checked |
| `SmallPrimeClaim5.lean` | reachable and machine-checked |
| `SmallPrimeTests.lean` | reachable; positive boundary and negative congruence regressions checked |
| `Claim5Assembly.lean` | reachable; all-range valuation assembly, nonzero bridge, and natural identity checked |
| `Claim5AssemblyTests.lean` | reachable; assembled theorem interface checked at `k = 2` |

## Current #678 mathematical state

Canonical statement: locked.

Verified:

- the valid concrete witness and its domain condition;
- rejection of the false scaling and `Q=P/M` constructions;
- all three range-specific Claim 5 valuation identities under explicit hypotheses;
- a single theorem assembling Claim 5 across every prime;
- nonzero side conditions and the final natural-number equality for Claim 5 under the explicit residue interfaces.

Not yet proved in this repository:

- Claim 4 CRT-density lemma;
- CRT construction of `x` and `y`;
- quantitative LCM-ratio estimate;
- exact formal prime-density input;
- strong Cambie theorem;
- Erdős #678 itself.

## Required restart sequence

1. Extract the exact Claim 4 / CRT-density statement used by Cambie and state it without importing Claim 5 conclusions.
2. Define admissible residue boxes that produce `Claim5MediumResidues` and `Claim5SmallResidues`.
3. Formalize the CRT combination and prove existence of representatives satisfying both interfaces.
4. Add the quantitative bounds and separation condition required for the later `x,y` construction.
5. Connect the constructed residues to `claim5_full_identity_of_residues`.
6. Add reachable positive and negative regressions, then run the canonical CI gate.
7. Synchronize this checkpoint and the roadmap before opening the quantitative-finish phase.

## Completed benchmark outcomes

- #18: known sub-result `h(n!) ≤ n-1` independently reconstructed; parent problem not solved.
- #214: candidate retracted; restart incomplete; blind phase later terminated by contamination.
- #225: inactive with no candidate proof; blind boundary remains intact if resumed.
- #246: paused because the copied benchmark statement is defective.
- #275: independent proof audited and frozen before reference access; equivalent core mechanism to the reference proof.
- #303: blind attempt incomplete; Brown–Rödl reference comparison completed.
- #447: contaminated challenge; not an active blind benchmark.
- #1125: blind proof attempt failed; historical/modern reconstruction completed.

## Documentation synchronization status

The root README, this checkpoint, the active #678 roadmap, the problem index, the #678 README, and the #678 lessons addendum are synchronized with the verified full-Claim-5 checkpoint. The decision register and agent guide remain current and require no semantic change.
