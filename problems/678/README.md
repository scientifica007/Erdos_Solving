# Erdős Problem #678 — Active Cambie Reconstruction

> **Current repository status (2026-08-16): ACTIVE, CI GREEN.**
> The independent attempt was invalidated. The active work is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k ≥ 3` with `m ≥ n+k` such that `M(n,k) > M(m,k+1)`?

## Exact project classification

- External problem status: proved.
- Independent proof attempt in this repository: rejected.
- Valid concrete witness: `M(36,8) > M(47,9)` — machine-checked.
- Rejected candidate: `(495,504,8)` — machine-refuted and retained as a negative regression.
- Current mode: reconstruction of Cambie's proof architecture.
- Full Claim 5: machine-checked under explicit residue hypotheses.
- Claim 4: machine-checked through the construction of the actual scales, fixed prime-window/search obligations, full-scale factorization, quantitative placement utilities, and a dependent close-and-separated representative endpoint under an explicit room contract.
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
| prime-window contract and exact five search-length bounds | machine-checked conditionally on explicit prime-window data |
| full-scale factorization and canonical placement utilities | machine-checked |
| generic separated representatives + full Claim 5 | machine-checked under explicit separated-window data |
| dependent `y`-first / moving-`x` endpoint with `x+k<y<x+gap` + full Claim 5 | machine-checked under `Claim4DependentPlacementData` |
| sharp Cambie target-room theorem | **CURRENT / not yet proved** |
| formal prime-density existence of the five special primes | pending |
| quantitative LCM-ratio finish | pending |
| strong Cambie theorem / full #678 | pending |

## Verified checkpoint

Canonical run `31953021835` passed `lake exe mk_all --check` with `No update necessary` and the full Lean build at theorem-and-regression head `f1dba040aeeab6a4736ab8226a186d07fe86c4ed`. The build reached the D4 scale, prime-window, factorization, placement, representative-separation, and dependent-placement modules and completed **8754 jobs**.

The current verified boundary is deliberate:

- `claim4XScale` and `claim4YScale` are the actual general-`k` products formed by fixing all non-special coordinates;
- their required small- and medium-prime divisibility and the five special-prime nondivisibility conditions are proved;
- `Claim4PrimeWindowData` discharges all five search-length and `k<p²` obligations;
- exact factorizations relate `Nx,Ny` to the full scale;
- `claim4_exists_separated_representatives_with_claim5` constructs separated representatives from explicit separated windows;
- `claim4_exists_close_separated_representatives_with_claim5` is closer to Cambie's actual proof: it chooses `y` first, then searches for `x` in a moving interval below the selected `y`;
- the moving interval proves `y < x + gap`;
- the common small-prime scale proves `x + k < y` from `x ≡ 1` and `y ≡ 0`;
- the same representatives then satisfy both residue interfaces and the complete Claim 5 identity.

What remains outside the verified theorem is **not** the CRT producer. It is the proof that Cambie's sharp quantitative target windows satisfy the finite room contract for all sufficiently large `k`, plus the later existence of the five special primes.

The pair/triple producer remains specialized to the two arities actually used by Cambie. No arbitrary-finite-family CRT basis theorem is claimed.

## Sole next action

Formalize division-safe versions of Cambie's target `y` range and closeness gap, reduce `Claim4DependentPlacementData` to width inequalities using the verified scale factorizations and search budgets, and prove those inequalities under explicit sufficiently-large-`k` hypotheses. Keep prime-window **existence** separate for the later prime-density layer. Do not open Phase E until this D4 exit gate is green.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit.
- `LEAN_FORMALIZATION_ROADMAP.md` — sole active execution roadmap.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false `(495,504,8)` construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
