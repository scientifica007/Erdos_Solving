# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 differential-verification experiment SUCCESS; persistent-artifact integration PENDING final exact-head CI. The repository is now PUBLIC and project-owned material is licensed under Apache License 2.0.**
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

Run `32028006457`, job `95381414710`, on exact push-triggered experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`

provided the executable cross-artifact comparison. It:

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

Post-experiment auditing found that the historical PR workflow used default `actions/checkout`. Run `32033822601` therefore built synthetic integration-tree commit `5983f901358d8f82d85a425369d429cfa9475f96` while metadata exposed PR head `610d525145a8129d345a1d3ce6a6b41809e3d1f8`.

That build remains valid integration-tree evidence, but not literal PR-head verification.

The active S1 branch now:

- checks out `${{ github.event.pull_request.head.sha || github.sha }}` explicitly;
- logs `git rev-parse HEAD`;
- limits `GITHUB_TOKEN` to `contents: read`;
- sets `persist-credentials: false`;
- pins external GitHub Actions to concrete commit SHAs.

See `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`.

## Public release — transition completed

Before public visibility the project completed secret/provenance/license preflight, including defensive `.gitignore`, hardened CI, `THIRD_PARTY_NOTICES.md`, and non-vendoring of the unlicensed comparator source.

The owner selected **Apache License 2.0**. License-only PR #26 merged the standard license to `main` at

`87cf560451ef5aa4714069d52a3851c1f8547f70`.

The repository was then changed to **Public**. GitHub API verification confirmed:

- `private: false` / `visibility: public`;
- repository license metadata `Apache-2.0`;
- root `LICENSE` readable on `main`;
- Lean Verification workflow active.

No repository rulesets were detected immediately after the transition; `main` protection is therefore a separate GitHub-settings task before accepting external contributions.

The public transition also restored GitHub-hosted runner availability. Reopening PR #22 launched run `32043331012`, which successfully completed job setup, checkout, and `Record verified commit` and entered `Build canonical Lean graph`; the historical private-repository billing blocker therefore no longer prevents execution.

## Current S1 integration gate

Run `32043331012` is diagnostic evidence that runner availability returned after the public transition. Because the branch has since been synchronized to record the public state, it is **not** the final integration-credit run.

The remaining S1 gate is:

1. run the hardened canonical workflow on the **actual final PR #22 head**;
2. require the logged checked-out commit to equal that credited PR head;
3. require the canonical graph to pass;
4. merge #22 only then;
5. run post-merge verification on the resulting `main` commit;
6. close S1 only after the post-merge check succeeds.

S2 does not start before S1 closes.

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
