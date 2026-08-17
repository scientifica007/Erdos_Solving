# Erdős #678 — Public-Release Preflight Audit — 2026-08-17

## Status

**Preflight complete for a repository visibility change, subject to one owner decision: the license for project-owned material.**

The repository remains private at this checkpoint. The user has explicitly authorized preparation for public visibility, but the visibility switch itself has not been executed by this audit.

This audit is scoped to publication/readiness of the archived Erdős #678 work and the repository surfaces that will become public with it. It does not authorize work on another Erdős problem; `DEC-012` remains in force.

---

## 1. Audit scope and limitations

The audit inspected, to the extent exposed by the connected GitHub interfaces:

- current repository metadata and current PR #22 tree;
- root/project documentation relevant to public interpretation;
- active GitHub Actions workflow configuration;
- indexed repository searches for common credential/private-key indicators;
- representative successful historical GitHub Actions logs;
- direct Lean dependencies and their declared repository license metadata;
- the external formal comparator's repository-license metadata and current non-vendored reproduction boundary;
- repository-level inventory relevant to accidental public exposure, including existing `problems/*` directories and active `agent/*` branches.

This is **not** a cryptographic proof that no secret ever existed in every unreachable Git object, deleted object, attachment, cache, artifact, or every line of every historical Actions log. If any credential is independently suspected to have been committed historically, the correct response is to revoke/rotate it regardless of this audit.

---

## 2. Secret and sensitive-data findings

### Current indexed repository surface

Searches for common secret/token indicators found no exposed credential matching the inspected patterns, including:

- OpenAI-style key prefixes previously checked (`sk-proj` / `OPENAI_API_KEY`);
- GitHub classic/fine-grained token indicators previously checked (`ghp_` / `github_pat_`);
- `BEGIN PRIVATE KEY`;
- a broader search over `password`, `secret`, `token`, `api_key`, and `authorization`, whose relevant hits were documentation/process language rather than credential values.

### Workflow configuration

Only one repository workflow was found under `.github/workflows`: `lean.yml`.

The workflow does not consume repository/environment secrets. Before public release it was hardened to:

- declare `permissions: contents: read` explicitly;
- checkout the literal PR head for PR verification;
- set `persist-credentials: false` so the checkout token is not retained in local Git configuration for subsequent steps;
- record `git rev-parse HEAD` before verification;
- pin `actions/checkout` and `leanprover/lean-action` to concrete commit SHAs rather than mutable version tags.

### Historical Actions logs

Representative successful logs were inspected. GitHub rendered authentication material as masked values such as `token: ***` and `AUTHORIZATION: basic ***`; no unmasked credential was observed in those samples.

Historical workflows did use checkout's default `persist-credentials: true`; the active PR #22 workflow now removes that exposure for future public/fork execution.

### Preventive ignore rules

A root `.gitignore` was added before public release to exclude common local secret/configuration files, private-key material, and local Lean/Lake build state.

**Classification:** no known secret blocker found on the audited surfaces; residual risk is the ordinary limitation of a non-exhaustive historical audit.

---

## 3. Scientific attribution and public interpretation

The public-facing README and #678 scientific dossier correctly classify the successful mathematical route as a reconstruction of Stijn Cambie's 2024 proof.

The repository does **not** claim:

- a new independent mathematical solution of Erdős #678;
- the first Lean formalization;
- the first unconditional PNT-backed formalization.

The supported contribution language is:

- independent Lean reimplementation of Cambie's proof;
- machine-checked reconstruction in the repository's canonical graph;
- executable differential verification against a pinned public Aristotle/Alexeev artifact;
- alternative modular/regression-heavy proof architecture;
- direct `prime_between` analytic boundary;
- auditable AI-assisted scientific-production case study.

This classification is suitable for public visibility and should remain authoritative even though historical branches contain superseded exploratory states.

---

## 4. Third-party licensing and provenance

A root `THIRD_PARTY_NOTICES.md` has been created.

Verified repository metadata at this audit includes:

- `leanprover-community/mathlib4`: Apache-2.0;
- `AxiomMath/PrimeNumberTheoremAnd`: Apache-2.0;
- `google-deepmind/formal-conjectures`: Apache-2.0;
- `plby/lean-proofs`: public repository, but no repository license metadata was detected by this audit.

The public comparator is therefore **not vendored**. The S1 reproduction model fetches its immutable external commit/blob ephemerally, validates identity, compiles it unchanged, and does not persist the comparator source in this project.

### Remaining owner decision

This repository itself currently has no declared project license.

Public visibility without a project license is technically possible, but it leaves reuse rights for project-owned material unclear. For a scientific artifact intended for reuse and reproduction, the strong recommendation is to choose and commit an explicit root license before, or immediately with, the visibility transition.

The audit does not choose that license on the owner's behalf.

---

## 5. Repository surfaces that will become public

Changing repository visibility exposes more than `main`.

At the audit checkpoint, `problems/` contains existing directories for multiple historical/project benchmarks in addition to `678`. Their directory names were inventoried for exposure awareness; their mathematics was **not** inspected or activated, in compliance with `DEC-012`.

The repository also has multiple retained `agent/erdos678-*` branches. Those branches preserve intermediate, superseded, failed, and historical formalization states. Their existence adds useful process provenance for the AI-assisted-production case study, but public readers must not interpret each branch as a current claim.

Normative public state remains:

1. `main` for integrated repository state;
2. `PROJECT_STATE.md` for current operational classification;
3. the #678 evidence ledger/result reports for scientific claims;
4. explicit `HISTORICAL` / `SUPERSEDED` labels where present.

No branch deletion is required for correctness, but the repository owner should understand that the branch history itself becomes publicly inspectable.

---

## 6. GitHub Actions / public-fork safety posture

The active CI performs deterministic verification only; it does not deploy, publish packages, mutate repository content, or use project secrets.

For public operation:

- token permission is explicitly read-only;
- checkout credentials are not persisted;
- third-party actions are pinned by commit SHA;
- PR verification identifies the exact checked-out commit;
- no repository secrets are required for the Lean build.

This makes the current workflow materially safer for untrusted fork PRs than the historical default-checkout configuration.

After the repository becomes public, repository Actions settings and branch/ruleset protections should be reviewed in the GitHub UI before accepting external contributions.

---

## 7. Current scientific/CI state

The S1 **scientific experiment itself has already succeeded** at exact push head:

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`

via run `32028006457`, job `95381414710`.

That run established the common-environment differential-verification findings recorded in the evidence ledger.

The persistent PR #22 branch has subsequently accumulated documentation, semantic consolidation, CI provenance correction, and public-release hardening. Its **final current head must receive a new corrected canonical verification run before merge**.

While the repository remains private, GitHub-hosted Actions are currently blocked by the account billing/spending condition. The user's chosen resolution is to make the repository public rather than weaken the verification gate.

---

## 8. Public-release sequence

The controlled transition is:

1. **Owner license decision:** choose a license for project-owned material and commit it, preferably before changing visibility.
2. User changes `scientifica007/Erdos_Solving` from private to public.
3. Verify repository metadata reports public visibility.
4. Review GitHub Actions permissions/settings and branch/ruleset protections after the visibility transition.
5. Trigger/observe a new canonical Lean Verification run on the **actual final PR #22 head** using the hardened workflow.
6. Inspect the logged `verified_commit` and require it to equal the PR head being credited.
7. Merge PR #22 only if the canonical gate is green.
8. Run and verify the canonical workflow on the resulting `main` merge commit.
9. Mark S1 integrated/closed only after the post-merge check succeeds.
10. Do not start S2 before S1 closes; do not start another Erdős problem without explicit authorization.

---

## 9. Release decision

### Security/privacy preflight

**PASS WITH STATED AUDIT LIMITATIONS.** No known credential or private-key blocker was found on the inspected current/indexed and representative-log surfaces; workflow hardening and preventive ignores have been committed.

### Scientific attribution preflight

**PASS.** The repository distinguishes Cambie's mathematical proof, prior public formalization, our independent Lean reimplementation, and the AI-assisted process study.

### Third-party redistribution preflight

**PASS WITH NON-VENDORING BOUNDARY.** Apache-licensed dependencies are identified; the comparator remains externally fetched because no repository license was detected for it.

### Project-owned licensing preflight

**OWNER DECISION REQUIRED.** No root project license has yet been selected.

### Overall

**READY FOR PUBLIC VISIBILITY AFTER/WITH THE PROJECT-LICENSE DECISION, followed immediately by post-transition GitHub-settings review and a fresh exact-head CI gate for PR #22.**
