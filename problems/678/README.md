# Erdős Problem #678 — Active Cambie Reconstruction

> **Current repository status (2026-08-16): ACTIVE — Phase E1.**
> The independent attempt was invalidated. The active work is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). Phase D / Claim 4 has passed both its mathematical and documentation gates. The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

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
- Current formalization phase: **Phase E1 — quantitative LCM-ratio estimate**.
- Formal existence of the five sharp-window primes: pending as the separate **E2 prime-density dependency**.
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
| D4 state-document synchronization | **passed exact-head CI** |
| quantitative LCM-ratio finish | **CURRENT / E1** |
| formal prime-density existence of the five special primes | pending / E2 |
| strong Cambie theorem / full #678 | pending / E3–E4 |

## Verified D4 exit checkpoints

Mathematical exit: canonical run `31959479154` passed `lake exe mk_all --check` with `No update necessary` and the full Lean build at head `0696e6474ebaf6deec2303f38c862842da3b28e2`, completing **8766 jobs**.

Documentation exit: canonical run `31960707971` passed the same gate on synchronized head `c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893`, again with `No update necessary` and **8766 jobs**.

The D4 boundary is precise:

- `claim4XScale` and `claim4YScale` are the actual general-`k` products formed by fixing all non-special coordinates;
- the full scale is identified with `lcm(1,...,k)`;
- the dependent placement theorem chooses `y` first and then `x` close below it, deriving the lower separation from the common small-prime congruence and the upper closeness from the moving interval;
- `claim4SmallScale_gap_of_nine_le` removes the former small-scale room hypothesis for all `k≥9`;
- `Claim4CambieLargeKData` turns `20*C*k^2*(k+1) ≤ 2^k` into the actual Cambie target-window room;
- `Claim4CambieSharpPrimeWindowData` uses a slack `s` and the bounds `40*C*(s+1) ≤ k`, `2p≤k+s` for the two `y` primes, and `k≤p+s` for the three `x` primes to discharge both exact search budgets;
- `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows` constructs the actual `x,y`, proves `x+k<y<x+M/(5Ck)`, places `y` in the paper-compatible range, and proves the complete Claim 5 identity for those same representatives;
- a reachable nonvacuous closed regression uses `C=1`, `k=1000`, `s=23`, `x` primes `977,983,991`, and `y` primes `503,509`.

This does **not** assert a prime-density theorem. Existence of such five primes for every sufficiently large `k` remains a separate analytic obligation in E2. No axiom was introduced to hide it.

The pair/triple CRT producer remains specialized to the two arities actually used by Cambie. No arbitrary-finite-family CRT basis theorem is claimed.

## Sole next action — E1

Formalize the exact natural-number algebra converting the machine-checked Claim 5 identity into the LCM comparison, then prove Cambie's quantitative lower bound using the already verified target range and closeness bound.

The first E1 checkpoint is deliberately algebraic:

1. prove a reusable `intervalLCM ∣ intervalProd` bridge;
2. cross-multiply the Claim 5 quotient identity using exact `Nat.div_mul_cancel`, obtaining an equality of products rather than informal fractions;
3. prove an inequality-transfer lemma that reduces the desired LCM comparison to the product inequality `C * Prod_y < M * Prod_x` under explicit positivity;
4. add closed boundary regressions for the cancellation lemmas;
5. only then introduce the paper-compatible product-ratio estimate.

E1 must remain independent of E2 prime-density existence.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit.
- `LEAN_FORMALIZATION_ROADMAP.md` — sole active execution roadmap.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false `(495,504,8)` construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
