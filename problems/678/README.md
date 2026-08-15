# Erdős Problem #678 — Active Cambie Reconstruction

> **Current repository status (2026-08-15): ACTIVE, CI GREEN.**
> The independent attempt was invalidated. The active work is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k ≥ 3` with `m ≥ n+k` such that `M(n,k) > M(m,k+1)`?

## Exact project classification

- External problem status: proved.
- Independent proof attempt in this repository: rejected.
- Valid concrete witness: `M(36,8) > M(47,9)` — machine-checked.
- Rejected candidate: `(495,504,8)` — machine-refuted and retained as a negative regression.
- Current mode: reconstruction of Cambie's proof architecture.
- Full Claim 5 in this repository: machine-checked under explicit residue hypotheses.
- Claim 4 in this repository: partially machine-checked through the concrete pair/triple application boxes; the paper/canonical coefficient translation, exact exclusions and cardinalities, strict budgets, and application-density endpoints are live, while their Claim 5 connection remains pending.
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
| Claim 4 finite union-bound core | machine-checked with positive and strict-budget negative regressions |
| Claim 4 modular injectivity and prime-coordinate density | machine-checked with unit and non-unit regressions |
| Claim 4 weighted consumer under `Claim4WeightedRepresentation` | machine-checked with positive and zero-weight negative regressions |
| concrete pair/triple CRT-basis producer | machine-checked with positive, full-contract negative, and density-endpoint regressions |
| application residue boxes and exclusion-cardinality budgets | machine-checked with coefficient-convention, concrete endpoint, and equality-budget regressions |
| connection to `Claim5MediumResidues` and `Claim5SmallResidues` | current / not yet proved |
| quantitative finish and prime-density input | pending |
| full theorem | pending |

## Verified checkpoint

Canonical run `31870476963` passed the generated import-graph check and the full Lean build at theorem-and-regression head `b2a05790b4ae466133e792ca6afa3eae730c0427`. It reached all ten Claim 4 implementation and regression modules and completed 8739 jobs. The workflow retains Mathlib's cache but skips GitHub's `.lake` archive, preserving the repair for the post-build disk exhaustion seen in run `31853895481`.

The verified boundary is deliberate:

- `claim4_exists_avoiding_coordinate_exclusions` proves the finite strict union-bound engine;
- `claim4_prime_coordinate_density` proves the modular prime-coordinate specialization from explicit nondivisibility and length assumptions;
- `claim4_weighted_density_of_representation` transports the accepted coordinate vector to a weighted residue, provided `Claim4WeightedRepresentation` is supplied;
- `claim4_pair_crt_density` and `claim4_triple_crt_density` construct the actual basis multipliers, prove their representation contracts, and expose density endpoints with no representation assumption left to the caller;
- `claim4_pair_y_box_density` and `claim4_triple_x_box_density` instantiate those producers with Cambie's exact coefficient boxes and internalized strict exclusion budgets;
- no theorem yet packages the resulting coefficients and weighted representatives as the Claim 5 residue interfaces.

The verified producer is specialized to the two- and three-prime bases used in Cambie's construction. A generic arbitrary-finite-family basis theorem is not claimed.

## Sole next action

Translate the outputs of `claim4_pair_y_box_density` and `claim4_triple_x_box_density` into `Claim5MediumResidues` and `Claim5SmallResidues`, add reachable interface regressions, and do not yet credit quantitative representative bounds or separation.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and exact Claim 4 audit.
- `LEAN_FORMALIZATION_ROADMAP.md` — sole active execution roadmap.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — exact rejection of the false `(495,504,8)` construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
