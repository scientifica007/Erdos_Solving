# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős #678 mathematics, S1, and S2a are closed and machine-verified. S2b controlled build-behavior has executed successfully with six validated paired replicates and is awaiting canonical PR integration. S2c has not started.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This is the authoritative restart checkpoint. Verification credit belongs only to artifacts and commits actually executed.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2b-integration
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

s2b_status: executed-success-validated-pending-pr-integration
s2b_protocol: problems/678/S2_BUILD_BEHAVIOR_PROTOCOL.md
s2b_runner: problems/678/experiments/s2_build_behavior.py
s2b_aggregator: problems/678/experiments/s2_build_behavior_aggregate.py
s2b_baseline_markdown: problems/678/S2_BUILD_BEHAVIOR_BASELINE.md
s2b_baseline_json: problems/678/S2_BUILD_BEHAVIOR_BASELINE.json
s2b_pilot_status: excluded-whole-run-predeclared-provenance-invariant-failure
s2b_pilot_run: 32052134207
s2b_pilot_apparatus: a349010e295afa52d040feacbb2d02d5c081c548
s2b_credited_run: 32053575928
s2b_apparatus_commit: c2ef703c954e462096162a3b4a59a5e0f8d48488
s2b_replicates: 6
s2b_replicates_success: 6
s2b_retries: 0
s2b_exclusions: 0
s2b_runner_version: 2.336.0
s2b_runner_image: ubuntu24-20260810.271.1
s2b_internal_cold_wall_median_s: 159.575
s2b_comparator_cold_wall_median_s: 156.280
s2b_paired_cold_wall_median_difference_s: 4.06
s2b_paired_cold_wall_difference_range_s: [-10.68, 11.73]
s2b_wall_clock_conclusion: no-stable-winner-in-six-paired-runs
s2b_internal_cold_user_cpu_median_s: 176.105
s2b_comparator_cold_user_cpu_median_s: 480.580
s2b_internal_cold_system_cpu_median_s: 64.840
s2b_comparator_cold_system_cpu_median_s: 5.990
s2b_internal_cold_total_cpu_median_s: 241.155
s2b_comparator_cold_total_cpu_median_s: 486.475
s2b_paired_total_cpu_median_ratio_internal_over_comparator: 0.502837
s2b_internal_cold_max_rss_median_kib: 7183766
s2b_comparator_cold_max_rss_median_kib: 7828930
s2b_resource_conclusion: similar-wall-time-but-materially-different-cpu-and-memory-profile-under-pinned-common-environment

s2c_status: not-started
s2d_status: not-started
s2e_status: not-started
s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: synchronize S2b evidence; open PR; require canonical exact-head Lean Verification; merge only if green; verify main; only then start S2c repair-locality study
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

#678 is a machine-checked reconstruction of Cambie (2024), classified as an independent Lean reimplementation rather than new mathematics or first formalization. S1 executable differential verification closed through PR #22 and closure PR #27; `main` passed run `32045885504` with exact provenance, `No update necessary`, and 8808 jobs.

### S2a

S2a dependency-surface evidence closed through PR #28 and closure PR #29. The final closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed run `32050862725`, job `95449629511`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

Its scientific control remains binding: PNT+ lies on different repository boundaries in the two source trees, so raw module/file/frontier counts mix decomposition, packaging, and ownership.

## Active checkpoint — S2b result

The protocol predeclared six fresh paired `ubuntu-24.04` runner replicates with alternating order, common Lean/Mathlib/PNT+ environment, dependency preparation outside timing, artifact-owned cold cleanup, immediate warm repeat, and robust summaries.

The first green pilot (`32052134207`) is **not credited** because every result omitted the predeclared runner-version provenance field. The entire pilot was excluded before timing interpretation; no performance-selected exclusion occurred.

After making provenance fail-closed, run `32053575928` on exact apparatus commit `c2ef703c954e462096162a3b4a59a5e0f8d48488` completed 6/6 jobs successfully with no retries/exclusions. All six downloaded artifact digests matched GitHub and all `result.json` files recorded runner `2.336.0`, image `ubuntu24/20260810.271.1`, Lean 4.33.0, the exact Mathlib/PNT+ pins, exact comparator commit/blob, and zero build exit codes.

### Result interpretation

Cold wall time does **not** show a stable winner: paired differences change sign and range from `-10.68` to `+11.73 s`; medians are `159.575 s` internal versus `156.280 s` comparator.

The resource profile is substantially different under the common environment. Median cold user CPU is `176.105 s` internal versus `480.580 s` comparator; median cold system CPU is `64.840 s` versus `5.990 s`; median total CPU is `241.155 s` versus `486.475 s`; max RSS medians are `7,183,766 KiB` versus `7,828,930 KiB`. This supports a descriptive claim of different execution profiles, not a universal speed/quality claim.

The causal explanation—e.g. modular process/file overhead versus monolithic elaboration cost—remains an inference for later investigation, not an S2b theorem.

## Required restart sequence

1. Treat mathematics, S1, and S2a as closed.
2. Treat S2b evidence as executed/validated but not integrated until its PR passes exact-head CI and `main` post-merge verification.
3. Do not start S2c before S2b integration closes.
4. Continue all scientific work only on archived #678.
5. **Do not start another Erdős problem without explicit user authorization.**
