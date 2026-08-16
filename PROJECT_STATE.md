# Project State

> **Operational checkpoint synchronized on 2026-08-16.**
>
> Verified D4 theorem-and-regression basis: commit `0696e6474ebaf6deec2303f38c862842da3b28e2`.
> Canonical pull-request CI run for that head: `31959479154` — **SUCCESS**.
> The run passed `lake exe mk_all --check` (`No update necessary`), reached the live sharp Cambie room/prime-window modules and regressions, and completed the canonical `lake build` with **8766 jobs**.
>
> **Documentation synchronization is now the only open D4 exit gate.** Phase E1 becomes operational only after canonical CI is green for the exact synchronized documentation head.

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
current_phase: cambie-claim4-exit-documentation-gate
current_stage: D4-documentation-exact-head-ci
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: exact-claim4-and-dependent-placement-audited

current_target: pass-exact-head-ci-for-d4-exit-documentation-then-start-E1
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked-under-explicit-residue-hypotheses
claim4_status: machine-checked-through-sharp-cambie-dependent-placement-under-explicit-large-k-and-sharp-prime-window-data
full_erdos678_formalization_status: not-proved

ci_status: green-at-D4-mathematical-head-documentation-head-pending
canonical_ci_run: 31959479154
canonical_ci_commit: 0696e6474ebaf6deec2303f38c862842da3b28e2
build_graph_audit: mk-all-check-passed
ci_blocker: documentation-head-recheck-required
phase_e_gate: pending-documentation-head-ci
next_action: pass canonical CI on the synchronized documentation head; then formalize E1, the quantitative LCM-ratio estimate, while keeping the five-prime existence theorem as the explicit E2 dependency
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

### Claim 4 / CRT engine through D3

Machine-checked:

- strict finite union bound;
- modular injectivity and prime-coordinate density;
- weighted representation consumer;
- concrete pair/triple CRT basis producers;
- exact paper/canonical residue boxes, exclusions, and search lengths;
- scaled representatives `y = z*Ny` and `x = 1 + z*Nx`;
- medium-prime residue packaging and small-prime power support;
- the combined D3 scaled producer crossing into full Claim 5.

### D4 — actual scales, placement, and sharp Cambie representatives — MATHEMATICAL GATE PASSED

Machine-checked:

- `claim4SmallScale`, `claim4Scale`, `claim4XScale`, `claim4YScale`;
- all required small-prime support, non-special medium-prime divisibility, and five special-prime nondivisibility conditions;
- `Claim4PrimeWindowData` and derivation of all five `k < p^2` and basic search-length obligations;
- `claim4FullScale`, with exact factorizations `Nx*(xp*xq*xr)=fullScale` and `Ny*(yp*yq)=fullScale`;
- `claim4FullScale k = Nat.lcmUpto k = intervalLCM 1 k`;
- canonical search starts and quantitative placement of `x` and `y`;
- the generic separated representative endpoint feeding the complete Claim 5 identity;
- the dependent Cambie-style endpoint choosing `y` first, then `x` in a moving interval, deriving `x+k<y<x+gap`, and feeding the same representatives into full Claim 5;
- width-form reduction of the dependent room contract;
- division-safe Cambie parameters
  - `claim4CambieGap C k = M/(5*C*k)`,
  - `claim4CambieYLower C k = M*(k+1)/(5*C*k)`,
  - `claim4CambieYUpper C k = M/(4*C)-k`;
- the general small-scale separation theorem `9 ≤ k → k+2 ≤ claim4SmallScale k`;
- `Claim4CambieLargeKData`, where `20*C*k^2*(k+1) ≤ 2^k` implies the full-scale growth and target-window room inequality;
- `Claim4CambieSharpPrimeWindowData`, a `C`-dependent refinement with slack `s`, two `y` primes just above `k/2`, three `x` primes just below `k`, and `40*C*(s+1) ≤ k`;
- exact derivation of both D4f search budgets from those strips;
- `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows`, constructing representatives in the actual Cambie target range with `x+k<y<x+claim4CambieGap C k` and the complete Claim 5 identity;
- reachable large-`k` and sharp-window regressions, including `C=1, k=1000, s=23`.

## D4 verification chronology

| Substep | Exact head | Canonical run | Result |
|---|---|---:|---|
| D4a/D4b — scales, support, constructed-scale wrapper | `a259da8a6a42512a347f34b15de9b0be1e2fd9af` | `31947099017` | SUCCESS, 8745 jobs |
| D4c — prime-window contract and basic search budgets | `eef7d931e4984110222aa72b6b2df2fa5d70928b` | `31948527075` | SUCCESS, 8747 jobs |
| D4d — full-scale factorization and placement utilities | `b0914c876732d0f0791d71a74289c6cbae1d4466` | `31949164598` | SUCCESS, 8750 jobs |
| D4e — generic separated representatives + Claim 5 | `89f500f729c4ea5507296d397f378562179d58ba` | `31951779394` | SUCCESS, 8752 jobs |
| D4e-bis — dependent close-and-separated endpoint | `72432d4b3d18f8772cc0c6371a3f331222fb5700` | `31952559027` | SUCCESS, 8754 jobs |
| D4e cleanup — kernel-checked closed regression | `f1dba040aeeab6a4736ab8226a186d07fe86c4ed` | `31953021835` | SUCCESS, 8754 jobs |
| D4f.1 — sharp-room reduction and Cambie target parameters | `0e9ff533671dd974c5aad9100b321c2e4c24da85` | `31956361984` | SUCCESS, 8760 jobs |
| D4f.2 — general small-scale gap | `6386278dc00d19dceec346524f92139ac0f9449c` | `31957062773` | SUCCESS, 8762 jobs |
| D4f mathematical exit — large-`k` room + sharp prime strips + final endpoint | `0696e6474ebaf6deec2303f38c862842da3b28e2` | `31959479154` | SUCCESS, `mk_all`: No update necessary, 8766 jobs |

Red intermediate runs are diagnostic only and are not proof checkpoints. The final sharp-window repairs changed proof scripts only, not theorem statements, constants, or assumptions.

## Exact mathematical boundary after D4

D4 is mathematically complete **as the finite arithmetic/CRT construction**. This does not assert a prime-density theorem.

The final D4 theorem is conditional on explicit `Claim4CambieLargeKData` and `Claim4CambieSharpPrimeWindowData`. The latter includes the primality and sharp location of the five special primes. Their existence for every sufficiently large `k` is deliberately not manufactured axiomatically and remains the separate Phase E2 analytic dependency.

Still not proved:

1. the quantitative LCM-ratio estimate converting Claim 5 and the sharp bounds into `LCM_x > C * LCM_y` — E1;
2. a formal prime-density theorem producing the required five sharp-window primes — E2;
3. the strong Cambie theorem for every fixed `C ≥ 1` and all sufficiently large `k` — E3;
4. Erdős #678 itself — E4.

A generic arbitrary-cardinality CRT-basis theorem is also not claimed; only the two arities used by Cambie's proof are formalized.

## Phase E — quantitative finish — PENDING DOCUMENTATION CI

### E1 — LCM-ratio estimate — NEXT AFTER THIS GATE

Formalize the exact natural-number algebra from Claim 5 to the LCM comparison and prove the lower bound using:

- `M = intervalLCM 1 k`;
- the verified target window for `y`;
- `x < y < x + M/(5*C*k)`;
- positivity and nonzero facts from the representative endpoint.

Audit rule: do not perform informal field-style cancellation in `ℕ`; isolate divisibility and exact cancellation lemmas first.

### E2 — prime-density dependency — PENDING

Prove or import a theorem supplying the five primes in the explicit `C`-dependent strips for all sufficiently large `k`. Keep this dependency explicit and independently auditable.

### E3/E4 — strong Cambie theorem and Erdős #678 — PENDING

Combine E1 and E2, then take `C=1` and perform the final interval-index translation.

## Required restart sequence

1. Verify the exact synchronized documentation head and its canonical CI.
2. Only if green, mark the D4 documentation gate passed and activate E1.
3. Start E1 by isolating exact natural-number divisibility/cancellation lemmas needed to pass from Claim 5 to the LCM comparison.
4. Add boundary regressions before using those lemmas in the final estimate.
5. Keep E2 prime-density existence separate from E1 quantitative algebra.

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

The root README, this checkpoint, the active #678 roadmap, the problem index, and the #678 README now describe the D4 mathematical exit and the pending documentation CI gate. This synchronization is credited only after canonical CI is green for the exact documentation head.
