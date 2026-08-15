# Project State

> **Operational checkpoint synchronized on 2026-08-15.**
>
> Verified theorem-and-regression basis: commit `b2a05790b4ae466133e792ca6afa3eae730c0427`.
> Canonical pull-request CI run for that head: `31870476963` — **SUCCESS**.
> The run passed `lake exe mk_all --check`, reached all ten live Claim 4 implementation and regression modules, and completed the canonical `lake build` with 8739 jobs.

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
current_stage: claim4-claim5-interface-connection
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: exact-claim4-audited

current_target: connect-claim4-box-representatives-to-claim5-residue-interfaces
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked-under-explicit-residue-hypotheses
claim4_status: partial-machine-checked-through-application-residue-boxes
full_erdos678_formalization_status: not-proved

ci_status: green
canonical_ci_run: 31870476963
canonical_ci_commit: b2a05790b4ae466133e792ca6afa3eae730c0427
build_graph_audit: mk-all-check-passed
ci_blocker: none
next_action: translate the coefficients and weighted representatives produced by the verified application boxes into Claim5MediumResidues and Claim5SmallResidues, without yet claiming the quantitative representative bounds or separation condition
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
- a reachable assembled theorem-interface regression at `k = 2`;
- a generic finite coordinate-avoidance theorem from injectivity and a strict excluded-cardinality budget;
- positive and equality-budget negative regressions for that union bound;
- injectivity of multiplication modulo a coprime modulus over a short consecutive interval;
- its prime/nondivisibility specialization and the resulting prime-coordinate density theorem;
- a positive unit-multiplier regression and a negative non-unit regression;
- a named weighted-combination representation contract and a theorem transporting coordinate density through it;
- a positive one-coordinate weighted representation and a negative zero-weight regression.
- the concrete pair basis with weights `q,p`, inverse multipliers, its weighted representation theorem, and a density endpoint requiring no external representation contract;
- the concrete triple basis with weights `q*r,p*r,p*q`, inverse multipliers, its weighted representation theorem, and the analogous density endpoint;
- concrete pair/triple producer regressions, a full-contract negative regression for a divisible multiplier, and reachable pair/triple density-endpoint instantiations.
- the explicit translation from canonical residue zero to the paper coefficient `p`, with modular equivalence and coefficient bounds;
- the exact canonical exclusion sets for the two-prime `y` box and three-prime `x` box, with exact cardinalities;
- exact pair/triple search lengths equal to the summed exclusion budget plus one;
- `claim4_pair_y_box_density` and `claim4_triple_x_box_density`, which expose the paper's coefficient inequalities and weighted congruences;
- reachable concrete pair/triple application regressions and an equality-budget negative regression.

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

## Claim 4 module state

| Module | Current classification |
|---|---|
| `Claim4Density.lean` | reachable; generic strict finite union-bound theorem machine-checked |
| `Claim4DensityTests.lean` | reachable; positive and equality-budget negative regressions checked |
| `Claim4Modular.lean` | reachable; coprime/prime modular injectivity and prime-coordinate density checked |
| `Claim4ModularTests.lean` | reachable; unit positive and non-unit negative regressions checked |
| `Claim4Weighted.lean` | reachable; weighted representation contract and conditional consumer theorem checked |
| `Claim4WeightedTests.lean` | reachable; one-coordinate positive and zero-weight negative regressions checked |
| `Claim4CRT.lean` | reachable; pair/triple CRT weights, inverse multipliers, representation contracts, and unconditional density endpoints machine-checked |
| `Claim4CRTTests.lean` | reachable; pair/triple positive, full-contract negative, existence, and density-endpoint regressions checked |
| `Claim4ApplicationBoxes.lean` | reachable; paper/canonical coefficient translation, exact exclusions and cards, strict search lengths, and pair/triple application-box endpoints machine-checked |
| `Claim4ApplicationBoxesTests.lean` | reachable; endpoint convention, exact-cardinality, concrete pair/triple, and strict equality-budget regressions checked |

The table does **not** certify Cambie's full application of Claim 4. The pair/triple producer and exact application boxes are now discharged, but the selected coefficients and weighted representatives have not yet been translated into `Claim5MediumResidues` and `Claim5SmallResidues`. A generic arbitrary-cardinality CRT-basis theorem is also not present; only the two arities used by the current reconstruction are credited.

## Claim 4 CI disk incident — RESOLVED

Run `31853895481` reached `No update necessary`, built the then-live six Claim 4 modules, and reported `Build completed successfully (8735 jobs)`. The job then failed while GitHub's cache-save path exhausted the runner disk, so that run is correctly classified as red despite the successful Lean build.

The workflow now keeps `use-mathlib-cache: true` but sets the official `lean-action` input `use-github-cache: false`. Run `31870476963` preserves that configuration: `mk_all --check` passes, all ten current Claim 4 modules are reached, and the 8739-job build and job conclusion are successful.

## Current #678 mathematical state

Canonical statement: locked.

Verified:

- the valid concrete witness and its domain condition;
- rejection of the false scaling and `Q=P/M` constructions;
- all three range-specific Claim 5 valuation identities under explicit hypotheses;
- a single theorem assembling Claim 5 across every prime;
- nonzero side conditions and the final natural-number equality for Claim 5 under the explicit residue interfaces;
- the finite counting mechanism at the heart of Cambie's Claim 4;
- the modular injectivity obligation made explicit as coprimality/nondivisibility;
- the prime-coordinate density specialization;
- the weighted conclusion under an explicit representation contract.
- concrete pair and triple CRT weights and inverse multipliers;
- `Claim4WeightedRepresentation` for both concrete bases;
- pair/triple density endpoints that internalize the producer and expose only prime, coprimality, interval, and exclusion-budget hypotheses.
- the exact `x` and `y` application boxes in the paper's `{1,...,p}` coefficient convention;
- their exact canonical exclusion cardinalities and strict summed search budgets;
- concrete pair/triple density endpoints whose outputs satisfy the application coefficient inequalities.

Not yet proved in this repository:

- the connection from those boxes to `Claim5MediumResidues` and `Claim5SmallResidues`;
- quantitative representative bounds and the separation condition;
- quantitative LCM-ratio estimate;
- exact formal prime-density input;
- strong Cambie theorem;
- Erdős #678 itself.

## Required restart sequence

1. Identify the precise medium-prime and small-prime congruence data carried by the outputs of `claim4_pair_y_box_density` and `claim4_triple_x_box_density`.
2. Package those outputs into `Claim5MediumResidues` and `Claim5SmallResidues`, keeping every modulus and coefficient convention explicit.
3. Add reachable positive and malformed-interface regressions for the new connection.
4. Connect the constructed residue interfaces to `claim5_full_identity_of_residues`.
5. Add the quantitative representative bounds and separation condition required for the later `x,y` construction.
6. Pass the exact-head canonical CI gate and synchronize this checkpoint before opening the quantitative-finish phase.

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

The root README, this checkpoint, the active #678 roadmap, the problem index, the #678 README, the Cambie proof analysis, and the #678 lessons addendum are synchronized with the verified application-residue-box checkpoint. The decision register, agent guide, protocols, and historical snapshots were audited and remain current without semantic change.
