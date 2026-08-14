# Erdős Problem #678 — Active Cambie Reconstruction

> **Current repository status (2026-08-14): ACTIVE, CI GREEN.**
> The independent attempt was invalidated. The active work is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k ≥ 3` with `m ≥ n+k` such that `M(n,k) > M(m,k+1)`?

## Exact project classification

- External problem status: proved.
- Independent proof attempt in this repository: rejected.
- Valid concrete witness: `M(36,8) > M(47,9)` — machine-checked.
- Rejected candidate: `(495,504,8)` — machine-refuted and retained as a negative regression.
- Current mode: reconstruction of Cambie's proof architecture.
- Full Claim 5 in this repository: machine-checked under explicit residue hypotheses; residue construction remains Claim 4.
- Full Erdős #678 theorem in this repository: not formalized.

## Historical independent-attempt failure

The project found the correct finite witness `(36,47,8)` but then asserted the false scaling identity

```text
M(t*n,k) = t*M(n,k).
```

This fails because `M(t*n,k)` is the LCM of `tn+1,...,tn+k`, not of `t(n+1),...,t(n+k)`. A later attempted `Q=P/M` construction also failed because it used the wrong interval for `M(t,k+1)`.

The failures were recorded before reference reconstruction and remain part of project provenance.

## Current Lean reconstruction

| Layer | Status |
|---|---|
| length-based intervals and canonical `erdosM` | machine-checked |
| positive and negative concrete regressions | machine-checked |
| finite product/LCM valuation core | machine-checked |
| Claim 5 range `p > k` | machine-checked |
| Claim 5 range `p ≤ k < p²` | machine-checked |
| small-prime capped congruence core | machine-checked |
| integrated small-prime Claim 5 | machine-checked with reachable boundary regressions |
| full Claim 5 assembly | machine-checked under explicit residue hypotheses |
| Claim 4 / CRT construction | pending |
| quantitative finish and prime-density input | pending |
| full theorem | pending |

## Verified checkpoint

Canonical run `31847883886` passed the generated import-graph check and the full Lean build at commit `61431b8881e481a56d06e00d702eabb6b64ae471`. It reached the new assembly and regression modules and completed 8729 jobs.

The three range theorems are now assembled into a single prime-by-prime valuation theorem and a natural-number identity. The result is deliberately conditional on `Claim5MediumResidues` and `Claim5SmallResidues`; constructing those residues is the still-unproved Claim 4 / CRT layer.

## Sole next action

Formalize Claim 4: state the CRT-density lemma and construct residue data satisfying `Claim5MediumResidues` and `Claim5SmallResidues`. The quantitative finish, prime-density input, and full Erdős #678 theorem remain outside the current gate.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture of the reference proof.
- `LEAN_FORMALIZATION_ROADMAP.md` — sole active execution roadmap.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — exact rejection of the false `(495,504,8)` construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
