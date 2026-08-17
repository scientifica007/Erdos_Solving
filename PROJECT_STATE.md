# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> Erdős Problem #678 is mathematically closed, machine-checked, and integrated into `main` through PR #17.
>
> - D4 final reachable repair: `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495` — **SUCCESS**, **8766 jobs**.
> - E1 mathematical exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909` — **SUCCESS**, **8770 jobs**.
> - E2 prime-density exit: `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856` — **SUCCESS**, **8800 jobs**.
> - E3 strong Cambie exit: `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891` — **SUCCESS**, **8804 jobs**.
> - E4 mathematical exit: `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757` — **SUCCESS**, **8806 jobs**.
> - Final synchronized E4 head: `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`, run `31977861568` — **SUCCESS**, **8806 jobs**.
> - Integration: PR #17 merged into `main` as `8fd1b20541ac7782f52429db3a2cc4c887547372` on 2026-08-17.
> - Post-merge `main` verification: run `32011189766` was started for the merge commit; credit it only after GitHub reports a successful conclusion.

This file is the authoritative operational restart checkpoint. Mathematical credit comes from exact reachable Lean builds, not from source presence or GitHub metadata alone.

## Global operating rules

- `DEC-011` supersedes `DEC-004`: `main` is the stable integration branch; substantive work uses a dedicated branch and pull request.
- Do not merge a mathematical change unless canonical Lean CI is green for the credited pull-request head.
- State documents must agree with the reachable Lean graph and credited CI evidence.
- Do not treat a file name, source presence, GitHub metadata, or an AI-generated argument as proof by itself.
- Distinguish external problem status, project reconstruction, independent discovery, and machine verification.
- Preserve rejected paths, negative regressions, contamination events, and revoked claims.
- For interval arguments, endpoints and length remain explicit mathematical data.
- A Lean module is live only when the canonical aggregator reaches it and the build succeeds.

## Current project

```yaml
current_problem: 678
current_phase: closed
current_stage: integrated-main-postmerge-verification
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: true

external_problem_status: proved
project_reconstruction_status: proved-machine-checked-integrated-main
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: reconstructed-through-final-index-translation

current_target: close-operational-tail-and-archive-678
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked
claim4_status: machine-checked
lcm_ratio_status: machine-checked-eventually-for-every-positive-C
full_erdos678_formalization_status: proved-machine-checked-integrated-main

premerge_canonical_ci_run: 31977861568
premerge_canonical_ci_commit: eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f
premerge_canonical_build_jobs: 8806
main_integration_commit: 8fd1b20541ac7782f52429db3a2cc4c887547372
main_postmerge_ci_run: 32011189766
main_postmerge_ci_status: pending-at-this-checkpoint
build_graph_audit: mk-all-check-passed-on-final-e4-head
ci_blocker: none-known
phase_e_gate: closed
next_action: confirm post-merge main CI, finish non-blocking PR hygiene, archive #678, then select the next active problem
```

## Trusted machine-checked result for Erdős #678

The reachable formal graph proves the complete canonical infinite-family conclusion.

### Arithmetic, Claim 5, and Claim 4 / Phase D

Machine-checked components include:

- length-based consecutive intervals and canonical `erdosM`;
- the valid finite witness `M(36,8) > M(47,9)`;
- the rejected `(495,504,8)` candidate retained as a negative regression;
- finite-product, finite-LCM, reciprocal-LCM, and prime-power valuation primitives;
- Claim 5 in all prime ranges and the assembled natural-number identity;
- finite density, modular and weighted CRT arguments;
- pair/triple CRT-basis producers and exact residue boxes;
- constructed scales, factorizations, dependent placement, target windows, and sharp prime-window budgets.

D4 final reachable checkpoint: `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495`.

### E1 — quantitative LCM-ratio estimate — PASSED

The graph proves exact interval-LCM divisibility, cancellation-safe cross multiplication, product comparison, and strict transfer from product inequalities to LCM inequalities.

E1 exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909`.

### E2 — sharp prime density — PASSED

No opaque prime-existence hypothesis remains. The proof pins `AxiomMath/PrimeNumberTheoremAnd` at revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`, derives a natural-number relative-prime provider from its kernel-checked `prime_between` consequence, and converts that provider to the five required additive strips.

E2 exit: `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856`.

No custom prime-density axiom is introduced.

### E3 — strong eventual Cambie theorem — PASSED

The elementary large-`k` condition is discharged with

`claim4CambieLargeKThreshold C = max 9 (3840*C + 3)`

and combined with the PNT threshold in `cambie_lcm_ratio_eventually`.

E3 exit: `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891`.

### E4 — canonical Erdős #678 theorem — PASSED

`Erdos678Final.lean` performs the off-by-one-safe translation from interval starts to canonical variables. In particular:

- `claim4_cambie_k_lt_x_of_bounds` recovers `k < x` from verified bounds;
- `cambie_lcm_ratio_eventually_with_large_start` retains sufficient start information;
- `erdos678_unbounded_witnesses` proves that for every `B : ℕ` there exist `n m k` with `B ≤ k`, `3 ≤ n,m,k`, `n+k ≤ m`, and `erdosM m (k+1) < erdosM n k`;
- `erdos678_good_lengths_infinite` proves that the set of valid block lengths is infinite.

E4 mathematical exit: `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757`.

Final synchronized E4 head: `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`, run `31977861568`.

## Integration state

PR #17, `agent/erdos678-e4-index-translation-20260816` → `main`, was merged on 2026-08-17 as merge commit `8fd1b20541ac7782f52429db3a2cc4c887547372`.

The previous stacked checkpoint PRs #7–#12 and #14–#16 were closed after integration because their content is preserved in the merged history. PR #13 is a diagnostic-only compatibility probe and is non-blocking; it was never intended as the integration vehicle.

No mathematical layer should be reopened unless a concrete regression is found.

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
| E4 mathematical exit | `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941` | `31976903757` | SUCCESS, 8806 jobs |
| E4 synchronized documentation head | `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f` | `31977861568` | SUCCESS, 8806 jobs |
| merged `main` | `8fd1b20541ac7782f52429db3a2cc4c887547372` | `32011189766` | post-merge verification pending at this checkpoint |

Red intermediate runs are diagnostic only and do not supersede later exact-head green checkpoints.

## Exact boundary after integration

The mathematical reconstruction of Erdős #678 is complete and integrated into `main`. There is no known mathematical or analytic gap in the formalized proof chain.

Still deliberately not claimed:

- a generic arbitrary-cardinality CRT-basis theorem; only the pair/triple arities needed by Cambie's argument are formalized;
- that the earlier independent proof attempt was valid. It remains rejected because it used the false scaling identity `M(t*n,k) = t*M(n,k)` and later a wrong interval in a `Q=P/M` construction.

## Required restart sequence

1. Verify the exact head of `main` and its latest Lean CI conclusion.
2. Read this file and `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
3. Do not reopen D4 or E1–E4 mathematics unless a concrete regression is found.
4. Treat remaining diagnostic PR or branch cleanup as non-mathematical hygiene.
5. Preserve the pinned PNT+ revision and all positive/negative regressions.
6. Once `main` post-merge verification is green, classify #678 as archived/completed and choose the next active benchmark.

## Completed benchmark outcomes

- #18: known sub-result `h(n!) ≤ n-1` independently reconstructed; parent problem not solved.
- #214: candidate retracted; restart incomplete; blind phase later terminated by contamination.
- #225: inactive with no candidate proof; blind boundary remains intact if resumed.
- #246: paused because the copied benchmark statement is defective.
- #275: independent proof audited and frozen before reference access; equivalent core mechanism to the reference proof.
- #303: blind attempt incomplete; Brown–Rödl reference comparison completed.
- #447: contaminated challenge; not an active blind benchmark.
- #678: Cambie reconstruction complete, machine-checked, and integrated into `main`; post-merge verification is the only remaining gate at this checkpoint.
- #1125: blind proof attempt failed; historical/modern reconstruction completed.
