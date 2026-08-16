# Project State

> **Operational checkpoint synchronized on 2026-08-16.**
>
> Verified theorem-and-regression basis: commit `f1dba040aeeab6a4736ab8226a186d07fe86c4ed`.
> Canonical pull-request CI run for that head: `31953021835` — **SUCCESS**.
> The run passed `lake exe mk_all --check` (`No update necessary`), reached the live D4 scale/window/placement modules and regressions, and completed the canonical `lake build` with **8754 jobs**.

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
current_stage: claim4-sharp-dependent-placement-room
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: exact-claim4-and-dependent-placement-audited

current_target: discharge-sharp-cambie-dependent-placement-room-inequalities
small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked-under-explicit-residue-hypotheses
claim4_status: machine-checked-through-dependent-placement-under-explicit-room-contract
full_erdos678_formalization_status: not-proved

ci_status: green
canonical_ci_run: 31953021835
canonical_ci_commit: f1dba040aeeab6a4736ab8226a186d07fe86c4ed
build_graph_audit: mk-all-check-passed
ci_blocker: none
phase_e_gate: closed
next_action: prove Claim4DependentPlacementData for Cambie's sharp target windows from the verified scale factorization, prime-window bounds, and explicit sufficiently-large-k inequalities; keep actual prime-window existence as the later prime-density dependency
```

## Trusted machine-checked state

The reachable graph machine-checks the following chain.

### Arithmetic and Claim 5

- length-based consecutive intervals and canonical `erdosM`;
- the positive witness `M(36,8) > M(47,9)` and the rejected `(495,504,8)` negative regression;
- finite-product, finite-LCM, and reciprocal-LCM valuation lemmas;
- prime-power counting primitives;
- Claim 5 in the large, medium, and capped small-prime ranges;
- explicit `Claim5MediumResidues` and `Claim5SmallResidues` interfaces;
- the prime-by-prime assembled Claim 5 valuation identity;
- nonzero interval bridges and the final natural-number Claim 5 identity under those residue interfaces;
- reachable positive and negative boundary regressions.

### Claim 4 / CRT engine through D3

- the generic strict finite union-bound theorem;
- modular injectivity and the prime-coordinate density specialization;
- the weighted representation consumer;
- concrete pair/triple CRT basis producers and representation contracts;
- the paper/canonical coefficient translation, exact exclusion sets and exact search lengths;
- the two-prime `y` and three-prime `x` application boxes;
- scaled representatives of the forms `y = z*Ny` and `x = 1 + z*Nx`;
- packaging of special and fixed medium coordinates as `Claim5MediumResidues`;
- derivation of `Claim5SmallResidues` from common small-prime power support;
- the combined D3 scaled producer and a reachable regression crossing into the full Claim 5 identity.

### D4 quantitative construction now machine-checked

- `claim4SmallScale`, `claim4Scale`, `claim4XScale`, and `claim4YScale`;
- maximal small-prime power support in both scales;
- divisibility of every non-special medium prime;
- nondivisibility/unit conditions for each designated special prime;
- `claim4_exists_claim5_residue_interfaces_of_constructed_scales`, which discharges the D3 scale-support premises automatically;
- `Claim4PrimeWindowData`, isolating two `y` primes in `(k/2,2k/3]` and three `x` primes in a fixed near-`k` window;
- automatic derivation of the five `k < p^2` obligations and the exact pair/triple search-length inequalities from that prime-window contract;
- `claim4FullScale` and the exact factorizations `Nx * (xp*xq*xr) = fullScale` and `Ny * (yp*yq) = fullScale`;
- canonical search starts and lemmas translating search membership into bounds for `x` and `y`;
- a generic separated-window endpoint producing `0 < x < y`, `x+k < y`, both Claim 5 residue interfaces, and the complete Claim 5 identity;
- the stronger Cambie-style dependent endpoint `claim4_exists_close_separated_representatives_with_claim5`, which chooses `y` first and then `x` in a moving interval below `y`;
- in that endpoint, the **upper closeness** `y < x + gap` is derived from the moving search interval, while the **lower separation** `x + k < y` is derived from `x ≡ 1` and `y ≡ 0` modulo `claim4SmallScale`;
- a reachable `k = 50` end-to-end regression for the dependent endpoint using the concrete prime-window data `41,43,47` and `29,31`;
- the closed regression uses ordinary `decide`, not `native_decide`, so this checkpoint does not enlarge the trusted base for that finite proof.

## D4 verification chronology

| Substep | Exact head | Canonical run | Result |
|---|---|---:|---|
| D4a/D4b — scales, support, constructed-scale wrapper | `a259da8a6a42512a347f34b15de9b0be1e2fd9af` | `31947099017` | SUCCESS, 8745 jobs |
| D4c — prime-window contract and search budgets | `eef7d931e4984110222aa72b6b2df2fa5d70928b` | `31948527075` | SUCCESS, 8747 jobs |
| D4d — full-scale factorization and placement utilities | `b0914c876732d0f0791d71a74289c6cbae1d4466` | `31949164598` | SUCCESS, 8750 jobs |
| D4e — generic separated representatives + Claim 5 | `89f500f729c4ea5507296d397f378562179d58ba` | `31951779394` | SUCCESS, 8752 jobs |
| D4e-bis — dependent close-and-separated endpoint | `72432d4b3d18f8772cc0c6371a3f331222fb5700` | `31952559027` | SUCCESS, 8754 jobs |
| D4e cleanup — kernel-checked closed regression | `f1dba040aeeab6a4736ab8226a186d07fe86c4ed` | `31953021835` | SUCCESS, 8754 jobs |

The earlier red D4 runs are not credited as proof checkpoints. In particular, run `31952363851` failed at `mk_all --check` because the aggregator import order was not canonical; the subsequent repair changed import order only, not theorem statements or assumptions.

## Claim 4 module state

| Module | Current classification |
|---|---|
| `Claim4Density.lean` / tests | reachable; strict finite union bound checked |
| `Claim4Modular.lean` / tests | reachable; modular coordinate density checked |
| `Claim4Weighted.lean` / tests | reachable; weighted consumer checked |
| `Claim4CRT.lean` / tests | reachable; pair/triple CRT producers checked |
| `Claim4ApplicationBoxes.lean` / tests | reachable; exact Cambie boxes and budgets checked |
| `Claim4Claim5Interface.lean` / tests | reachable; D3 scaled connection to both Claim 5 interfaces checked |
| `Claim4Scales.lean` / tests | reachable; actual constructed scales and support/unit facts checked |
| `Claim4ConstructedInterface.lean` / tests | reachable; constructed scales discharge the D3 scale premises |
| `Claim4PrimeWindows.lean` / tests | reachable; five special-prime window/search obligations checked conditionally on the explicit window data |
| `Claim4ScaleFactorization.lean` | reachable; full-scale factorizations and positivity checked |
| `Claim4Placement.lean` / tests | reachable; canonical search starts and representative bounds checked |
| `Claim4RepresentativeSeparation.lean` / tests | reachable; generic separated representatives feed full Claim 5 |
| `Claim4DependentPlacement.lean` / tests | reachable; choose `y` first, then close `x`, derive `x+k<y<x+gap`, and feed full Claim 5 |

## Exact boundary — D4 is still CURRENT

This checkpoint does **not** certify Cambie's full quantitative construction and does not open Phase E.

The dependent endpoint consumes an explicit finite arithmetic contract:

`Claim4DependentPlacementData k xp xq xr yp yq yLower yUpper gap`.

The repository still has to discharge that contract for Cambie's actual quantitative target windows. In particular, the following remain open:

1. a general sufficiently-large-`k` proof of the small-scale gap needed for `m-1>k` rather than only a concrete regression;
2. the sharp `y_room` inequality placing `y` in a Cambie-compatible absolute range;
3. the moving `x_room` inequality placing `x` close enough below the actual selected `y`;
4. the exact connection from those room inequalities to the target constants used by the final LCM-ratio estimate;
5. existence, for all sufficiently large `k`, of the required two and three special primes — this is deliberately kept as the later prime-density dependency rather than hidden as an axiom.

A generic arbitrary-cardinality CRT-basis theorem is also not claimed; only the two arities used by the current reconstruction are formalized.

## Current #678 mathematical state

Canonical statement: locked.

Verified in this repository:

- the exact Claim 5 identity under explicit residue data;
- the full finite/CRT mechanism needed for Cambie's two special `y` primes and three special `x` primes;
- general-`k` scale definitions and their support/unit properties;
- prime-window-to-search-budget derivation;
- quantitative search placement infrastructure;
- construction of close-and-separated representatives under an explicit room contract;
- direct consumption of those same representatives by the full Claim 5 identity.

Not yet proved in this repository:

- the sharp dependent-placement room contract for Cambie's target ranges for all sufficiently large `k`;
- the exact formal prime-density input producing the five special primes;
- the quantitative LCM-ratio estimate;
- the strong Cambie theorem for arbitrary fixed `C`;
- Erdős #678 itself.

## Required restart sequence

1. Define the exact Cambie target parameters `yLower`, `yUpper`, and `gap` in a division-safe form suitable for Lean.
2. Reduce `Claim4DependentPlacementData` to explicit width inequalities using the verified `Nx,Ny` factorization and search-length bounds.
3. Prove those width inequalities under explicit sufficiently-large-`k` hypotheses; prove the general small-scale gap in the same layer.
4. Instantiate `claim4_exists_close_separated_representatives_with_claim5` with the sharp room theorem.
5. Add boundary regressions and pass exact-head canonical CI.
6. Only then mark D4 complete and open Phase E1. Keep the existence of the five special primes as the explicit prime-density dependency for the later theorem closure.

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

The root README, this checkpoint, the active #678 roadmap, the problem index, and the #678 README are synchronized with the D4 dependent-placement checkpoint in this pull request. `CAMBIE_PROOF_ANALYSIS.md` and `LESSONS_LEARNED_678_ADDENDUM.md` remain reference/history documents; their mathematical descriptions are compatible with this checkpoint but they are not the operational source of the current next action.
