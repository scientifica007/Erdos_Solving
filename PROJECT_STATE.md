# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős Problem #678 mathematics is complete, machine-checked, integrated into `main`, post-merge verified, and archived. The only authorized active work is scientific evaluation and public-artifact integration of that archived result.**
>
> **No other Erdős problem may be selected, activated, resumed, researched, or formalized without explicit user authorization (`DEC-012`).**

This file is the authoritative restart checkpoint. Proof/CI credit must be tied to the repository tree actually executed, not inferred from file presence or GitHub metadata alone.

## Current state

```yaml
current_problem: 678
current_phase: archived
current_stage: scientific-evaluation-s1-public-integration
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
current_target: close-s1-public-integration

s1_scientific_experiment_status: success
s1_experiment_run: 32028006457
s1_experiment_job: 95381414710
s1_experiment_head: b1e3fc60f6dc4f125a125121a2abbcf3610ed749
s1_canonical_build_jobs: 8808
s1_public_comparator_commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
s1_public_comparator_compiled_unchanged_in_internal_environment: true
s1_matched_axiom_footprint: propext-Classical.choice-Quot.sound
s1_repository_integration_status: pending-final-public-exact-head-ci

ci_provenance_audit_status: correction-recorded
historical_pr_checkout_issue: default-pull-request-checkout-may-build-synthetic-merge-ref
canonical_workflow_repair: explicit-pr-head-checkout-plus-git-rev-parse-head
public_ci_hardening: contents-read-only-persist-credentials-false-actions-pinned-by-sha

public_visibility_preparation_authorized_by_user: true
repository_visibility_at_checkpoint: public
public_transition_verified_by_api: true
public_transition_effect: github-hosted-actions-runners-start-again
public_transition_diagnostic_run: 32043331012
public_transition_diagnostic_run_status_at_sync: in-progress
private_billing_blocker_status: resolved-by-public-transition
project_license_status: apache-2.0-selected-and-committed-on-main
project_license_file: LICENSE
third_party_notices_status: created
secret_audit_status: no-known-secret-blocker-on-audited-surfaces-with-stated-limitations
repository_rulesets_at_public_transition: none-detected

s2_status: not-started
s3_status: not-started
s4_status: not-started
s5_status: not-started
user_transition_gate: explicit-authorization-required
next_action: complete a fresh corrected canonical CI run on the actual final PR22 head; merge only if green; verify main; close S1 before S2; separately configure main branch/ruleset protection in GitHub UI
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

The final reachable graph proves the complete canonical conclusion through:

- `cambie_lcm_ratio_eventually_with_large_start`;
- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`.

The project pins

`AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`

and derives the application-specific relative-prime provider directly from its kernel-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

Key closed checkpoints include:

| Stage | Commit | Run | Result |
|---|---|---:|---|
| E2 PNT closure | `6d06401bd2ee3aca116fd4ac592bf14d5e43694c` | `31975809856` | SUCCESS, 8800 jobs |
| E3 strong Cambie | `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94` | `31975821891` | SUCCESS, 8804 jobs |
| final synchronized E4 | `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f` | `31977861568` | SUCCESS, 8806 jobs |
| mathematical merge on `main` | `8fd1b20541ac7782f52429db3a2cc4c887547372` | `32011189766` | SUCCESS, `No update necessary`, 8806 jobs |
| scientific dossier baseline | `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e` | `32026434043` | SUCCESS |

The earlier independent route remains rejected because it used the false scaling identity `M(t*n,k)=t*M(n,k)` and later a wrong interval in a `Q=P/M` construction. The valid witness `M(36,8)>M(47,9)` and the machine-refuted `(495,504,8)` candidate remain regression evidence.

## S1 — differential verification

### Executed scientific experiment — SUCCESS

Run `32028006457`, job `95381414710`, executed on exact push head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`.

It established that:

- `mk_all --check` reported `No update necessary`;
- the internal canonical graph built successfully in 8808 jobs;
- the statement bridge was reachable;
- `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` was fetched with source-blob verification and its public `Erdos678.lean` compiled unchanged in our pinned Lean 4.33 / Mathlib / PNT+ environment;
- selected endpoints on both sides printed only `[propext, Classical.choice, Quot.sound]`.

Machine-checked S1 bridge results include:

- length-based intervals equal the public `Finset.Ioc n (n+k)` semantics;
- our theorem derives the Formal-Conjectures-style eventual-nonempty valid-pair statement;
- valid block lengths are exposed through unbounded/infinite semantic endpoints;
- the natural-factor strong theorem is lifted to every real `C ≥ 1`, with a `C=3/2` regression.

This is differential-verification evidence, not a priority or architecture-superiority claim.

### Verification-credit correction

Audit of historical PR run `32033822601` found that PR metadata exposed head `610d525...` while the actual default checkout built synthetic integration-tree commit `5983f901...`. That run remains valid integration-tree evidence, not literal PR-head evidence.

The active S1 workflow therefore:

- checks out `${{ github.event.pull_request.head.sha || github.sha }}` explicitly;
- records `git rev-parse HEAD`;
- uses `permissions: contents: read`;
- sets `persist-credentials: false`;
- pins external GitHub Actions by commit SHA.

## Public transition — completed

The owner selected Apache License 2.0 and the license-only PR #26 merged it to `main` at

`87cf560451ef5aa4714069d52a3851c1f8547f70`.

The user then changed `scientifica007/Erdos_Solving` to **Public**. GitHub API verification reported:

- `private: false` / `visibility: public`;
- repository license metadata: `Apache-2.0`;
- `LICENSE` readable on `main`;
- the Lean Verification workflow active;
- no repository rulesets detected at the transition checkpoint.

The private-repository billing blocker is therefore historical. Reopening PR #22 after the visibility change launched run `32043331012`, whose job reached checkout, commit recording, and the canonical Lean build rather than failing before the first step. This confirms runner availability was restored.

The current task is not to credit that diagnostic run as the final S1 gate after further documentation synchronization. A new run must verify the **actual final PR #22 head** after this synchronization.

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
- `LICENSE`
- `THIRD_PARTY_NOTICES.md`

## Required restart sequence

1. Verify `main`, repository visibility, and active PR #22 head.
2. Read this file plus the S1 result/evidence/public-release audit.
3. Treat #678 mathematics as frozen/archived.
4. Do not start S2 until S1 persistent-artifact integration closes.
5. Run the hardened canonical gate on the actual final PR #22 head and inspect the checked-out commit.
6. Merge only if green; then verify the resulting `main` head.
7. Configure/verify `main` protection in the GitHub UI before accepting outside contributions; no ruleset was detected immediately after the public transition.
8. **Do not select, activate, resume, research, or formalize another Erdős problem without explicit user authorization.**
