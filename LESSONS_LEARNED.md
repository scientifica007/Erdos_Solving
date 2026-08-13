# Lessons Learned — Experimental Cycle: Erdős Problem #1125

This document converts the #1125 experiment into reusable project knowledge. It is not a mathematical proof file; it records methodological lessons for future Erdős solving attempts.

## L-001 — Problem-level status must be verified independently

A solved theorem, solved variant, or formalized sub-result inside a problem file does not imply that the main Erdős problem is solved. The source of truth for the problem-level status must be checked explicitly.

Consequence: the #18 episode exposed this failure mode. Future triage must record separately: problem status, variant status, known sub-results, formalized statement, and formalized proof.

## L-002 — A canonical statement must be locked before mathematical work

For blind experiments, the exact problem statement supplied by the user can be designated canonical. Any paraphrase is secondary and must not silently replace it.

Consequence: #1125 was kept in the exact user-supplied form.

## L-003 — Blind-mode contamination is a first-class failure state

If verification or search exposes solution information before the blind attempt is frozen, the challenge is contaminated and must not be presented as independent.

Consequence: #447 was discarded as a blind benchmark after solution information appeared during identification.

## L-004 — Short statements do not imply easy problems

#1125 has a one-line statement, yet its solution uses a deep global mechanism involving finite quantitative estimates, a covering construction on a dense arithmetic set, interpolation, and irrational approximation via Pell sequences.

Consequence: future benchmark selection must consider proof architecture and known depth, not statement length alone.

## L-005 — Local midpoint amplification is insufficient without regularity

For #1125, a strict descent forces increasingly large values along dyadic points approaching an endpoint. Without continuity, measurability, local boundedness, or another regularity hypothesis, this is not itself a contradiction.

Consequence: a successful proof must exploit the universal quantification over all positive real step sizes, rather than assuming regularity that is not given.

## L-006 — Fixed-step reduction loses essential information

Restricting the inequality to one arithmetic progression yields a recurrence such as

`2 a_n ≤ a_(n+1) + a_(n+2)`.

That recurrence alone does not force monotonicity. The real problem uses interactions among many step sizes and arithmetic progressions.

## L-007 — Quantitative finite-interval estimates can replace unavailable regularity

The reference reconstruction for #1125 derives bounds of the form

`f(0) ≤ f(n) + O(K/n)`

for finite discrete restrictions bounded by `K`. This creates an error term that can later be driven to zero by taking `n → ∞`.

Methodological lesson: when a proof lacks continuity or measurability, search for quantitative inequalities whose error tends to zero under refinement.

## L-008 — Dense arithmetic subsets can bridge discrete and real arguments

The reference mechanism works on

`I(α) = {n α + k : n,k ∈ Z}`

and proves monotonicity there before transporting the conclusion back to arbitrary real points.

Methodological lesson: search for a structured dense subgroup or orbit on which the discrete inequality is tractable.

## L-009 — Irrational approximation can provide the needed refinement scales

For #1125, `α = √2` is used together with Pell approximants having controlled growth, small approximation error, and alternating signs.

Methodological lesson: when arbitrary real step sizes create a Diophantine obstacle, continued fractions/Pell-type approximants may supply the required controlled scales.

## L-010 — Candidate proofs need algebraic audit before freeze

The attempted increment-monotonicity proof contained an invalid algebraic rearrangement. It was initially close enough to look convincing, but a deliberate audit exposed the mistake.

Consequence: no proof is frozen until every transformation has been checked independently. A revoked freeze must remain visible in history.

## L-011 — GitHub is useful as operational memory, not as mathematical authority

`PROJECT_STATE.md`, research logs, decision records, and lesson records allow the research process to resume consistently. They do not turn an unchecked mathematical claim into truth.

Consequence: repository state tracks claims, provenance, and workflow state; mathematical validity still requires explicit verification.

## L-012 — Failed paths are valuable research data

Rejected approaches must be preserved with the reason for rejection. Deleting them causes repeated work and hides why an apparently natural route was abandoned.

## L-013 — Separate historical attribution from modern formal reconstruction

A modern Lean file may formalize a historical theorem while having different authors and a different implementation structure. For #1125, Laczkovich is the historical attribution, while the inspected Lean reconstruction credits Aristotle and Stefano Rocca as formal authors.

Consequence: future comparison records should distinguish historical proof, modern reconstruction, and machine-checked formalization.

## L-014 — The blind phase and reference-comparison phase must be immutable boundaries

Once the reference solution is opened, the experiment can no longer be described as a blind independent solve. The transition must be recorded explicitly, and previous failed attempts must not be rewritten with hindsight.

## L-015 — Benchmark selection should prefer solved problems with shallow proof depth

#1125 was too deep for a first benchmark of the workflow. The next calibration problem should be verified at the problem level, have an independently available reference solution, and have a proof whose main ideas are likely recoverable without specialized machinery.

## Lessons for the agent

Before acting on a new problem, the agent should ask internally:

1. What is the exact problem-level status?
2. Is the canonical statement locked?
3. Are we in blind mode?
4. What information is forbidden until proof freeze?
5. Which lemmas are established versus merely conjectured?
6. Have failed paths been recorded?
7. Has every candidate proof passed an algebraic/logical audit?
8. If reference material is opened, has the blind boundary been closed?

