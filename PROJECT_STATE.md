# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős Problem #678 mathematics and scientific stage S1 are complete, integrated, and post-merge verified. S2 is active on archived #678 only. S2a dependency-surface measurement has executed successfully and is awaiting canonical PR integration.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This file is the authoritative restart checkpoint. Proof/CI credit is tied to the repository tree actually executed, not inferred from file presence or GitHub metadata alone.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2a-dependency-surface-integration
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
repository_rulesets_at_public_transition: none-detected

s1_status: complete-integrated-postmerge-verified
s1_scientific_experiment_run: 32028006457
s1_merge_commit: 358cd541ff81a2b59611b7addfc90ae17e03b36f
s1_closure_merge_commit: 7aff8d8d8680e90b34be64650c68c0fc778749fc
s1_closure_postmerge_ci_run: 32045885504

s2_status: active
s2_current_substage: S2a-dependency-surface
s2a_protocol: problems/678/S2_DEPENDENCY_SURFACE_PROTOCOL.md
s2a_analyzer: problems/678/experiments/s2_dependency_surface.py
s2a_baseline_markdown: problems/678/S2_DEPENDENCY_SURFACE_BASELINE.md
s2a_baseline_json: problems/678/S2_DEPENDENCY_SURFACE_BASELINE.json
s2a_experiment_status: executed-success-pending-pr-integration
s2a_experiment_commit: 4685fca552ae4a0270dfa3823d46fde48efa5ade
s2a_experiment_run: 32047324807
s2a_experiment_job: 95438118197
s2a_artifact_id: 9293347138
s2a_artifact_digest: sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd
s2a_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s2a_comparator_entry_blob: f2331e8bcc71bc36cce7724a0c54fafd8d64d480
s2a_identity_validation: pass
s2a_internal_reachable_modules: 46
s2a_internal_local_edges: 58
s2a_internal_max_depth: 33
s2a_internal_artifact_owned_lines: 5546
s2a_comparator_reachable_local_modules: 10
s2a_comparator_local_edges: 10
s2a_comparator_max_depth: 4
s2a_comparator_artifact_owned_modules: 1
s2a_comparator_artifact_owned_lines: 2546
s2a_comparator_third_party_repository_local_modules: 9
s2a_comparator_third_party_repository_local_lines: 6943
s2a_metric_scope: module-import-structure-not-proof-complexity
s2a_primary_finding: dependency-surface-counts-are-boundary-sensitive-because-pnt-packaging-differs

s2b_status: not-started
s2c_status: not-started
s2d_status: not-started
s2e_status: not-started
s2f_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: open the S2a PR; require canonical exact-head Lean Verification on its final head; merge only if green; verify main; only then start S2b controlled build-behavior measurements
```

## Governing rules

- `DEC-011`: `main` is the stable integration branch; substantive work uses a dedicated branch/PR and exact-head canonical CI before merge.
- `DEC-012`: completion of #678 does not authorize work on another Erdős problem.
- `lake exe mk_all --check` and the full reachable Lean build define canonical machine verification.
- CI evidence is credited to the commit actually checked out; metadata labels alone are insufficient.
- Infrastructure failures and proof failures are classified separately.
- State/roadmap/README synchronization is a project gate.
- Public visibility does not relax attribution, provenance, licensing, or verification requirements.
- S2 measurements are experimental evidence; no architecture-superiority claim is allowed before controlled measurements support it.

## Closed checkpoints

### Mathematics

#678 is complete and archived. Final reachable endpoints include `cambie_lcm_ratio_eventually_with_large_start`, `erdos678_unbounded_witnesses`, and `erdos678_good_lengths_infinite`. The project pins `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` and consumes its machine-checked `prime_between` theorem.

### S1

S1 differential verification is closed. Run `32028006457` established the common-environment cross-artifact result. PR #22 passed exact-head run `32043807200`, merged as `358cd541...`, and passed post-merge verification in `32044314748` attempt 2. Closure PR #27 merged as `7aff8d8d...` and passed post-merge run `32045885504` with exact provenance, `No update necessary`, and 8808 jobs.

## S2a — dependency surface — EXECUTED

The S2a analyzer ran at exact internal commit `4685fca552ae4a0270dfa3823d46fde48efa5ade` in run `32047324807`, job `95438118197`. The workflow validated the internal commit and fixed comparator commit/blob, generated JSON/Markdown evidence, and uploaded an artifact with digest `sha256:9723b6e2...`.

Canonical-result structural baseline:

| Metric | Internal | Comparator |
|---|---:|---:|
| reachable local modules | 46 | 10 |
| local import edges | 58 | 10 |
| max local import depth | 33 | 4 |
| external-frontier modules | 14 | 27 |
| artifact-owned modules | 46 | 1 |
| artifact-owned source lines | 5546 | 2546 |
| third-party repository-local support modules | 0 | 9 |
| third-party repository-local support lines | 0 | 6943 |

The correct interpretation is **not** that one architecture is better. The important result is that dependency metrics are boundary-sensitive: PNT+ is an external Lake dependency internally, but its source is physically repository-local in the comparator. Raw module/file/frontier counts therefore mix decomposition, dependency packaging, and ownership unless normalized.

This boundary result becomes a control for later S2 experiments. Build, repair, mutation, and upgrade studies must distinguish project-owned failure/repair surface from external or repository-local third-party support.

The exact executed baseline is recorded in `S2_DEPENDENCY_SURFACE_BASELINE.md` and machine-readable summary JSON. Full module/edge output is reproducible with the analyzer and was generated in the run artifact.

## Public-artifact governance

The repository is Public and Apache-2.0 licensed. The comparator remains an immutable external fetch, not vendored source. No repository ruleset was detected at public transition; configure `main` protection before accepting outside contributions.

A non-blocking Actions warning was observed: the currently pinned checkout action targets Node 20 and GitHub forces it onto Node 24. This is retained as an environment/maintenance observation, not part of the S2a dependency metric.

## Required restart sequence

1. Treat #678 mathematics and S1 as closed.
2. Treat S2a experiment evidence as executed but not integrated until its PR passes canonical exact-head CI and post-merge verification.
3. Do not start S2b before S2a integration closes.
4. Continue all experiments only on archived #678.
5. **Do not start another Erdős problem without explicit user authorization.**
