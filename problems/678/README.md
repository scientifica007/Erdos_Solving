# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Current repository status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
> The earlier independent attempt remains rejected. The completed result is an external-proof reconstruction and independent Lean reimplementation of Cambie (2024). The canonical operational sources are `PROJECT_STATE.md` and `LEAN_FORMALIZATION_ROADMAP.md`.
> Per `DEC-012`, the project remains at this archived checkpoint until the user explicitly authorizes moving to another Erdős problem.

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
- `lake exe mk_all --check` = `No update necessary`;
- full build = **8806 jobs**.

Integration and post-merge verification:

- PR #17 merged into `main` on 2026-08-17;
- mathematical merge commit `8fd1b20541ac7782f52429db3a2cc4c887547372`;
- post-merge Lean Verification run `32011189766` — **SUCCESS**;
- `lake exe mk_all --check` = `No update necessary`;
- full `lake build` = **8806 jobs**.

Archival documentation synchronization:

- PR #18 exact head `4c5a305c8756c5dc0d8e5545825a87d48a438965`;
- Lean Verification run `32013917788` — **SUCCESS**;
- merged archival documentation commit `755c9601816fbbd7e2181a2e56c34f28667ceb67`.

Final lessons/postmortem integration:

- PR #20 exact head `6fffdc71d2166004fe9e6d412ea3d0b1dd739e53`;
- exact-head Lean Verification run `32019975193` — **SUCCESS**;
- merge commit `4596a360257a3f659d2a260b4cb00b22d0ffa94c`;
- post-merge Lean Verification run `32021192337` — **SUCCESS**.

## Exact project classification

- External problem status: proved.
- Repository reconstruction status: **proved / machine-checked / integrated / post-merge verified / archived**.
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
- Post-merge canonical verification: passed through run `32011189766`.
- Final postmortem verification: passed through run `32021192337`.
- User transition gate: explicit authorization required before any other Erdős problem may become active.

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

The analytic input is the pinned package `AxiomMath/PrimeNumberTheoremAnd` at revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

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

## Scientific positioning and external value

The completed artifact is **not** a new solution of #678 and **not** the first Lean formalization. A prior public formalization by Aristotle and Boris Alexeev exists on top of Cambie's mathematics.

The current scientific opportunity is instead to use this independently reconstructed artifact in two ways:

1. **formal differential verification / proof engineering** — compare our modular, regression-heavy architecture and direct `prime_between` PNT interface with the public Aristotle/Alexeev development;
2. **AI-assisted scientific-production research** — analyze the preserved path from failed independent reasoning to machine-checked reconstruction, including target fidelity, failure retention, externalized state, dependency closure, canonical build verification, and exact-head CI.

Canonical dossier:

- `SCIENTIFIC_COMPARATIVE_STUDY.md` — external comparison, claim boundaries, quantitative architecture, testable hypotheses, and candidate upstream contributions;
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` — longitudinal AI-for-science case study, failure taxonomy, research questions, threats to validity, and prospective experiments;
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md` — staged plan for common-environment comparison, upstream work, empirical extensions, and publication decisions.

These documents do not reopen the mathematics and do not authorize transition to another Erdős problem.

## Archival disposition

No mathematical phase remains open. Integration and post-merge verification are complete. **#678 is archived as a completed benchmark.**

Scientific comparison, reproducibility analysis, and publication/upstream work on the already completed #678 artifact are permitted archival follow-up. They must not be misclassified as new mathematical discovery.

**Stop at this checkpoint. Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.** Do not reopen D4 or E1–E4 mathematics unless a concrete regression is found.

## Main references inside this folder

- `SCIENTIFIC_COMPARATIVE_STUDY.md` — comparative scientific positioning against Cambie, Aristotle/Alexeev, Formal Conjectures, and current AI-for-math work.
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` — #678 as an auditable long-horizon AI-assisted scientific-production case.
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md` — evidence gates and sequencing for external outputs.
- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit; contains historical development-status passages and is not the current operational state source.
- `LEAN_FORMALIZATION_ROADMAP.md` — canonical execution roadmap, now closed, integrated, verified, and archived.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false earlier construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
