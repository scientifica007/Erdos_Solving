# Erdős #678 — Public-Release Audit — 2026-08-17

## Status

**PUBLIC TRANSITION COMPLETED. FINAL S1 INTEGRATION CI PENDING.**

The repository is now public. Project-owned material is licensed under Apache License 2.0. The archived Erdős #678 mathematics remains frozen; this audit concerns publication/readiness and does not authorize work on another Erdős problem. `DEC-012` remains in force.

## 1. Pre-transition audit result

Before the visibility change, the project inspected the current repository and accessible historical surfaces for common secret/token/private-key indicators, representative GitHub Actions logs, workflow permissions and credential persistence, third-party license/provenance boundaries, repository surfaces that would become public, and scientific attribution.

No known credential/private-key blocker was found on the audited current/indexed surfaces. This remains a bounded audit, not a cryptographic proof about every unreachable Git object, deleted object, cache, attachment, artifact, or historical log.

The connected integration could not exhaustively enumerate historical commit-author emails before the transition. Git commit author/committer metadata is public history; if a personal historical email is ever identified and considered sensitive, address that independently rather than treating this audit as proof that none exists.

## 2. Workflow hardening before public operation

The active S1 branch hardens `.github/workflows/lean.yml` for public/fork execution:

- `permissions: contents: read`;
- literal PR-head checkout via `${{ github.event.pull_request.head.sha || github.sha }}`;
- `persist-credentials: false`;
- explicit `git rev-parse HEAD` recording;
- `actions/checkout` and `leanprover/lean-action` pinned to concrete commit SHAs;
- no repository secrets required by the Lean build.

A root `.gitignore` excludes common local secret/configuration files, private-key material, and Lean/Lake local build state.

## 3. Scientific attribution

The repository classifies #678 as:

- mathematical result/author: known result by Stijn Cambie;
- project route: external-proof reconstruction;
- formal artifact: independent Lean reimplementation;
- independent mathematical attempt: rejected;
- new mathematical solution claim: no;
- first Lean formalization claim: no;
- prior formal authors: Aristotle and Boris Alexeev;
- S1 contribution: executable differential verification and alternative formal-engineering evidence.

Historical branches may contain superseded exploratory states. Normative public state is `main`, `PROJECT_STATE.md`, and the #678 evidence/result files.

## 4. Licensing and redistribution

The owner selected **Apache License 2.0** for project-owned material. License-only PR #26 merged the standard root `LICENSE` to `main` at

`87cf560451ef5aa4714069d52a3851c1f8547f70`.

GitHub subsequently recognized repository license metadata as `Apache-2.0`.

Root `THIRD_PARTY_NOTICES.md` records important provenance and redistribution boundaries. At the audited state:

- Mathlib reports Apache-2.0;
- `AxiomMath/PrimeNumberTheoremAnd` reports Apache-2.0;
- `google-deepmind/formal-conjectures` reports Apache-2.0;
- `plby/lean-proofs` had no repository license metadata detected, so its comparator source remains an immutable external fetch and is not vendored into this repository.

## 5. Public transition verification

After the user changed repository visibility, GitHub API verification reported:

- `private: false`;
- `visibility: public`;
- default branch: `main`;
- repository license: `Apache-2.0`;
- root `LICENSE` readable on `main`;
- Lean Verification workflow state: active.

The browser briefly displayed an `Error loading page` when opening `LICENSE`, but the repository/content APIs returned the file correctly; this was classified as a UI/session rendering issue rather than repository corruption.

## 6. Actions/billing blocker resolution

While private, runs `32036454657` and `32036454660` stopped before any Lean step because of the account payment/spending condition.

After the repository became public, reopening PR #22 launched run `32043331012`. Its job successfully advanced through setup, checkout, `Record verified commit`, and entry into `Build canonical Lean graph`.

Therefore the private-repository billing/spending condition is no longer preventing standard GitHub-hosted runner execution.

Run `32043331012` is **diagnostic evidence of restored runner availability**, not the final S1 integration-credit run, because documentation synchronization after the public transition changed PR #22's head.

## 7. Repository protection status

Immediately after the public transition, the GitHub rulesets API returned an empty list (`[]`). No repository ruleset was therefore detected at that checkpoint.

This does not invalidate #678 or S1. It is a repository-governance item: configure/verify `main` protection in the GitHub UI before accepting outside contributions. The desired policy should prevent unreviewed/unverified integration while preserving the existing PR + canonical CI workflow.

## 8. Final S1 release sequence

The remaining controlled sequence is:

1. synchronize `PROJECT_STATE.md`, active roadmap, and READMEs to the public state;
2. identify the **actual final PR #22 head**;
3. require a fresh hardened canonical Lean Verification run on that head;
4. inspect execution provenance so the checked-out commit equals the PR head being credited;
5. require the canonical graph to pass;
6. merge PR #22 only if green;
7. verify the resulting `main` merge commit with the canonical workflow;
8. mark S1 integrated/closed only after post-merge success;
9. do not start S2 before S1 closes;
10. do not start another Erdős problem without explicit authorization.

## 9. Release decision

- Security/privacy preflight: **PASS WITH STATED LIMITATIONS**.
- Scientific attribution: **PASS**.
- Third-party redistribution: **PASS WITH NON-VENDORING BOUNDARY**.
- Project-owned licensing: **PASS — Apache-2.0 committed on `main`**.
- Public visibility: **PASS — transition completed and verified by API**.
- GitHub-hosted runner availability: **RESTORED after public transition**.
- Repository protection: **UI CONFIGURATION/VERIFICATION STILL REQUIRED before outside contributions**.
- Final S1 integration: **PENDING exact-head PR #22 CI + post-merge main verification**.
