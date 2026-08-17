# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 DIFFERENTIAL VERIFICATION COMPLETE / INTEGRATED / POST-MERGE VERIFIED. Repository PUBLIC; project-owned material Apache-2.0.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let

`M(n,k) = lcm{n+1,...,n+k}`.

The final Lean graph includes:

- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`;
- the stronger preceding Cambie construction.

The analytic dependency is pinned to

`AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`

and the application adapter consumes its machine-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

## Scientific classification

- mathematical author/result: Stijn Cambie / known solution;
- independent mathematical attempt in this repository: rejected;
- project mode: external-proof reconstruction;
- formal artifact: independent Lean reimplementation;
- new mathematical proof claim: **no**;
- first Lean formalization claim: **no**;
- prior public formalization: Aristotle + Boris Alexeev;
- machine verification: **yes**;
- executable differential verification against pinned public artifact: **yes**.

## S1 experiment

Run `32028006457`, job `95381414710`, exact experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`

built the canonical graph with **8808 jobs** and compiled the pinned public comparator source

`plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`

**unchanged** inside this repository's Lean 4.33 / Mathlib / PNT+ environment.

Machine-checked comparison bridges establish:

- `intervalFinset (n+1) k = Finset.Ioc n (n+k)`;
- exact public half-open interval semantics for `erdosM`;
- the Formal-Conjectures-style eventual-nonempty statement;
- unbounded and infinitely many admissible block lengths;
- extension of the strong theorem to every real `C ≥ 1`, including nonintegral regression `C=3/2`.

Selected internal/public endpoints exposed only the standard axiom footprint

`[propext, Classical.choice, Quot.sound]`.

This is differential-verification evidence, not a priority or superiority claim.

## S1 repository integration — CLOSED

The persistent artifact passed repaired exact-head CI on PR #22:

- exact head: `1c6bea992033390ac4364033fafcd221694baf4c`;
- run `32043807200`;
- job `95427648473`;
- checkout and `verified_commit`: exact head above;
- `mk_all`: `No update necessary`;
- full build: **SUCCESS / 8808 jobs**.

PR #22 then merged to `main` as

`358cd541ff81a2b59611b7addfc90ae17e03b36f`.

Post-merge run `32044314748` attempt 1 encountered a transient HTTP 502 while downloading Lean and never reached proof checking. It was therefore classified as infrastructure failure, not proof failure. Attempt 2, job `95429173912`, succeeded on the same merge commit:

- `verified_commit=358cd541ff81a2b59611b7addfc90ae17e03b36f`;
- Lean `4.33.0`;
- PNT+ exact pin and Mathlib revision resolved as expected;
- `No update necessary`;
- **Build completed successfully (8808 jobs).**

S1 is therefore integrated and post-merge verified.

## Verification-provenance lesson

Historical PR run `32033822601` had PR-head metadata `610d525...` but default checkout actually built synthetic integration-tree commit `5983f901...`. The evidence was reclassified rather than discarded or overstated.

The canonical workflow now:

- checks out `${{ github.event.pull_request.head.sha || github.sha }}`;
- logs `git rev-parse HEAD`;
- uses `contents: read` only;
- sets `persist-credentials: false`;
- pins directly used external Actions by commit SHA.

This episode is documented in `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md` and `AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`.

## Public artifact

The repository is Public. Apache License 2.0 applies to project-owned material; `THIRD_PARTY_NOTICES.md` records third-party/provenance boundaries. The comparator remains an immutable external fetch and is not vendored because no repository license was detected for it during the audit.

No repository ruleset was detected immediately after the public transition. Protecting `main` in GitHub remains a governance task before accepting external contributions.

## Next scientific stage

After this S1-closure synchronization PR itself is canonically verified and integrated, the #678 roadmap permits **S2 — controlled metric and mutation experiments**. S2 must measure, rather than assume, dependency coupling, build behavior, repair locality, mutation resistance, and upgrade robustness.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
