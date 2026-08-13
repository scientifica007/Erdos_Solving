# Lessons Learned — Erdős Problem #275

## Outcome

The enhanced benchmark protocol completed its full cycle without blind-mode contamination:

`problem status → canonical lock → blind exploration → candidate proof → audit → freeze → reference comparison → final classification`.

## Reusable lessons

### L-275-01 — Match the numerical threshold to a structural dimension

The appearance of `2^r` was the decisive clue. A product over `r` congruences expands into at most `2^r` exponential terms. This suggested looking for a finite-dimensional linear-algebraic invariant rather than a density argument.

### L-275-02 — Encode covering conditions as zeros

For each congruence, a root of unity turns membership in that congruence class into the vanishing of one factor. The product therefore converts a covering problem into a zero-set problem for an exponential polynomial.

### L-275-03 — Consecutive zeros can be stronger than density

Counting how many integers each congruence covers was insufficient. The exact location of `2^r` consecutive covered integers is much stronger because a finite-dimensional exponential family is rigid under consecutive vanishing.

### L-275-04 — Independent rediscovery is not historical novelty

The blind proof and the reference proof use different packaging but the same core root-of-unity / finite-dimensional mechanism. The correct classification is `independent rederivation / equivalent core mechanism`, not a new mathematical method.

### L-275-05 — Freeze-before-reference makes comparison meaningful

Because the candidate proof was frozen before the reference was opened, its later similarity to the reference provides evidence of genuine blind rediscovery rather than contamination.

### L-275-06 — Audit representation-level edge cases

For this style of proof the audit must check modulus `1`, repeated moduli, repeated exponential bases, zero coefficients after merging terms, and the exact hypotheses of the Vandermonde lemma.

### L-275-07 — Keep failed approaches

Density/counting, parity reduction, and the initial minimal-counterexample route were insufficient. They remain recorded because they explain why the successful invariant search was necessary.

## Benchmark lesson

#275 is a better calibration benchmark than #1125 because its decisive mechanism is short, algebraic, and discoverable without specialized machinery. Future benchmarks should be chosen similarly: solved at the main-problem level, statementually compact, and with a plausible elementary invariant.

## Required future protocol improvement

Add an explicit `Invariant Hunt` substage after statement triage: inspect conspicuous numerical thresholds in the statement and ask what finite dimension, recurrence order, combinatorial state count, or algebraic expansion could naturally produce that threshold.
