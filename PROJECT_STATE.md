# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős #678 mathematics, S1, S2a, and S2b are closed, integrated, and closure-verified. S2c repair-locality is active with its mutation protocol predeclared and no repair observations collected yet.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Verification/experimental credit belongs only to artifacts and commits actually executed.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2c-repair-locality-predeclared
proof_frozen: true
repository_visibility: public
project_license: Apache-2.0

s1_status: complete-integrated-postmerge-verified
s1_experiment_run: 32028006457
s1_closure_merge_commit: 7aff8d8d8680e90b34be64650c68c0fc778749fc
s1_closure_postmerge_run: 32045885504

s2_status: active
s2a_status: complete-integrated-postmerge-verified-closure-verified
s2a_experiment_run: 32047324807
s2a_merge_commit: 37deb850f894d32863970aca6b07e876f89e813d
s2a_closure_merge_commit: c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5
s2a_closure_postmerge_run: 32050862725
s2a_primary_finding: dependency-surface-counts-are-boundary-sensitive

s2b_status: complete-integrated-postmerge-verified-closure-verified
s2b_credited_run: 32053575928
s2b_apparatus_commit: c2ef703c954e462096162a3b4a59a5e0f8d48488
s2b_replicates_success: 6
s2b_wall_clock_conclusion: no-stable-winner-in-six-paired-runs
s2b_resource_conclusion: similar-wall-time-but-materially-different-cpu-and-memory-profile-under-pinned-common-environment
s2b_pr: 30
s2b_exact_head: e52e85d9b328a9cbc2349a6b61e23187dcc72fb5
s2b_exact_head_ci_run: 32055813783
s2b_merge_commit: c9900f9e2590f3101fc24f3f894f43b6fcf4e03c
s2b_postmerge_ci_run: 32058421851
s2b_postmerge_job: 95473817638
s2b_closure_pr: 31
s2b_closure_exact_head: 594ea7adb59a291d28a320e8d4c88fe4579312f6
s2b_closure_exact_head_ci_run: 32059445520
s2b_closure_merge_commit: cc55073fceddb51e3fa2c1854f797fe989523985
s2b_closure_postmerge_ci_run: 32060186755
s2b_closure_postmerge_job: 95479480527
s2b_closure_postmerge_commit_match: true
s2b_closure_postmerge_import_check: no-update-necessary
s2b_closure_postmerge_build_jobs: 8808

s2c_status: active-predeclared-not-executed
s2c_protocol: problems/678/S2_REPAIR_LOCALITY_PROTOCOL.md
s2c_mutation_manifest: problems/678/S2_REPAIR_LOCALITY_MUTATIONS.yaml
s2c_internal_baseline: cc55073fceddb51e3fa2c1854f797fe989523985
s2c_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s2c_comparator_blob: f2331e8bcc71bc36cce7724a0c54fafd8d64d480
s2c_mutation_kind: declaration-identifier-rename-without-alias
s2c_mutation_count: 3
s2c_observations_collected: 0
s2c_scope: symbol-api-repair-locality-not-general-maintainability
s2d_status: not-started
s2e_status: not-started
s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: implement fail-closed S2c harness from the frozen manifest; execute all three matched mutations independently; retain all six side-by-mutation observations; do not modify the mutation set after observing results
```

## Governing rules

- `DEC-011`: substantive integration uses a branch/PR, exact-head canonical CI, then post-merge verification on `main`.
- `DEC-012`: completion/evaluation of #678 never authorizes another Erdős problem.
- `lake exe mk_all --check` plus the full reachable Lean build define canonical machine verification.
- Infrastructure failures and proof failures are classified separately.
- Documentation/state synchronization is itself an integration gate (`DEC-008`).
- S2 metrics are descriptive evidence with explicit scope; no general architecture-superiority claim is allowed.

## Closed checkpoints

### Mathematics / S1

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or first formalization. S1 differential verification and closure are complete.

### S2a

S2a dependency-surface evidence and closure are complete. Its binding control is that raw module/file/frontier counts mix decomposition, packaging, and ownership because PNT+ lies on different repository boundaries in the two source trees.

### S2b

The credited six-replicate common-environment run is `32053575928`; it supports no stable wall-clock winner but records materially different user/system CPU and peak-memory profiles. The earlier fully green pilot `32052134207` remains excluded because required runner-version provenance was missing.

Substantive PR #30 passed exact-head run `32055813783`, merged as `c9900f9e2590f3101fc24f3f894f43b6fcf4e03c`, and passed post-merge run `32058421851`. Documentation/evidence closure PR #31 passed exact-head run `32059445520`, merged as `cc55073fceddb51e3fa2c1854f797fe989523985`, and that exact merge passed run `32060186755`, job `95479480527`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

## S2c — repair locality — PREDECLARED

S2c deliberately measures a narrow quantity: the project-owned **API/reference repair blast radius** induced by a declaration rename that preserves proposition and proof body. It does not measure semantic robustness or general maintainability.

Three matched logical layers are frozen before execution:

1. R1 analytic-input closure: `claim4RelativePrimeProviderOfPNT` ↔ `density_proof`;
2. R2 eventual construction: `claim4_exists_cambie_lcm_ratio_eventually_of_pnt` ↔ `exists_xy_for_large_k`;
3. R3 strong public endpoint: `cambie_lcm_ratio_eventually_with_large_start_real` ↔ `main_theorem_given_pnt`.

Each mutation independently renames the declaration only, requires the un-repaired artifact to fail if a downstream reference exists, then permits only exact downstream identifier substitution. Project-owned production and verification references are counted separately; third-party/dependency edits must remain zero. The full frozen rules and interpretation limits are in `S2_REPAIR_LOCALITY_PROTOCOL.md` and `S2_REPAIR_LOCALITY_MUTATIONS.yaml`.

No mutation has yet been executed and no repair result has yet been observed at this checkpoint.

## Required restart sequence

1. Treat mathematics, S1, S2a, and S2b as closed and machine-verified.
2. Treat the S2c mutation set as frozen before observations.
3. Build a fail-closed harness that validates exact baselines and executes all three mutations independently.
4. Do not alter the mutation set after observing outcomes; a protocol defect requires marking the affected run exploratory/excluded and rerunning the full corrected set.
5. Do not start S2d before S2c integration and post-merge verification close.
6. Continue all scientific work only on archived #678.
7. **Do not start another Erdős problem without explicit user authorization.**
