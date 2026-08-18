# Project State

> **Operational checkpoint synchronized on 2026-08-18.**
>
> **Erdős #678 mathematics, S1, S2a, S2b, S2c, and S2d are closed and machine-verified. S2e upgrade robustness is prospectively predeclared but has not been executed.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Verification and experimental credit belong only to artifacts, commits, and runs actually executed and scientifically admitted.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2e-predeclaration
proof_frozen: true
repository_visibility: public
project_license: Apache-2.0

s1_status: complete-integrated-postmerge-verified
s1_experiment_run: 32028006457
s1_closure_merge_commit: 7aff8d8d8680e90b34be64650c68c0fc778749fc
s1_closure_postmerge_run: 32045885504

s2_status: active
s2a_status: complete-integrated-postmerge-verified-closure-verified
s2a_closure_merge_commit: c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5
s2a_closure_postmerge_run: 32050862725
s2a_primary_finding: dependency-surface-counts-are-boundary-sensitive

s2b_status: complete-integrated-postmerge-verified-closure-verified
s2b_credited_run: 32053575928
s2b_apparatus_commit: c2ef703c954e462096162a3b4a59a5e0f8d48488
s2b_primary_finding: no-stable-wall-clock-winner-with-materially-different-cpu-memory-profile-under-pinned-common-environment
s2b_closure_pr: 31
s2b_closure_merge_commit: cc55073fceddb51e3fa2c1854f797fe989523985
s2b_closure_postmerge_ci_run: 32060186755
s2b_closure_postmerge_job: 95479480527

s2c_status: complete-integrated-postmerge-verified-closure-verified
s2c_primary_finding: repair-blast-radius-is-mixed-and-interface-layer-dependent-no-uniform-advantage
s2c_closure_pr: 33
s2c_closure_merge_commit: 47b85a2f2f5be6e6e4ede2b600723b8616aeeee4
s2c_closure_postmerge_ci_run: 32071325525
s2c_closure_postmerge_job: 95514986697
s2c_closure_postmerge_commit_match: true
s2c_closure_postmerge_import_check: no-update-necessary
s2c_closure_postmerge_build_jobs: 8808

s2d_status: complete-integrated-postmerge-verified-closure-verified
s2d_protocol: problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md
s2d_mutation_manifest: problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml
s2d_baseline_markdown: problems/678/S2_SEMANTIC_INDEX_BASELINE.md
s2d_baseline_json: problems/678/S2_SEMANTIC_INDEX_BASELINE.json
s2d_internal_baseline: 47b85a2f2f5be6e6e4ede2b600723b8616aeeee4
s2d_predeclaration_head: 5aaef5a667ee11cc526beae587cf9ab799727f7e
s2d_predeclaration_pr: 34
s2d_predeclaration_merge: 2db145226bf530f406e734129fd8a451a2ab3899
s2d_excluded_pilot_run: 32074822049
s2d_excluded_pilot_job: 95525626029
s2d_excluded_pilot_scope: entire-run
s2d_excluded_pilot_reason: comparator-main-theorem-logical-classification-defect
s2d_credited_apparatus_head: a82ae53b57a9f97844013a9b2e96a9182cee241d
s2d_credited_run: 32076614547
s2d_credited_job: 95531085803
s2d_artifact_id: 9303987121
s2d_artifact_digest: sha256:29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881
s2d_semantic_rejections: 6
s2d_semantic_survivors: 0
s2d_proof_repairs: 0
s2d_third_party_dependency_source_touches: 0
s2d_primary_finding: all-three-predeclared-semantic-index-perturbations-rejected-in-both-artifacts-with-layer-dependent-detection
s2d_pr: 35
s2d_final_head: 1a5728574f3d2c5101851becfb2500400aa395bd
s2d_exact_head_ci_run: 32078084197
s2d_exact_head_ci_job: 95535434320
s2d_merge_commit: 891d7b9e51c3ecc1313ee2de8d2a98036841b128
s2d_postmerge_ci_run: 32102682942
s2d_postmerge_ci_job: 95606121109
s2d_closure_pr: 36
s2d_closure_final_head: 46b52c2c8ed1c4dd0623974c82c367071618f71b
s2d_closure_exact_head_ci_run: 32103456742
s2d_closure_exact_head_ci_job: 95608318715
s2d_closure_merge_commit: 5039d464f6196e6b47494f0a6fae869e3362d082
s2d_closure_postmerge_ci_run: 32103947182
s2d_closure_postmerge_ci_job: 95609642835
s2d_closure_postmerge_commit_match: true
s2d_closure_postmerge_import_check: no-update-necessary
s2d_closure_postmerge_build_jobs: 8808

s2e_status: predeclared-not-executed-pending-integration
s2e_baseline_commit: 5039d464f6196e6b47494f0a6fae869e3362d082
s2e_protocol: problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md
s2e_candidate_matrix: problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml
s2e_candidate_count: 2
s2e_candidates:
  - U1-lean-4.34.0-rc1-compiler-only
  - U2-lean-mathlib-4.34.0-rc1-root-upgrade
s2e_baseline_lean: leanprover/lean4:v4.33.0
s2e_baseline_mathlib_input: v4.33.0
s2e_baseline_mathlib_resolved: db584cd6d46c92f209a44c0f1c829460d327499d
s2e_baseline_pnt: 2667e414c38e5a5dc9aa1946f16f13001e5cd3ed
s2e_candidate_lean: leanprover/lean4:v4.34.0-rc1
s2e_candidate_mathlib_tag: v4.34.0-rc1
s2e_candidate_mathlib_commit: de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11
s2e_pnt_main_at_predeclaration: 2667e414c38e5a5dc9aa1946f16f13001e5cd3ed
s2e_newer_coordinated_pnt_provider_at_predeclaration: false
s2e_harness_status: forbidden-until-predeclaration-integrated-and-postmerge-verified
s2e_execution_status: not-executed
s2e_repair_budget_batches: 12
s2e_repair_budget_files: 10
s2e_repair_budget_line_churn: 250
s2e_dependency_source_repairs_allowed: false

s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: exact-head verify and merge the S2e predeclaration-only PR; verify the exact resulting main commit; only then create the fail-closed S2e apparatus and execute exactly U1 and U2 from pristine baselines
```

## Governing rules

- `DEC-011`: substantive integration uses a branch/PR, exact-head canonical CI, then post-merge verification on `main`.
- `DEC-012`: completion/evaluation of #678 never authorizes another Erdős problem.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure failures, dependency-support failures, and project-owned proof/source failures are classified separately.
- Documentation/state synchronization is an integration gate (`DEC-008`).
- S2 metrics are descriptive evidence with explicit scope; no general architecture-superiority claim is allowed.
- Prospectively frozen experiments retain mixed, null, dependency-blocked, early-failure, and surviving results rather than redesigning after observation.
- A computationally successful run may still be scientifically excluded if a primary predeclared measurement is instrumented incorrectly.
- S2e forbids third-party source repair and distinguishes dependency-support blockers from project-owned compatibility failures.

## Closed checkpoints

### Mathematics / S1

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or first formalization. S1 differential verification and closure are complete.

### S2a

Dependency-surface evidence is closure-verified. Raw dependency/module counts are boundary-sensitive and are not proof-complexity or architecture-quality metrics.

### S2b

Controlled build/resource evidence is closure-verified. The credited six-replicate run found no stable wall-clock winner while recording materially different CPU/memory profiles under the pinned common environment.

### S2c

Repair-locality evidence is closure-verified. The result is mixed/interface-dependent and supports no uniform repair-locality or maintainability advantage.

### S2d — semantic/index mutation resistance — CLOSED / CLOSURE VERIFIED

The three semantic/index mutations were prospectively frozen, all six artifact×mutation observations were rerun under a corrected primary classifier after excluding the first pilot in full, and all six credited observations were rejected with zero proof repairs or dependency-source edits.

The substantive evidence merged through PR #35 and was post-merge verified. Documentation closure PR #36 final head `46b52c2c8ed1c4dd0623974c82c367071618f71b` passed run `32103456742`, job `95608318715`, then merged as `5039d464f6196e6b47494f0a6fae869e3362d082`. That exact `main` commit passed push run `32103947182`, job `95609642835`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**. S2d is therefore fully closure-verified.

## S2e — upgrade robustness — PREDECLARED / NOT EXECUTED

S2e measures exact version-transition compatibility and bounded project-owned repair surface for the archived internal artifact. It is intentionally not another cross-artifact ranking.

Frozen baseline: S2d closure merge `5039d464f6196e6b47494f0a6fae869e3362d082`, Lean `v4.33.0`, Mathlib `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`, PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

Frozen forward candidates:

1. **U1 compiler-only:** Lean `v4.34.0-rc1`, baseline Mathlib/PNT source and manifest identities unchanged; no `lake update`.
2. **U2 root Lean+Mathlib RC:** Lean `v4.34.0-rc1` plus exact Mathlib commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` (tag provenance `v4.34.0-rc1`), with PNT+ fixed at `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

At predeclaration time PNT+ `main` equals that same baseline PNT commit, so there is no newer coordinated PNT provider revision to substitute. This is a design constraint, not an experiment result.

Detection is staged: candidate identity → package resolution → three project-owned Mathlib-only sentinels → external PNT support boundary → project PNT boundary → canonical #678 endpoint → canonical import/full graph. Dependency-support failures are retained as such and are never patched in third-party source.

Project repair, if eligible, occurs only after a complete no-repair detection pass and under a fixed budget of 12 batches, 10 project-owned files, and 250 aggregate changed lines. Canonical theorem headers and key regression files are immutable semantic-fidelity controls.

Full prospective definitions are frozen in:

- `problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- `problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`.

**No S2e harness exists and no U1/U2 candidate has been executed.** The predeclaration must pass exact-head CI, merge, and exact-main post-merge verification before apparatus creation is allowed.

## Required restart sequence

1. Treat mathematics, S1, S2a, S2b, S2c, and S2d as closed and machine-verified.
2. Treat the S2e protocol/matrix as prospective predeclaration only until integrated and post-merge verified.
3. Do not create an S2e harness or run U1/U2 before that integration gate.
4. After the gate, build a fail-closed apparatus implementing exactly the frozen candidate identities, detection stages, ownership taxonomy, semantic-fidelity invariants, and repair budgets.
5. Execute U1 and U2 from pristine baseline copies and retain dependency-blocked, project-failure, repaired, or survivor outcomes alike.
6. Continue all scientific work only on archived #678.
7. **Do not start another Erdős problem without explicit user authorization.**
