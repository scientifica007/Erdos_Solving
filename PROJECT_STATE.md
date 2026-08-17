# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős #678 mathematics, S1, S2a, and S2b are closed and machine-verified. S2c repair-locality is complete, integrated, and post-merge machine-verified; documentation closure is in progress.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Verification and experimental credit belong only to artifacts and commits actually executed.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2c-closure
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

s2c_status: complete-integrated-postmerge-verified
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
s2c_artifact_digest_local_revalidation: pass
s2c_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s2c_comparator_blob: f2331e8bcc71bc36cce7724a0c54fafd8d64d480
s2c_mutation_kind: declaration-identifier-rename-without-alias
s2c_mutation_count: 3
s2c_observation_count: 6
s2c_observable_breaks: 6
s2c_legal_repairs_green: 6
s2c_third_party_dependency_files_touched: 0
s2c_internal_repaired_reference_counts: [3, 2, 2]
s2c_comparator_repaired_reference_counts: [1, 1, 3]
s2c_internal_production_reference_counts: [2, 1, 0]
s2c_internal_verification_reference_counts: [1, 1, 2]
s2c_comparator_production_reference_counts: [1, 1, 3]
s2c_primary_finding: repair-blast-radius-is-mixed-and-interface-layer-dependent-no-uniform-advantage
s2c_scope: symbol-api-reference-repair-locality-not-general-maintainability
s2c_internal_canonical_reverification: all-three-mk-all-no-update-and-8808-job-build-success
s2c_pr: 32
s2c_exact_head: 7471370081dece8ac99ec3888636d7d9cc0fa78f
s2c_exact_head_ci_run: 32065778293
s2c_exact_head_ci_job: 95497421954
s2c_exact_head_commit_match: true
s2c_exact_head_import_check: no-update-necessary
s2c_exact_head_build_jobs: 8808
s2c_merge_commit: bf54f5eb16e477d1b41b336e68ce82a729c98912
s2c_postmerge_ci_run: 32067478680
s2c_postmerge_job: 95502840936
s2c_postmerge_commit_match: true
s2c_postmerge_import_check: no-update-necessary
s2c_postmerge_build_jobs: 8808

s2d_status: not-started
s2e_status: not-started
s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: exact-head verify and merge this documentation-only S2c closure; verify main; then predeclare S2d semantic/index mutations and success metrics before execution
```

## Governing rules

- `DEC-011`: substantive integration uses a branch/PR, exact-head canonical CI, then post-merge verification on `main`.
- `DEC-012`: completion/evaluation of #678 never authorizes another Erdős problem.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure failures and proof failures are classified separately.
- Documentation/state synchronization is an integration gate (`DEC-008`).
- S2 metrics are descriptive evidence with explicit scope; no general architecture-superiority claim is allowed.
- A predeclared experiment that produces a mixed/null result is preserved rather than redesigned after observation.

## Closed checkpoints

### Mathematics / S1

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or first formalization. S1 differential verification and closure are complete.

### S2a

S2a dependency-surface evidence and closure are complete. Its binding control is that raw module/file/frontier counts mix decomposition, packaging, and ownership because PNT+ lies on different repository boundaries in the two source trees.

### S2b

S2b controlled build/resource evidence and its documentation closure are complete. The credited run `32053575928` supports no stable wall-clock winner while recording materially different user/system CPU and peak-memory profiles. Closure PR #31 merged as `cc55073fceddb51e3fa2c1854f797fe989523985`, and that exact merge passed post-merge run `32060186755`, job `95479480527`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

## S2c — repair locality — COMPLETE / INTEGRATED / POST-MERGE VERIFIED

The mutation protocol and manifest were frozen at `a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1` before the harness and before observations. The apparatus commit is `00d340d3ccdc13418615b6526e9b736d9f9e03e7`; run `32062501296`, job `95486770197`, completed successfully.

The uploaded artifact `9299556049` has GitHub SHA-256 `0369ec66c689572307660765b0c84cd86b6339f4f4d26a788c560ca11f7b7f4b`; an independent post-run download produced the same SHA-256. Its exact `result.json` is persisted as `S2_REPAIR_LOCALITY_BASELINE.json`.

All six artifact×mutation observations produced the expected unknown-identifier break and all six legal identifier-only repairs returned green. Third-party/dependency touches were zero. Each internal repaired mutation additionally returned `mk_all = No update necessary` and a successful full build of 8808 jobs.

Raw repair-reference counts by layer:

| layer | internal | comparator |
|---|---:|---:|
| R1 analytic closure | 3 (2 production + 1 verification) | 1 production |
| R2 eventual construction | 2 (1 production + 1 verification) | 1 production |
| R3 strong endpoint | 2 verification, **0 production** | 3 production |

The result is deliberately recorded as **mixed**. R1/R2 expose more static references internally, while R3 reverses at the production layer. Therefore S2c does not support a uniform repair-locality or maintainability advantage for either artifact. It establishes only that reference blast radius depends on interface layer and on whether verification consumers are separated from production consumers.

PR #32 final head `7471370081dece8ac99ec3888636d7d9cc0fa78f` passed canonical run `32065778293`, job `95497421954`, with matching `verified_commit`, `No update necessary`, and 8808 jobs. It merged as `bf54f5eb16e477d1b41b336e68ce82a729c98912`; that exact merge commit passed post-merge run `32067478680`, job `95502840936`, again with matching `verified_commit`, `No update necessary`, and 8808 jobs.

This mixed result is scientifically useful because it blocks a tempting inference from modular source layout to general maintainability superiority.

## Required restart sequence

1. Treat mathematics, S1, S2a, and S2b as closed and machine-verified.
2. Treat S2c as complete, integrated, and post-merge machine-verified; its protocol, mutation set, result artifact, and mixed conclusion are frozen evidence.
3. Complete this documentation-only S2c closure through exact-head canonical CI, merge, and verification of the resulting exact `main` commit.
4. Only after that closure verification, start S2d by prospectively defining semantic/index mutations and success metrics before observing outcomes.
5. Continue all scientific work only on archived #678.
6. **Do not start another Erdős problem without explicit user authorization.**