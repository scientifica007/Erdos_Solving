# Project State

> **Operational checkpoint synchronized on 2026-08-18.**
>
> **Erdős #678 mathematics, S1, S2a, S2b, S2c, and S2d are closed and machine-verified. S2e upgrade-robustness detection has been executed successfully and independently artifact-validated; substantive evidence integration is now the active gate.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Scientific credit belongs only to prospectively admitted artifacts/runs and to repository state that passes the required integration gates.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2e-evidence-integration
proof_frozen: true
repository_visibility: public
project_license: Apache-2.0

s1_status: complete-integrated-postmerge-verified
s2_status: active
s2a_status: complete-integrated-postmerge-verified-closure-verified
s2b_status: complete-integrated-postmerge-verified-closure-verified
s2c_status: complete-integrated-postmerge-verified-closure-verified
s2d_status: complete-integrated-postmerge-verified-closure-verified

s2d_closure_merge_commit: 5039d464f6196e6e4ede2b600723b8616aeeee4
s2d_closure_postmerge_ci_run: 32103947182
s2d_closure_postmerge_ci_job: 95609642835
s2d_closure_postmerge_import_check: no-update-necessary
s2d_closure_postmerge_build_jobs: 8808

s2e_status: detection-executed-success-artifact-validated-pending-evidence-integration
s2e_protocol: problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md
s2e_candidate_matrix: problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml
s2e_baseline_markdown: problems/678/S2_UPGRADE_ROBUSTNESS_BASELINE.md
s2e_baseline_json: problems/678/S2_UPGRADE_ROBUSTNESS_BASELINE.json
s2e_baseline_commit: 5039d464f6196e6b47494f0a6fae869e3362d082
s2e_baseline_lean: leanprover/lean4:v4.33.0
s2e_baseline_mathlib_input: v4.33.0
s2e_baseline_mathlib_resolved: db584cd6d46c92f209a44c0f1c829460d327499d
s2e_baseline_pnt: 2667e414c38e5a5dc9aa1946f16f13001e5cd3ed
s2e_candidate_count: 2
s2e_candidates:
  - U1-lean-4.34.0-rc1-compiler-only
  - U2-lean-mathlib-4.34.0-rc1-root-upgrade
s2e_candidate_lean: leanprover/lean4:v4.34.0-rc1
s2e_candidate_mathlib_commit: de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11
s2e_newer_coordinated_pnt_provider_at_predeclaration: false

s2e_predeclaration_pr: 38
s2e_predeclaration_head: c733ac4baae1a53b20d2e395eaab5c938683a74a
s2e_predeclaration_exact_head_run: 32105032799
s2e_predeclaration_exact_head_job: 95612654549
s2e_predeclaration_merge: 0fcefd7ea8cb3753a80a3f93c2498841b1938e55
s2e_predeclaration_postmerge_run: 32105520785
s2e_predeclaration_postmerge_job: 95614030394

s2e_core_apparatus_commit: 1b241344377d80e9cc4532ec1b92f884e71dc837
s2e_runtime_primary_owner_wrapper_commit: fdfee69c0672067469d6916f630c61e345579ed7
s2e_combiner_commit: 4e18481d34ccf609cd5ee7ea2726f2ef1a7f0c63
s2e_integrated_instrumentation_main: eaf77afd8db3e9e3c32770b953eb2c0ef8a61be7
s2e_instrumentation_postmerge_run: 32164784651
s2e_instrumentation_postmerge_job: 95801720316

s2e_excluded_execution_runs:
  - 32114757196
  - 32139077608
  - 32161655865
  - 32168529883
s2e_exclusion_policy: complete-affected-run-or-candidate-set
s2e_exclusion_reasons:
  - baseline-timeout-2400-before-candidates
  - baseline-timeout-7200-before-candidates
  - D1-primary-owner-classifier-defect
  - aggregate-artifact-transport-http-401-before-combiner

s2e_transport_audit_pr: 52
s2e_transport_audit_run: 32170073082
s2e_transport_audit_job: 95818872837
s2e_transport_audit_result: pass-synthetic-no-candidate-execution

s2e_credited_execution_pr: 53
s2e_credited_execution_pr_merged: false
s2e_credited_workflow_head: dfb7d1122e0e482626c9849f0e083ecbe71e58be
s2e_credited_run: 32170243744
s2e_credited_u1_job: 95819384522
s2e_credited_u2_job: 95819384599
s2e_credited_aggregate_job: 95822552072
s2e_u1_artifact_id: 9337314559
s2e_u1_artifact_digest: sha256:d06ce516f34f509d307ab121242c60b7dca95ecff6646355783a544caa846ac7
s2e_u2_artifact_id: 9337277099
s2e_u2_artifact_digest: sha256:fadbb09d97c96292838d25ed1cf89297a14918dfe4c24772e3e880ed464470c7
s2e_complete_artifact_id: 9337321640
s2e_complete_artifact_digest: sha256:90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c
s2e_complete_artifact_independent_digest_match: true
s2e_complete_artifact_file_count: 40
s2e_combine_audit: pass
s2e_ownership_validation: pass
s2e_apparatus_failures_in_credited_set: 0
s2e_repair_outputs_in_credited_set: 0

s2e_u1_deepest_green_stage: D1
s2e_u1_primary_failure_owner: mathlib_or_transitive_dependency
s2e_u1_dependency_support_blocked: true
s2e_u1_project_owned_failure_reached: false
s2e_u2_deepest_green_stage: D0
s2e_u2_primary_failure_owner: package_resolution
s2e_u2_project_owned_failure_reached: false
s2e_repair_phase: not-applicable-no-eligible-project-owned-failure
s2e_repair_batches: 0
s2e_project_owned_files_repaired: 0
s2e_third_party_dependency_source_touches: 0
s2e_primary_finding: both-exact-frozen-forward-candidates-blocked-at-dependency-or-package-boundaries-before-eligible-project-owned-repair

s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: canonical-exact-head-verify-and-merge-the-S2e-evidence-only-PR; verify-the-exact-resulting-main-commit; then-create-a-documentation-only-S2e-closure-PR-before-S2f
```

## Governing rules

- `DEC-011`: substantive integration uses a branch/PR, canonical exact-head CI, merge unchanged, then exact-main post-merge verification.
- `DEC-012`: evaluation/completion of #678 never authorizes another Erdős problem.
- `DEC-008`: documentation/state synchronization is an integration gate.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure, package-resolution, dependency-support, and project-owned failures are classified separately.
- Prospectively frozen experiments retain inconvenient, null, early, dependency-blocked, mixed, and surviving outcomes; designs are not silently changed after observation.
- A computationally successful run can still be scientifically excluded when a primary measurement or provenance/aggregation contract is invalid.
- S2e forbids third-party source repair and permits project-owned repair only after an eligible project-owned detection failure.
- Timing is metadata, not an S2e outcome metric.

## Closed checkpoints

### Mathematics / S1 / S2a–S2d

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or a first formalization. S1 and S2a–S2d are closed. S2d closure merge `5039d464...` passed exact-main run `32103947182`, job `95609642835`, with `No update necessary` and 8808 jobs.

## S2e — upgrade robustness — DETECTION EXECUTED / ARTIFACT VALIDATED

S2e asked where two exact prospectively frozen forward version candidates first become incompatible, and whether any project-owned compatibility repair becomes eligible.

The complete credited detection is run `32170243744` on exact execution head `dfb7d112...`. U1, U2, and the complete-set aggregate jobs all succeeded. Aggregate artifact `9337321640` independently rehashed to the GitHub digest `90f72854...001c`; its fail-closed combine/ownership/provenance audits all pass.

**U1:** D0 and D1 are green. All three D2 sentinels and D3 fail first in Mathlib/transitive dependency code. Deepest green = D1; primary owner = `mathlib_or_transitive_dependency`. No project-owned proof failure is reached.

**U2:** D0 is green. D1 package resolution selects the exact frozen Mathlib candidate but terminates after dependency-version mismatch warnings with `error: mathlib: failed to fetch cache`. Deepest green = D0; primary owner = `package_resolution`.

**Repair:** not applicable. Neither candidate reaches an eligible project-owned failure, so the frozen repair phase correctly executes zero repair batches and yields no repair-surface metric.

Full persisted evidence is in `S2_UPGRADE_ROBUSTNESS_BASELINE.md/.json`; exact raw logs/results remain in complete artifact `9337321640`.

The bounded conclusion is an exact-version dependency/package-boundary observation only. It does not imply general Lean/Mathlib incompatibility, general maintainability, future upgrade cost, proof-quality criticism of dependencies, human repair difficulty, or architecture superiority.

## Required restart sequence

1. Treat mathematics, S1, S2a, S2b, S2c, and S2d as closed and machine-verified.
2. Treat S2e detection run `32170243744` as scientifically credited and artifact-validated, but repository integration remains pending until the evidence PR passes exact-head CI, merges, and its exact main commit passes post-merge CI.
3. Do not execute an S2e repair phase: it is prospectively inapplicable because no eligible project-owned failure was reached.
4. After substantive evidence integration is exact-main verified, perform a documentation-only S2e closure PR and verify it under the same discipline.
5. Do not begin S2f before S2e closure is complete.
6. Continue all scientific work only on archived #678.
7. **Do not start another Erdős problem without explicit user authorization.**
