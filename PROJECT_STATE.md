# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős Problem #678 mathematics is complete, machine-checked, integrated into `main`, post-merge verified, and archived. The only authorized active work is scientific evaluation and public-release preparation of that archived artifact.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This file is the authoritative restart checkpoint. Proof/CI credit must be tied to the repository tree actually executed, not inferred from file presence or GitHub metadata alone.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s1-public-release-preflight
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: true

external_problem_status: proved
mathematical_author: Stijn-Cambie
project_reconstruction_status: proved-machine-checked-integrated-main-verified
project_formalization_classification: independent-lean-reimplementation
independent_attempt_status: rejected
first_formalization_claim: false
new_mathematical_proof_claim: false

scientific_evaluation_authorized: true
scientific_evaluation_scope: erdos678-only
scientific_dossier_main_baseline: 0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e
current_target: complete-public-release-transition-then-close-s1-integration

s1_scientific_experiment_status: success
s1_experiment_run: 32028006457
s1_experiment_job: 95381414710
s1_experiment_head: b1e3fc60f6dc4f125a125121a2abbcf3610ed749
s1_canonical_build_jobs: 8808
s1_public_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s1_public_comparator_compiled_unchanged_in_internal_environment: true
s1_matched_axiom_footprint: propext-Classical.choice-Quot.sound
s1_repository_integration_status: pending-fresh-final-head-ci

ci_provenance_audit_status: correction-recorded
historical_pr_checkout_issue: default-pull-request-checkout-may-build-synthetic-merge-ref
canonical_workflow_repair: explicit-pr-head-checkout-plus-git-rev-parse-head
public_ci_hardening: contents-read-only-persist-credentials-false-actions-pinned-by-sha
current_ci_blocker: github-actions-billing-or-spending-limit-while-private
current_ci_blocker_is_proof_failure: false

public_visibility_preparation_authorized_by_user: true
repository_visibility_at_checkpoint: private
public_release_preflight_status: complete-awaiting-project-license-and-user-visibility-switch
project_license_status: undecided-owner-decision-required
third_party_notices_status: created
secret_audit_status: no-known-secret-blocker-on-audited-surfaces-with-stated-limitations
public_transition_strategy: user-will-change-repository-to-public-to-restore-standard-actions

s2_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required
next_action: owner chooses project license; user changes repository visibility to public; verify public GitHub settings; run corrected canonical CI on actual final PR22 head; merge only if green; verify main; close S1 before S2
```

## Governing rules

- `DEC-011`: `main` is the stable integration branch; substantive work uses branch/PR workflow.
- `DEC-012`: completion of #678 does not authorize work on another problem.
- A theorem file is live only if reachable from the canonical `Formalization` build graph.
- `lake exe mk_all --check` and the full Lean build are part of canonical verification.
- Pull-request verification credit must identify the commit actually checked out. `head_sha` metadata alone is not literal exact-head proof.
- Infrastructure failures must be separated from proof failures.
- Mathematical provenance, formal-verification status, scientific novelty, and redistribution rights are independent labels.
- Rejected paths and negative regressions remain part of the scientific record.
- State/roadmap/README synchronization is required before advancing a project stage.
- Public visibility does not relax proof, attribution, provenance, or licensing gates.

## Mathematical #678 checkpoint — closed

The final reachable graph proves the complete canonical conclusion.

### Key theorem endpoints

- `cambie_lcm_ratio_eventually_with_large_start`: strong Cambie construction for every positive natural factor `C` and all sufficiently large `k`, retaining the start-size fact needed for final indexing.
- `erdos678_unbounded_witnesses`: for every lower bound `B`, a canonical valid triple exists with `B ≤ k`.
- `erdos678_good_lengths_infinite`: the set of valid block lengths is infinite.

### Analytic boundary

The project pins:

`AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`

and derives the application-specific relative-prime provider directly from its kernel-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

### Important mathematical checkpoints

| Stage | Commit | Run | Result |
|---|---|---:|---|
| D4 final reachable repair | `eb5ffebffcb199cc76c83a941da955f4ecfebde5` | `31963803495` | SUCCESS, 8766 jobs |
| E1 quantitative ratio | `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a` | `31968714909` | SUCCESS, 8770 jobs |
| E2 PNT closure | `6d06401bd2ee3aca116fd4ac592bf14d5e43694c` | `31975809856` | SUCCESS, 8800 jobs |
| E3 strong Cambie | `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94` | `31975821891` | SUCCESS, 8804 jobs |
| E4 mathematical exit | `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941` | `31976903757` | SUCCESS, 8806 jobs |
| final synchronized E4 | `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f` | `31977861568` | SUCCESS, 8806 jobs |
| mathematical merge on `main` | `8fd1b20541ac7782f52429db3a2cc4c887547372` | `32011189766` | SUCCESS, `No update necessary`, 8806 jobs |
| scientific dossier on `main` | `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e` | `32026434043` | SUCCESS |

The earlier independent route remains rejected because it used the false scaling identity `M(t*n,k)=t*M(n,k)` and later a wrong interval in a `Q=P/M` construction. The valid witness `M(36,8)>M(47,9)` and the machine-refuted `(495,504,8)` candidate remain regression evidence.

## S1 — common-environment differential verification

### Scientific experiment — SUCCESS

Run `32028006457`, job `95381414710`, was a push-triggered experiment on exact head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`.

The execution log explicitly checked out that commit, then:

- `mk_all --check` reported `No update necessary`;
- the internal canonical graph built successfully in 8808 jobs;
- the bridge modules were reachable;
- the pinned public comparator source `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` was fetched with blob verification and compiled **unchanged** in our pinned Lean 4.33 / Mathlib / PNT+ environment;
- selected endpoints on both sides printed only `[propext, Classical.choice, Quot.sound]`.

Machine-checked bridge results include:

- our length-based intervals equal `Finset.Ioc n (n+k)` semantics;
- our theorem derives the Formal-Conjectures-style eventual-nonempty valid-pair statement;
- valid block lengths are exposed through unbounded/infinite semantic endpoints;
- our natural-factor strong theorem is lifted to every real `C ≥ 1`, with a `C=3/2` regression.

This establishes differential-verification compatibility. It does not establish that one architecture is superior.

### Verification-credit correction

A later audit of PR run `32033822601` found:

- PR `head_sha` metadata: `610d525145a8129d345a1d3ce6a6b41809e3d1f8`;
- actual checkout in the log: synthetic integration-tree commit `5983f901358d8f82d85a425369d429cfa9475f96`.

That successful run remains valid evidence for the integration tree, but not literal PR-head checkout.

The active S1 branch repairs `.github/workflows/lean.yml` to checkout the literal PR head, records `git rev-parse HEAD`, declares `contents: read`, disables persisted checkout credentials, and pins third-party Actions by commit SHA.

Full record: `problems/678/CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`.

### Public-release preflight

The user chose public repository visibility as the intended resolution to the private-repository Actions billing blocker and explicitly authorized the preflight.

Completed before the visibility switch:

- indexed current-tree searches found no known common credential/private-key blocker on the audited surfaces;
- representative historical Actions logs showed authentication values masked by GitHub;
- `.gitignore` now excludes common local secrets/private keys and Lean local build state;
- CI token permissions are read-only and checkout credentials are not persisted;
- `actions/checkout` and `leanprover/lean-action` are pinned to concrete commit SHAs;
- `THIRD_PARTY_NOTICES.md` records dependency/comparator provenance;
- Mathlib, PNT+, and Formal Conjectures currently report Apache-2.0;
- the public comparator remains external/non-vendored because no repository license metadata was detected;
- `problems/678/PUBLIC_RELEASE_AUDIT_2026-08-17.md` records the full preflight and limitations.

The remaining publication decision before/with visibility change is the owner-selected root license for project-owned material.

### Current blocker / transition

While the repository remains private, new GitHub Actions jobs are blocked by the account billing/spending condition. Runs `32036454657` and `32036454660` stopped before any Lean step.

Classification:

- CI infrastructure blocker: **yes while private**;
- proof failure: **no**;
- evidence against the S1 experiment: **no**.

The user intends to change the repository to public. After that transition, the actual final PR #22 head must receive a fresh corrected canonical run before merge.

## S1 durable artifacts

- `formalization/Formalization/Erdos678/ExternalStatementBridge.lean`
- `formalization/Formalization/Erdos678/ExternalStatementBridgeTests.lean`
- `problems/678/DIFFERENTIAL_VERIFICATION_PROTOCOL.md`
- `problems/678/S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- `problems/678/DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`
- `problems/678/CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`
- `problems/678/AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`
- `problems/678/PUBLICATION_READINESS_LICENSE_AUDIT.md`
- `problems/678/PUBLIC_RELEASE_AUDIT_2026-08-17.md`
- `problems/678/experiments/run_public_comparator_common_env.sh`
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md`
- `THIRD_PARTY_NOTICES.md`

## Required restart sequence

1. Verify `main`, repository visibility, and the active S1 PR head.
2. Read this file and the S1 result/evidence/public-release audit files.
3. Treat #678 mathematics as frozen/archived.
4. Do not start S2 until the S1 persistent-artifact integration gate closes.
5. If the repository is still private and Actions remains billing-blocked, do not infer a proof failure and do not weaken the gate.
6. Resolve the project-license decision and have the user perform the intended public-visibility switch.
7. After public transition, review GitHub Actions/branch protection settings, run the corrected canonical PR gate, inspect the logged checkout commit, merge only if green, then verify `main`.
8. **Do not select, activate, resume, research, or formalize another Erdős problem without explicit user authorization.**
