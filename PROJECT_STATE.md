# Project State

> **Operational checkpoint synchronized on 2026-08-20.**
>
> **Erdős #678 mathematics and scientific evaluation S1 / S2a / S2b / S2c / S2d / S2e are closed and machine-verified. S2 is complete.**
>
> **Project methodology: `ERDOS_PROBLEM_SOLVING_PROTOCOL.md` v1 is the standard operational protocol under `DEC-013`, promoted from the #678 lessons.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Scientific credit belongs only to prospectively admitted artifacts/runs and to repository state that passed the required integration gates.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-complete-await-user-authorization
proof_frozen: true
repository_visibility: public
project_license: Apache-2.0

methodology_protocol: ERDOS_PROBLEM_SOLVING_PROTOCOL.md
methodology_protocol_version: v1
methodology_status: adopted
methodology_origin: erdos-678-postmortem
methodology_decision: DEC-013

s1_status: complete-integrated-postmerge-verified
s2_status: complete
s2a_status: complete-integrated-postmerge-verified-closure-verified
s2b_status: complete-integrated-postmerge-verified-closure-verified
s2c_status: complete-integrated-postmerge-verified-closure-verified
s2d_status: complete-integrated-postmerge-verified-closure-verified
s2e_status: complete-integrated-postmerge-verified-closure-verified

s2e_protocol: problems/678/S2_UPGRADE_ROBUSTNESS_PROTOCOL.md
s2e_candidate_matrix: problems/678/S2_UPGRADE_ROBUSTNESS_MATRIX.yaml
s2e_result_markdown: problems/678/S2_UPGRADE_ROBUSTNESS_RESULT.md
s2e_result_json: problems/678/S2_UPGRADE_ROBUSTNESS_RESULT.json

s2e_baseline_commit: 5039d464f6196e6b47494f0a6fae869e3362d082
s2e_baseline_lean: leanprover/lean4:v4.33.0
s2e_baseline_mathlib_resolved: db584cd6d46c92f209a44c0f1c829460d327499d
s2e_baseline_pnt: 2667e414c38e5a5dc9aa1946f16f13001e5cd3ed

s2e_credited_execution_pr: 53
s2e_credited_execution_pr_merged: false
s2e_credited_workflow_head: dfb7d1122e0e482626c9849f0e083ecbe71e58be
s2e_credited_run: 32170243744
s2e_credited_u1_job: 95819384522
s2e_credited_u2_job: 95819384599
s2e_credited_aggregate_job: 95822552072
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

s2e_evidence_pr: 55
s2e_evidence_final_head: 9176ba2669299cb60a6cd78324f2e7d6994a8d48
s2e_evidence_exact_head_run: 32174316252
s2e_evidence_exact_head_job: 95832572901
s2e_evidence_merge_commit: a0dffadfbba22325103170a8222d8adb10ffe6e9
s2e_evidence_postmerge_run: 32175057976
s2e_evidence_postmerge_job: 95834940169

s2e_closure_pr: 57
s2e_closure_final_head: 51aacbfb0fa56582baba4b6b5c6bc9730c0615ce
s2e_closure_exact_head_run: 32176992624
s2e_closure_exact_head_job: 95841104500
s2e_closure_merge_commit: 872be99ac79e3d905dd6d696e626d424331a1faa
s2e_closure_postmerge_run: 32177665772
s2e_closure_postmerge_job: 95843195690
s2e_closure_postmerge_commit_match: true
s2e_closure_postmerge_import_check: no-update-necessary
s2e_closure_postmerge_build_jobs: 8808

user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_scientific_gate: await-user-authorization
next_action: none-without-explicit-user-authorization
```

## Governing rules

- `DEC-013`: `ERDOS_PROBLEM_SOLVING_PROTOCOL.md` v1 is the standard operational lifecycle for future mathematical benchmarks; stricter governing/problem-specific rules still control.
- `DEC-011`: substantive integration uses a branch/PR, canonical exact-head CI, merge unchanged, then exact-main post-merge verification.
- `DEC-012`: completion/evaluation of #678 and adoption of the protocol never authorize another Erdős problem.
- `DEC-008`: documentation/state synchronization is an integration gate.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure, package-resolution, dependency-support, and project-owned failures are classified separately.
- Prospectively frozen experiments retain inconvenient, null, early, dependency-blocked, mixed, and surviving outcomes; designs are not silently changed after observation.
- A computationally successful run can still be scientifically excluded when a primary measurement or provenance/aggregation contract is invalid.
- S2e forbids third-party source repair and permits project-owned repair only after an eligible project-owned detection failure.
- Timing is metadata, not an S2e outcome metric.

## Project methodology — Protocol v1

The durable lessons of #678 are now promoted from a problem-specific postmortem into a reusable project method. `ERDOS_PROBLEM_SOLVING_PROTOCOL.md` defines gates `G0`–`G10` from authorization/state synchronization through statement audit, research-mode separation, falsification-first testing, proof stabilization, provenance, formalization, exact-head verification, scientific experiment governance where applicable, integration, archival closure, and postmortem.

The protocol preserves the central #678 controls: exact statement/indexing fidelity, negative regressions, witness-versus-infinitude separation, producer/consumer interfaces, pinned dependencies, canonical build-graph liveness, exact-head CI credit, bounded provenance language, failure-owner classification, and documentation synchronization.

Protocol adoption is methodological only. It does not reopen #678 mathematics, resume S2, or activate a new target.

## Closed checkpoints

### Mathematics / S1 / S2a–S2d

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or a first formalization. S1 and S2a–S2d are closed and closure-verified.

### S2e — upgrade robustness — CLOSED / CLOSURE VERIFIED

The complete credited detection is run `32170243744` on exact execution head `dfb7d1122e0e482626c9849f0e083ecbe71e58be`. Aggregate artifact `9337321640` independently rehashed to SHA-256 `90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`; complete-set ownership/provenance checks passed.

**U1:** D0 and D1 are green. All three D2 sentinels and D3 fail first in Mathlib/transitive dependency code. Deepest green = D1; primary owner = `mathlib_or_transitive_dependency`. No project-owned proof failure is reached.

**U2:** D0 is green. D1 package resolution fails before project compilation. Deepest green = D0; primary owner = `package_resolution`.

**Repair:** not applicable. Neither candidate reaches an eligible project-owned failure, so zero project repair batches were run.

Evidence PR #55 merged as `a0dffadfbba22325103170a8222d8adb10ffe6e9` and passed exact-main verification `32175057976` / `95834940169`. Closure PR #57 merged as `872be99ac79e3d905dd6d696e626d424331a1faa`; that exact `main` commit passed canonical run `32177665772` / job `95843195690` with matching commit, pinned dependencies, `No update necessary`, and **8808 jobs**.

The bounded conclusion is an exact-version dependency/package-boundary observation only. It does not imply general Lean/Mathlib incompatibility, general maintainability, future upgrade cost, proof-quality criticism of dependencies, human repair difficulty, or architecture superiority.

## Restart rule

Treat mathematics, S1, and S2 as complete. Apply `ERDOS_PROBLEM_SOLVING_PROTOCOL.md` to future authorized benchmarks, but do not resume S2 experimentation or start another Erdős problem unless the user explicitly authorizes new work. `DEC-012` remains binding.
