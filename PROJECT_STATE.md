# Project State

> **Operational checkpoint synchronized on 2026-08-16.**
>
> D4 mathematical exit: commit `0696e6474ebaf6deec2303f38c862842da3b28e2`, canonical run `31959479154` — **SUCCESS**.
> D4 final reachable repair: commit `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, canonical run `31963803495` — **SUCCESS**, `No update necessary`, **8766 jobs**.
> E1a cancellation-safe algebra: commit `36b91df00a7a25d20a635256a8533a7d9030714d`, canonical run `31963812320` — **SUCCESS**, `No update necessary`, **8768 jobs**.
> E1 mathematical exit: commit `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, canonical run `31968714909` — **SUCCESS**, `No update necessary`, **8770 jobs**.
>
> **Phase D and Phase E1 are closed. Phase E2 is the active formalization stage.**

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
current_phase: cambie-quantitative-finish
current_stage: E2-sharp-prime-density
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: quantitative-claim4-claim5-and-lcm-ratio-audited

current_target: formalize-or-import-prime-density-producing-the-five-sharp-window-primes-for-all-sufficiently-large-k
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked-under-explicit-residue-hypotheses
claim4_status: passed-through-sharp-cambie-dependent-placement
lcm_ratio_status: machine-checked-under-explicit-large-k-and-sharp-prime-window-data
full_erdos678_formalization_status: not-proved

ci_status: green-through-E1-mathematical-exit
canonical_ci_run: 31968714909
canonical_ci_commit: 3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a
build_graph_audit: mk-all-check-passed
ci_blocker: none-for-E2-entry
phase_e_gate: open
next_action: formalize E2 sharp-prime-density existence; do not reopen E1 or hide prime existence behind an axiom
```

## Trusted machine-checked state

### Arithmetic and Claim 5

The reachable graph machine-checks:

- length-based consecutive intervals and canonical `erdosM`;
- the positive witness `M(36,8) > M(47,9)` and the rejected `(495,504,8)` negative regression;
- finite-product, finite-LCM, reciprocal-LCM, and prime-power valuation primitives;
- Claim 5 in the large, medium, and capped small-prime ranges;
- explicit `Claim5MediumResidues` and `Claim5SmallResidues` interfaces;
- the assembled prime-by-prime Claim 5 valuation identity;
- the final natural-number Claim 5 identity under those residue interfaces;
- positive and negative boundary regressions.

### Claim 4 / Phase D — PASSED

The complete finite arithmetic/CRT construction is machine-checked:

- strict finite union bound, modular injectivity, prime-coordinate density, and weighted CRT;
- concrete pair/triple CRT basis producers;
- exact paper/canonical residue boxes, exclusion cardinalities, and exact search lengths;
- D3 scaled representatives `y = z*Ny`, `x = 1 + z*Nx`, and derivation of both Claim 5 residue interfaces;
- constructed scales `claim4SmallScale`, `claim4XScale`, `claim4YScale` with all support/unit obligations;
- `Claim4PrimeWindowData` and the broad medium/search obligations;
- `claim4FullScale k = Nat.lcmUpto k = intervalLCM 1 k` and the exact `x`/`y` scale factorizations;
- canonical and dependent placement, including `x+k<y<x+gap`;
- division-safe Cambie parameters `gap`, `yLower`, `yUpper`;
- `claim4SmallScale_gap_of_nine_le`;
- `Claim4CambieLargeKData` and target-window room;
- `Claim4CambieSharpPrimeWindowData` and both exact sharp search budgets;
- `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows`;
- closed regressions, including `C=1, k=1000, s=23` with `x` primes `977,983,991` and `y` primes `503,509`.

### Phase E1 — LCM-ratio estimate — PASSED

The reachable graph now machine-checks the complete quantitative bridge from the D4 representatives to the strict LCM comparison:

- `intervalLCM_dvd_intervalProd` — exact divisibility of an interval LCM into its product;
- `claim5_cross_multiplication` — cancellation-safe conversion of the Claim 5 quotient identity to a product equality using exact divisibility;
- `claim5_lcm_lt_of_product_lt` — strict inequality transfer from `C * Prod_y < M * Prod_x` to `C * LCM_y < LCM_x` under explicit nonzero hypotheses;
- zero-boundary and positive regressions for the cancellation layer;
- `intervalProd_eq_prod_range` and `intervalProd_succ`;
- the universal bound `succ_pow_lt_three_mul_pow : 0 < k → (k+1)^k < 3*k^k`;
- `claim4CambieGap_mul_succ_le_yLower`;
- `claim4_cambie_prefix_product_lt_three` from the verified lower target and closeness bounds;
- `claim4_cambie_product_lt_fullScale` and `claim4_cambie_product_lt_initialLCM`;
- `claim5_lcm_lt_of_cambie_bounds`;
- final E1 endpoint `claim4_exists_cambie_lcm_ratio_of_sharp_windows`, which composes the verified D4 sharp representative theorem with Claim 5 and proves
  `C * intervalLCM y (k+1) < intervalLCM x k`.

E1a checkpoint: `36b91df00a7a25d20a635256a8533a7d9030714d`, run `31963812320`, **8768 jobs**.

E1 mathematical exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909`, `No update necessary`, **8770 jobs**.

## Verification chronology

| Substep | Exact head | Canonical run | Result |
|---|---|---:|---|
| D4a/D4b — scales/support/wrapper | `a259da8a6a42512a347f34b15de9b0be1e2fd9af` | `31947099017` | SUCCESS, 8745 jobs |
| D4c — broad prime-window contract | `eef7d931e4984110222aa72b6b2df2fa5d70928b` | `31948527075` | SUCCESS, 8747 jobs |
| D4d — factorization/placement | `b0914c876732d0f0791d71a74289c6cbae1d4466` | `31949164598` | SUCCESS, 8750 jobs |
| D4e — dependent close/separated reps | `72432d4b3d18f8772cc0c6371a3f331222fb5700` | `31952559027` | SUCCESS, 8754 jobs |
| D4f room reduction | `0e9ff533671dd974c5aad9100b321c2e4c24da85` | `31956361984` | SUCCESS, 8760 jobs |
| D4f small-scale gap | `6386278dc00d19dceec346524f92139ac0f9449c` | `31957062773` | SUCCESS, 8762 jobs |
| D4 mathematical exit | `0696e6474ebaf6deec2303f38c862842da3b28e2` | `31959479154` | SUCCESS, 8766 jobs |
| D4 final reachable repair | `eb5ffebffcb199cc76c83a941da955f4ecfebde5` | `31963803495` | SUCCESS, 8766 jobs |
| E1a cancellation-safe algebra | `36b91df00a7a25d20a635256a8533a7d9030714d` | `31963812320` | SUCCESS, 8768 jobs |
| E1 mathematical exit | `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a` | `31968714909` | SUCCESS, 8770 jobs |

Red intermediate runs are diagnostic only. They do not reduce the status of later exact-head green checkpoints.

## Exact boundary after E1

D4 and E1 are complete under explicit `Claim4CambieLargeKData` and `Claim4CambieSharpPrimeWindowData`.

The remaining analytical gap is not hidden: `Claim4CambieSharpPrimeWindowData` contains the primality and sharp-location facts for five special primes. Their existence for every sufficiently large `k` has **not** yet been formalized.

Still not proved:

1. a formal prime-density theorem producing the five required sharp-window primes for every fixed positive `C` and all sufficiently large `k` — **E2, current**;
2. the strong Cambie theorem after combining E1 with that E2 existence theorem — **E3**;
3. Erdős #678 via `C=1` and the final index translation — **E4**.

A generic arbitrary-cardinality CRT-basis theorem is also not claimed; only the two arities used by Cambie's proof are formalized.

## Phase E — quantitative finish — CURRENT

### E1 — LCM-ratio estimate — PASSED / MACHINE-CHECKED

E1 uses cancellation-safe natural-number algebra, not informal field manipulation. Its final theorem is `claim4_exists_cambie_lcm_ratio_of_sharp_windows`.

### E2 — sharp prime-density existence — CURRENT / SOLE NEXT ACTION

Formalize or import a theorem supplying the five primes required by `Claim4CambieSharpPrimeWindowData` for every fixed positive `C` and all sufficiently large `k`.

The intended interface must provide a slack `s` and five pairwise distinct primes with the already-fixed sharp inequalities, including `40*C*(s+1) ≤ k`. E2 must produce these inputs without changing the D4/E1 contracts and without introducing an uncredited axiom.

First inspect the pinned Mathlib graph for available prime-counting/PNT results and identify the smallest theorem sufficient to obtain:

- two distinct primes immediately above `k/2` inside the D4 `y` strip;
- three distinct primes immediately below `k` inside the D4 `x` strip;
- a single slack parameter satisfying the D4 budget.

### E3/E4 — strong Cambie theorem and Erdős #678 — PENDING

Combine E1 and E2, then take `C=1` and translate interval starts to the canonical problem variables.

## Required restart sequence

1. Verify the active branch/PR head and its exact canonical CI.
2. Read this file and `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
3. Start E2 by auditing available formal prime-density/PNT theorems against the exact `Claim4CambieSharpPrimeWindowData` inequalities.
4. Keep the prime-existence theorem separate from the already closed D4 and E1 arithmetic layers.
5. Add explicit finite/threshold regressions before composing E2 into E3.

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

The root README, this checkpoint, the active #678 roadmap, the problem index, and the #678 README are being synchronized to identify **E2 as current** and E1 as passed. This synchronized head must pass canonical exact-head CI before the transition is credited for review readiness.
