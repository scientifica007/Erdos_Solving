# Project State

> **Operational checkpoint synchronized on 2026-08-16.**
>
> D4 mathematical exit: commit `0696e6474ebaf6deec2303f38c862842da3b28e2`, canonical run `31959479154` — **SUCCESS**.
> D4 documentation gate: synchronized head `c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893`, canonical run `31960707971` — **SUCCESS**.
> Both credited runs passed `lake exe mk_all --check` with `No update necessary` and completed the canonical `lake build` with **8766 jobs**.
>
> **Phase D is closed. Phase E1 is the active formalization stage.**

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
current_stage: E1-lcm-ratio-estimate
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: exact-claim4-and-dependent-placement-audited

current_target: derive-the-natural-number-lcm-ratio-comparison-from-claim5-and-the-machine-checked-sharp-representative-bounds
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked-under-explicit-residue-hypotheses
claim4_status: passed-through-sharp-cambie-dependent-placement
full_erdos678_formalization_status: not-proved

ci_status: green-through-D4-documentation-gate
canonical_ci_run: 31960707971
canonical_ci_commit: c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893
build_graph_audit: mk-all-check-passed
ci_blocker: none-for-E1-entry
phase_e_gate: open
next_action: formalize E1 cancellation-safe Claim5-to-LCM algebra; keep sharp-prime existence as the separate E2 dependency
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
- constructed scales `claim4SmallScale`, `claim4XScale`, `claim4YScale` with all small-prime support, non-special medium divisibility, and five special-prime nondivisibility conditions;
- `Claim4PrimeWindowData` and the broad medium/search obligations;
- `claim4FullScale`, exact factorizations, and `claim4FullScale k = Nat.lcmUpto k = intervalLCM 1 k`;
- canonical absolute-window placement;
- a generic separated representative endpoint and the stronger `y`-first moving-`x` endpoint;
- derivation of `x+k<y<x+gap` from placement plus the common small-prime congruence;
- the complete Claim 5 identity for those same representatives;
- division-safe Cambie parameters
  - `claim4CambieGap C k = M/(5*C*k)`,
  - `claim4CambieYLower C k = M*(k+1)/(5*C*k)`,
  - `claim4CambieYUpper C k = M/(4*C)-k`;
- the general small-scale theorem `9 ≤ k → k+2 ≤ claim4SmallScale k`;
- `Claim4CambieLargeKData`, where `20*C*k^2*(k+1) ≤ 2^k` supplies full-scale growth and actual target-window room;
- `Claim4CambieSharpPrimeWindowData`, with slack `s`, two `y` primes in a sharp strip above `k/2`, three `x` primes in a sharp strip below `k`, and `40*C*(s+1) ≤ k`;
- exact derivation of both sharp D4f search budgets;
- final endpoint `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows`;
- closed regressions, including `C=1, k=1000, s=23` with `x` primes `977,983,991` and `y` primes `503,509`.

### D4 verification chronology

| Substep | Exact head | Canonical run | Result |
|---|---|---:|---|
| D4a/D4b — scales/support/wrapper | `a259da8a6a42512a347f34b15de9b0be1e2fd9af` | `31947099017` | SUCCESS, 8745 jobs |
| D4c — broad prime-window contract | `eef7d931e4984110222aa72b6b2df2fa5d70928b` | `31948527075` | SUCCESS, 8747 jobs |
| D4d — factorization/placement | `b0914c876732d0f0791d71a74289c6cbae1d4466` | `31949164598` | SUCCESS, 8750 jobs |
| D4e — generic separated reps | `89f500f729c4ea5507296d397f378562179d58ba` | `31951779394` | SUCCESS, 8752 jobs |
| D4e — dependent close/separated reps | `72432d4b3d18f8772cc0c6371a3f331222fb5700` | `31952559027` | SUCCESS, 8754 jobs |
| D4e cleanup | `f1dba040aeeab6a4736ab8226a186d07fe86c4ed` | `31953021835` | SUCCESS, 8754 jobs |
| D4f room reduction | `0e9ff533671dd974c5aad9100b321c2e4c24da85` | `31956361984` | SUCCESS, 8760 jobs |
| D4f small-scale gap | `6386278dc00d19dceec346524f92139ac0f9449c` | `31957062773` | SUCCESS, 8762 jobs |
| D4 mathematical exit | `0696e6474ebaf6deec2303f38c862842da3b28e2` | `31959479154` | SUCCESS, 8766 jobs |
| D4 documentation exit | `c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893` | `31960707971` | SUCCESS, 8766 jobs |

Red intermediate runs are diagnostic only. The sharp-window repairs changed proof scripts only, not theorem statements, constants, or assumptions.

## Exact boundary after D4

D4 is complete as the **finite arithmetic/CRT construction**. It does not assert a prime-density theorem.

The final D4 theorem is conditional on explicit `Claim4CambieLargeKData` and `Claim4CambieSharpPrimeWindowData`. The latter includes primality and sharp location of the five special primes. Their existence for every sufficiently large `k` remains the separate Phase E2 analytic dependency; no axiom was introduced to hide it.

Still not proved:

1. the quantitative LCM-ratio estimate `intervalLCM x k > C * intervalLCM y (k+1)` from Claim 5 and the sharp bounds — **E1, current**;
2. a formal prime-density theorem producing the five required sharp-window primes — **E2**;
3. the strong Cambie theorem for fixed `C` and all sufficiently large `k` — **E3**;
4. Erdős #678 via `C=1` and the final index translation — **E4**.

A generic arbitrary-cardinality CRT-basis theorem is also not claimed; only the two arities used by Cambie's proof are formalized.

## Phase E — quantitative finish — CURRENT

### E1 — LCM-ratio estimate — CURRENT

The first E1 checkpoint must be cancellation-safe natural-number algebra, not an informal fraction manipulation.

Planned machine-checkable chain:

1. expose a reusable theorem `intervalLCM start len ∣ intervalProd start len`;
2. consume the verified Claim 5 quotient identity and exact divisibilities via `Nat.div_mul_cancel` to derive a cross-multiplied equality
   `Prod_y * LCM_x = M * Prod_x * LCM_y`;
3. prove an inequality-transfer lemma showing that, under positivity, the product inequality
   `C * Prod_y < M * Prod_x`
   implies
   `C * LCM_y < LCM_x`;
4. add closed positive/zero-boundary regressions for the cancellation layer;
5. only then formalize the paper-compatible product-ratio estimate from the verified target range and closeness bound.

No field-style cancellation across `Nat.div` is permitted without exact divisibility/nonzero hypotheses.

### E2 — prime-density dependency — PENDING

Prove or import a theorem supplying the five primes in the explicit `C`-dependent strips for all sufficiently large `k`. This dependency remains independent of E1.

### E3/E4 — strong Cambie theorem and Erdős #678 — PENDING

Combine E1 and E2, then take `C=1` and translate interval starts to the canonical problem variables.

## Required restart sequence

1. Verify the active branch/PR head and its exact canonical CI.
2. Read this file and `problems/678/LEAN_FORMALIZATION_ROADMAP.md`.
3. Start E1 with the generic divisibility/cross-multiplication layer.
4. Add regressions before quantitative product estimates.
5. Keep E2 prime-density existence separate.

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

The root README, this checkpoint, the active #678 roadmap, the problem index, and the #678 README now identify **E1 as current** and preserve the explicit E2 prime-density boundary. The exact activation head must pass canonical CI before this state is credited for merge/review readiness.
