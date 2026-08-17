# Erdős #678 — S1 Differential Verification Result

## Result

**SCIENTIFIC EXPERIMENT: SUCCESS. REPOSITORY INTEGRATION: PENDING.**

On 2026-08-17, the executable cross-artifact verification experiment completed successfully in GitHub Actions run `32028006457`, job `95381414710`, on exact push-triggered experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`.

The run did two things sequentially on one Ubuntu 24.04 runner:

1. built this repository's complete canonical Lean graph with the external-statement bridge;
2. fetched the pinned public Aristotle/Alexeev #678 source and compiled that source **unchanged** in this repository's pinned Lake environment.

This establishes the core S1 differential-verification result. The persistent S1 artifacts are not yet merged into `main`: their final canonical PR gate is currently blocked by a GitHub Actions billing/spending-limit condition. That infrastructure blocker does not alter the successful experiment result.

---

## Exact experiment environment

The runner installed:

- Lean `4.33.0`, Lean commit `d8b18978322de05a8f3dba51ef03cf5461676c17`;
- Mathlib Lake version `v4.33.0`, resolved revision `db584cd6d46c92f209a44c0f1c829460d327499d`;
- `AxiomMath/PrimeNumberTheoremAnd` revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

The canonical import audit printed:

```text
No update necessary
```

and the internal build ended with:

```text
Build completed successfully (8808 jobs).
```

The bridge modules were part of that graph:

- `Formalization.Erdos678.ExternalStatementBridge`;
- `Formalization.Erdos678.ExternalStatementBridgeTests`.

The execution log explicitly checked out the experiment head `b1e3fc60...`; the S1 scientific experiment therefore has commit-explicit provenance.

---

## Public comparator input

The experiment pinned:

- repository `plby/lean-proofs`;
- commit `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- file `src/latest/ErdosProblems/Erdos678.lean`;
- expected Git blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.

The script verified at runtime:

```text
Comparator commit: 6f906fef432892db5c910c48ad1a3728dd42cdac
Comparator blob:   f2331e8bcc71bc36cce7724a0c54fafd8d64d480
Expected commit:   6f906fef432892db5c910c48ad1a3728dd42cdac
Expected blob:     f2331e8bcc71bc36cce7724a0c54fafd8d64d480
```

It materialized the source only in the runner's temporary directory and invoked it through this repository's Lake environment. The public source was not edited and is not redistributed by this repository.

This is stronger than observing that each repository builds separately: it demonstrates portability of the pinned public proof source to the same Lean/Mathlib/PNT+ environment in which our reconstruction was checked.

---

## Formal statement alignment established internally

The bridge closes three previously informal comparison gaps.

### 1. Interval convention

`intervalFinset_succ_eq_Ioc` proves

```text
intervalFinset (n + 1) k = Finset.Ioc n (n + k).
```

Consequently `erdosM_eq_Ioc_lcm` proves that our canonical `erdosM n k` has exactly the half-open interval semantics used by the public comparator's `lcmInterval n k`.

This matters because the project had already experienced a real off-by-one error during its rejected independent attempt. Agreement is now a Lean theorem, not visual similarity of notation.

### 2. Formal Conjectures endpoint

`erdos678_formalConjectures_eventual_nonempty` has the literal target shape

```text
∀ᶠ k in atTop,
  {(m,n) |
    n + k ≤ m ∧
    (Finset.Ioc m (m + (k + 1))).lcm id <
      (Finset.Ioc n (n + k)).lcm id}.Nonempty.
```

Thus our final construction has a kernel-checked bridge to the eventual-nonempty reading used by Formal Conjectures.

### 3. Real multiplicative factor

Before S1, our retained strong endpoint used a positive natural factor `C`, while the public `main_theorem_expanded` uses `C : ℝ` with `C ≥ 1`.

`cambie_lcm_ratio_eventually_with_large_start_real` closes that interface difference by taking `N = Nat.ceil C`, invoking the natural-factor theorem, and comparing the real casts.

The regression suite includes the non-integral test `C = 3/2`.

Therefore the earlier `ℕ`/`ℝ` parameter-domain mismatch is no longer an unresolved comparison caveat.

---

## Matched axiom audit

The internal run printed only

```text
[propext, Classical.choice, Quot.sound]
```

for:

- `Erdos678.cambie_lcm_ratio_eventually_with_large_start_real`;
- `Erdos678.erdos678_formalConjectures_eventual_nonempty`;
- `Erdos678.erdos678_unbounded_witnesses`;
- `Erdos678.erdos678_good_lengths_infinite`.

The public source, compiled unchanged in the same environment, printed the same axiom set for:

- `Erdos678.main_theorem_expanded`;
- `Erdos678.erdos_678_kmn_infinite`;
- `Erdos678.not_erdos_678_fc`;
- `Erdos678.not_erdos_678_other`;
- `Erdos678.erdos_678`.

No project-specific mathematical axiom or `sorryAx` appears in these audited endpoints.

---

## Timing observations

These are **single-run observations, not performance claims**.

- the internal full `lake build` action reported approximately `838647 ms` and ended at 8808 jobs;
- the public single-file compile began at approximately `12:23:27.5Z` and produced its final axiom output at approximately `12:26:37.4Z`, roughly 190 seconds later.

These values are not directly comparable because the workloads and cache states differ. Controlled cold/warm timing belongs to S2.

---

## Scientific interpretation

S1 supports the following defensible characterization:

1. the project is an independent Lean reimplementation of Cambie's known proof, not a new mathematical solution and not the first formalization;
2. the final theorem is formally normalized to the public interval semantics;
3. the project explicitly derives the Formal Conjectures eventual-existence reading;
4. the strong endpoint is bridged to the public real-factor parameter domain;
5. the pinned current public proof source compiles unchanged in our exact Lean/Mathlib/PNT+ environment;
6. selected endpoints from both artifacts have the same standard-axiom footprint in that environment.

This is meaningful **differential-verification evidence**. It reduces obvious sources of false agreement: interval conventions, parameter domains, dependency versions, and hidden axiom differences.

S1 does **not** establish architecture superiority, faster builds, lower maintenance cost, genealogical independence of all proof ideas, or a new theorem. Those are separate questions.

---

## Verification-provenance correction discovered after the experiment

A later audit found that the repository's historical pull-request `Lean Verification` workflow used default `actions/checkout` behavior. A PR-event run can therefore build GitHub's synthetic merge ref even when run metadata exposes the PR `head_sha`.

Concrete audit example:

- PR head metadata: `610d525145a8129d345a1d3ce6a6b41809e3d1f8`;
- run `32033822601`;
- actual checked-out integration-tree commit: `5983f901358d8f82d85a425369d429cfa9475f96`.

That run succeeded and its mathematical output remains valid for the integration tree, but it should not be described as literal exact-head checkout.

The active S1 branch therefore changes canonical PR checkout to

```yaml
ref: ${{ github.event.pull_request.head.sha || github.sha }}
```

and records `git rev-parse HEAD` before building.

See `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md` for the full correction. This is a process-level finding, not a defect in the #678 theorem.

---

## Current integration blocker

The scientific experiment is complete, but S1 repository integration remains pending.

After the commit-explicit workflow repair was prepared, GitHub refused to start new Actions jobs because of an account billing/spending-limit condition. In particular:

- run `32036454657` did not start its canonical Lean job;
- run `32036454660` did not start its comparison job.

GitHub annotated both as account-payment/spending-limit failures. No Lean step executed in either run.

Therefore these are classified as **CI infrastructure failures**, not proof failures.

The S1 branch should not be merged until the account condition is resolved and the standard canonical PR gate successfully checks the final persistent-artifact head with explicit checkout provenance.

---

## Why this matters for the AI-production case study

S1 supplies two distinct process results.

First, an AI-assisted comparison found real interface mismatches—interval representation and `ℕ` versus `ℝ` factor domain—and converted them into explicit Lean bridge theorems rather than explaining them away in prose.

Second, the later audit found **verification-credit drift**: project language about “exact-head CI” was stronger than the old PR checkout semantics justified. The discrepancy was retained, historical evidence was reclassified, and the workflow was repaired instead of hiding the issue.

The reusable pattern is:

> comparison → mismatch detection → formal bridge → executable portability test → axiom audit → execution-provenance audit → correction.

This is a concrete example of how AI-assisted scientific production can generate value not only in theorem construction but also in verification methodology.

---

## Persistent reproduction artifacts

The durable S1 artifacts are:

- `Formalization/Erdos678/ExternalStatementBridge.lean`;
- `Formalization/Erdos678/ExternalStatementBridgeTests.lean`;
- `problems/678/DIFFERENTIAL_VERIFICATION_PROTOCOL.md`;
- `problems/678/DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`;
- `problems/678/experiments/run_public_comparator_common_env.sh`;
- `problems/678/CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`;
- this result document.

The one-time experiment workflow was intentionally deleted after the successful run; the immutable run/log record and reproduction script remain.

---

## S1 integration gate

The **experimental** component of S1 is complete and successful.

The **repository-integration** component closes only after:

1. the GitHub billing/spending condition is resolved;
2. the persistent final S1 head passes the corrected commit-explicit canonical `Lean Verification` gate;
3. the merged `main` head passes post-merge verification.

No other Erdős problem is involved or authorized.
