# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős Problem #678 mathematics is complete, machine-checked, integrated, post-merge verified, and archived. Scientific-evaluation stage S1 is also complete: the differential-verification artifact is integrated into public `main` and post-merge verified.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This file is the authoritative restart checkpoint. Proof/CI credit is tied to the repository tree actually executed, not inferred from file presence or GitHub metadata alone.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s1-complete-ready-for-s2
current_mode: external-proof-reconstruction
proof_frozen: true

external_problem_status: proved
mathematical_author: Stijn-Cambie
project_reconstruction_status: proved-machine-checked-integrated-main-verified
project_formalization_classification: independent-lean-reimplementation
independent_attempt_status: rejected
first_formalization_claim: false
new_mathematical_proof_claim: false

repository_visibility: public
project_license: Apache-2.0
project_license_main_commit: 87cf560451ef5aa4714069d52a3851c1f8547f70
repository_rulesets_at_public_transition: none-detected

s1_scientific_experiment_status: success
s1_experiment_run: 32028006457
s1_experiment_job: 95381414710
s1_experiment_head: b1e3fc60f6dc4f125a125121a2abbcf3610ed749
s1_experiment_build_jobs: 8808
s1_public_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s1_public_comparator_compiled_unchanged_in_internal_environment: true
s1_matched_axiom_footprint: propext-Classical.choice-Quot.sound

s1_integration_pr: 22
s1_premerge_head: 1c6bea992033390ac4364033fafcd221694baf4c
s1_premerge_ci_run: 32043807200
s1_premerge_ci_job: 95427648473
s1_premerge_ci_result: success
s1_premerge_verified_commit_match: true
s1_premerge_build_jobs: 8808
s1_merge_commit: 358cd541ff81a2b59611b7addfc90ae17e03b36f
s1_postmerge_ci_run: 32044314748
s1_postmerge_ci_attempt: 2
s1_postmerge_ci_job: 95429173912
s1_postmerge_ci_result: success
s1_postmerge_verified_commit_match: true
s1_postmerge_import_check: no-update-necessary
s1_postmerge_build_jobs: 8808
s1_repository_integration_status: complete-public-main-verified

postmerge_attempt_1_classification: transient-infrastructure-failure
postmerge_attempt_1_root_cause: HTTP-502-downloading-Lean
postmerge_attempt_1_proof_failure: false

ci_provenance_audit_status: correction-recorded-and-validated
canonical_workflow: explicit-head-checkout-plus-git-rev-parse-head
public_ci_hardening: contents-read-only-persist-credentials-false-actions-pinned-by-sha
private_billing_blocker_status: resolved-by-public-transition

s2_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: after this S1-closure synchronization itself passes PR CI and merges cleanly, begin S2 metric-and-mutation work on archived #678 only; separately configure main protection/ruleset before accepting outside contributions
```

## Governing rules

- `DEC-011`: `main` is the stable integration branch; substantive work uses a dedicated branch/PR and exact-head canonical CI before merge.
- `DEC-012`: completion of #678 does not authorize work on another Erdős problem.
- `lake exe mk_all --check` and the full reachable Lean build define canonical machine verification.
- CI evidence is credited to the commit actually checked out; metadata labels alone are insufficient.
- Infrastructure failures and proof failures are classified separately.
- State/roadmap/README synchronization is a project gate, not optional bookkeeping.
- Public visibility does not relax attribution, provenance, licensing, or verification requirements.

## Mathematical #678 checkpoint — closed

The final reachable graph proves:

- `cambie_lcm_ratio_eventually_with_large_start`;
- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`.

The analytic boundary pins

`AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`

and consumes its machine-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

Important mathematical verification remains anchored by final E4 run `31977861568` and mathematical post-merge run `32011189766`.

The earlier independent route remains rejected because it used the false scaling identity `M(t*n,k)=t*M(n,k)` and later a wrong interval in a `Q=P/M` construction. The valid witness `M(36,8)>M(47,9)` and machine-refuted `(495,504,8)` candidate remain regression evidence.

## S1 — differential verification — COMPLETE

The scientific experiment itself succeeded in run `32028006457` on exact head `b1e3fc60...` and established:

- canonical graph build with 8808 jobs;
- machine bridges to public `Finset.Ioc` interval semantics and Formal-Conjectures-style eventual existence;
- explicit unbounded/infinite valid-length endpoints;
- lift of the strong theorem to every real `C ≥ 1`;
- unchanged compilation of `plby/lean-proofs@6f906fef...` #678 source inside our pinned Lean 4.33 / Mathlib / PNT+ environment;
- matched selected-endpoint axiom footprint `[propext, Classical.choice, Quot.sound]`.

The persistent S1 artifact then passed the repaired exact-head PR gate:

- PR #22 head: `1c6bea992033390ac4364033fafcd221694baf4c`;
- run `32043807200`, job `95427648473`: **SUCCESS**;
- logged checkout and `verified_commit` both equal the PR head;
- `mk_all`: `No update necessary`;
- build: **8808 jobs**.

PR #22 merged as

`358cd541ff81a2b59611b7addfc90ae17e03b36f`.

Post-merge run `32044314748` attempt 1 failed before Lean setup completed because `releases.lean-lang.org` returned HTTP 502. This is retained as a transient infrastructure failure, not a proof failure. Attempt 2, job `95429173912`, then:

- checked out `358cd541ff81a2b59611b7addfc90ae17e03b36f` exactly;
- logged the same `verified_commit`;
- installed Lean 4.33.0;
- checked the pinned PNT/Mathlib revisions;
- returned `No update necessary` from `mk_all`;
- completed the full build successfully with **8808 jobs**.

Therefore S1 scientific evidence and repository integration are both closed.

## Public-artifact checkpoint

The repository is Public and GitHub recognizes Apache-2.0. `THIRD_PARTY_NOTICES.md` records provenance and redistribution boundaries. The public comparator remains an immutable external fetch rather than vendored source because no comparator repository license was detected during the audit.

No repository ruleset was detected immediately after the public transition. Before accepting outside contributions, configure `main` protection in GitHub so normal integration remains PR + required Lean verification, with force-push/deletion protection.

## Required restart sequence

1. Verify current `main` and repository visibility.
2. Treat #678 mathematics and S1 as closed checkpoints.
3. Do not start another Erdős problem without explicit authorization.
4. S2 may begin only within #678 after this closure-documentation PR itself passes canonical CI and is integrated.
5. Keep all S2 architecture/performance claims experimental until controlled evidence exists.
