# Lean Reconstruction and Differential Verification of Cambie's Solution to Erdős Problem #678

## Manuscript status

**Paper 1 — Formal Verification / Proof Engineering**  
**Status:** Draft 2 — P4 adversarial review complete; not yet submission-ready  
**Draft date:** 2026-08-20  
**Experimental evidence cutoff:** 2026-08-18 for the completed S1/S2 program  
**Publication/reproducibility infrastructure cutoff:** 2026-08-20  
**P4 review record:** `PAPER_1_ADVERSARIAL_REVIEW_2026-08-20.md`  
**Primary target for full-paper development:** Journal of Automated Reasoning  
**Accelerated option:** CPP 2027, subject to a successful 12-page compression audit  

This draft preserves the manuscript architecture established in the scaffold at commit `54c5c2b89eedc2dcb63c08aa23cf2ed8fc5e1c2d`. The underlying mathematics, Lean proof, dependency pins, and S1/S2 experiments are frozen; this document synthesizes them for publication.

## Contribution boundary

The successful mathematics is Stijn Cambie's 2024 solution of Erdős Problem #678. This paper reports a separately structured Lean reimplementation of that proof, explicit statement-fidelity bridges, controlled differential verification against a prior public Aristotle/Boris Alexeev Lean artifact, a bounded proof-engineering evaluation, and a reproducibility/provenance discipline.

The paper does **not** claim a new mathematical solution, a new independent mathematical proof, the first Lean formalization, general architectural superiority, universal speed superiority, general maintainability superiority, general semantic-robustness superiority, or general Lean/Mathlib upgrade compatibility.

A recurring interpretation rule is therefore:

> **Bounded experimental advantages or contrasts are reportable evidence; they are not, by themselves, general superiority claims.**

## Abstract

Stijn Cambie resolved Erdős Problem #678 in 2024 by proving a stronger least-common-multiple inequality for separated intervals of consecutive integers. We report a separately structured Lean reimplementation of Cambie's argument, with explicit bridges between the development's interval API and public `Finset.Ioc` statement conventions. The formalization proves witnesses for arbitrarily large block length and hence infinitely many good lengths. We differentially verified the reconstruction against a pinned, unchanged prior Aristotle/Boris Alexeev Lean artifact in a controlled common environment and audited selected theorem-level axiom footprints. We then ran a prospectively controlled proof-engineering evaluation covering dependency surface, build behavior, repair locality, semantic/index mutations, and two exact forward-version candidates. The results are deliberately bounded: dependency counts were packaging-sensitive; six paired builds produced no stable wall-clock winner, although the reconstruction used substantially less median total CPU time and somewhat less peak memory in the pinned environment; repair locality was mixed; all six frozen semantic/index observations were rejected; and forward-version tests stopped at dependency/package boundaries before an eligible project-owned repair surface was reached. Finally, we make verification credit auditable through canonical import-graph checks, full builds, exact-head verification, exact-main post-merge status, and a reproducibility package. The contribution is formal-verification and proof-engineering evidence, not new mathematics or first-formalization priority.

**Keywords:** Lean 4; formalized mathematics; proof reconstruction; differential verification; reproducibility; proof engineering

---

## 1. Introduction

### 1.1 Problem context

For natural numbers `n` and `k`, write

\[
M(n,k)=\operatorname{lcm}\{n+1,n+2,\ldots,n+k\}.
\]

Erdős asked whether a shorter block of consecutive integers can have larger least common multiple than a longer block beginning sufficiently far to the right. In the formulation relevant here, one seeks, for sufficiently large block length `k`, integers `n,m` satisfying

\[
n+k\le m
\quad\text{and}\quad
M(n,k)>M(m,k+1).
\]

The quantifier over `k` matters. For a fixed `k`, the intended result is not that infinitely many pairs `(m,n)` satisfy the inequality. Rather, the positive result ranges over arbitrarily large `k`: for every sufficiently large `k` there is at least one valid pair, and consequently valid triples occur for infinitely many block lengths. This distinction is explicit both in the current public Formal Conjectures statement for Erdős #678 and in the endpoints of our formalization.

Cambie [1] answered the question affirmatively in 2024 and proved a stronger statement: the ratio between the two relevant LCMs can be made arbitrarily large. The mathematical contribution of the present work is therefore not a new solution. Our object of study is what happens when that published argument is reconstructed as a machine-checked Lean development with explicit semantic interfaces and then subjected to independent executable comparison and controlled proof-engineering experiments.

### 1.2 Why formal reconstruction is scientifically useful

A proof assistant verifies a proposition only after the proposition, its definitions, its dependencies, and the proof term have all been represented in a precise formal environment. This creates several verification obligations that are easy to conflate.

First, **proof correctness** asks whether the kernel accepts a proof of the formal proposition. Second, **statement fidelity** asks whether that formal proposition faithfully represents the intended mathematical claim, including indexing conventions and quantifier scope. Third, **artifact provenance** asks which exact source tree, dependency graph, and commit were verified. Fourth, when experiments compare formal artifacts, **scientific admissibility** asks whether the observed run satisfied its predeclared protocol before any conclusion is credited.

Erdős #678 is a useful case because its mathematical statement looks elementary while the successful proof combines prime-density input, Chinese-remainder constructions, p-adic valuation arguments, interval products, and asymptotic inequalities. The problem is also sensitive to off-by-one interval conventions: shifting a block by one integer can turn a plausible statement into a false one. A reconstruction therefore provides more than a binary “Lean accepts” signal. It makes the interfaces among the published proof, internal definitions, public statement conventions, analytic dependencies, and final benchmark endpoint explicit and checkable.

A separately structured implementation is also useful for a different reason. A second artifact can expose assumptions or semantic choices that are invisible when one only recompiles the original artifact. Here “separately structured” describes implementation organization and repository provenance only: the project reimplements Cambie's published mathematics in its own Lean development; it does not claim independent discovery, a genealogically unrelated proof, or an independent new mathematical proof.

Finally, formal artifacts are executable software objects. They can be compared under frozen environments, perturbed by prospectively specified mutations, and tested under controlled upgrade candidates. Such measurements can reveal engineering contrasts, but only within the scope of the experiment. A central methodological stance of this paper is that raw measurements should not be promoted into general architecture rankings without a design that supports that inference.

### 1.3 Contributions

This paper makes seven contributions.

1. **Separately structured Lean reconstruction.** We provide a separately structured Lean 4 reimplementation of Cambie's proof under pinned dependencies, culminating in an unbounded-witness theorem and an infinitude theorem for good block lengths.

2. **Explicit statement fidelity.** We prove bridges between the development's length-based interval semantics and the public `Finset.Ioc` convention, including the index translation from the strong theorem to the canonical Erdős variables.

3. **Closed analytic dependency path.** The proof uses a pinned `PrimeNumberTheoremAnd` dependency for the prime-distribution input rather than leaving a project-local analytic assumption opaque.

4. **Differential verification.** We compile and compare the reconstruction with a pinned, unchanged prior Aristotle/Boris Alexeev formal artifact in a common environment, including selected statement and axiom-footprint checks.

5. **Verification-credit provenance.** The repository distinguishes a green computation from credit for the exact artifact: the canonical import graph, exact pull-request head, merge identity, and exact resulting `main` commit are independently checked.

6. **Prospectively controlled proof-engineering evaluation.** The S2 program measures dependency surface, paired build behavior, repair locality, frozen semantic/index perturbations, and two exact forward-version candidates.

7. **Conservative interpretation of mixed and bounded results.** We report favorable, null, mixed, excluded, and dependency-boundary outcomes without converting them into unsupported claims of general speed, maintainability, robustness, or architectural superiority.

---

## 2. Mathematical background

### 2.1 Erdős #678 statement and canonical endpoint

The repository defines `erdosM n k` to represent

\[
M(n,k)=\operatorname{lcm}\{n+1,\ldots,n+k\}.
\]

The strongest canonical endpoint used for the benchmark is an unbounded formulation. In mathematical notation, the Lean theorem `erdos678_unbounded_witnesses` establishes

\[
\forall B\in\mathbb N,\;\exists n,m,k\in\mathbb N,
\]

such that

\[
B\le k,\quad 3\le n,\quad 3\le m,\quad 3\le k,\quad n+k\le m,
\]

and

\[
M(m,k+1)<M(n,k).
\]

This formulation makes the source of infinitude explicit: valid witnesses exist above every requested lower bound on the block length. From it the development proves `erdos678_good_lengths_infinite`, asserting that the set

\[
\{k:\exists n,m,\;3\le n,\;3\le m,\;3\le k,\;n+k\le m,\;M(m,k+1)<M(n,k)\}
\]

is infinite.

A finite positive witness is retained as an executable regression:

\[
M(36,8)>M(47,9).
\]

The development also retains a historically tempting but false candidate as a negative regression:

\[
\neg\bigl(M(495,8)>M(504,9)\bigr).
\]

These examples are semantic guardrails. The positive witness demonstrates executable agreement with the intended finite behavior; the negative witness prevents recurrence of a previously rejected generalization. Neither is used as the mechanism for proving infinitude.

### 2.2 Cambie's stronger theorem and proof architecture

Cambie's proof establishes more than the benchmark inequality. The formal reconstruction first proves an eventual statement parameterized by an arbitrary positive multiplicative factor `C`: for sufficiently large `k`, one can construct starts `x<y`, with sufficient separation, such that the LCM attached to the later interval is smaller by the requested factor. The benchmark is then obtained by taking `C=1` and translating interval starts to the conventional variables.

At a high level, the reconstructed dependency path is

```text
pinned PNT+ prime-between consequence
        ↓
relative-prime provider
        ↓
five disjoint prime strips
        ↓
Claim 4 finite density / CRT engine
        ↓
constructed x,y residue interfaces and placement
        ↓
Claim 5 prime-adic valuation identity
        ↓
quantitative product/LCM estimate
        ↓
strong Cambie theorem for arbitrary positive C
        ↓
large-start-preserving endpoint
        ↓
n = x - 1, m = y - 1
        ↓
unbounded witnesses
        ↓
infinitely many good k
```

Two parts deserve emphasis because they determine the formal architecture.

**Claim 4 is a producer.** It is the combinatorial/CRT construction layer. It selects compatible residue data modulo controlled primes and proves existence of representatives in prescribed windows. Formalization exposes obligations that can remain implicit on paper: integer exclusion budgets, unit/nonzero conditions for CRT coordinate multipliers, the distinction between normalized residues and actual affine representatives, and preservation of positivity, ordering, separation, and start-size information through interfaces.

**Claim 5 is a consumer.** It is the arithmetic identity layer. It compares p-adic valuation contributions across prime ranges, using the residue information constructed earlier to establish the required equality. Once this exact identity is available, product/LCM cancellation and quantitative interval estimates turn it into a strict LCM-ratio inequality.

This producer/consumer split is not presented as universally optimal Lean architecture. It is the structure that made the obligations of this proof explicit and gives a meaningful unit for later mutation and repair-locality analysis.

### 2.3 Attribution and prior formal artifact

Three kinds of credit are deliberately separated.

- **Mathematical authorship:** Stijn Cambie, for the 2024 solution used here [1].
- **Prior public formalization:** Aristotle and Boris Alexeev, as recorded in the pinned `plby/lean-proofs` source used as our comparator.
- **Present project artifact:** a separately structured Lean reimplementation of Cambie's mathematics in this repository, later compared against the pinned public artifact; no genealogical-independence claim is made beyond the recorded reconstruction process.

The current Formal Conjectures Erdős #678 file also records the prior Alexeev/Aristotle formalization and points to the public proof. Thus neither mathematical novelty nor first-formalization priority is part of the present contribution.

---

## 3. Formalization architecture

### 3.1 Canonical interval API

The most consequential low-level design decision is to make interval start and length explicit interfaces. For an LCM problem, this may look like notation, but it determines the proposition. In particular,

\[
M(t,k+1)=\operatorname{lcm}\{t+1,\ldots,t+k+1\},
\]

not the left-shifted block \(\{t,\ldots,t+k\}\).

An earlier failed path in the project exposed exactly this kind of off-by-one error. The final formalization therefore does not rely on informal visual similarity between interval expressions. Algebraic transformations are accepted only after the relevant endpoints and lengths are made explicit, and the public statement bridge is itself machine checked.

This discipline affects theorem interfaces throughout the reconstruction. When a lemma produces a representative inside a window, downstream consumers need the precise endpoints. When a strong theorem uses interval starts `x,y`, the final benchmark translation needs enough information to justify `n=x-1` and `m=y-1` in the natural-number domain. The large-start condition is therefore preserved as proof data rather than recovered at the end.

### 3.2 Producer/consumer proof contracts

The formalization is organized around explicit contracts between major layers.

The **prime-window provider** supplies primes in the relative ranges required by Cambie's construction. The **Claim 4 layers** transform those primes into CRT/density data and then into actual representatives with the required placement properties. Intermediate pair/triple interfaces expose only the residue, divisibility, ordering, and separation facts needed downstream. The **Claim 5 layers** consume these facts to compare p-adic valuations. The **product-estimate layer** consumes the exact valuation identity and quantitative bounds. Finally, the **strong theorem layer** packages the result in a parameterized form from which the benchmark endpoint follows.

This explicit interface discipline has two verification benefits. First, it localizes mathematical obligations: the consumer does not need to know how the producer found its witnesses. Second, it creates independently testable boundaries. The S2c repair-locality experiment later mutates frozen API references at such boundaries, while S2d tests whether semantic/index perturbations survive independent checks.

### 3.3 Analytic dependency closure

The proof requires prime-distribution input. The final project does not receive credit for an opaque custom assumption standing in for that analytic fact. Instead it pins the `PrimeNumberTheoremAnd` (PNT+) repository at

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`

and closes the prime-window requirement through the reachable dependency graph. The environment also pins Lean 4.33.0 and Mathlib at

`db584cd6d46c92f209a44c0f1c829460d327499d`.

This does not mean the entire mathematical ecosystem has been minimized or independently re-proved inside the project. It means the analytic dependency used by the canonical theorem is explicit, versioned, reachable, and included in the reproducible build.

### 3.4 Strong theorem before benchmark corollary

Rather than targeting only the Boolean shape of the original benchmark, the formalization follows the stronger mathematical structure. It first proves a `C`-parameterized eventual ratio theorem and only later specializes to `C=1`.

This has two advantages. Mathematically, it stays close to the strength of Cambie's result. Formally, it separates the difficult construction and inequality from the final index normalization. The public-facing theorem `cambie_lcm_ratio_eventually_with_large_start_real` exposes a normalized real-factor version used in differential verification, while the internal strong theorem retains the information needed for the final natural-number translation.

### 3.5 Infinitude through unbounded witnesses

The final set-theoretic infinitude statement is derived from an unbounded-witness theorem rather than from a single numerical example. This is a useful proof-engineering choice because it makes the quantifier structure visible. The theorem directly says that no proposed upper bound on good `k` can be final. Standard unboundedness-to-infinitude reasoning then yields `erdos678_good_lengths_infinite`.

The same structure provides a clean bridge to the eventual-nonempty formulation used by public benchmark repositories: sufficiently large `k` admit a valid pair, hence valid lengths are unbounded and infinite.

---

## 4. Statement fidelity and semantic bridges

### 4.1 Internal versus public interval semantics

The public comparator and Formal Conjectures use `Finset.Ioc`-style interval expressions. The project uses a length-oriented internal LCM API because it matches the way many intermediate lemmas are parameterized. A formal bridge proves that these representations denote the same set of consecutive integers at the relevant indices.

At the core is the identity

\[
M(n,k)
=
\operatorname{lcm}_{i\in (n,n+k]} i,
\]

represented in Lean by equality between `erdosM n k` and the appropriate `Finset.Ioc` LCM. The bridge is tested in `ExternalStatementBridgeTests.lean` rather than asserted only in manuscript prose.

This matters because an off-by-one shift can preserve types and much of the surrounding algebra while changing the theorem. Statement fidelity is therefore treated as an independent verification obligation, not a cosmetic translation performed after proof completion.

### 4.2 Formal-Conjectures-style endpoint

The public-facing theorem `erdos678_formalConjectures_eventual_nonempty` states the benchmark in an eventual-nonemptiness form compatible with the contemporary public convention:

for all sufficiently large `k`, the set of pairs `(m,n)` satisfying

\[
n+k\le m
\quad\text{and}\quad
\operatorname{lcm}(m,m+k+1]
<
\operatorname{lcm}(n,n+k]
\]

is nonempty.

The development separately proves unbounded valid lengths and infinite good lengths, preventing ambiguity between eventual existence for varying `k` and an incorrect fixed-`k` infinitude reading.

### 4.3 Real-factor strong theorem bridge

S1 needs a comparison point strong enough to reflect the mathematical content of Cambie's result, not merely one finite regression. The bridge theorem `cambie_lcm_ratio_eventually_with_large_start_real` normalizes the strong eventual ratio statement to a public-facing real-factor form while retaining the large-start condition required by the final indexing translation.

This theorem is useful as an interface between internal proof architecture and external comparison: the internal implementation can remain modular while S1 reasons about a stable theorem-level endpoint.

### 4.4 Axiom audit

For selected final/public endpoints, the recorded Lean axiom audit reports the standard footprint

`[propext, Classical.choice, Quot.sound]`.

The same selected footprint was recorded for both artifacts in S1. This is not a claim that the implementations are definitionally identical or that every intermediate declaration has the same dependencies. It is a bounded theorem-level cross-check that neither selected endpoint secretly depends on an additional project-specific axiom in the controlled comparison.

---

## 5. Differential verification (S1)

### 5.1 Comparator and common environment

S1 compares the internal reconstruction with the public artifact

`plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`

file

`src/latest/ErdosProblems/Erdos678.lean`.

The comparator source records Stijn Cambie as the informal author and Aristotle/Boris Alexeev as formal authors. For the credited experiment it is treated as an immutable external artifact: the comparison does not edit it to make the experiment pass.

The common setup uses Lean 4.33.0 and the pinned Mathlib revision, while the internal reconstruction additionally reaches its pinned PNT+ dependency through the canonical graph. S1 records the exact comparator commit/blob and source digest so that “the comparator” is not a moving target.

The credited S1 experiment is GitHub Actions run `32028006457` (job `95381414710`). Its result is recorded as common-environment differential-verification success. Closure was subsequently integrated and post-merge verified.

### 5.2 What differential verification establishes

Two evidence layers must be kept distinct. Repository provenance establishes that the project formalization is separately housed and structured and that the comparator is fetched as an immutable external source rather than vendored into the project. S1 itself supports three bounded experimental conclusions. First, both artifacts compile under the controlled setup used by the experiment. Second, the project's explicit statement bridges connect its internal endpoint to the public interval convention used for comparison. Third, selected endpoint axiom footprints agree at `[propext, Classical.choice, Quot.sound]`.

Together, the provenance record and S1 observations strengthen confidence that two different Lean developments implement compatible formal content for the same known mathematics. They do **not** establish an independent mathematical discovery, a first formalization, or proof genealogy in the historical sense.

### 5.3 Verification-credit correction

During the broader #678 work, a green run initially supported a weaker provenance statement than surrounding metadata suggested. The computation itself was successful, but the evidentiary question “which exact source should receive credit?” was not yet answered to the project's later standard. The record was corrected rather than silently treating the green badge as sufficient proof of provenance.

This episode motivates a distinction that recurs throughout the paper:

> **Proof verification and verification-credit provenance are separate objects that both require audit.**

For a formal theorem, kernel acceptance answers a logical question. For a scientific artifact, one also needs an exact association among source commit, dependency graph, workflow event, and credited result. Sections 7 and 8 describe how this distinction became an explicit repository mechanism.

---

## 6. Scientific evaluation program (S2)

The S2 experiments were designed after the mathematical proof was closed. Each stage freezes its question, comparator/environment, measurement or mutation set, credit rules, and interpretation limits before the credited observation. This matters because exploratory measurements can easily become post-hoc narratives if the success criterion changes after results are seen.

The experiments are intentionally heterogeneous. They do not attempt to collapse architecture into a single score. Instead they ask separate questions about structural dependency surface, build behavior, repair locality, semantic/index mutation detection, and exact forward-version behavior.

### 6.1 S2a — dependency surface

S2a measures controlled structural properties of the two artifacts: modules, files, lines, and dependency-related surfaces under specified boundaries. The experiment showed that these counts are highly sensitive to what is classified as project-owned versus dependency-owned and to how functionality is packaged.

This is a scientifically useful negative result. A modular reconstruction may expose intermediate interfaces in many files while a more monolithic artifact may contain comparable reasoning in fewer files. Conversely, imported support may move apparent complexity outside the measured project boundary. Raw line/module counts therefore cannot be read directly as proof complexity or architecture quality.

The credited S2a experiment is run `32047324807`. Its publication-level conclusion is not a winner but a measurement warning:

> **dependency-surface metrics require ownership and packaging context before interpretation.**

### 6.2 S2b — controlled build behavior

S2b evaluates cold-build behavior under a pinned common environment using prospectively controlled paired replicates. A pilot run in which all six jobs completed successfully was excluded because required runner-version provenance was absent from the predeclared result metadata. The exclusion was not performance-selected: the entire pilot was removed for provenance reasons before the credited experiment.

The timed unit is artifact-owned recompilation, not dependency installation or an isolated architecture microbenchmark. External/prerequisite dependencies are prepared and both targets are prebuilt outside the timed region. For a cold measurement, the workflow removes only the relevant artifact-owned Lake outputs, preserves prepared dependency outputs, and rebuilds the internal target `Formalization.Erdos678.Erdos678Final` or the byte-validated comparator source exposed as `Formalization.Erdos678Benchmark.Comparator` inside the same pinned project environment. The resulting timings and resource measurements therefore describe the two packaged artifacts' rebuild behavior under this protocol; they do not identify proof architecture as the causal source of any difference.

The credited experiment, run `32053575928`, contains six paired observations with zero retries and zero exclusions. The wall-clock result does not support a stable winner:

- internal cold median: **159.575 s**;
- comparator cold median: **156.280 s**;
- paired internal-minus-comparator difference range: **−10.68 s to +11.73 s**.

The sign change across paired differences is more informative than a small difference between medians: under these replicates, neither artifact consistently finished first.

Resource profiles, however, differed materially:

- internal median total CPU time: **241.155 s**;
- comparator median total CPU time: **486.475 s**;
- internal median maximum RSS: **7,183,766 KiB**;
- comparator median maximum RSS: **7,828,930 KiB**.

Thus the internal reconstruction consumed roughly half the median total CPU time measured for the comparator and somewhat less peak memory in this exact environment, while not providing a stable wall-clock advantage. This is a meaningful bounded contrast and should be reported as such. The protocol does not establish that the architecture is universally faster, cheaper, or more maintainable across machines, caches, Lean releases, dependency versions, or alternative build configurations.

### 6.3 S2c — repair locality

S2c asks a different engineering question: when a frozen API reference is changed, how local is the resulting legal repair? Three prospectively frozen API-reference mutations were applied across both artifacts, producing six observations. Each mutation caused an observable break, and each legal repair returned the artifact to green without modifying third-party dependency source.

The resulting repair-reference blast radius was **mixed and interface-dependent**. Some changes remained local; others propagated differently according to the surrounding proof structure. No uniform winner emerged.

The credited experiment is run `32062501296` (job `95486770197`), with archived artifact `9299556049`. The appropriate conclusion is therefore narrower than “maintainability”:

> **For these three frozen mutations, repair locality depended on the interface and artifact; the experiment did not produce a uniform repair-locality advantage.**

Human debugging time was not prospectively measured, so the study also cannot translate changed references or files into human maintenance cost.

### 6.4 S2d — semantic/index mutation evaluation

S2d targets an especially relevant failure mode for #678: type-correct or near-type-correct one-unit shifts in interval/index semantics. The protocol froze three perturbations before observation and applied them to both artifacts, for six credited observations. Proof repairs were forbidden; the question was whether the mutated artifact would survive its existing checks.

All six credited observations were rejected:

- semantic rejections: **6/6**;
- semantic survivors: **0**;
- proof repairs: **0**;
- third-party dependency-source edits: **0**.

The first rejection location varied by mutation and artifact. In one internal case, a primitive mutation elaborated far enough to be rejected by an independent concrete semantic oracle; other internal changes failed during source elaboration. Comparator rejections occurred at different local, strong-theorem, or canonical-corollary layers. These locations are not a shared ordinal “robustness score”: the artifacts expose different declaration structures.

A prior pilot was computationally successful but excluded because its primary logical classifier was defective. Rather than relabeling the observed data post hoc, the project corrected the apparatus and reran the frozen mutation set. The credited run is `32076614547`, with archived artifact `9303987121` and recorded digest.

The supported conclusion is strong but bounded: **both artifacts rejected all three predeclared semantic/index perturbations in the credited experiment.** It does not establish that either artifact is generally more robust to arbitrary semantic faults.

### 6.5 S2e — exact forward-version robustness candidates

S2e asks what happens under two exact, prospectively frozen forward-version candidates rather than making a vague “upgrade Lean” claim.

- **U1:** Lean `v4.34.0-rc1` with the baseline Mathlib/PNT dependency graph otherwise locked.
- **U2:** Lean `v4.34.0-rc1` plus an exact Mathlib `v4.34.0-rc1` commit, while retaining the available PNT+ state.

The result is dominated by dependency ownership rather than project proof repair.

U1 reaches the dependency-source stage and then encounters Mathlib/transitive dependency-owned failures before project-owned proof incompatibility is established. U2 stops earlier, at package resolution, before project compilation. Neither candidate reaches an eligible project-owned repair surface, and the credited project repair-batch count is therefore zero.

The complete-set credited S2e run is `32170243744`, with archived artifact `9337321640` and recorded digest. The experiment supports exact statements about these two candidates only. It does not show that the project is generally compatible or incompatible with future Lean/Mathlib versions, and zero project repair batches must not be misreported as “zero repairs will be required after upgrade.” The experiment simply did not reach a scientifically eligible project-owned repair phase.

---

## 7. Reproducibility and scientific-credit discipline

### 7.1 Canonical build graph

A theorem file existing in a repository is not sufficient for project verification credit. The final theorem must be reachable from the canonical generated import graph. The reproducibility path therefore runs

```bash
cd formalization
lake exe mk_all --check
lake build Formalization
```

and expects the import check to report `No update necessary` before the full canonical build completes.

For the frozen #678 environment, the key pins are:

- Lean: `leanprover/lean4:v4.33.0`;
- Mathlib: `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

The historical closed evaluation graph built 8,808 jobs. That count is retained as provenance metadata, not as a universal assertion that every future exact reproduction must emit the same job count under all caching/tooling conditions.

### 7.2 Exact-head verification

Before merge, the unit of credit is the exact pull-request head SHA. Testing a nearby ancestor or a synthetic merge tree and then merging a different head creates a provenance gap even when all changes appear innocuous. The repository therefore records and checks the exact head that passes the package validator, canonical import check, and full Lean build.

### 7.3 Merge unchanged and exact-main verification

Pre-merge verification alone does not establish that the resulting default branch has the same verified content. The integration rule is

```text
exact PR head CI
    → merge that head unchanged
    → verify exact resulting main SHA
```

The #678 reproducibility package strengthens this rule with a machine-readable legacy commit status. On a `push` to `main`, after the package validator and canonical Lean verification complete, the workflow publishes

`erdos678/post-merge-verification`

on the exact `github.sha`, with state `success` or `failure` and a target URL pointing to the exact Actions run. The package validator itself checks that this provenance mechanism has not silently drifted.

### 7.4 Exclusion rules and scientific admissibility

Several S1/S2 episodes demonstrate why computational success and scientific credit are not synonyms. Runs were excluded or corrected when predeclared provenance, classifier, aggregation, or instrumentation requirements were defective, even when the computation itself completed.

We therefore separate three questions:

1. **Did the computation finish?**
2. **Is the observation admissible under the frozen protocol?**
3. **What inference is licensed by the admitted observation?**

A green job answers the first question. It does not automatically answer the second or third. This separation is especially important for benchmark-like formalization research, where a mislabeled statement, wrong source revision, incomplete result subset, or dependency-owned failure can otherwise be converted into a stronger scientific claim than the computation supports.

---

## 8. Results summary

Table 1 summarizes the controlled verification/evaluation program. “Frozen” means that the credited stage used a protocol or exact candidate/mutation definition fixed before the credited observation. Run IDs are preserved for audit; stage-specific artifacts and hashes are indexed in the reproducibility package.

| Stage | Question | Frozen before credited observation? | Credited run | Bounded result | Explicitly unsupported generalization |
|---|---|---:|---:|---|---|
| S1 | Can the reconstruction and pinned prior artifact be differentially checked in a controlled common setup? | Yes | `32028006457` | Both artifacts compile in the controlled setup; statement bridges and selected endpoint axiom footprints are compatible. | New mathematics, first formalization, proof genealogy. |
| S2a | What does a structural dependency-surface comparison show? | Yes | `32047324807` | Raw module/file/line/dependency counts are ownership- and packaging-boundary sensitive. | Proof-complexity or architecture-quality ranking from raw counts. |
| S2b | How do paired artifact-owned cold rebuilds behave in the pinned environment? | Yes | `32053575928` | No stable wall-clock winner; internal median total CPU `241.155 s` vs comparator `486.475 s`; internal median max RSS `7,183,766 KiB` vs comparator `7,828,930 KiB`. | Universal speed or maintainability superiority. |
| S2c | How local are repairs for three frozen API-reference mutations? | Yes | `32062501296` | Six observable breaks; six legal green repairs; mixed/interface-dependent repair locality; no uniform winner. | General maintainability ranking or human repair-cost inference. |
| S2d | Do three frozen semantic/index perturbations survive existing checks? | Yes | `32076614547` | Six rejections, zero survivors, zero proof repairs; first rejection layer varies by mutation/artifact. | General semantic-robustness ranking. |
| S2e | What happens for two exact forward-version candidates? | Yes | `32170243744` | U1 stops in dependency-owned source after D1; U2 stops at package resolution after D0; neither reaches eligible project-owned repair. | General upgrade compatibility/incompatibility or zero future repair cost. |

The table also exposes an important pattern: “better” is not a single scalar property of these proof artifacts. S2b contains a favorable CPU/memory contrast for the internal artifact but no stable wall-time advantage; S2c is mixed; S2d is symmetric at the coarse 6/6 rejection level but structurally different in where faults are detected; S2e is blocked by ecosystem boundaries before project-owned repair can be measured. A scientifically faithful account therefore reports a profile, not a leaderboard.

---

## 9. Related work

### 9.1 Formal verification of substantial mathematics

Formal reconstruction of known mathematics has a long history and includes projects far larger than the present case. Hales et al.'s Flyspeck project produced a formal proof of the Kepler conjecture using HOL Light and Isabelle [2]. It demonstrates the role of independent machine checking in closing a theorem whose accepted proof combined conceptual mathematics and substantial computation.

Within Lean, Buzzard, Commelin, and Massot's formalization of perfectoid spaces [3] showed that a proof assistant can represent sophisticated contemporary mathematical objects and used the experience to discuss formalization design and interaction with the mathematical library. The Liquid Tensor Experiment [4] similarly connected advanced current mathematics to a large collaborative Lean development and used a blueprint/dependency structure to align informal and formal proof components.

The present work is much narrower mathematically. Its contribution is not scale but the explicit combination of reconstruction, semantic bridging, differential executable comparison, bounded experiments, and provenance controls around one completed theorem.

### 9.2 Formal statements and fidelity

Formal Conjectures [5] treats research-level mathematical statements as a large, evolving Lean benchmark and explicitly makes correctness/fidelity auditing part of benchmark maintenance. Its current Erdős #678 file is directly relevant to the present case: it states the varying-`k` reading, records finite examples, credits Cambie's solution, and points to prior Lean formalization.

Our statement-fidelity work is artifact-specific rather than benchmark-wide. We prove explicit equivalences between internal interval semantics and the public `Finset.Ioc` form and preserve the off-by-one-sensitive translation from the stronger theorem to the benchmark variables. This complements, rather than replaces, community-level statement curation.

### 9.3 Reconstruction, multiple routes, and cross-checking

Proof reconstruction appears in settings other than published mathematical proofs. Bodingbauer et al. reconstruct Vampire proofs as trusted Lean proofs [9], illustrating how proof objects from one reasoning system can be replayed inside another trusted environment. The source and automation model differ from our setting, but both emphasize that independent checking can increase confidence beyond an external success report.

Freer formalizes three routes to de Finetti's theorem in Lean 4 and uses their common interface as a cross-check during development [8]. That work provides a useful example of multiple proof routes converging on a shared endpoint. Our differential verification instead compares two separately housed formal artifacts implementing the same published mathematics and adds controlled environment/provenance constraints.

### 9.4 End-to-end verification and proof-engineering infrastructure

Gallicchio et al. give an end-to-end verification of Keller's conjecture in Lean [7], including the verified computational chain. This is relevant to our insistence that verification credit belongs to an exact reachable chain rather than to an isolated success signal, although our exact-head/exact-main mechanism addresses repository provenance rather than SAT proof checking.

LeanArchitect [6] automates blueprint extraction and synchronization between Lean declarations and informal exposition/dependency data. Its emphasis on synchronized interfaces and dependency structure is closely related to the proof-engineering concerns that motivated our producer/consumer architecture. Our study does not propose comparable tooling; it evaluates one proof artifact and its interfaces.

### 9.5 Positioning without a priority claim

The literature contains clear precedents for each broad ingredient: substantial mathematical formalization, reconstruction, multiple-route cross-checking, statement benchmarks, blueprints, end-to-end verification, and proof-assistant performance/engineering analysis. We therefore do not claim that any individual ingredient is new.

The contribution studied here is their specific combination in a single auditable case: a separately structured Lean reimplementation of a known proof, an explicit semantic bridge to public statement conventions, controlled differential verification against a pinned prior artifact, prospectively frozen bounded proof-engineering experiments, and exact verification-credit provenance. Our literature audit did not identify an exact precedent containing this complete combination, but absence from a finite search is not evidence of first-of-kind priority; the manuscript intentionally makes no such claim.

---

## 10. Threats to validity

### 10.1 Single-case scope

The study concerns one theorem, one internal reconstruction, and one pinned prior comparator. Erdős #678 combines arithmetic, CRT, valuations, and analytic prime input, but it is not representative of all Lean formalizations. No inference about proof assistants or proof architectures in general follows from a single case.

### 10.2 External-proof reconstruction mode

The successful route reconstructs Cambie's published proof after independent exploration had failed. This means the study evaluates formal reconstruction of known mathematics, not independent theorem discovery. Claims about creativity, discovery, or independent mathematical proof would require different evidence.

### 10.3 Structural non-equivalence of artifacts

The internal and comparator artifacts differ in modularity, file boundaries, packaging, and dependency organization. These differences make direct counts easy to misinterpret. S2a explicitly demonstrates this boundary sensitivity. Even when S2b measures both under a common environment, the resource profile reflects the complete artifacts as packaged, not an isolated causal effect of a single architecture decision.

### 10.4 Limited replicate and mutation sets

S2b uses six credited paired replicates. This is sufficient to reject a simplistic stable wall-clock winner in the observed sample and to report the measured resource medians, but it is not a broad performance benchmark.

S2c uses three frozen API-reference mutations and S2d uses three frozen semantic/index perturbations. The experiments were prospectively controlled, but their finite scope does not estimate behavior under the universe of possible edits or semantic faults.

### 10.5 Forward-version candidate limits

S2e freezes only two exact RC-based candidates. Both encounter dependency/package boundaries before an eligible project-owned repair phase. The experiment therefore contains little direct evidence about future project repair effort after the surrounding ecosystem gains support. General compatibility conclusions would be an extrapolation beyond the observed data.

### 10.6 CI runner and ecosystem effects

Build times, CPU accounting, memory, package resolution, caches, runner images, and upstream repositories are environmental variables. The credited experiments record their relevant provenance, but rerunning on different infrastructure may produce different resource measurements. The results should be read as reproducible observations of a pinned setup, not hardware-independent constants.

### 10.7 Repair metrics are not human effort

S2c measures reference/blast-radius properties under defined legal repairs. It does not prospectively measure human debugging time, cognitive load, or maintainability over months of development. Inferring human effort from changed references would exceed the experiment.

### 10.8 Researcher and apparatus bias

The same project designed the formalization and the evaluation protocols. Prospective freezing, immutable comparator pins, archived artifacts, explicit exclusions, and exact-head/exact-main checks reduce opportunities for post-hoc selection but do not substitute for independent external replication. The internal P4 adversarial review reduces manuscript-level claim and provenance risk but does not substitute for external replication or peer review; a publication-grade release should facilitate third-party reproduction.

---

## 11. Discussion

### 11.1 Statement fidelity is an independent verification obligation

The #678 experience shows why “the file compiles” is not the end of formal verification. A one-unit interval shift can leave much of a proof-looking expression plausible while changing the mathematical claim. The explicit bridge between `erdosM` and `Finset.Ioc`, the retained positive/negative semantic regressions, and the public eventual-nonempty endpoint together form a statement-fidelity layer distinct from the proof kernel's acceptance of internal lemmas.

This observation does not imply that every formalization needs a second public representation. It does suggest that when multiple conventions coexist—or when an external benchmark is involved—semantic bridges should be theorem-level objects where practical rather than prose assurances.

### 11.2 Build-graph reachability is part of proof credit

A theorem can be correct in an isolated file yet absent from the canonical project build. Conversely, CI can be green on a commit adjacent to, but not identical with, the artifact eventually merged. Treating canonical import reachability and exact commit identity as part of verification credit closes these gaps.

The exact-main commit status makes this principle machine readable: after integration, the repository records whether the exact default-branch SHA passed the package validator, canonical import check, and full build. This is a software-engineering mechanism, but it has a scientific role because it binds published claims to an auditable artifact.

### 11.3 Computational success and scientific admissibility differ

The excluded S2b and S2d pilots illustrate a broader issue in empirical formalization work. A run can be computationally successful yet fail the predeclared evidentiary contract. Missing runner provenance or a defective logical classifier affects what the result can support, even if the program exits successfully.

The response in this project was to preserve exclusions and rerun corrected apparatus rather than reinterpret the data post hoc. This makes null/mixed/excluded outcomes part of the scientific record rather than invisible failed attempts.

### 11.4 Bounded advantages should be stated precisely

Conservatism should not erase real differences. In S2b the internal artifact's median total CPU time is `241.155 s`, compared with `486.475 s` for the comparator, and its median peak RSS is lower in the pinned common environment. Those are substantial observed differences. At the same time, wall-clock pair differences change sign and the median wall times are close, so the same experiment does not support a stable wall-time winner.

The scientifically informative statement is therefore a **resource-profile contrast**, not “our architecture is faster.” This distinction preserves both the positive evidence and its limits.

### 11.5 Mixed results are informative about measurement design

S2a, S2c, and S2e are useful partly because they resist simple rankings. Dependency-surface counts depend on ownership boundaries; repair locality depends on the interface being changed; forward-version behavior can stop in dependency infrastructure before project code becomes measurable.

These results suggest that future proof-engineering comparisons should define ownership, failure classification, and eligible repair surfaces before observing outcomes. Otherwise a metric may end up measuring packaging or ecosystem state rather than the intended artifact property.

### 11.6 Formal verification can make epistemic contributions without new mathematics

The underlying theorem here was already solved, and a public Lean artifact already existed. The present work is still scientifically testable because it asks different questions: Can the proof be reconstructed under a separately structured implementation? Does the internal statement provably match the public convention? Do two pinned artifacts survive a controlled differential check? What engineering behavior is observed under frozen experiments? Can verification provenance itself be made reproducible?

These are epistemic and engineering questions about formal mathematical knowledge. Their value does not depend on relabeling known mathematics as new.

---

## 12. Conclusion

We presented a separately structured Lean reimplementation of Stijn Cambie's 2024 solution to Erdős Problem #678 and connected its internal interval semantics to public statement conventions through explicit machine-checked bridges. The formalization proves witnesses for arbitrarily large block length and hence infinitely many good lengths, while retaining a stronger parameterized LCM-ratio theorem before the benchmark corollary.

A controlled differential verification against a pinned prior Aristotle/Boris Alexeev artifact provided an executable cross-check of the two formalizations under a common setup. The subsequent S2 program measured several proof-engineering dimensions without collapsing them into a global ranking. Dependency-surface counts were boundary-sensitive; paired builds had no stable wall-clock winner while exhibiting a favorable CPU/memory profile for the internal artifact in the pinned environment; repair locality was mixed; all six frozen semantic/index observations were rejected; and two exact forward-version candidates stopped at dependency/package boundaries before project-owned repair could be measured.

The reproducibility package binds these claims to exact theorem endpoints, dependency revisions, archived experimental evidence, canonical build commands, and exact-head/exact-main verification provenance. The result is not a new solution or first formalization of Erdős #678. It is a reproducible case study in how separately structured reconstruction, semantic fidelity, differential verification, bounded empirical evaluation, and provenance controls can strengthen the evidence surrounding a machine-checked mathematical artifact.

---

## Data and artifact availability

The project repository is public under the Apache-2.0 license. The curated reproduction entry point is

`problems/678/reproducible/`.

It records the exact Lean/Mathlib/PNT+ environment, theorem endpoints, regression semantics, Claim–Evidence Matrix, S1/S2 evidence index, and canonical reproduction commands. The intended one-command reproduction path is

```bash
bash problems/678/reproducible/scripts/reproduce.sh
```

which validates the package and then runs the canonical import-graph and full Lean build.

Stage-specific S1/S2 protocols, results, exclusions, artifact identifiers, and hashes remain in `problems/678/` and are indexed from the reproducibility package. An immutable external archival snapshot/DOI is still required or strongly preferred before the final submission candidate, depending on venue policy.

## Draft AI-use disclosure placeholder

This manuscript was prepared with AI assistance during repository analysis, evidence synthesis, literature/venue auditing, and drafting. AI systems are not authors. Final authors must verify every mathematical, experimental, bibliographic, and policy claim and retain responsibility for the submitted text. Current Springer journal guidance does not treat LLMs as authors and requires generative-AI use beyond AI-assisted copy editing to be transparently documented. Because publisher/venue wording is mutable, the exact disclosure placement and wording will be frozen during P6 against the selected venue's then-current policy.

## References — Draft 2 / P4-audited

[1] Stijn Cambie. **Resolution of an Erdős' problem on least common multiples.** arXiv:2410.09138, 2024. DOI: https://doi.org/10.48550/arXiv.2410.09138

[2] Thomas Hales, Mark Adams, Gertrud Bauer, Tat Dat Dang, John Harrison, Le Truong Hoang, Cezary Kaliszyk, Victor Magron, Sean McLaughlin, Tat Thang Nguyen, Quang Truong Nguyen, Tobias Nipkow, Steven Obua, Joseph Pleso, Jason Rute, Alexey Solovyev, Thi Hoai An Ta, Nam Trung Tran, Thi Diep Trieu, Josef Urban, Ky Vu, and Roland Zumkeller. **A Formal Proof of the Kepler Conjecture.** *Forum of Mathematics, Pi* 5:e2, 2017. DOI: https://doi.org/10.1017/fmp.2017.1

[3] Kevin Buzzard, Johan Commelin, and Patrick Massot. **Formalising Perfectoid Spaces.** In *Proceedings of the 9th ACM SIGPLAN International Conference on Certified Programs and Proofs (CPP 2020)*, pp. 299–312, 2020. DOI: https://doi.org/10.1145/3372885.3373830

[4] Peter Scholze. **Liquid Tensor Experiment.** *Experimental Mathematics* 31(2):349–354, 2022. DOI: https://doi.org/10.1080/10586458.2021.1926016

[5] Moritz Firsching, Paul Lezeau, Salvatore Mercuri, Miklós Z. Horváth, Yaël Dillies, Calle Sönne, Eric Wieser, Fred Zhang, Thomas Hubert, Blaise Agüera y Arcas, and Pushmeet Kohli. **Formal Conjectures: An Open and Evolving Benchmark for Verified Discovery in Mathematics.** arXiv:2605.13171, 2026. https://arxiv.org/abs/2605.13171

[6] Thomas Zhu, Pietro Monticone, Sean Welleck, and Jeremy Avigad. **LeanArchitect: Automating Blueprint Generation for Humans and AI.** In *17th International Conference on Interactive Theorem Proving (ITP 2026)*, LIPIcs 382, 25:1–25:16, 2026. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.25; arXiv:2601.22554.

[7] James Gallicchio, Cayden Codel, Jeremy Avigad, and Marijn J. H. Heule. **An End-To-End Verification of Keller's Conjecture.** In *17th International Conference on Interactive Theorem Proving (ITP 2026)*, LIPIcs 382, 26:1–26:20, 2026. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.26

[8] Cameron Freer. **Three Roads to de Finetti's Theorem in Lean 4.** In *17th International Conference on Interactive Theorem Proving (ITP 2026)*, LIPIcs 382, 34:1–34:9, 2026. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.34

[9] Jonas Bodingbauer, Márton Hajdu, Laura Kovács, Axel Polaczek, and Michael Rawson. **Lean on Vampire Proofs.** In *17th International Conference on Interactive Theorem Proving (ITP 2026)*, LIPIcs 382, 36:1–36:9, 2026. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.36

[10] Aristotle and Boris Alexeev. **Lean formalization of Cambie's solution to Erdős Problem #678.** Pinned comparison artifact: `plby/lean-proofs`, commit `6f906fef432892db5c910c48ad1a3728dd42cdac`, file `src/latest/ErdosProblems/Erdos678.lean`.

[11] Formal Conjectures contributors. **Erdős Problem 678.** `google-deepmind/formal-conjectures`, commit `9f5ee773841921f460b4a26a3552f5eca4accaa0`, file `FormalConjectures/ErdosProblems/678.lean`, blob `b6612bf9419ab37830cad78fa8e46280236182ac` (audited 2026-08-20).

---

## Internal drafting control — remove or convert before final submission

The manuscript's central publication claims are restricted to the Paper 1 allowlist in `../reproducible/papers/PAPER_1_CLAIMS.json`. The machine-readable evidence authority is `../reproducible/CLAIM_EVIDENCE_MATRIX.json`; numerical/run provenance is governed by `../SCIENTIFIC_EVIDENCE_LEDGER.yaml` and stage-specific frozen result files.

Claim-to-section map:

| Claim ID | Main manuscript location |
|---|---|
| `C-MATH-001` | 1.1, 2.2–2.3, 12 |
| `C-FORMAL-001` | 1.2–1.3, 2.3, 12 |
| `C-FORMAL-002` | 2.1, 3.5, 12 |
| `C-FORMAL-003` | 4.1–4.2 |
| `C-VERIFY-001` | 7.1–7.3 |
| `C-S1-001` | 5, 8 |
| `C-S2A-001` | 6.1, 8 |
| `C-S2B-001` | 6.2, 8, 11.4 |
| `C-S2C-001` | 6.3, 8 |
| `C-S2D-001` | 6.4, 8 |
| `C-S2E-001` | 6.5, 8 |

Publication-disallowed controls:

- `C-UNSUPPORTED-NEW-SOLUTION` — absent as a positive claim;
- `C-UNSUPPORTED-FIRST-FORMALIZATION` — explicitly negated;
- `C-UNSUPPORTED-GENERAL-SUPERIORITY` — explicitly negated and guarded by the bounded-advantages interpretation rule.

### Draft 2 submission-readiness checklist

- [x] literature/novelty audit completed for Paper 1;
- [x] current venue shortlist established;
- [x] exact mathematical statement and indexing conventions written;
- [x] claim-to-evidence authority exists and is mapped to manuscript sections;
- [x] S1/S2 summary table written;
- [x] key S2b numerical values checked against the scientific evidence ledger;
- [x] abstract drafted after results/limitations stabilized and kept within current JAR length guidance;
- [x] primary-source draft bibliography established;
- [x] run P4 adversarial scientific review;
- [x] independently recheck every numerical value and Draft 1 citation during P4;
- [x] freeze exact Formal Conjectures statement-context revision used in Draft 2;
- [ ] decide JAR versus accelerated CPP 2027 strategy after compression risk review;
- [ ] repeat final bibliography/URL/policy audit at P6 and convert to venue style;
- [ ] create immutable archival release/DOI or equivalent long-term identifier;
- [ ] finalize author/contribution/competing-interest metadata;
- [ ] finalize AI-use disclosure against selected venue policy immediately before submission;
- [ ] final claim-boundary audit;
- [ ] produce venue-specific Submission Candidate v1.
