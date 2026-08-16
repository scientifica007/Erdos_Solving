# Project State

> **Operational checkpoint synchronized on 2026-08-16.**
>
> D4 final reachable repair: commit `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495` — **SUCCESS**, `No update necessary`, **8766 jobs**.
> E1 mathematical exit: commit `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909` — **SUCCESS**, `No update necessary`, **8770 jobs**.
> E2 prime-density exit: commit `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856` — **SUCCESS**, `No update necessary`, **8800 jobs**.
> E3 strong Cambie exit: commit `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891` — **SUCCESS**, `No update necessary`, **8804 jobs**.
> E4 / full Erdős #678 mathematical exit: commit `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757` — **SUCCESS**, `No update necessary`, **8806 jobs**.
>
> **Phases D and E1–E4 are mathematically closed. Erdős Problem #678 is fully formalized in the reachable Lean graph on the E4 branch.**

This file is the authoritative operational memory checkpoint. It must agree with the reachable Lean graph and the latest credited CI evidence.

## Global operating rules

- `DEC-011` supersedes `DEC-004`: `main` is the stable integration branch; substantive work uses a dedicated branch and pull request.
- Do not merge a mathematical change unless canonical Lean CI is green for the credited pull-request head.
- State documents travel in the same pull request and must be synchronized before merge.
- Do not treat source presence, a file name, GitHub metadata, or an AI-generated argument as proof by itself.
- Distinguish problem-level status, known sub-results, formalized statements, formalized proofs, external-proof reconstruction, and independent discovery.
- Preserve rejected paths, revoked freezes, contamination events, and negative regressions.
- For interval arguments, endpoints and length are mathematical data and must remain explicit.
- A Lean module is live only when `lake exe mk_all --check` accepts the aggregator and canonical build reaches the module.

## Current project

```yaml
current_problem: 678
current_phase: cambie-quantitative-finish
current_stage: E4-complete-documentation-sync
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: proved-machine-checked-on-e4-branch
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: reconstructed-through-final-index-translation

current_target: documentation-sync-and-review-ready-stacked-pr-chain
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked
claim4_status: machine-checked
lcm_ratio_status: machine-checked-eventually-for-every-positive-C
full_erdos678_formalization_status: proved-machine-checked

ci_status: green-through-E4-mathematical-exit
canonical_ci_run: 31976903757
canonical_ci_commit: 54fe163f8a70b736255bea7ffc1a4cf8d4fcb941
canonical_build_jobs: 8806
build_graph_audit: mk-all-check-passed
ci_blocker: none
phase_e_gate: closed
next_action: synchronize documentation, re-run canonical CI for documentation head, then review stacked PRs without rewriting mathematical layers
```

## Trusted machine-checked state

### Arithmetic, Claim 5, and Claim 4 / Phase D

The reachable graph machine-checks:

- length-based consecutive intervals and canonical `erdosM`;
- the valid finite witness `M(36,8) > M(47,9)` and the rejected `(495,504,8)` negative regression;
- finite-product, finite-LCM, reciprocal-LCM, and prime-power valuation primitives;
- Claim 5 in the large, medium, and capped small-prime ranges;
- explicit medium/small residue interfaces and the assembled natural-number Claim 5 identity;
- the finite union-bound, modular, weighted CRT, pair/triple CRT-basis producers, exact application boxes, scales, factorizations, and dependent placement;
- Cambie's division-safe `gap`, `yLower`, `yUpper`, full-scale LCM identity, target-window room, small-scale gap, sharp-prime-window budgets, and the final D4 sharp representative endpoint.

D4 final reachable checkpoint: `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495`, **8766 jobs**.

### E1 — quantitative LCM-ratio estimate — PASSED

Machine-checked components include:

- `intervalLCM_dvd_intervalProd`;
- cancellation-safe `claim5_cross_multiplication`;
- `claim5_lcm_lt_of_product_lt`;
- interval-product recursion and the universal `(k+1)^k < 3*k^k` bound;
- the target/closeness prefix-product comparison;
- the full product inequality and transfer to LCMs;
- `claim4_exists_cambie_lcm_ratio_of_sharp_windows`.

E1 exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909`, **8770 jobs**.

### E2 — sharp prime density — PASSED

E2 no longer contains an opaque prime-existence hypothesis.

The reachable graph machine-checks:

- `Claim4CambieFiveStripPrimeData`, reducing distinctness to five disjoint strips;
- a natural-number `Claim4RelativePrimeProvider q` with an explicit threshold and prime-after theorem;
- conversion of multiplicative relative prime intervals to additive strips;
- application of one provider at denominator `320*C` to the three near-`k` and two near-`k/2` strips;
- the pinned dependency `AxiomMath/PrimeNumberTheoremAnd` at revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` under project Mathlib `v4.33.0`;
- `claim4RelativePrimeProviderOfPNT`, derived from the imported `prime_between` consequence;
- `claim4_exists_cambie_lcm_ratio_eventually_of_pnt`.

Checkpoints:

- five-strip arithmetic: `81cf4b2303a4a93bf30d2fcb322b810c754530f3`, run `31972724132`, **8774 jobs**;
- provider→five-strips: `14c9e5e8df00de4e129d142e472b3c9d91fd1c00`, run `31975082883`, **8778 jobs**;
- E2 PNT exit: `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856`, **8800 jobs**.

No custom prime-density axiom is introduced.

### E3 — strong eventual Cambie theorem — PASSED

The elementary large-`k` package is discharged independently by the fourth binomial coefficient:

- `claim4CambieLargeKThreshold C = max 9 (3840*C + 3)`;
- `claim4CambieLargeKData_of_threshold` proves `20*C*k^2*(k+1) ≤ 2^k` above that threshold using Mathlib's binomial bounds;
- `cambie_lcm_ratio_eventually` combines the growth threshold with E2's PNT threshold.

E3a checkpoint: `58b870511588e6f9100443d2250024031bfaa3fd`, run `31974295910`, **8776 jobs**.

E3 exit: `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891`, **8804 jobs**.

### E4 — canonical Erdős #678 theorem — PASSED

`Erdos678Final.lean` retains enough placement data to perform the canonical off-by-one translation safely:

- `claim4_cambie_k_lt_x_of_bounds` recovers `k < x` from the verified lower target and closeness bounds;
- strengthened sharp-window, five-strip, provider, and PNT endpoints preserve `k < x`;
- `cambie_lcm_ratio_eventually_with_large_start` gives the strong eventual comparison with large starts;
- `erdos678_unbounded_witnesses` proves that for every `B : ℕ` there exist `n m k` with
  `B ≤ k`, `3 ≤ n`, `3 ≤ m`, `3 ≤ k`, `n+k ≤ m`, and
  `erdosM m (k+1) < erdosM n k`;
- `erdos678_good_lengths_infinite` proves the set of block lengths admitting canonical witnesses is infinite.

This is the requested infinite-family conclusion for Erdős Problem #678.

E4 mathematical exit: `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757`, `No update necessary`, **8806 jobs**. The build reached `Claim4RelativePrimePNT`, `CambieStrongTheorem`, `Erdos678Final`, their regression modules, and the top-level `Formalization` target.

## Verification chronology

| Substep | Exact head | Canonical run | Result |
|---|---|---:|---|
| D4 final reachable repair | `eb5ffebffcb199cc76c83a941da955f4ecfebde5` | `31963803495` | SUCCESS, 8766 jobs |
| E1 mathematical exit | `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a` | `31968714909` | SUCCESS, 8770 jobs |
| E2c five-strip arithmetic | `81cf4b2303a4a93bf30d2fcb322b810c754530f3` | `31972724132` | SUCCESS, 8774 jobs |
| E3a elementary growth | `58b870511588e6f9100443d2250024031bfaa3fd` | `31974295910` | SUCCESS, 8776 jobs |
| E2d provider→five-strips | `14c9e5e8df00de4e129d142e472b3c9d91fd1c00` | `31975082883` | SUCCESS, 8778 jobs |
| E2 PNT exit | `6d06401bd2ee3aca116fd4ac592bf14d5e43694c` | `31975809856` | SUCCESS, 8800 jobs |
| E3 strong Cambie exit | `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94` | `31975821891` | SUCCESS, 8804 jobs |
| E4 / full #678 exit | `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941` | `31976903757` | SUCCESS, 8806 jobs |

Red intermediate runs are diagnostic only. They do not reduce the status of later exact-head green checkpoints.

## Exact boundary after E4

The mathematical reconstruction of Erdős #678 is complete on the E4 branch. There is no remaining mathematical or analytic gap in the formalized proof chain.

Still deliberately not claimed:

- a generic arbitrary-cardinality CRT-basis theorem; only the pair/triple arities actually needed by Cambie's argument are formalized;
- that the earlier independent proof attempt was valid; it remains rejected because it used the false scaling identity `M(t*n,k) = t*M(n,k)` and later a wrong interval in a `Q=P/M` construction.

## Required restart sequence

1. Verify the active E4 documentation head and its canonical CI.
2. Read this file and `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
3. Do not reopen D4 or E1–E4 mathematics unless a concrete regression is found.
4. Finish documentation synchronization and stacked-PR review hygiene.
5. Preserve the pinned PNT+ revision and all negative regressions when integrating.

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

`PROJECT_STATE.md` now records the E4 mathematical exit. The active roadmap, root README, problem index, and `problems/678/README.md` must be synchronized on this same E4 PR head, followed by one final canonical CI run before documentation closure is credited.
