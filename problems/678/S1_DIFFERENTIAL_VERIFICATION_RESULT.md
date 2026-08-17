# Erdős #678 — S1 Differential Verification Result

## Result

**SUCCESS.** On 2026-08-17, the first executable cross-artifact verification experiment completed successfully.

The experiment used GitHub Actions run `32028006457`, job `95381414710`, on exact internal experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`.

The run did two things sequentially in one GitHub runner:

1. built this repository's complete canonical Lean graph with the new external-statement bridge;
2. fetched a pinned public Aristotle/Alexeev #678 source file and compiled it **unchanged** in this repository's pinned Lake environment.

The second step is the crucial external result: the public proof did not merely build in its own repository; it built against the same Lean/Mathlib/PNT+ environment used by our reconstruction.

---

## Exact environment

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

The two new bridge modules were part of that graph:

- `Formalization.Erdos678.ExternalStatementBridge`;
- `Formalization.Erdos678.ExternalStatementBridgeTests`.

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

It then materialized the source only in the runner's temporary directory and invoked

```text
lake env lean <temporary/Erdos678Comparator.lean>
```

from our `formalization/` Lake project.

The source was not edited and is not redistributed by this repository.

---

## Formal statement alignment established internally

The new bridge closes three previously informal comparison gaps.

### Interval convention

`intervalFinset_succ_eq_Ioc` proves exactly

```text
intervalFinset (n + 1) k = Finset.Ioc n (n + k).
```

Consequently `erdosM_eq_Ioc_lcm` proves that our canonical `erdosM n k` has exactly the same half-open interval semantics as the public comparator's `lcmInterval n k`.

This matters because the project had already experienced a real off-by-one failure during its rejected independent attempt.  The comparison no longer relies on visual similarity of notation.

### Formal Conjectures endpoint

`erdos678_formalConjectures_eventual_nonempty` has the literal target shape

```text
∀ᶠ k in atTop,
  {(m,n) |
    n + k ≤ m ∧
    (Finset.Ioc m (m + (k + 1))).lcm id <
      (Finset.Ioc n (n + k)).lcm id}.Nonempty.
```

Thus our final construction now has a kernel-checked bridge to the statement convention used by Formal Conjectures.

### Real multiplicative factor

Before S1, our retained strong endpoint used a positive natural factor `C`, whereas the public `main_theorem_expanded` uses `C : ℝ` with `C ≥ 1`.

`cambie_lcm_ratio_eventually_with_large_start_real` now closes that interface difference by taking `N = Nat.ceil C`, invoking the natural-factor theorem, and comparing the real casts.

The test suite includes the genuinely non-integral factor

```text
C = 3/2.
```

Therefore the earlier `ℕ`/`ℝ` API difference is no longer an unresolved comparison caveat.

---

## Matched axiom audit

The internal run printed:

```text
'Erdos678.cambie_lcm_ratio_eventually_with_large_start_real'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.erdos678_formalConjectures_eventual_nonempty'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.erdos678_unbounded_witnesses'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.erdos678_good_lengths_infinite'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

The public source, compiled in the same environment, printed:

```text
'Erdos678.main_theorem_expanded'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.erdos_678_kmn_infinite'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.not_erdos_678_fc'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.not_erdos_678_other'
depends on axioms: [propext, Classical.choice, Quot.sound]

'Erdos678.erdos_678'
depends on axioms: [propext, Classical.choice, Quot.sound]
```

This exactly matches the permitted-axiom set published by the public `ComparatorChallenges/ErdosProblems/Erdos678.json` configuration.

The experiment therefore gives a matched external baseline for our axiom claim rather than an internally selected standard.

---

## Timing observations

These are **observations from one run, not performance-comparison results**.

The internal `lake build` action reported approximately `838647 ms` and finished with 8808 jobs.

The public single-file compile began at approximately `12:23:27.5Z`; its axiom output appeared at `12:26:37.4Z`, roughly 190 seconds later.

These numbers are not directly comparable:

- the internal action builds an entire library target;
- the public command compiles one source after dependencies and caches have already been prepared;
- no controlled cold/warm repetitions were performed.

S2 must establish a controlled measurement protocol before any efficiency claim is made.

---

## Scientific interpretation

S1 strengthens the defensible scientific characterization of the project.

Before S1 we knew that two successful Lean artifacts existed.  After S1 we additionally know that:

1. our final target is formally normalized to the public interval semantics;
2. our artifact derives the Formal Conjectures eventual-existence reading explicitly;
3. our strong endpoint reaches the same real-factor parameter domain as the public strong theorem;
4. the current public proof source is portable, unchanged, to our exact pinned PNT+/Mathlib environment;
5. selected endpoints in both artifacts produce the same standard-axiom footprint in that environment.

This is meaningful **differential-verification evidence**.  It reduces several obvious sources of false agreement—different interval conventions, different factor domains, different dependency versions, and different axiom assumptions.

It still does not show that our architecture is better, faster, easier to maintain, or more independent historically.  Those remain S2/provenance questions.

---

## Why this matters for the AI-production case study

S1 also converts one important process principle into measurable evidence:

> external comparison should not rely on narrative claims that two artifacts "prove the same thing"; the workflow should create formal statement bridges and executable environment checks.

The AI-assisted process first detected an interface mismatch (`ℕ` factor versus `ℝ` factor), then converted it into an explicit Lean theorem rather than explaining it away in prose.

That sequence—comparison, mismatch detection, formal repair, exact-head build, external portability test, axiom audit—is itself a reusable pattern for AI-assisted scientific verification.

---

## Persistent reproduction artifacts

The durable artifacts are:

- `Formalization/Erdos678/ExternalStatementBridge.lean`;
- `Formalization/Erdos678/ExternalStatementBridgeTests.lean`;
- `problems/678/DIFFERENTIAL_VERIFICATION_PROTOCOL.md`;
- `problems/678/DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`;
- `problems/678/experiments/run_public_comparator_common_env.sh`.

The GitHub Actions workflow used for the one-time experiment was intentionally temporary and was deleted after run `32028006457`.  The run/log record remains the immutable execution evidence.

---

## S1 integration gate

The experimental phase is complete and successful.

S1 is fully closed only after the persistent artifacts—without the temporary workflow—pass the repository's standard exact-head `Lean Verification` PR gate and the merged `main` head passes post-merge verification.

No other Erdős problem is involved or authorized.
