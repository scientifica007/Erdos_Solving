# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Current repository status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED INTO `main`.**
> The earlier independent attempt remains rejected. The completed result is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k ≥ 3` with `m ≥ n+k` such that `M(n,k) > M(m,k+1)`?

The repository proves this conclusion in Lean.

## Final formal theorem

`Erdos678Final.lean` contains:

- `erdos678_unbounded_witnesses`: for every lower bound `B : ℕ`, there exist `n,m,k` such that
  - `B ≤ k`,
  - `3 ≤ n`, `3 ≤ m`, `3 ≤ k`,
  - `n + k ≤ m`, and
  - `erdosM m (k+1) < erdosM n k`;
- `erdos678_good_lengths_infinite`: the set of block lengths `k` admitting such canonical witnesses is infinite.

Thus the formalized conclusion is stronger than merely recording infinitely many unnamed triples: valid witnesses occur at unbounded block lengths.

## Verification and integration checkpoints

Final E4 mathematical checkpoint:

- head `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`;
- canonical run `31976903757` — **SUCCESS**;
- `lake exe mk_all --check` = `No update necessary`;
- full `lake build` = **8806 jobs**.

Final synchronized E4 head:

- head `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`;
- canonical run `31977861568` — **SUCCESS**;
- full build = **8806 jobs**.

Integration:

- PR #17 merged into `main` on 2026-08-17;
- merge commit `8fd1b20541ac7782f52429db3a2cc4c887547372`;
- post-merge Lean Verification run `32011189766` was started on that exact merge commit and must be checked for its final conclusion before archival credit.

## Exact project classification

- External problem status: proved.
- Repository reconstruction status: **proved / machine-checked / integrated into `main`**.
- Independent proof attempt in this repository: rejected.
- Valid concrete witness: `M(36,8) > M(47,9)` — machine-checked.
- Rejected candidate: `(495,504,8)` — machine-refuted and retained as a negative regression.
- Full Claim 5: machine-checked.
- Claim 4 / Phase D: passed.
- Phase E1 quantitative LCM-ratio estimate: passed.
- Phase E2 prime-density existence: passed using pinned PNT+.
- Phase E3 strong eventual Cambie theorem: passed.
- Phase E4 canonical index translation and infinitude: passed.
- Integration into `main`: passed through PR #17.

## Proof architecture live in Lean

| Layer | Status |
|---|---|
| length-based intervals and canonical `erdosM` | machine-checked |
| positive and negative concrete regressions | machine-checked |
| finite product/LCM valuation core | machine-checked |
| all three Claim 5 prime ranges + assembly | machine-checked |
| Claim 4 finite density / modular / weighted CRT | machine-checked |
| pair/triple CRT producers and exact application boxes | machine-checked |
| constructed scales, full-scale factorization, dependent placement | machine-checked |
| Cambie target window and sharp search budgets | machine-checked |
| E1 cancellation-safe product/LCM estimate | machine-checked |
| E2 five-strip relative-prime adapter | machine-checked |
| E2 PNT `prime_between` → relative-prime provider | machine-checked |
| E3 elementary large-`k` growth threshold | machine-checked |
| E3 strong eventual Cambie comparison | machine-checked |
| E4 `k<x` recovery and canonical `n=x-1, m=y-1` translation | machine-checked |
| unbounded canonical witnesses and infinitely many good lengths | machine-checked |

## Prime-density dependency

No opaque prime-density hypothesis is left in the theorem.

The analytic input is the pinned package

`AxiomMath/PrimeNumberTheoremAnd`

at revision

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

Its kernel-checked `prime_between` consequence is converted into the natural-number `Claim4RelativePrimeProvider`, then into five disjoint additive prime strips with denominator `320*C`.

E2 exit: head `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856`, **8800 jobs**.

## Strong Cambie layer

The remaining large-`k` condition is discharged independently using the fourth binomial coefficient. The explicit coarse threshold is

`claim4CambieLargeKThreshold C = max 9 (3840*C + 3)`.

The theorem `cambie_lcm_ratio_eventually` combines this elementary growth threshold with the PNT threshold.

E3 exit: head `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891`, **8804 jobs**.

## Historical independent-attempt failure

The project first found the valid finite witness `(36,47,8)` but later asserted the false scaling identity

```text
M(t*n,k) = t*M(n,k).
```

This is false because `M(t*n,k)` is the LCM of `tn+1,...,tn+k`, not of `t(n+1),...,t(n+k)`. A subsequent `Q=P/M` construction also used the wrong interval for `M(t,k+1)`.

Those failures remain recorded as provenance and are not reclassified by the successful Cambie reconstruction.

## Current next action

No mathematical phase remains open and integration is complete. Confirm the post-merge `main` CI. If green, archive #678 as a completed benchmark and move project attention to the next selected problem. Do not reopen D4 or E1–E4 mathematics unless a concrete regression is found.

## Main references inside this folder

- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit.
- `LEAN_FORMALIZATION_ROADMAP.md` — canonical execution roadmap, now closed and integrated.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false earlier construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
