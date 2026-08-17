# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős #678 mathematics, S1, S2a, S2b, and S2c are closed and machine-verified. S2d semantic/index mutation resistance has executed under a prospectively frozen mutation set; the credited artifact is validated and awaits final PR integration.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Verification and experimental credit belong only to artifacts, commits, and runs actually executed and scientifically admitted.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2d-integration
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
s2b_wall_clock_conclusion: no-stable-winner-in-six-paired-runs
s2b_resource_conclusion: similar-wall-time-but-materially-different-cpu-and-memory-profile-under-pinned-common-environment
s2b_closure_pr: 31
s2b_closure_merge_commit: cc55073fceddb51e3fa2c1854f797fe989523985
s2b_closure_postmerge_ci_run: 32060186755
s2b_closure_postmerge_job: 95479480527
s2b_closure_postmerge_commit_match: true
s2b_closure_postmerge_import_check: no-update-necessary
s2b_closure_postmerge_build_jobs: 8808

s2c_status: complete-integrated-postmerge-verified-closure-verified
s2c_primary_finding: repair-blast-radius-is-mixed-and-interface-layer-dependent-no-uniform-advantage
s2c_pr: 32
s2c_merge_commit: bf54f5eb16e477d1b41b336e68ce82a729c98912
s2c_postmerge_ci_run: 32067478680
s2c_postmerge_job: 95502840936
s2c_closure_pr: 33
s2c_closure_exact_head: 3439b58f1e05e2cb21ee1c9374857eb3b4197163
s2c_closure_exact_head_ci_run: 32070637072
s2c_closure_exact_head_job: 95512851767
s2c_closure_merge_commit: 47b85a2f2f5be6e6e4ede2b600723b8616aeeee4
s2c_closure_postmerge_ci_run: 32071325525
s2c_closure_postmerge_job: 95514986697
s2c_closure_postmerge_commit_match: true
s2c_closure_postmerge_import_check: no-update-necessary
s2c_closure_postmerge_build_jobs: 8808

s2d_status: executed-success-artifact-validated-pending-pr-integration
s2d_protocol: problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md
s2d_mutation_manifest: problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml
s2d_baseline_markdown: problems/678/S2_SEMANTIC_INDEX_BASELINE.md
s2d_baseline_json: problems/678/S2_SEMANTIC_INDEX_BASELINE.json
s2d_internal_baseline: 47b85a2f2f5be6e6e4ede2b600723b8616aeeee4
s2d_predeclaration_head: 5aaef5a667ee11cc526beae587cf9ab799727f7e
s2d_predeclaration_pr: 34
s2d_predeclaration_exact_head_run: 32073161789
s2d_predeclaration_exact_head_job: 95520595880
s2d_predeclaration_merge: 2db145226bf530f406e734129fd8a451a2ab3899
s2d_predeclaration_postmerge_run: 32073820006
s2d_predeclaration_postmerge_job: 95522556326
s2d_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s2d_comparator_blob: f2331e8bcc71bc36cce7724a0c54fafd8d64d480
s2d_mutation_count: 3
s2d_observation_count: 6
s2d_excluded_pilot_run: 32074822049
s2d_excluded_pilot_job: 95525626029
s2d_excluded_pilot_artifact_id: 9303487756
s2d_excluded_pilot_artifact_digest: sha256:815e676189486afa15876589043e563f9a1d69d18a27c72e766c660993e40faf
s2d_excluded_pilot_reason: comparator-main-theorem-logical-classification-defect
s2d_excluded_pilot_scope: entire-run
s2d_credited_apparatus_head: a82ae53b57a9f97844013a9b2e96a9182cee241d
s2d_credited_run: 32076614547
s2d_credited_job: 95531085803
s2d_credited_trigger: pull_request-exact-head
s2d_artifact_id: 9303987121
s2d_artifact_size_bytes: 74518
s2d_artifact_digest: sha256:29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881
s2d_artifact_digest_local_revalidation: pass
s2d_semantic_rejections: 6
s2d_semantic_survivors: 0
s2d_proof_repairs: 0
s2d_third_party_dependency_source_touches: 0
s2d_i1_internal_first_rejection: L1-concrete-semantic-oracle-after-mutated-source-elaborated
s2d_i1_comparator_first_rejection: local-invariant-lcmInterval_ge_choose
s2d_i2_internal_first_rejection: L0-mutated-strong-endpoint-source-type-mismatch
s2d_i2_comparator_first_rejection: strong-theorem-main_theorem
s2d_i3_internal_first_rejection: L0-mutated-canonical-endpoint-source-application-type-mismatch
s2d_i3_comparator_first_rejection: canonical-corollary-erdos_678_kmn_infinite
s2d_primary_finding: all-three-predeclared-semantic-index-perturbations-rejected-in-both-artifacts-with-layer-dependent-detection
s2d_scope: three-predeclared-one-unit-type-correct-semantic-index-perturbations-only
s2d_general_semantic_robustness_claim: unsupported
s2d_pr: 35

s2e_status: not-started
s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: synchronize final S2d evidence on PR 35; require canonical exact-head Lean Verification on the final PR head; merge only if green; verify exact resulting main commit; then perform documentation-only S2d closure before S2e
```

## Governing rules

- `DEC-011`: substantive integration uses a branch/PR, exact-head canonical CI, then post-merge verification on `main`.
- `DEC-012`: completion/evaluation of #678 never authorizes another Erdős problem.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure failures and proof failures are classified separately.
- Documentation/state synchronization is an integration gate (`DEC-008`).
- S2 metrics are descriptive evidence with explicit scope; no general architecture-superiority claim is allowed.
- A predeclared experiment that produces a mixed/null/surviving result is preserved rather than redesigned after observation.
- S2d mutations are type-correct semantic/index changes; identifier/API breakage belongs to closed S2c.
- S2d contains no proof-repair phase: it measures rejection/survival location only.
- A computationally green run is scientifically excluded if a predeclared primary measurement classification is instrumented incorrectly.

## Closed checkpoints

### Mathematics / S1

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or first formalization. S1 differential verification and closure are complete.

### S2a

S2a dependency-surface evidence and closure are complete. Its durable control is that raw dependency counts are boundary-sensitive.

### S2b

S2b controlled build/resource evidence and closure are complete. The credited six-replicate run found no stable wall-clock winner while recording materially different CPU/memory profiles under the pinned common environment.

### S2c

S2c repair-locality evidence and closure are complete. Its result is mixed/interface-dependent and supports no uniform repair-locality or maintainability advantage.

## S2d — semantic/index mutation resistance — EXECUTED / VALIDATED

The protocol and three matched mutations were frozen and fully integrated through PR #34 before apparatus creation. The frozen internal source baseline is `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`.

The first computationally successful pilot run `32074822049` is excluded in full because post-run audit found a defect in the comparator logical-layer classifier: `main_theorem : MainTheoremStatement` was categorized as a generic local lemma instead of a strong theorem. Since rejection classification is a primary metric, the run was not relabeled post hoc. Only the classifier was corrected; the mutation set and checks remained frozen, and all six observations were rerun.

The credited exact-head PR-event run `32076614547`, job `95531085803`, on apparatus head `a82ae53b57a9f97844013a9b2e96a9182cee241d` completed successfully. Artifact `9303987121` has GitHub SHA-256 `29f9cd51e8862dd028dcc92086dc795450c1585938bc379688a2cf99dbc59881`; an independent download produced the same digest.

All six observations were semantic rejections; there were no survivors, no proof repairs, and no third-party/dependency source edits.

| mutation | internal first rejection | comparator first rejection |
|---|---|---|
| I1 canonical start shift | `L1` concrete numerical oracle, after mutated `erdosM` source built | local invariant `lcmInterval_ge_choose` |
| I2 drop long-block final term | `L0` mutated strong endpoint source, type mismatch | strong theorem `main_theorem` |
| I3 strengthen separation | `L0` mutated canonical endpoint source, application type mismatch | canonical corollary `erdos_678_kmn_infinite` |

The defensible conclusion is limited: **the three frozen one-unit semantic/index perturbations were rejected in both artifacts, but the first encoded rejection location depended on mutation and artifact structure.** In particular, I1 demonstrates distinct value from the internal independent concrete oracle because the type-correct primitive mutation itself elaborated before that oracle rejected it.

This does not support a general semantic-robustness ranking. Internal staged modules and comparator monolithic declaration classes are not a shared ordinal robustness scale.

Full validated evidence is in `S2_SEMANTIC_INDEX_BASELINE.md/.json`; exact raw `result.json` and logs remain in artifact `9303987121`.

## Required restart sequence

1. Treat mathematics, S1, S2a, S2b, and S2c as closed and machine-verified.
2. Treat S2d predeclaration as frozen/integrated and the credited run/artifact above as the executed result.
3. Complete S2d state/evidence synchronization on PR #35.
4. Require canonical exact-head Lean Verification on the final PR #35 head; merge only if green.
5. Verify the exact resulting `main` commit, then close S2d documentation through the same DEC-008/DEC-011 discipline.
6. Do not start S2e until S2d closure verification is complete.
7. Continue all scientific work only on archived #678.
8. **Do not start another Erdős problem without explicit user authorization.**
