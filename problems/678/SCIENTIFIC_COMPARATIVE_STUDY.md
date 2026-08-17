# Erdős #678 — Scientific Comparative Study

## Purpose and scope

This document positions the completed `Erdos_Solving` reconstruction of Erdős Problem #678 against the mathematical source and the public Lean formalizations known as of 2026-08-17.

It is intentionally conservative about novelty. The repository does **not** claim a new mathematical solution and does **not** claim the first Lean formalization. Its potential scientific contribution is instead evaluated as an independently developed formal replication, an alternative proof-engineering architecture, and a reproducible case study in machine-checked research-mathematics production.

The comparison is frozen against the following artifacts:

- S. Cambie, *Resolution of an Erdős' problem on least common multiples*, arXiv:2410.09138 (2024): https://arxiv.org/abs/2410.09138
- public Lean proof snapshot: `plby/lean-proofs`, commit `68da20b96673899166e94638f5a7fffeb7231d35`, file `src/latest/ErdosProblems/Erdos678.lean`;
- Formal Conjectures statement: `google-deepmind/formal-conjectures`, `FormalConjectures/ErdosProblems/678.lean`;
- this repository: `scientifica007/Erdos_Solving`, archival comparison base `main` commit `4596a360257a3f659d2a260b4cb00b22d0ffa94c`.

No claim below should be interpreted as a priority claim unless it is explicitly stated and supported by the cited artifacts.

---

## 1. What is already known

### 1.1 Mathematical result

Cambie proved a strong affirmative form of Erdős #678: the ratio between the LCM of the earlier shorter interval and the later longer interval can be made larger than any prescribed constant for sufficiently large block length.

Therefore our Lean development is a reconstruction of existing mathematics. The mathematical author of the proof is Stijn Cambie.

### 1.2 Existing Lean formalization

A public Lean formalization by Aristotle and Boris Alexeev predates this repository's completed reconstruction. At the pinned comparison commit `68da20b...`, its header records:

- Lean `v4.32.0`;
- Mathlib `v4.32.0`;
- informal author: Stijn Cambie;
- formal authors: Aristotle and Boris Alexeev;
- imports `Mathlib` and `PrimeNumberTheoremAnd.Consequences`.

The file defines a local theorem `pi_alt` by invoking `_root_.pi_alt`; it is no longer an opaque custom PNT axiom at this pinned snapshot. Its final `#print axioms` output for `main_theorem_expanded`, `erdos_678`, and `erdos_678_kmn_infinite` reports only Lean's standard logical axioms `propext`, `Classical.choice`, and `Quot.sound`.

This matters: the scientific value of our work cannot rest on either "first formalization" or "first unconditional PNT-backed formalization".

### 1.3 Formal Conjectures

The Formal Conjectures project now records #678 as solved and points to the public `plby/lean-proofs` artifact. It distinguishes several readings:

- eventual nonemptiness of the valid-pair set as `k -> infinity`;
- infinitely many valid triples when `k` varies;
- the fact that one should **not** read the problem as requiring infinitely many pairs for each fixed `k`.

That statement-level correction is scientifically important because #678 is a concrete example where formalization helped expose ambiguity in an informal problem statement.

---

## 2. What this repository proves

The final endpoint is `formalization/Formalization/Erdos678/Erdos678Final.lean`.

The principal public-facing theorems are:

- `cambie_lcm_ratio_eventually_with_large_start`: for every positive constant `C`, all sufficiently large `k` admit `x,y` with the strong LCM ratio and the placement information needed for the canonical Erdős indexing;
- `erdos678_unbounded_witnesses`: for every requested lower bound `B`, there is a valid canonical triple `(n,m,k)` with `B <= k`;
- `erdos678_good_lengths_infinite`: the set of block lengths admitting canonical witnesses is infinite.

These endpoints do **not** constitute a new mathematical result beyond Cambie's theorem. Their value is as a clean interface to the original Erdős formulation and as independently checked downstream consequences of the reconstructed proof.

The analytic dependency is pinned explicitly in `formalization/lakefile.toml`:

- Mathlib `v4.33.0`;
- `AxiomMath/PrimeNumberTheoremAnd` revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

The PNT bridge is implemented in `Claim4RelativePrimePNT.lean` from the already formalized theorem `prime_between`, producing exactly the relative-prime provider consumed by the Claim 4 layer.

---

## 3. Quantitative architecture comparison

The following metrics are structural, not quality scores.

### 3.1 This repository

At archival head `4596a360...`, the directory `formalization/Formalization/Erdos678` contains:

- **78 Lean files**;
- **7046 lines** in those files;
- **47 non-test/formal-development files**, 5662 lines;
- **31 explicitly named test/regression files**, 1384 lines.

The line counts are reconstructed from the GitHub comparison against the pre-directory checkpoint `c5689514feaa3469b9234f5f79f76a61474d56a1`, where all current `Formalization/Erdos678/*` files appear as additions.

The development is intentionally decomposed into layers for:

- interval semantics and LCM definitions;
- basic/product/LCM valuations;
- small-, medium-, and large-prime cases;
- Claim 5 assembly and LCM algebra;
- generic density and modular lemmas;
- pair/triple CRT producers;
- application boxes and weighted representations;
- scale construction and factorization;
- prime windows and representative placement;
- PNT-to-relative-prime adapter;
- strong Cambie theorem;
- final canonical index translation;
- positive and negative regression tests.

### 3.2 Pinned public comparator

The pinned `plby/lean-proofs` snapshot stores the #678 formalization in a **single 2535-line Lean file**.

It follows the same broad mathematics—Cambie's definitions, CRT/density construction, valuation arguments, asymptotic estimates, PNT input, and final Erdős consequences—but packages the proof much more monolithically.

### 3.3 Interpretation

`7046 lines / 78 files` versus `2535 lines / 1 file` does **not** imply that our proof is superior. The extra surface area partly reflects deliberate interface boundaries, duplicated test declarations, explanatory structure, and engineering checks.

The scientifically testable question is narrower:

> Does a modular, regression-heavy reconstruction improve auditability, maintenance locality, dependency transparency, or resistance to target/interval drift enough to justify its larger code footprint?

That question can be evaluated experimentally; it should not be answered from file counts alone.

---

## 4. Proof-architecture crosswalk

| Mathematical responsibility | `plby/lean-proofs` | `Erdos_Solving` |
|---|---|---|
| Main Cambie setup | definitions and lemmas in one file | separate interval/valuation/Claim 4/Claim 5 modules |
| Prime-density input | local `pi_alt` theorem backed by PNT+ | `prime_between` -> `Claim4RelativePrimeProvider` adapter |
| CRT/density | inline theorem chain | generic density, modular, weighted, pair/triple CRT modules |
| Prime-range valuation split | inline sections/lemmas | dedicated small/medium/large-prime modules |
| Claim 5 | inline chain | assembly + algebra + product-estimate boundary |
| Placement/search windows | inline | prime-window, scale, room, placement, separation modules |
| Final Erdős indexing | final theorem code | dedicated E4 translation with explicit recovery of `k < x` |
| Infinitude | `erdos_678_kmn_infinite` | unbounded-witness theorem + infinite-good-length theorem |
| Regression layer | no comparable dedicated file family in the pinned artifact | 31 dedicated test/regression files |
| Dependency pinning | environment-specific public repository | explicit Mathlib and PNT+ revisions in local Lake project |

This table identifies architecture differences, not semantic differences in the underlying mathematics.

---

## 5. The most concrete technical difference: the PNT interface

The public pinned proof imports PNT+ and proves a local `pi_alt` wrapper from `_root_.pi_alt`.

Our reconstruction instead consumes PNT+ through `prime_between` and converts it to a small domain-specific interface:

`prime_between`

`-> Claim4RelativePrimeProvider`

`-> five separated prime strips`

`-> Claim 4 construction`.

This is potentially useful beyond this repository for two reasons.

First, the interface expresses the actual downstream need: a prime in a multiplicatively short interval, not an asymptotic formula for `primeCounting`.

Second, Boris Alexeev explicitly noted in the Erdős Problems formalisation discussion that for #678, `prime_between` would have been a better choice than `pi_alt`, but he had not known that result was available at the time. See:

https://www.erdosproblems.com/forum/thread/Formalisation

This does **not** make our theorem stronger or more unconditional. Both pinned developments ultimately rely on machine-checked PNT+ results. It does, however, create a concrete candidate for an upstream simplification or reusable adapter.

---

## 6. Independent replication value

The strongest defensible scientific characterization is:

> an independent Lean reimplementation of Cambie's proof, completed after a separate failed discovery attempt, with a different module/interface architecture and a different direct PNT consequence at the analytic boundary.

Independent formal replication can add value even when it proves no new theorem:

1. **Statement cross-checking.** Two separately engineered developments reduce the chance that a single formal encoding mistake silently defines the target incorrectly.
2. **Proof decomposition cross-checking.** Different abstractions expose different hidden obligations. Our reconstruction, for example, elevated interval-length semantics, affine CRT scaling, and final `x -> n=x-1` translation to explicit proof boundaries.
3. **Dependency cross-checking.** The direct `prime_between` route checks that the analytic part can be connected without relying on the comparator's particular `pi_alt` proof route.
4. **Maintenance evidence.** Two code structures allow controlled experiments on upgrade robustness and edit locality.
5. **Benchmark enrichment.** A research-level theorem with two non-identical formal proofs is useful data for theorem-proving and proof-translation systems.

A relevant precedent is the ITP 2026 short paper *Three Roads to de Finetti's Theorem in Lean 4*, where independently structured routes to a shared interface were explicitly used as a cross-check during AI-assisted development:

https://doi.org/10.4230/LIPIcs.ITP.2026.34

The analogy is methodological, not a claim that the two projects have the same scale or novelty.

---

## 7. What is **not** a contribution

The following claims should not be made in a paper, README, talk, or upstream proposal:

- "We solved Erdős #678." — Cambie solved it.
- "We found a new proof." — the successful proof is a reconstruction of Cambie's argument.
- "We produced the first Lean proof." — Aristotle/Alexeev predates this reconstruction.
- "We were the first to remove the PNT axiom." — the pinned public comparator already imports PNT+ and its final axiom audit is clean apart from standard Lean axioms.
- "Our proof is better because it is longer/more modular." — this requires measurement.
- "Our final infinitude theorem is mathematically stronger than the public eventual-existence theorem." — Cambie's strong theorem already supplies witnesses for every sufficiently large `k`; the endpoint formulations package the same underlying strength differently.

This negative-claim list is part of the scientific artifact because it protects attribution and prevents novelty inflation.

---

## 8. Testable scientific hypotheses

The existing artifacts support several hypotheses that can be tested without changing the mathematics.

### H1 — Direct analytic interfaces reduce coupling

Replacing a `primeCounting` asymptotic wrapper with `prime_between` should reduce the number of analytic concepts exposed to the combinatorial construction.

**Measurement:** transitive imports, declarations referenced by the #678 bridge, proof lines in the adapter, and changes required under PNT+ API updates.

### H2 — Modular interfaces localize repair

A proof split around mathematical contracts should require fewer unrelated edits when one interface changes.

**Measurement:** controlled edits to the prime-window provider, interval convention, or Claim 5 interface; count files/declarations affected and compare repair effort.

### H3 — Explicit regression tests detect semantic drift earlier

Positive and negative witnesses plus boundary tests should catch interval/indexing errors before they propagate to the final theorem.

**Measurement:** mutation testing on `Ioc/Icc`, length/end-point translation, or the `n=x-1,m=y-1` bridge; record which checks fail and at what layer.

### H4 — A dedicated final translation layer improves statement fidelity

Keeping the paper's `x,y` convention separate from Erdős's `n,m` convention should make off-by-one obligations auditable.

**Measurement:** theorem dependency graph and mutation tests in the final translation only.

### H5 — Independent implementations provide useful differential verification

Normalizing the two final statements and proving bridge lemmas should expose any semantic mismatch between the two artifacts.

**Measurement:** construct a small compatibility module importing both developments in a common environment and prove statement equivalences/implications.

---

## 9. Experiments required before publication-grade comparison

The current dossier supports a strong technical note, but a publication-grade empirical comparison should additionally perform:

1. **Common-environment build.** Port both artifacts to one pinned Lean/Mathlib/PNT+ environment.
2. **Axiom audit.** Run `#print axioms` on matched endpoints in the common environment.
3. **Normalized statement bridge.** Define one canonical #678 predicate and prove both formalizations imply it.
4. **Cold/warm build measurements.** Record wall-clock, CPU, memory, and compiled-job counts under controlled hardware.
5. **Dependency graph metrics.** Count direct/transitive imports and declarations reachable from the final theorem.
6. **Edit-locality experiments.** Change one boundary API and record repair footprint.
7. **Mutation testing.** Introduce known historical bugs—the false interval shift and selected off-by-one variants—and compare detection behavior.
8. **Upgrade experiment.** Move both developments one Mathlib release forward and record breakages and repair size.
9. **Documentation/audit evaluation.** Have an independent Lean user locate the PNT boundary, final indexing boundary, and negative regression from each artifact; measure time/errors.

Until these experiments are run, claims about maintainability or auditability remain hypotheses supported by design rationale, not established results.

---

## 10. Candidate upstream contributions

The highest-value upstream work appears to be small and surgical rather than attempting to replace the existing public proof.

### Candidate A — `prime_between` adapter

Extract a reusable theorem/structure that turns PNT+'s multiplicative prime-existence result into the natural-number relative-prime provider used by short-interval CRT constructions.

Potential destinations:

- PNT+ `Consequences` utilities;
- a small utility module in the public #678 proof;
- a general number-theory formalization helper repository.

### Candidate B — statement-bridge module

Provide a compact formal bridge among:

- eventual nonempty pairs;
- unbounded good `k`;
- infinite valid triples.

This would make the intended semantics of #678 explicit and reusable by Formal Conjectures-style benchmarks.

### Candidate C — regression cases

Offer the verified positive witness and carefully chosen negative/off-by-one regressions as tests for future refactors of the public artifact.

### Candidate D — modular extraction, only if justified by measurement

If experiments show clear maintenance benefits, selected generic CRT-density or interval-translation lemmas may be worth upstreaming. The full 78-file architecture should **not** be proposed wholesale merely because it exists.

---

## 11. Relationship to current AI-for-mathematics research

The #678 development is particularly relevant to research on **long-horizon** formalization rather than one-shot theorem proving.

Recent work provides useful comparison points:

- *Formal Conjectures: An Open and Evolving Benchmark for Verified Discovery in Mathematics*, arXiv:2605.13171 — emphasizes research-level statements, statement auditing, and AI-generated proof/disproof as a mechanism for improving benchmark fidelity.
- *Advancing Mathematics Research with AI-Driven Formal Proof Search*, arXiv:2605.22763 — evaluates AI agents on open Erdős and other research problems.
- *LeanMarathon: Toward Reliable AI Co-Mathematicians through Long-Horizon Lean Autoformalization*, arXiv:2606.05400 — identifies statement drift, dependency tangling, context decay, and local repairs corrupting distant work as central long-horizon failure modes.
- *FormalScience: Scalable Human-in-the-Loop Autoformalisation of Science with Agentic Code Generation in Lean*, ACL 2026 — studies semantic alignment and semantic drift in agentic autoformalization.
- G. R. Lau, *Using Aristotle API for AI-Assisted Theorem Proving in Lean 4: A Formalisation Case Study of the Grasshopper Problem*, arXiv:2605.20120 — emphasizes the need to distinguish locally verified helper lemmas from a genuinely closed main theorem.

Our #678 experience contains concrete instances of exactly these issues: statement/index fidelity, a locally attractive but false generalization, dependency closure, long chains of interfaces, verification of the reachable build graph, and the distinction between a finite witness and an infinitude theorem.

That makes the development potentially valuable not just as a second proof artifact but as a **longitudinal AI-assisted scientific-production case study**. The companion document `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` treats that dimension separately.

---

## 12. Scientific-value assessment

### Mathematical novelty

**Low / none.** The successful mathematics is Cambie's.

### Formalization priority novelty

**None.** A public Lean formalization already exists.

### Independent verification value

**Material.** The code architecture and PNT interface are independently reconstructed and yield the same mathematical endpoint.

### Formal proof-engineering value

**Potentially high, but empirical validation is still required.** The repository exposes unusually explicit boundaries and regressions that support controlled experiments.

### AI-for-mathematics value

**Potentially high as a case study.** The repository preserves a transition from failed independent reasoning to audited external-proof reconstruction, with git history, machine checks, negative regressions, state protocols, and CI gates.

### Immediate upstream value

**Moderate and concrete.** The `prime_between` adapter and statement-bridge/regression material are the strongest candidates.

---

## 13. Recommended public characterization

A defensible one-sentence description is:

> We independently reconstructed Cambie's solution of Erdős Problem #678 in Lean as a modular, regression-tested development, using a direct `prime_between` interface to PNT+, and we compare this artifact with the existing Aristotle/Alexeev formalization as a case study in long-horizon AI-assisted formal mathematics.

The words **independently reconstructed** refer to the Lean development, not to independent discovery of the mathematics.

---

## 14. Evidence ledger

Internal reproducibility anchors:

- archival comparison head: `4596a360257a3f659d2a260b4cb00b22d0ffa94c`;
- mathematical integration merge: `8fd1b20541ac7782f52429db3a2cc4c887547372`;
- final mathematical pre-merge head: `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`;
- final E4 run: `31977861568` — success, 8806-job canonical build;
- post-merge mathematical run: `32011189766` — success;
- post-postmortem archival run: `32021192337` — success;
- PNT+ revision: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

External reproducibility anchors:

- Cambie: arXiv:2410.09138;
- public comparator: `plby/lean-proofs@68da20b96673899166e94638f5a7fffeb7231d35`;
- Formal Conjectures: `FormalConjectures/ErdosProblems/678.lean`;
- Erdős Problems discussion: https://www.erdosproblems.com/forum/thread/678
- formalisation discussion, including the `prime_between` remark: https://www.erdosproblems.com/forum/thread/Formalisation

---

## 15. Bottom line

The completed #678 artifact should be treated neither as a new solution nor as redundant duplication.

Its best scientific use is the intersection of:

`independent formal replication`

`+ alternative dependency/interface architecture`

`+ differential comparison against an existing AI-generated formalization`

`+ a preserved long-horizon AI-assisted scientific-production record`.

The next scientific work on #678 should therefore be comparative and experimental, not a reopening of the mathematics.