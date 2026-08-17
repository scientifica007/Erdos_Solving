# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 differential-verification experiment SUCCESS; persistent-artifact integration PENDING. Public-release preflight is complete; Apache License 2.0 has been selected and committed for project-owned material. The repository is still private at this checkpoint and awaits the user's intended public-visibility switch.**
>
> The earlier independent attempt remains rejected. The successful result is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical statement and final result

Let

`M(n,k) = lcm{n+1,...,n+k}`.

The repository proves the Erdős #678 conclusion in Lean through:

- `erdos678_unbounded_witnesses`: for every lower bound `B`, there exist canonical `n,m,k` with `B ≤ k`, `3 ≤ n,m,k`, `n+k ≤ m`, and `M(n,k) > M(m,k+1)`;
- `erdos678_good_lengths_infinite`: the set of valid block lengths is infinite.

The strong construction is formalized before specializing to the original problem.

## Mathematical verification checkpoint

Key final checkpoints:

| Checkpoint | Commit | Run | Result |
|---|---|---:|---|
| E2 PNT closure | `6d06401bd2ee3aca116fd4ac592bf14d5e43694c` | `31975809856` | SUCCESS, 8800 jobs |
| E3 strong Cambie | `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94` | `31975821891` | SUCCESS, 8804 jobs |
| final E4 synchronized head | `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f` | `31977861568` | SUCCESS, 8806 jobs |
| mathematical merge on `main` | `8fd1b20541ac7782f52429db3a2cc4c887547372` | `32011189766` | SUCCESS, `No update necessary`, 8806 jobs |
| scientific dossier baseline on `main` | `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e` | `32026434043` | SUCCESS |

The analytic dependency is pinned to

`AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`,

and the application adapter consumes its machine-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

## Exact scientific classification

- mathematical author/result: Stijn Cambie / known solution;
- independent mathematical attempt in this repository: rejected;
- successful project mode: external-proof reconstruction;
- Lean artifact: independent reimplementation;
- new mathematical proof claim: **no**;
- first Lean formalization claim: **no**;
- prior public formalization: Aristotle + Boris Alexeev;
- machine verification: **yes** for the archived internal theorem;
- differential verification against the public artifact: **yes, executed in S1**.

## S1 — executed differential verification

Run `32028006457`, job `95381414710`, on push-triggered experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`

provided the first executable cross-artifact comparison.

On one Ubuntu 24.04 runner it:

- checked out the exact experiment head;
- ran the canonical import audit: `No update necessary`;
- built the internal graph successfully: **8808 jobs**;
- reached `ExternalStatementBridge` and its tests;
- fetched `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` with exact source-blob verification;
- compiled the public `Erdos678.lean` **unchanged** in this repository's pinned Lean 4.33 / Mathlib / PNT+ environment;
- printed the same selected-endpoint axiom footprint on both sides: `propext`, `Classical.choice`, `Quot.sound`.

### Machine-checked statement bridges

S1 proves internally that:

- `intervalFinset (n+1) k = Finset.Ioc n (n+k)`;
- `erdosM` therefore has the exact public half-open interval semantics;
- our result derives the Formal-Conjectures-style eventual-nonempty valid-pair statement;
- valid block lengths have explicit unbounded/infinite semantic endpoints;
- the retained strong theorem extends from positive natural factors to every real `C ≥ 1`, including a regression at `C=3/2`.

This is differential-verification evidence, not a priority or superiority claim.

## Verification-provenance correction

Post-experiment auditing found that the historical PR workflow used default `actions/checkout`. For a pull-request event, GitHub can therefore build a synthetic merge ref even when run metadata displays the PR head.

Run `32033822601` is the concrete case:

- PR head metadata: `610d525145a8129d345a1d3ce6a6b41809e3d1f8`;
- actual checked-out integration-tree commit: `5983f901358d8f82d85a425369d429cfa9475f96`.

The build was successful, but its correct classification is **integration-tree verification**, not literal PR-head checkout.

The active S1 branch now:

- checks out `${{ github.event.pull_request.head.sha || github.sha }}` explicitly;
- logs `git rev-parse HEAD`;
- limits `GITHUB_TOKEN` to `contents: read`;
- sets `persist-credentials: false`;
- pins external GitHub Actions to concrete commit SHAs.

See `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`.

## Public-release preflight

The user chose to make the repository public as the intended resolution to the private-repository GitHub Actions billing blocker, and explicitly authorized the preflight.

Before the visibility switch the project has:

- searched the indexed repository for common secret/private-key indicators and found no known blocker on the audited surfaces;
- inspected representative historical Actions logs, where authentication values were masked;
- added a defensive root `.gitignore` for local secrets/private keys/build state;
- hardened the only GitHub Actions workflow for public/fork execution;
- verified Apache-2.0 repository metadata for Mathlib, PNT+, and Formal Conjectures;
- retained the `plby/lean-proofs` comparator as an immutable external fetch rather than vendoring it because no repository license metadata was detected by the audit;
- created root `THIRD_PARTY_NOTICES.md`;
- selected and committed **Apache License 2.0** in root `LICENSE` for project-owned material, unless otherwise noted;
- documented the audit and its limitations in `PUBLIC_RELEASE_AUDIT_2026-08-17.md`.

The project-license decision is therefore closed. Third-party material remains governed by its own licenses/notices and the non-vendoring boundary documented in `THIRD_PARTY_NOTICES.md`.

## Current S1 integration gate

While the repository remains private, GitHub reported an account payment/spending-limit condition for attempted runs `32036454657` and `32036454660`; both stopped before any Lean step.

Therefore:

- this is an infrastructure blocker, not a proof failure;
- the active S1 PR remains unmerged;
- the intended resolution is the user-performed public visibility switch, not weakening CI;
- after the switch, the actual final PR #22 head must pass the hardened exact-head canonical workflow;
- `main` must then pass post-merge verification;
- S2 does not start until S1 closes.

## Scientific value tracks

The archived #678 artifact is being developed along two external-value tracks:

1. **formal differential verification / proof engineering:** compare the modular, regression-heavy reconstruction and direct `prime_between` boundary against the public Aristotle/Alexeev development;
2. **AI-assisted scientific production:** study the observable path from invalid independent reasoning to verified reconstruction, including failure retention, state externalization, dependency closure, interface repair, attribution discipline, verification-credit correction, and public-artifact closure.

No claim of new mathematics follows from either track.

## Durable S1/publication dossier

- `SCIENTIFIC_COMPARATIVE_STUDY.md`
- `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md`
- `AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`
- `PUBLICATION_AND_UPSTREAM_ROADMAP.md`
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `DIFFERENTIAL_VERIFICATION_PROTOCOL.md`
- `S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`
- `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`
- `PUBLICATION_READINESS_LICENSE_AUDIT.md`
- `PUBLIC_RELEASE_AUDIT_2026-08-17.md`
- `experiments/run_public_comparator_common_env.sh`
- `CAMBIE_PROOF_ANALYSIS.md`
- `FORMALIZATION_CORRECTION_2026-08-14.md`
- `LEAN_FORMALIZATION_ROADMAP.md`
- root `LICENSE`
- root `THIRD_PARTY_NOTICES.md`

## Historical failed independent route

The repository first retained the valid witness `M(36,8)>M(47,9)` but later used the false scaling identity

`M(t*n,k)=t*M(n,k)`

and a subsequent `Q=P/M` construction used a wrong interval. Those paths remain rejected and documented; the `(495,504,8)` candidate remains machine-refuted regression evidence.

## Operational stop rule

#678 mathematics remains frozen/archived. Scientific evaluation may continue only within the documented #678 roadmap.

**Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
