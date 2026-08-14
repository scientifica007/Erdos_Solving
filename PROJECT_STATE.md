# Project State

> **Operational checkpoint synchronized on 2026-08-14.**
>
> Code-state basis: commit `ac65fb32a90abf5183b52f117248793517262e65`.
> Diagnostic CI run: `31839041104` — **FAILURE**.
> This documentation synchronization does not change Lean code; CI remains red until the failures below are repaired.

This file is the authoritative operational memory checkpoint. It must agree with the canonical build graph and the latest known CI result. If it does not, stop research work and synchronize state before proceeding.

## Global operating rules

- Work directly on `main` only while `DEC-004` remains in force; do not interpret that decision as permission to leave state documents stale.
- Do not treat GitHub or a file named `theorem` as proof by itself.
- Never call an AI-generated argument a proof until it has passed the required audit and proof-freeze gates.
- Distinguish problem-level status, known sub-results, formalized statements, formalized proofs, external-proof reconstruction, and independent discovery.
- During a blind challenge, do not consult target-specific solution material before proof freeze.
- Preserve rejected paths, revoked freezes, contamination events, and negative regressions.
- For interval arguments, interval endpoints and interval length are mathematical data and must be formalized before simplification.
- A Lean module is live only when reachable from `Formalization.lean` and successfully checked by the canonical `lake build` CI job.
- A green run before importing a new file does not validate that file.
- After every material transition, update this file, the active roadmap, and any README that presents a current status.

## Current project

```yaml
current_problem: 678
current_phase: cambie-claim5
current_stage: small-prime-integration-repair
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: false

external_problem_status: proved
project_reconstruction_status: in-progress
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: analyzed

current_target: restore-and-machine-check-small-prime-claim5
full_claim5_status: not-proved
full_erdos678_formalization_status: not-proved

ci_status: red
ci_blocker: two Lean proof failures in the small-prime integration
diagnostic_ci_run: 31839041104
diagnostic_ci_commit: ac65fb32a90abf5183b52f117248793517262e65
next_action: fix SmallPrimeWindows line 71 and SmallPrimeValuation line 55, then run the canonical build
```

## Current CI failure

The canonical root imports `SmallPrimeClaim5.lean`, so the small-prime dependency graph is now live. GitHub Actions run `31839041104` failed with two blocking errors:

1. `Formalization/Erdos678/SmallPrimeWindows.lean:71` — equality orientation mismatch: the available term simplifies to `start = z`, while the goal is `z = start`.
2. `Formalization/Erdos678/SmallPrimeValuation.lean:55` — `omega` cannot close the natural-number subtraction/supremum step. The proof must be decomposed explicitly; no mathematical credit is given until Lean accepts it.

`SmallPrimeClaim5.lean` was therefore not machine-checked through the canonical graph.

## Trusted machine-checked state

The following components were machine-checked in earlier green canonical runs and are unchanged in the failing head:

- length-based consecutive interval API;
- canonical `erdosM n k = lcm(n+1,...,n+k)` abstraction;
- explicit abstraction-oracle checks for `(36,8)`, `(47,9)`, `(495,8)`, and `(504,9)`;
- positive regression `M(36,8) > M(47,9)` and its domain condition;
- negative regression `¬(M(495,8) > M(504,9))`;
- equality of nonzero naturals from all prime `padicValNat` values;
- finite-product and finite-LCM valuation theorems;
- exact product-over-LCM valuation theorem;
- prime-power divisibility counting primitives;
- finite-support bound for valuation counts;
- Claim 5 large-prime range `p > k`;
- Claim 5 medium-prime range `p ≤ k < p²`;
- capped-valuation congruence core in `SmallPrimeRange.lean`.

Important provenance:

- Run `31836288385` / commit `25987ea7` closed the integrated medium-prime range.
- Run `31837842207` / commit `e4c3c8c5` checked the imported capped small-prime congruence core.
- Run `31838112013` / commit `959fa24d` was green, but its newly added `SmallPrimeValuation.lean` was not yet imported; that green run is not validation of that file.

## Small-prime implementation state

| Module | Current classification |
|---|---|
| `SmallPrimeRange.lean` | integrated and previously machine-checked |
| `SmallPrimeInitialLCM.lean` | compiled during the failing run, but overall graph remained red |
| `SmallPrimeWindows.lean` | live and failing |
| `SmallPrimeValuation.lean` | live and failing |
| `SmallPrimeSup.lean` | source present; dependent graph not fully validated at head |
| `SmallPrimeClaim5.lean` | source present and imported; not machine-checked because dependencies fail |

## Current #678 mathematical state

Canonical statement: locked.

Verified:

- `M(36,8) > M(47,9)`;
- `47 ≥ 36 + 8`;
- the rejected `(495,504,8)` construction is false;
- the large- and medium-prime Claim 5 valuation identities under their explicit hypotheses.

Rejected paths:

- false scaling identity `M(t*n,k) = t*M(n,k)`;
- invalid `t` / `Q=P/M` infinitude construction;
- false positive witness `(495,504,8)`;
- incorrect interval identification `[t,t+k]` for `M(t,k+1)`.

Not yet proved in this repository:

- integrated small-prime Claim 5 theorem;
- assembly of Claim 5 across every prime;
- Claim 4 CRT-density lemma;
- CRT construction of `x` and `y`;
- quantitative LCM-ratio estimate;
- exact formal prime-density input;
- strong Cambie theorem;
- Erdős #678 itself.

## Required restart sequence

1. Make no progress on Claim 4, CRT, or estimates while CI is red.
2. Repair the two recorded Lean failures without weakening theorem statements.
3. Run canonical `lake build` through GitHub Actions.
4. Confirm that `SmallPrimeClaim5.lean` is reachable and checked in the successful run.
5. Update this checkpoint and the roadmap with the successful run and commit.
6. Assemble full Claim 5 prime-by-prime.
7. Only then advance to Claim 4 and CRT.

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

The root README, this checkpoint, the active #678 roadmap, the problem index, and stale benchmark-stage documents were synchronized in one documentation-only change. Historical records retain their original reasoning but carry explicit banners when their embedded status is no longer current.
