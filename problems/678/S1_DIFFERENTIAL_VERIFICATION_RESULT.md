# Erdős #678 — S1 Differential Verification Result

## Result

**SCIENTIFIC EXPERIMENT: SUCCESS. REPOSITORY INTEGRATION: SUCCESS. POST-MERGE VERIFICATION: SUCCESS.**

S1 is closed as a scientific and repository checkpoint.

The core cross-artifact experiment completed on 2026-08-17 in run `32028006457`, job `95381414710`, exact push head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`.

It built this repository's canonical Lean graph and then fetched the pinned public Aristotle/Alexeev #678 source and compiled that source **unchanged** in this repository's pinned environment.

The persistent S1 artifacts subsequently passed exact-head PR CI, merged into public `main`, and passed post-merge verification.

## Exact experiment environment

The experiment used:

- Lean `4.33.0`, commit `d8b18978322de05a8f3dba51ef03cf5461676c17`;
- Mathlib `v4.33.0`, resolved revision `db584cd6d46c92f209a44c0f1c829460d327499d`;
- `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

Canonical import audit:

```text
No update necessary
```

Internal graph:

```text
Build completed successfully (8808 jobs).
```

## Public comparator input

The experiment pinned:

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- file: `src/latest/ErdosProblems/Erdos678.lean`;
- expected blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.

The source was fetched ephemerally, identity-checked, compiled unchanged, and not redistributed by this repository.

## Formal statement alignment

S1 closes several comparison gaps by machine-checked bridges:

- `intervalFinset_succ_eq_Ioc` proves the internal length-based interval equals `Finset.Ioc n (n+k)`;
- `erdosM_eq_Ioc_lcm` aligns the canonical LCM semantics with the public convention;
- `erdos678_formalConjectures_eventual_nonempty` derives the Formal-Conjectures-style eventual-nonempty endpoint;
- `erdos678_valid_pair_lengths_unbounded` and `erdos678_valid_pair_good_lengths_infinite` expose the varying-`k` semantics explicitly;
- `cambie_lcm_ratio_eventually_with_large_start_real` lifts the retained strong theorem to every real `C ≥ 1`, with a nonintegral `C=3/2` regression.

## Axiom audit

Selected internal endpoints and selected public endpoints, compiled under the same pinned environment, reported only:

```text
[propext, Classical.choice, Quot.sound]
```

No project-specific mathematical axiom or `sorryAx` appears in these audited endpoints.

## Scientific interpretation

S1 supports the following characterization:

1. this project is an independent Lean reimplementation of Cambie's known proof, not a new mathematical solution and not the first formalization;
2. the final statement is machine-normalized to the public interval semantics;
3. the Formal Conjectures eventual-existence reading is derived internally;
4. the strong result is bridged to the public real-factor parameter domain;
5. the pinned public proof source compiles unchanged in our exact Lean/Mathlib/PNT+ environment;
6. selected endpoints have the same standard-axiom footprint in that environment.

This is **differential-verification evidence**. It does not establish architecture superiority, faster builds, lower maintenance cost, or genealogical independence of all proof ideas.

## Verification-provenance correction

Historical PR run `32033822601` exposed PR head `610d525...` in metadata while default checkout actually built synthetic integration-tree commit `5983f901...`.

The run remains valid evidence for that integration tree, but was reclassified rather than described as literal exact-head verification.

The canonical workflow was repaired to:

- checkout `${{ github.event.pull_request.head.sha || github.sha }}`;
- record `git rev-parse HEAD`;
- use read-only contents permission;
- disable persisted checkout credentials;
- pin directly used external Actions by commit SHA.

This produced an empirical process category retained as **verification-credit drift**.

## Public transition

The owner selected Apache License 2.0; license-only PR #26 merged root `LICENSE` at

`87cf560451ef5aa4714069d52a3851c1f8547f70`.

The repository was then changed to Public. That transition restored GitHub-hosted runner availability after the earlier private-repository billing/spending blocker.

## Persistent integration evidence

### Exact-head PR gate

PR #22 final head:

`1c6bea992033390ac4364033fafcd221694baf4c`

Canonical run:

- run: `32043807200`;
- job: `95427648473`;
- result: **SUCCESS**;
- checkout ref: exact PR head;
- `verified_commit`: exact PR head;
- `mk_all`: `No update necessary`;
- full build: **8808 jobs**.

### Merge

PR #22 merged to public `main` as

`358cd541ff81a2b59611b7addfc90ae17e03b36f`.

### Post-merge verification

Run `32044314748` attempt 1 failed before proof checking because Lean download returned HTTP 502. The checkout and `verified_commit` already matched the merge commit, but Lean installation did not complete. This is classified as **transient infrastructure failure**, not proof failure.

The same job was rerun without changing the repository. Attempt 2, job `95429173912`, completed successfully:

- exact checkout: `358cd541ff81a2b59611b7addfc90ae17e03b36f`;
- `verified_commit=358cd541ff81a2b59611b7addfc90ae17e03b36f`;
- Lean `4.33.0`;
- PNT+ exact pin checked;
- Mathlib exact resolved revision checked;
- `mk_all`: `No update necessary`;
- full build: **SUCCESS / 8808 jobs**;
- selected bridge endpoints again reported only standard axioms.

This closes the repository-integration component of S1.

## Reusable process result

The observed pipeline is:

> comparison → mismatch detection → formal bridge → executable portability test → axiom audit → execution-provenance audit → correction → public release → exact-head integration gate → post-merge verification.

A second reusable distinction was reinforced by the post-merge 502 incident:

> a failed CI run is not automatically failed mathematics; classify the earliest failed layer before changing the proof.

## Persistent artifacts

- `Formalization/Erdos678/ExternalStatementBridge.lean`;
- `Formalization/Erdos678/ExternalStatementBridgeTests.lean`;
- `problems/678/DIFFERENTIAL_VERIFICATION_PROTOCOL.md`;
- `problems/678/DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`;
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`;
- `problems/678/experiments/run_public_comparator_common_env.sh`;
- `problems/678/CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`;
- `problems/678/AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`;
- `problems/678/PUBLIC_RELEASE_AUDIT_2026-08-17.md`;
- this result document.

## Exit

**S1 is complete.** S2 may begin only after this closure-documentation synchronization itself passes the canonical PR workflow and is integrated cleanly. All further work remains scoped to archived #678 unless the user explicitly authorizes another Erdős problem.
