# Lessons Learned — Experimental Cycle: Erdős Problems #1125, #275, and #303

This document converts benchmark experiments into reusable project knowledge. It is not a mathematical proof file; it records methodological lessons for future Erdős solving attempts.

## L-001 — Problem-level status must be verified independently

A solved theorem, solved variant, or formalized sub-result inside a problem file does not imply that the main Erdős problem is solved. The source of truth for the problem-level status must be checked explicitly.

Consequence: the #18 episode exposed this failure mode. Future triage must record separately: problem status, variant status, known sub-results, formalized statement, and formalized proof.

## L-002 — A canonical statement must be locked before mathematical work

For blind experiments, the exact problem statement supplied by the user can be designated canonical. Any paraphrase is secondary and must not silently replace it.

Consequence: #1125 and #303 were kept in the exact user-supplied form.

## L-003 — Blind-mode contamination is a first-class failure state

If verification or search exposes solution information before the blind attempt is frozen, the challenge is contaminated and must not be presented as independent.

Consequence: #447 was discarded as a blind benchmark after solution information appeared during identification.

## L-004 — Short statements do not imply easy problems

#1125 has a one-line statement, yet its solution uses a deep global mechanism involving finite quantitative estimates, a covering construction on a dense arithmetic set, interpolation, and irrational approximation via Pell sequences. #303 is also one line but hides a compactness/partition-regularity argument.

Consequence: future benchmark selection must consider proof architecture and hidden machinery, not statement length alone.

## L-005 — Local midpoint amplification is insufficient without regularity

For #1125, a strict descent forces increasingly large values along dyadic points approaching an endpoint. Without continuity, measurability, local boundedness, or another regularity hypothesis, this is not itself a contradiction.

Consequence: a successful proof must exploit the universal quantification over all positive real step sizes, rather than assuming regularity that is not given.

## L-006 — Fixed-step reduction loses essential information

Restricting the inequality to one arithmetic progression yields a recurrence such as `2 a_n ≤ a_(n+1) + a_(n+2)`. That recurrence alone does not force monotonicity. The real problem uses interactions among many step sizes and arithmetic progressions.

## L-007 — Quantitative finite-interval estimates can replace unavailable regularity

The reference reconstruction for #1125 derives bounds of the form `f(0) ≤ f(n) + O(K/n)` for finite discrete restrictions bounded by `K`. This creates an error term that can later be driven to zero by taking `n → ∞`.

Methodological lesson: when a proof lacks continuity or measurability, search for quantitative inequalities whose error tends to zero under refinement.

## L-008 — Dense arithmetic subsets can bridge discrete and real arguments

The reference mechanism works on `I(α) = {n α + k : n,k ∈ Z}` and proves monotonicity there before transporting the conclusion back to arbitrary real points.

## L-009 — Irrational approximation can provide refinement scales

For #1125, `α = √2` is used with Pell approximants having controlled growth, small approximation error, and alternating signs.

## L-010 — Candidate proofs need algebraic audit before freeze

The attempted increment-monotonicity proof for #1125 contained an invalid algebraic rearrangement. A deliberate audit exposed it.

Consequence: no proof is frozen until every transformation has been checked independently. A revoked freeze must remain visible in history.

## L-011 — GitHub is operational memory, not mathematical authority

`PROJECT_STATE.md`, research logs, decision records, and lesson records allow the process to resume consistently. They do not turn an unchecked mathematical claim into truth.

## L-012 — Failed paths are valuable research data

Rejected approaches must be preserved with the reason for rejection. Deleting them causes repeated work and hides why a natural route was abandoned.

## L-013 — Separate historical attribution from modern formal reconstruction

A modern Lean file may formalize a historical theorem while having different authors and a different implementation structure. Future comparison records should distinguish historical proof, modern reconstruction, and machine-checked formalization.

## L-014 — The blind phase and reference-comparison phase are immutable boundaries

Once the reference solution is opened, the experiment can no longer be described as a blind independent solve. The transition must be recorded explicitly, and previous failed attempts must not be rewritten with hindsight.

## L-015 — Benchmark selection should prefer solved problems with shallow proof depth

#1125 was too deep for first calibration. #275 was much better: short statement, problem-level solved status, and a concise algebraic invariant that was discoverable with standard tools. #303 shows that even a short statement can hide a theorem-level Ramsey transformation and therefore should be tagged as an intermediate benchmark rather than an elementary one.

## L-016 — Match conspicuous numerical thresholds to structural dimensions

#275 demonstrates a strong benchmark heuristic: when a statement contains a number such as `2^r`, immediately ask whether the same quantity appears naturally as a dimension/state count/number of terms in an algebraic expansion. This led from the covering count to a `2^r`-term exponential polynomial.

## L-017 — Encode combinatorial predicates as algebraic vanishing conditions when possible

In #275, roots of unity turned membership in a congruence class into the vanishing of one factor. The whole covering system became a zero-set problem for a finite-dimensional exponential polynomial.

## L-018 — Consecutive vanishing can be stronger than density information

Counting or density arguments did not solve #275. The decisive information was `2^r` consecutive zeros, which interacts rigidly with a finite-dimensional exponential family via Vandermonde/linear independence.

## L-019 — Independent rederivation is a distinct classification from novelty

The #275 blind proof and the reference proof share the same root-of-unity / finite-dimensional mechanism but package it differently. The correct classification is `independent rederivation / equivalent core mechanism`, not historical novelty.

## L-020 — Freeze-before-reference makes similarity evidence meaningful

Because #275 was frozen before reference access, the later match with the reference mechanism is evidence of genuine blind rediscovery rather than information leakage.

## L-021 — Representation-level audits are essential

For algebraic encodings, audit not only the main argument but also special representations: modulus `1`, repeated moduli, repeated bases/frequencies, zero coefficients after merging, and the exact hypotheses of the linear-independence lemma.

## L-022 — Add an explicit Invariant Hunt stage

The #275 success suggests adding an `Invariant Hunt` substage after statement triage. The agent should inspect conspicuous numerical thresholds and structural terms and ask what finite dimension, recurrence order, combinatorial state count, generating function, root-of-unity encoding, or other invariant could naturally produce them.

## L-023 — Transform reciprocal equations before direct Diophantine search

#303 exposed a broader pattern. The visible equation `1/a = 1/b + 1/c` is not best attacked as a reciprocal Diophantine equation. Brown–Rödl's solution identifies it as the reciprocal image of the homogeneous partition-regular equation `x0 = x1 + x2`.

Lesson: before manipulating a reciprocal equation directly, test whether it is obtained by inverting a homogeneous partition-regular system whose colouring theorem is already accessible.

## L-024 — Algebraic parametrization and colouring forcing are separate proof layers

#303 produced correct reductions such as `(b-a)(c-a)=a^2` and the family `(AB, A(A+B), B(A+B))`, but these did not force a monochromatic instance.

Lesson: record algebraic solution families as structural lemmas, but separately identify the combinatorial theorem that forces one member of the family to be monochromatic.

## L-025 — Do not substitute a stronger-looking Ramsey theorem without matching hypotheses

#303 tempted a direct invocation of polynomial van der Waerden. The needed homogeneous zero-based polynomial configuration did not match the standard translated configuration produced by that theorem.

Lesson: every Ramsey/partition-regularity theorem must be checked at the level of its exact hypotheses, domain, coefficient pattern, distinctness conditions, and target configuration.

## L-026 — Look for transformation classes as invariants

#303 suggests extending `Invariant Hunt` beyond numerical thresholds and algebraic expressions. Search for class-level transformations such as reciprocal transfer, homogenization, duality, compactness transfer, or scaling invariance that convert the target into a known theorem class.

## L-027 — Compactness + LCM is a reusable bridge for finite colourings

The Brown–Rödl reciprocal-transfer argument turns a finite-colouring statement on all positive integers into a finite problem using compactness and `lcm(1,...,T)`. This is a useful reusable pattern for reciprocal/finite-colouring problems.

## L-028 — Failure should be classified by missing mathematical technology

#303 did not fail because its algebraic reductions were wrong. It failed because the missing step required partition-regularity/compactness machinery not derived during the blind phase.

Lesson: benchmark logs should state not only `FAILED`, but also the missing proof technology: e.g. Ramsey theorem, compactness, additive combinatorics, Diophantine approximation, spectral method, etc.

## Agent checklist

Before acting on a new problem, the agent should ask internally:

1. What is the exact problem-level status?
2. Is the canonical statement locked?
3. Are we in blind mode?
4. What information is forbidden until proof freeze?
5. Which lemmas are established versus merely conjectured?
6. Have failed paths been recorded?
7. Has every candidate proof passed an algebraic/logical audit?
8. Has the proof actually been frozen before reference access?
9. What is the final discovery classification: new, independent rederivation, equivalent reformulation, or reference-derived?
10. What conspicuous numerical threshold might reveal the right invariant?
11. What theorem class might the problem belong to after a transformation of variables, reciprocals, duality, or homogenization?
12. If the blind attempt fails, what specific mathematical technology was missing?
