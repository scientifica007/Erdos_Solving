# Erdős #678 — Public-Release Audit — 2026-08-17

## Status

**PUBLIC TRANSITION COMPLETE. LICENSE COMPLETE. S1 ARTIFACT INTEGRATED AND POST-MERGE VERIFIED.**

The repository is Public and project-owned material is licensed under Apache License 2.0. Erdős #678 mathematics remains frozen/archived. This audit does not authorize work on another Erdős problem; `DEC-012` remains in force.

## Pre-transition audit

The project inspected accessible current/historical surfaces for common secret/token/private-key indicators, representative Actions logs, workflow permissions, third-party provenance/licenses, public repository exposure, and scientific attribution.

No known credential/private-key blocker was found on the audited current/indexed surfaces. This is a bounded audit, not proof about every unreachable/deleted Git object, attachment, cache, artifact, or historical log.

The integration could not exhaustively certify every historical commit-author email before publication. Git author/committer metadata is public history; any later-discovered personal email should be handled independently.

## Workflow hardening

The public workflow uses:

- `permissions: contents: read`;
- literal PR-head/current-commit checkout;
- `persist-credentials: false`;
- explicit `git rev-parse HEAD` recording;
- concrete commit SHAs for the directly configured `actions/checkout` and `leanprover/lean-action` references;
- no project secrets for the Lean build.

A root `.gitignore` excludes common local secret/configuration files, private keys, and local Lean/Lake build state.

## Attribution

The public classification is:

- mathematical result/author: known result by Stijn Cambie;
- project route: external-proof reconstruction;
- formal artifact: independent Lean reimplementation;
- independent mathematical attempt: rejected;
- new mathematical solution claim: no;
- first Lean formalization claim: no;
- prior formal authors: Aristotle and Boris Alexeev;
- S1 contribution: executable differential verification plus alternative formal-engineering/process evidence.

## Licensing and redistribution

The owner selected **Apache License 2.0** for project-owned material. License-only PR #26 merged root `LICENSE` to `main` at

`87cf560451ef5aa4714069d52a3851c1f8547f70`.

GitHub recognizes repository license metadata as `Apache-2.0`.

`THIRD_PARTY_NOTICES.md` records important boundaries. Mathlib, PNT+, and Formal Conjectures reported Apache-2.0 at audit time. No repository license was detected for `plby/lean-proofs`; its comparator source therefore remains an immutable **external fetch**, not vendored material.

## Public transition

GitHub API confirmed:

- `private: false`;
- `visibility: public`;
- default branch `main`;
- repository license `Apache-2.0`;
- root `LICENSE` readable;
- Lean Verification workflow active.

The temporary browser `Error loading page` for `LICENSE` was classified as UI/session rendering because repository/content APIs returned the file correctly.

## Billing/runner restoration

Private-repository runs `32036454657` and `32036454660` were prevented from starting by the account billing/spending condition.

After publication, diagnostic run `32043331012` progressed through setup, checkout, commit recording, and the canonical build. This demonstrated that standard GitHub-hosted runner execution had been restored.

## Final S1 integration

PR #22 final head

`1c6bea992033390ac4364033fafcd221694baf4c`

passed canonical exact-head run `32043807200`, job `95427648473`:

- checked-out commit = exact PR head;
- `verified_commit` = exact PR head;
- `mk_all`: `No update necessary`;
- build: **SUCCESS / 8808 jobs**.

PR #22 merged as

`358cd541ff81a2b59611b7addfc90ae17e03b36f`.

Post-merge run `32044314748` attempt 1 failed while downloading Lean because `releases.lean-lang.org` returned HTTP 502. The proof build never started; classification: **transient infrastructure failure**.

Attempt 2, job `95429173912`, reused the unchanged merge commit and succeeded:

- checkout and `verified_commit`: `358cd541ff81a2b59611b7addfc90ae17e03b36f`;
- Lean 4.33.0 installed;
- exact PNT+/Mathlib revisions resolved;
- `mk_all`: `No update necessary`;
- build: **SUCCESS / 8808 jobs**.

Therefore S1 integration is closed.

## Repository protection status

At the public-transition checkpoint, the rulesets API returned `[]`; no repository ruleset was detected.

This is a governance follow-up, not a mathematical blocker. Before accepting outside contributions, configure protection for `main` in GitHub so normal integration requires a pull request and successful Lean Verification and blocks force pushes/deletion.

## Release decision

- Security/privacy preflight: **PASS WITH STATED LIMITATIONS**.
- Scientific attribution: **PASS**.
- Third-party redistribution: **PASS WITH NON-VENDORING BOUNDARY**.
- Project-owned licensing: **PASS — Apache-2.0**.
- Public visibility: **PASS**.
- GitHub-hosted runner availability: **PASS / RESTORED**.
- S1 exact-head integration: **PASS**.
- S1 post-merge verification: **PASS**.
- Repository protection: **UI GOVERNANCE FOLLOW-UP REQUIRED BEFORE OUTSIDE CONTRIBUTIONS**.

## Next gate

After this closure-sync PR itself passes canonical CI and integrates cleanly, S2 metric/mutation work may begin on archived #678 only. No other Erdős problem is authorized.
