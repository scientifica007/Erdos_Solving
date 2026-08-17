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

Scientific dossier integration:

- PR #21 exact head `a9c336e66f4bf0853d03378f44ad33ebca89dfaf`;
- exact-head Lean Verification run `32025245681` — **SUCCESS**;
- merge commit `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`;
- post-merge Lean Verification run `32026434043` — **SUCCESS**.

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
- Scientific positioning dossier: integrated and post-merge verified through PR #21/run `32026434043`.
- S1 differential-verification experiment: **successful**; persistent-artifact integration is the current task.
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
| `erdosM` ↔ public `Finset.Ioc` interval semantics bridge | machine-checked in S1 experiment |
| Formal-Conjectures-style eventual nonempty endpoint | machine-checked in S1 experiment |
| strong Cambie factor lifted from positive `ℕ` to every real `C ≥ 1` | machine-checked in S1 experiment |

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

The scientific opportunity is to use this independently reconstructed artifact in two ways:

1. **formal differential verification / proof engineering** — compare our modular, regression-heavy architecture and direct `prime_between` PNT interface with the public Aristotle/Alexeev development;
2. **AI-assisted scientific-production research** — analyze the preserved path from failed independent reasoning to machine-checked reconstruction, including target fidelity, failure retention, externalized state, dependency closure, canonical build verification, and exact-head CI.

### S1 executed differential verification

S1 has produced executable evidence rather than a prose-only comparison.

GitHub Actions run `32028006457`, job `95381414710`, on exact experiment head `b1e3fc60f6dc4f125a125121a2abbcf3610ed749`:

- built the complete internal canonical graph with the new statement bridge — **SUCCESS**, `No update necessary`, **8808 jobs**;
- fetched `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` and verified comparator blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- compiled the public `Erdos678.lean` **unchanged** in this repository's pinned Lean 4.33 / Mathlib / PNT+ environment — **SUCCESS**;
- established the same selected-endpoint axiom footprint on both sides: `propext`, `Classical.choice`, `Quot.sound`;
- machine-proved our interval semantics equal the public `Finset.Ioc n (n+k)` convention;
- machine-derived the Formal Conjectures eventual-nonempty endpoint;
- machine-lifted the retained natural-factor strong theorem to every real `C ≥ 1`, including a regression at `C=3/2`.

This establishes statement/interface/environment compatibility and matched axiom baselines. It does **not** establish architecture superiority, performance superiority, or genealogical independence.

Canonical dossier:

- `SCIENTIFIC_COMPARATIVE_STUDY.md` — external comparison, claim boundaries, quantitative architecture, testable hypotheses, and candidate upstream contributions;
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` — longitudinal AI-for-science case study, failure taxonomy, research questions, threats to validity, and prospective experiments;
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md` — staged plan for common-environment comparison, upstream work, empirical extensions, and publication decisions;
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml` — machine-readable frozen provenance, metrics, comparison anchors, claim limits, and missing measurements;
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md` — exact S1 comparison protocol and success criteria;
- `S1_DIFFERENTIAL_VERIFICATION_RESULT.md` — narrative result and scientific interpretation of executed S1;
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml` — machine-readable S1 environment/run/axiom evidence;
- `experiments/run_public_comparator_common_env.sh` — persistent pinned reproduction script; the public source is fetched ephemerally and is not redistributed here.

These artifacts do not reopen the mathematics and do not authorize transition to another Erdős problem.

## Archival disposition

No original mathematical proof phase remains open. Integration and post-merge verification of the mathematical result are complete. **#678 remains archived as a completed benchmark.**

Scientific comparison, reproducibility analysis, and publication/upstream work on the already completed #678 artifact are permitted archival follow-up. They must not be misclassified as new mathematical discovery.

**Stop at this checkpoint for mathematical work. Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.** Do not reopen D4 or E1–E4 mathematics unless a concrete regression is found.

## Main references inside this folder

- `SCIENTIFIC_COMPARATIVE_STUDY.md` — comparative scientific positioning against Cambie, Aristotle/Alexeev, Formal Conjectures, and current AI-for-math work.
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` — #678 as an auditable long-horizon AI-assisted scientific-production case.
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md` — evidence gates and sequencing for external outputs.
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml` — machine-readable evidence and claim ledger for future papers/upstream work.
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md` — frozen S1 protocol.
- `S1_DIFFERENTIAL_VERIFICATION_RESULT.md` — executed S1 result.
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml` — machine-readable S1 evidence.
- `experiments/run_public_comparator_common_env.sh` — pinned common-environment comparator reproduction script.
- `CAMBIE_PROOF_ANALYSIS.md` — mathematical architecture and Claim 4 audit; contains historical development-status passages and is not the current operational state source.
- `LEAN_FORMALIZATION_ROADMAP.md` — canonical execution roadmap, now closed, integrated, verified, and archived.
- `FORMALIZATION_CORRECTION_2026-08-14.md` — rejection of the false earlier construction.
- `LEAN_TEST_PLAN.md` — superseded historical plan; not an execution source.
