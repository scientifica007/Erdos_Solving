# Erdős #678 — Differential Verification Protocol

## Purpose

Stage S1 converts the existence of two Lean developments of Cambie's proof into a reproducible differential-verification experiment.

The goal is **not** to claim a new theorem or to import/copy the public Aristotle/Alexeev proof into this repository.  The goal is to establish, under pinned inputs, that:

1. this repository formally derives the same canonical interval semantics used by the public comparator and Formal Conjectures;
2. this repository derives the Formal-Conjectures-style eventual-nonempty statement;
3. this repository's natural-factor strong theorem lifts to the real-factor domain `C ≥ 1` used by the public strong endpoint;
4. the public comparator source itself compiles in this repository's pinned Lean/Mathlib/PNT+ environment;
5. both artifacts expose clean axiom audits under those conditions.

This is a statement/interface and environment compatibility test, not a literal simultaneous import of both developments into one namespace.

---

## Frozen inputs

### Internal artifact

- repository: `scientifica007/Erdos_Solving`;
- S1 base: `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`;
- Lean/Mathlib: `v4.33.0`;
- PNT+: `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### Historical public comparator referenced by Formal Conjectures

- repository: `plby/lean-proofs`;
- commit: `68da20b96673899166e94638f5a7fffeb7231d35`;
- file: `src/latest/ErdosProblems/Erdos678.lean`;
- Lean/Mathlib recorded by that snapshot: `v4.32.0`.

This remains the priority/reference pin because Formal Conjectures links to it.

### Common-environment public comparator

For the executable S1 portability experiment we freeze the newer public source:

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- file: `src/latest/ErdosProblems/Erdos678.lean`;
- file blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- header: Lean `v4.33.0`, Mathlib `v4.33.0`.

This source imports only `Mathlib` and `PrimeNumberTheoremAnd.Consequences`, so it can be compiled against the pinned Lake environment of this repository rather than against the vendored PNT+ tree in `plby/lean-proofs`.

### Formal Conjectures statement audit

- repository: `google-deepmind/formal-conjectures`;
- comparison commit: `398958d3964d738886bd24433918c365df4a2aab`;
- file: `FormalConjectures/ErdosProblems/678.lean`.

The relevant solved statement is eventual nonemptiness of

`{(m,n) | n+k ≤ m ∧ lcmInterval m (k+1) < lcmInterval n k}`.

---

## Internal formal bridge

`Formalization.Erdos678.ExternalStatementBridge` contains four comparison endpoints.

### 1. Interval semantics

`intervalFinset_succ_eq_Ioc` proves

```text
intervalFinset (n+1) k = Finset.Ioc n (n+k).
```

`erdosM_eq_Ioc_lcm` therefore proves that the canonical `erdosM n k` definition is extensionally identical to the public

```text
(Finset.Ioc n (n+k)).lcm id
```

convention.

This is important because the project previously experienced a genuine off-by-one failure.  Semantic equivalence is machine-checked rather than assumed from notation.

### 2. Eventual nonemptiness

`erdos678_formalConjectures_eventual_nonempty` derives the eventual-nonempty pair statement directly from this repository's final Cambie endpoint.

The theorem intentionally uses literal `Finset.Ioc` expressions so its target can be compared with Formal Conjectures without depending on this repository's naming conventions.

### 3. Real-factor lift

The public `main_theorem_expanded` quantifies over `C : ℝ` with `C ≥ 1`, whereas the construction endpoint originally retained by this repository quantifies over a positive natural factor.

`cambie_lcm_ratio_eventually_with_large_start_real` closes that API difference by choosing `N = Nat.ceil C`, applying the natural-factor theorem, casting its strict inequality to `ℝ`, and using `C ≤ N`.

This is a packaging theorem, not new mathematics.

### 4. Axiom audit

`ExternalStatementBridgeTests.lean` prints axioms for the new comparison endpoints and the existing final infinitude endpoints.  The experiment records the output from CI.

---

## Public comparator challenge baseline

The current public repository includes

`src/latest/ComparatorChallenges/ErdosProblems/Erdos678.json`.

It designates five comparator endpoints:

- `Erdos678.erdos_678`;
- `Erdos678.erdos_678_kmn_infinite`;
- `Erdos678.main_theorem_expanded`;
- `Erdos678.not_erdos_678_fc`;
- `Erdos678.not_erdos_678_other`.

The permitted axioms are exactly:

- `propext`;
- `Classical.choice`;
- `Quot.sound`.

The config enables `nanoda`.

This provides an externally defined axiom-audit baseline rather than one selected by this project after seeing the results.

---

## Executable common-environment experiment

Persistent script:

`problems/678/experiments/run_public_comparator_common_env.sh`

The script:

1. initializes a temporary Git repository outside the project tree;
2. fetches exactly public commit `6f906fef...`;
3. verifies that the comparator file has exactly blob `f2331e8b...`;
4. materializes that file only in the temporary directory;
5. invokes `lake env lean` from this repository's `formalization/` project.

The public comparator source is therefore **not committed or redistributed** by this project.

A temporary branch-only GitHub Actions workflow is used to run the canonical build and this comparator compile in one runner/environment.  The temporary workflow is deleted before the final S1 PR is merged; its successful run ID and logs are retained as evidence.

---

## Success criteria

S1 passes only if all of the following hold:

1. `lake exe mk_all --check` accepts the canonical import graph with the new bridge;
2. the complete internal `Formalization` target builds;
3. bridge tests close, including a non-integral real factor such as `C = 3/2`;
4. the external comparator commit and blob checks pass;
5. the public `Erdos678.lean` compiles under this repository's pinned Lake environment;
6. public comparator `#print axioms` output remains within its published permitted-axiom set;
7. internal comparison endpoints have no unexpected custom axioms;
8. the temporary experiment workflow is removed before merge;
9. the final S1 branch itself passes the standard exact-head `Lean Verification` workflow.

A failure in (4)-(6) is a scientifically useful portability result and must be recorded rather than patched by silently changing the frozen comparator input.

---

## What S1 does and does not establish

If successful, S1 establishes a stronger comparison than independent builds in unrelated environments:

- the public source is portable to the same pinned Mathlib/PNT+ environment used by our artifact;
- our target is formally normalized to the public interval semantics;
- a previously visible `ℕ`-versus-`ℝ` factor-interface mismatch is formally bridged;
- both developments can be compared against explicit axiom baselines.

S1 still does **not** prove that the internal proof terms are independent in a cryptographic or genealogical sense, and it does not show that one architecture is better.  Those are separate provenance and empirical questions.

Because both developments use namespace `Erdos678`, a literal simultaneous import would create declaration collisions unless one source were mechanically renamed.  S1 deliberately avoids such source rewriting: separate compilation in the exact same environment plus a formal semantic bridge gives a cleaner, reproducible comparison without modifying the comparator.

---

## Relation to the larger publication plan

S1 is the first evidence-producing stage after the scientific dossier freeze.

After S1:

- **S2** measures dependency surface, build behavior, mutations, and repair locality;
- **S3** probes small upstream contributions such as the `prime_between` adapter or statement bridges;
- **S4** turns the observable #678 history into an AI-assisted scientific-production dataset and prospective experiments;
- **S5** decides whether the evidence supports one paper, two outputs, an upstream contribution, or an artifact-only technical report.

All stages remain restricted to archived Erdős #678.  `DEC-012` remains in force.
