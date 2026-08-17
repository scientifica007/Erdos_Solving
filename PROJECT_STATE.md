# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős #678 mathematics, S1, S2a, S2b, and S2c are closed and machine-verified. S2d semantic/index mutation resistance is prospectively defined but has not been executed.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Verification and experimental credit belong only to artifacts, commits, and runs actually executed.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2d-predeclaration
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
s2c_protocol: problems/678/S2_REPAIR_LOCALITY_PROTOCOL.md
s2c_mutation_manifest: problems/678/S2_REPAIR_LOCALITY_MUTATIONS.yaml
s2c_baseline_markdown: problems/678/S2_REPAIR_LOCALITY_BASELINE.md
s2c_baseline_json: problems/678/S2_REPAIR_LOCALITY_BASELINE.json
s2c_internal_baseline: cc55073fceddb51e3fa2c1854f797fe989523985
s2c_predeclaration_commit: a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1
s2c_experiment_commit: 00d340d3ccdc13418615b6526e9b736d9f9e03e7
s2c_run: 32062501296
s2c_job: 95486770197
s2c_artifact_id: 9299556049
s2c_artifact_digest: sha256:0369ec66c689572307660765b0c84cd86b6339f4f4d26a788c560ca11f7b7f4b
s2c_primary_finding: repair-blast-radius-is-mixed-and-interface-layer-dependent-no-uniform-advantage
s2c_pr: 32
s2c_exact_head: 7471370081dece8ac99ec3888636d7d9cc0fa78f
s2c_exact_head_ci_run: 32065778293
s2c_exact_head_ci_job: 95497421954
s2c_merge_commit: bf54f5eb16e477d1b41b336e68ce82a729c98912
s2c_postmerge_ci_run: 32067478680
s2c_postmerge_job: 95502840936
s2c_closure_pr: 33
s2c_closure_exact_head: 3439b58f1e05e2cb21ee1c9374857eb3b4197163
s2c_closure_exact_head_ci_run: 32070637072
s2c_closure_exact_head_job: 95512851767
s2c_closure_exact_head_commit_match: true
s2c_closure_exact_head_import_check: no-update-necessary
s2c_closure_exact_head_build_jobs: 8808
s2c_closure_merge_commit: 47b85a2f2f5be6e6e4ede2b600723b8616aeeee4
s2c_closure_postmerge_ci_run: 32071325525
s2c_closure_postmerge_job: 95514986697
s2c_closure_postmerge_commit_match: true
s2c_closure_postmerge_import_check: no-update-necessary
s2c_closure_postmerge_build_jobs: 8808

s2d_status: predeclared-not-executed-pending-integration
s2d_internal_baseline: 47b85a2f2f5be6e6e4ede2b600723b8616aeeee4
s2d_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s2d_comparator_blob: f2331e8bcc71bc36cce7724a0c54fafd8d64d480
s2d_protocol: problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md
s2d_mutation_manifest: problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml
s2d_mutation_count: 3
s2d_observation_count_planned: 6
s2d_mutations:
  - I1-canonical-start-left-shift
  - I2-long-block-drop-final-term
  - I3-strengthen-canonical-separation-one
s2d_harness_status: forbidden-until-predeclaration-integrated-and-postmerge-verified
s2d_execution_status: not-executed

s2e_status: not-started
s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: exact-head verify and merge the S2d predeclaration-only PR; verify the resulting main commit; only then create the S2d harness and execute the frozen six observations
```

## Governing rules

- `DEC-011`: substantive integration uses a branch/PR, exact-head canonical CI, then post-merge verification on `main`.
- `DEC-012`: completion/evaluation of #678 never authorizes another Erdős problem.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure failures and proof failures are classified separately.
- Documentation/state synchronization is an integration gate (`DEC-008`).
- S2 metrics are descriptive evidence with explicit scope; no general architecture-superiority claim is allowed.
- A predeclared experiment that produces a mixed/null/surviving result is preserved rather than redesigned after observation.
- S2d mutations must remain type-correct semantic/index changes; identifier/API breakage belongs to closed S2c.
- No S2d proof repair is allowed during measurement: S2d measures rejection/survival depth, not repair effort.

## Closed checkpoints

### Mathematics / S1

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or first formalization. S1 differential verification and closure are complete.

### S2a

S2a dependency-surface evidence and closure are complete. Its binding control is that raw module/file/frontier counts mix decomposition, packaging, and ownership because PNT+ lies on different repository boundaries in the two source trees.

### S2b

S2b controlled build/resource evidence and its documentation closure are complete. The credited run `32053575928` supports no stable wall-clock winner while recording materially different user/system CPU and peak-memory profiles. Closure PR #31 merged as `cc55073fceddb51e3fa2c1854f797fe989523985`, and that exact merge passed post-merge run `32060186755`, job `95479480527`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

### S2c — repair locality — CLOSED / CLOSURE VERIFIED

S2c used a prospectively frozen declaration-rename experiment and retained its mixed/interface-dependent result. PR #32 integrated the evidence. Documentation closure PR #33 final head `3439b58f1e05e2cb21ee1c9374857eb3b4197163` passed run `32070637072`, job `95512851767`, then merged as `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`. That exact merge passed post-merge run `32071325525`, job `95514986697`, with matching `verified_commit`, `No update necessary`, and 8808 jobs. S2c is therefore fully closed.

## S2d — semantic/index mutation resistance — PREDECLARED / NOT EXECUTED

Historical motivation is the rejected interval-index construction recorded on 2026-08-14: `M(t,k+1)` was mistakenly treated as the shifted block `[t,t+k]` rather than `[t+1,t+k+1]`. S2d prospectively replays bounded, type-correct one-unit semantic drifts instead of identifier breaks.

Frozen design files on the current predeclaration branch:

- `problems/678/S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`;
- `problems/678/S2_SEMANTIC_INDEX_MUTATIONS.yaml`.

The three matched mutations are:

1. **I1 canonical start shift:** shift the canonical same-length block left by one at the primitive interval convention.
2. **I2 long-block endpoint:** remove exactly the final term from the `k+1`-term long block at the strong theorem interface.
3. **I3 separation control:** strengthen `n+k≤m` to `n+(k+1)≤m` at a canonical endpoint. This is intentionally a possible semantic-survival control: if a changed but still true target passes verification, that is retained as evidence that machine checking alone does not guarantee statement fidelity.

No harness exists and no S2d mutation has been executed. The predeclaration must pass exact-head CI, merge, and exact-main post-merge verification before apparatus creation is permitted.

## Required restart sequence

1. Treat mathematics, S1, S2a, S2b, and S2c as closed and machine-verified.
2. Treat the S2d protocol/manifest as proposed predeclaration only until their PR is integrated and post-merge verified.
3. Do not create the S2d harness or execute a mutation before that integration gate.
4. After the gate, execute exactly the frozen three mutations on both artifacts from pristine baselines, retaining early rejection, late rejection, and canonical survival alike.
5. Continue all scientific work only on archived #678.
6. **Do not start another Erdős problem without explicit user authorization.**