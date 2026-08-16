# Erdős Problem #678 — Active Cambie Reconstruction

> **Current repository status (2026-08-16): ACTIVE — Phase E2.**
> The independent attempt was invalidated. The active work is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). Phase D / Claim 4 and Phase E1 / the quantitative LCM-ratio estimate have passed their mathematical gates. The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k ≥ 3` with `m ≥ n+k` such that `M(n,k) > M(m,k+1)`?

## Exact project classification

- External problem status: proved.
- Independent proof attempt in this repository: rejected.
- Valid concrete witness: `M(36,8) > M(47,9)` — machine-checked.
- Rejected candidate: `(495,504,8)` — machine-refuted and retained as a negative regression.
- Current mode: reconstruction of Cambie's proof architecture.
- Full Claim 5: machine-checked under explicit residue hypotheses.
- Claim 4 / Phase D: **PASSED**, through the sharp Cambie dependent-placement endpoint under explicit large-`k` and sharp-prime-window data.
- Phase E1 — quantitative LCM-ratio estimate: **PASSED / MACHINE-CHECKED**.
- Current formalization phase: **Phase E2 — sharp prime-density existence**.
- Full Erdős #678 theorem in this repository: not formalized.

## Historical independent-attempt failure

The project found the valid finite witness `(36,47,8)` but then asserted the false scaling identity

```text
M(t*n,k) = t*M(n,k).
```

This fails because `M(t*n,k)` is the LCM of `tn+1,...,tn+k`, not of `t(n+1),...,t(n+k)`. A later attempted `Q=P/M` construction also failed because it used the wrong interval for `M(t,k+1)`.

Those failures were recorded before reference reconstruction and remain part of project provenance.

## Current Lean reconstruction

| Layer | Status |
|---|---|
| length-based intervals and canonical `erdosM` | machine-checked |
| positive and negative concrete regressions | machine-checked |
| finite product/LCM valuation core | machine-checked |
| all three Claim 5 prime ranges | machine-checked |
| full Claim 5 assembly | machine-checked under explicit residue hypotheses |
| Claim 4 finite union-bound / modular / weighted layers | machine-checked |
| concrete pair/triple CRT-basis producer | machine-checked |
| exact application residue boxes and exclusion budgets | machine-checked |
| D3 scaled connection to both Claim 5 residue interfaces | machine-checked |
| general-`k` constructed scales `Nx,Ny` and support/unit facts | machine-checked |
| broad prime-window contract and exact five basic search-length bounds | machine-checked conditionally on explicit prime-window data |
| full-scale factorization, `fullScale = lcm(1,...,k)`, and canonical placement | machine-checked |
| dependent `y`-first / moving-`x` endpoint with `x+k<y<x+gap` + full Claim 5 | machine-checked |
| division-safe Cambie `gap`, `yLower`, `yUpper` | machine-checked |
| general `k≥9` small-scale gap | machine-checked |
| explicit large-`k` target-window room | machine-checked |
| `C`-dependent sharp prime strips → exact two search budgets | machine-checked |
| final D4 sharp representative endpoint + full Claim 5 | machine-checked under explicit large-`k` and sharp-prime-window data |
| E1a exact divisibility / cross-multiplication / LCM inequality transfer | machine-checked |
| E1b product estimate from target range and closeness | machine-checked |
| E1c final sharp-window representative → strict LCM comparison | machine-checked |
| formal prime-density existence of the five special primes | **CURRENT / E2** |
| strong Cambie theorem / full #678 | pending / E3–E4 |

## Verified D4 and E1 checkpoints

D4 final reachable gate: canonical run `31963803495` passed `lake exe mk_all --check` with `No update necessary` and the full Lean build at head `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, completing **8766 jobs**.

E1a gate: run `31963812320` passed on head `36b91df00a7a25d20a635256a8533a7d9030714d`, with `No update necessary` and **8768 jobs**.

E1 mathematical exit: run `31968714909` passed on head `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, with `No update necessary` and a full build of **8770 jobs**. The reachable graph builds both `Claim5ProductEstimate` and its regressions.

The E1 endpoint is

`claim4_exists_cambie_lcm_ratio_of_sharp_windows`.

Given explicit `Claim4CambieLargeKData C k` and `Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq`, it constructs `x,y` with

- `0 < x`, `0 < y`, `x < y`;
- `x + k < y`;
- `C * intervalLCM y (k+1) < intervalLCM x k`.

The proof remains cancellation-safe in `ℕ`: it first turns Claim 5 into a cross-multiplied equality using exact divisibility, proves the product inequality from Cambie's verified range/closeness bounds, then transfers that inequality to the LCMs.

## Exact remaining boundary

This repository still does **not** assert the formal existence of the five sharp-window primes for every sufficiently large `k`.

The frozen D4 contract `Claim4CambieSharpPrimeWindowData` requires one slack `s`, two y-primes just above `k/2`, three x-primes just below `k`, broad-window conditions, pairwise distinctness, and `40*C*(s+1) ≤ k`.

No axiom was introduced to hide this analytic input. This is now the sole active **E2** dependency. After E2, E3 will combine it with the passed E1 endpoint, and E4 will specialize `C=1` and translate interval starts to the canonical problem variables.

The pair/triple CRT producer remains specialized to the two arities actually used by Cambie. No arbitrary-finite-family CRT basis theorem is claimed.

## Sole next action — E2

Audit the pinned Mathlib revision for formal prime-counting/PNT/short-interval theorems and select the smallest result sufficient to construct `Claim4CambieSharpPrimeWindowData` for every fixed positive `C` and all sufficiently large `k`.

The E2 work order is:

1. identify the strongest usable formal prime-density theorem already available in the pinned graph;
2. derive the exact natural-number strip inequalities required by D4 without weakening or changing the existing constants merely to fit the library;
3. choose a common slack `s` satisfying `40*C*(s+1) ≤ k`;
4. construct two distinct y-primes and three distinct x-primes and discharge all `Claim4PrimeWindowData` fields;
5. expose a reachable sufficiently-large-`k` constructor for `Claim4CambieSharpPrimeWindowData`;
6. add threshold/boundary regressions and exact-head CI.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit.
- `LEAN_FORMALIZATION_ROADMAP.md` — sole active execution roadmap.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false `(495,504,8)` construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
