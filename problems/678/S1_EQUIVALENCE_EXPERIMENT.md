# Erdős #678 — S1 Semantic Equivalence and Differential Reproducibility Experiment

## Purpose

Stage S1 converts the qualitative statement “two Lean formalizations of Cambie's proof exist” into a reproducible comparison with explicit semantic and environment controls.

This experiment does **not** claim a new mathematical result, formalization priority, or an independent mathematical proof. Its scientific purpose is differential verification and proof-engineering comparison.

## Experimental questions

1. Does this project's final theorem normalize to the same interval semantics used by the public comparator and Formal Conjectures?
2. Do the normalized endpoints expose only the standard Lean axioms already reported by the public comparator?
3. Can both artifacts be rebuilt on the same runner and the same Lean/Mathlib release while preserving their native dependency layouts?
4. Which remaining differences are proof-architecture differences, and which are dependency/provenance differences?

## Fixed references

### Internal baseline

- repository: `scientifica007/Erdos_Solving`
- scientific-dossier baseline: `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`
- Lean: `v4.33.0`
- Mathlib: `v4.33.0`
- PNT+: `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`
- consumed analytic theorem: `prime_between`

### Public comparator — provenance pin

Formal Conjectures links to:

- repository: `plby/lean-proofs`
- commit: `68da20b96673899166e94638f5a7fffeb7231d35`
- file: `src/latest/ErdosProblems/Erdos678.lean`
- Lean/Mathlib at that snapshot: `v4.32.0`

This pin is retained for citation/provenance even though it is not the common-version comparator used by S1b.

### Public comparator — common-version pin

For controlled rebuilds we pin the current public comparator at:

- repository: `plby/lean-proofs`
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`
- file: `src/latest/ErdosProblems/Erdos678.lean`
- Lean/Mathlib: `v4.33.0`
- vendored `PrimeNumberTheoremAnd/Consequences.lean` blob: `167d52c19bdba66c37fa766415c3bd73105376b0`

The comparator vendors a local `PrimeNumberTheoremAnd` library; our project uses the external pinned Git dependency. Because both export modules with the same names but from different source snapshots, S1 does not force an artificial co-import. It instead uses a shared semantic contract plus separate native builds on the same runner. Dependency-source normalization is treated as a later controlled variable.

### Formal Conjectures pin

- repository: `google-deepmind/formal-conjectures`
- comparison snapshot: `398958d3964d738886bd24433918c365df4a2aab`
- target file: `FormalConjectures/ErdosProblems/678.lean`
- relevant reading: eventual non-emptiness of the valid-pair set, with an infinite-triples variant.

## S1a — semantic normalization inside Lean

The module

`Formalization.Erdos678.ExternalStatementBridge`

introduces the public interval representation

```lean
def externalLCMInterval (n k : ℕ) : ℕ :=
  (Finset.Ioc n (n + k)).lcm id
```

and proves the bridge chain:

1. `intervalFinset_succ_eq_Ioc`
2. `erdosM_eq_externalLCMInterval`
3. `erdos678_external_eventual_witnesses`
4. `erdos678_formalConjectures_eventually_nonempty`

The final theorem has the Formal-Conjectures-style semantic shape:

```lean
∀ᶠ k in atTop,
  {(m, n) |
    n + k ≤ m ∧
      externalLCMInterval m (k + 1) < externalLCMInterval n k}.Nonempty
```

Thus the comparison does not depend on visually similar notation or an informal indexing argument: our endpoint is transported to the external half-open interval convention in Lean.

### First verification result

PR #24 head `610d525145a8129d345a1d3ce6a6b41809e3d1f8` triggered Lean Verification run `32033822601`, job `95399520207`.

The build succeeded and reported:

- `No update necessary`
- `Build completed successfully (8808 jobs).`
- each of the four bridge/audit endpoints depends only on:
  - `propext`
  - `Classical.choice`
  - `Quot.sound`

No `sorryAx` or custom mathematical axiom appears in these audit outputs.

### CI-credit correction discovered by the experiment

The same log exposed an important workflow-semantics issue: before PR #24, the canonical pull-request workflow used the default `actions/checkout` behavior. For a `pull_request` event, run `32033822601` therefore checked out synthetic merge commit

`5983f901358d8f82d85a425369d429cfa9475f96`

which merges PR head `610d525...` into base `0d8287...`.

Accordingly, run `32033822601` is correctly classified as **successful integration-tree verification**, not literal exact-head checkout, even though GitHub run metadata exposes the PR `head_sha`.

PR #24 corrects the canonical workflow so pull-request builds explicitly checkout

`${{ github.event.pull_request.head.sha || github.sha }}`

and records `git rev-parse HEAD`. A later green run on the final PR head is required before S1 is credited as true exact-head verification.

This correction is itself process evidence for the AI-assisted-production track: verification claims must be tied to the commit actually checked out in logs, not inferred from run metadata alone.

## S1b — same-runner dual-build design

Workflow:

`.github/workflows/erdos678-comparison.yml`

The experiment runs on one `ubuntu-24.04` job and:

1. checks out this PR's actual head into `ours/`;
2. checks out `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` into `comparator/`;
3. verifies both toolchain files are identical;
4. builds `Formalization.Erdos678.ExternalStatementBridgeTests` in our native environment;
5. verifies our PNT dependency resolves to `2667e414...` and contains `prime_between`;
6. verifies the comparator's vendored `Consequences.lean` blob and presence of `prime_between`;
7. builds `ErdosProblems.Erdos678` in the comparator's native environment.

This controls runner and Lean/Mathlib version while deliberately recording, rather than hiding, the different PNT source snapshots.

### Why not naive co-import?

Both projects expose `PrimeNumberTheoremAnd.*` module names, but from different source snapshots. A forced joint Lake environment would introduce a module-source collision and could turn dependency reconciliation into an uncontrolled confounder. The semantic bridge supplies the common contract; the dual native build supplies the reproducibility comparison. A later dependency-normalization experiment may deliberately remove this difference.

## Evidence classification

At this checkpoint:

- semantic bridge: **machine-checked**
- bridge axiom audit: **standard Lean axioms only**
- first bridge build: **integration-tree verified**, not exact-head
- canonical workflow exact-head fix: **implemented, awaiting final green run**
- same-runner comparator workflow: **implemented, awaiting successful run**
- maintenance superiority: **not established**
- dependency-coupling superiority: **not established**
- new mathematics: **not claimed**

## Publication relevance

If S1b succeeds, the defensible contribution is stronger than “we also formalized #678”: it becomes an independently engineered formal replication whose endpoint has been semantically normalized to the public benchmark and whose two implementations can be rebuilt under a controlled common toolchain/run environment.

The workflow-discovery correction also provides a concrete AI-for-science case episode: an operational verification label was too strong, the discrepancy was found by inspecting execution evidence, and the protocol/workflow was repaired before publication.

## Scope gate

All work here concerns the already completed and archived #678 artifact. It does not authorize selection, exploration, or formalization of another Erdős problem; `DEC-012` remains in force.
