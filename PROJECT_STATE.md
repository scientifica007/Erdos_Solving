# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős Problem #678 mathematics and scientific stage S1 are complete, integrated, and post-merge verified. S2 is now active on archived #678 only; current substage S2a measures dependency-surface structure.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This file is the authoritative restart checkpoint. Proof/CI credit is tied to the repository tree actually executed, not inferred from file presence or GitHub metadata alone.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s2a-dependency-surface
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
s1_integration_pr: 22
s1_merge_commit: 358cd541ff81a2b59611b7addfc90ae17e03b36f
s1_postmerge_ci_run: 32044314748
s1_closure_pr: 27
s1_closure_merge_commit: 7aff8d8d8680e90b34be64650c68c0fc778749fc
s1_closure_postmerge_ci_run: 32045885504
s1_closure_postmerge_build_jobs: 8808

s2_status: active
s2_current_substage: S2a-dependency-surface
s2a_protocol: problems/678/S2_DEPENDENCY_SURFACE_PROTOCOL.md
s2a_analyzer: problems/678/experiments/s2_dependency_surface.py
s2a_experiment_status: implementation-ready-not-yet-executed
s2a_internal_entry: Formalization.Erdos678.Erdos678Final
s2a_comparator_repository: plby/lean-proofs
s2a_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s2a_comparator_entry_blob: f2331e8bcc71bc36cce7724a0c54fafd8d64d480
s2a_metric_scope: module-import-structure-not-proof-complexity
s2a_ownership_boundary: separate-artifact-owned-repository-support-third-party-repository-local-support

s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required-for-another-erdos-problem
next_action: add and execute the pinned S2a GitHub workflow; inspect generated structural metrics; persist the executed baseline and limitations; require canonical exact-head Lean CI before merging the S2a PR
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

#678 is complete and archived. Final reachable endpoints include:

- `cambie_lcm_ratio_eventually_with_large_start`;
- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`.

The project pins `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed` and consumes its machine-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

### S1

S1 differential verification is closed. The core experiment run `32028006457` built the internal graph with 8808 jobs and compiled the pinned public comparator unchanged in our Lean 4.33 / Mathlib / PNT+ environment. PR #22 passed exact-head run `32043807200`, merged as `358cd541...`, and passed post-merge verification in run `32044314748` attempt 2. The closure synchronization PR #27 merged as `7aff8d8d...` and passed post-merge run `32045885504` with exact commit provenance, `No update necessary`, and 8808 jobs.

## S2a — dependency surface — ACTIVE

S2a deliberately measures **module/import structure**, not theorem-level proof complexity.

The analyzer separates:

1. `artifact_owned` modules;
2. `repository_local_support` modules;
3. `third_party_repository_local_support` modules;
4. unresolved external import frontier.

This separation is required because PNT+ is an external pinned Lake dependency in this repository, while the public comparator repository physically contains `src/latest/PrimeNumberTheoremAnd/...`. Raw repository file counts would therefore conflate proof architecture, packaging, and third-party ownership.

The first profile compares the canonical result modules:

- internal: `Formalization.Erdos678.Erdos678Final`;
- public: `ErdosProblems.Erdos678` at the fixed S1 comparator commit/blob.

Recorded structural metrics include reachable local modules/edges/depth, external frontier, ownership-class module/line/declaration counts, and auditable module/edge lists.

No conclusion such as “simpler”, “lower coupling”, “faster”, “easier to maintain”, or “more robust” follows from S2a alone.

## Public-artifact governance

The repository is Public and Apache-2.0 licensed. `THIRD_PARTY_NOTICES.md` records provenance/redistribution boundaries. The comparator remains an immutable external fetch, not vendored source.

No repository ruleset was detected at the public-transition checkpoint. Before accepting outside contributions, configure `main` protection in GitHub so ordinary integration remains PR + required Lean verification, with force-push/deletion protection.

## Required restart sequence

1. Verify current `main`, active S2 branch/PR, and `PROJECT_STATE.md`.
2. Treat #678 mathematics and S1 as closed checkpoints.
3. Continue only S2 work on archived #678.
4. Execute S2a at immutable internal/comparator identities and persist the result only after inspecting the actual run.
5. Keep all S2 architecture/performance interpretations within the explicit claim limits.
6. **Do not start another Erdős problem without explicit user authorization.**
