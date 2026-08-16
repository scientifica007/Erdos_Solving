# Erdős Problem #678 — Active Cambie Reconstruction

> **Current repository status (2026-08-16): ACTIVE.**
> The independent attempt was invalidated. The active work is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). The D4 mathematical exit is green; the exact-head documentation synchronization CI is the only remaining gate before E1 becomes operational. The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k ≥ 3` with `m ≥ n+k` such that `M(n,k) > M(m,k+1)`?

## Exact project classification

- External problem status: proved.
- Independent proof attempt in this repository: rejected.
- Valid concrete witness: `M(36,8) > M(47,9)` — machine-checked.
- Rejected candidate: `(495,504,8)` — machine-refuted and retained as a negative regression.
- Current mode: reconstruction of Cambie's proof architecture.
- Full Claim 5: machine-checked under explicit residue hypotheses.
- Claim 4 / Phase D: mathematical gate passed through the actual sharp Cambie dependent-placement endpoint under explicit large-`k` and sharp-prime-window data.
- Current operational gate: exact-head CI for the synchronized D4 exit documentation.
- Next formalization phase after that gate: Phase E1, the quantitative LCM-ratio estimate.
- Formal existence of the five sharp-window primes: pending as the separate E2 prime-density dependency.
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
| D4 state-document synchronization | **CI gate pending** |
| quantitative LCM-ratio finish | next / E1 |
| formal prime-density existence of the five special primes | pending / E2 |
| strong Cambie theorem / full #678 | pending / E3–E4 |

## Verified D4 mathematical exit checkpoint

Canonical run `31959479154` passed `lake exe mk_all --check` with `No update necessary` and the full Lean build at mathematical head `0696e6474ebaf6deec2303f38c862842da3b28e2`. The build reached `Claim4CambieLargeK`, `Claim4CambieSharpPrimeWindow`, their tests, and the full aggregator, completing **8766 jobs**.

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

## Sole next action

First pass canonical CI on the exact synchronized documentation head. If green, activate E1 and formalize the natural-number algebra converting the machine-checked Claim 5 identity into the LCM comparison, then prove Cambie's quantitative lower bound using the already verified target range and closeness bound.

E1 audit requirements:

1. isolate exact divisibility and nonzero facts needed for cancellation in `ℕ`;
2. avoid informal field-style cancellation across `Nat.div`;
3. obtain the paper-compatible product-ratio estimate from `x<y<x+M/(5Ck)` and the target `y` range;
4. prove, under the D4 hypotheses, `intervalLCM x k > C * intervalLCM y (k+1)`;
5. keep E2 prime-density existence independent of this algebraic layer.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit.
- `LEAN_FORMALIZATION_ROADMAP.md` — sole active execution roadmap.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false `(495,504,8)` construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
