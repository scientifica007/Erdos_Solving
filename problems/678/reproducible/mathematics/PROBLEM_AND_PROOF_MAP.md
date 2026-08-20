# Erdős #678 — Problem Statement and Proof Map

## Canonical definition

For natural numbers `n,k`, the repository uses

`M(n,k) = lcm{n+1, n+2, ..., n+k}`.

The canonical Lean implementation is `erdosM`.

## Canonical target

The final machine-checked endpoint proves an explicitly unbounded form:

for every lower bound `B`, there exist natural numbers `n,m,k` such that

- `B ≤ k`;
- `3 ≤ n`, `3 ≤ m`, `3 ≤ k`;
- `n + k ≤ m`;
- `M(m,k+1) < M(n,k)`.

Consequently the set of valid block lengths `k` is infinite.

The corresponding Lean theorems are:

- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`.

## Mathematical attribution

The successful mathematics is Stijn Cambie's 2024 proof. The repository's successful mode is an external-proof reconstruction followed by an independent Lean reimplementation. The project does not claim a new mathematical solution, a new independent mathematical proof, or the first Lean formalization.

## Strong theorem used before the benchmark corollary

The reconstruction first proves the stronger eventual statement: for each fixed positive multiplicative factor `C`, all sufficiently large `k` admit `x,y` with

- `k < x < y`;
- `x + k < y`;
- `C * lcm{y,...,y+k} < lcm{x,...,x+k-1}`.

The benchmark follows at `C = 1` by translating

`n = x - 1`, `m = y - 1`.

The final formalization preserves the large-start fact `k < x` through the construction so that this off-by-one translation is valid at the benchmark domain boundary.

## Proof architecture

The successful dependency path is:

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

## Claim 4 — producer

Claim 4 is the combinatorial/CRT construction layer. It chooses compatible residue data modulo selected primes and proves that suitable representatives exist in controlled windows.

The formalization makes several paper-level obligations explicit:

- finite density is expressed with exact integer exclusion budgets;
- CRT coordinate multipliers must be nonzero/units modulo their coordinate primes;
- pair/triple CRT producers are separated from consumers;
- the paper convention in which coefficient `p` represents residue zero is translated explicitly to canonical residues;
- actual affine/scaled reconstructed representatives are distinguished from normalized CRT coordinates;
- downstream-critical information such as positivity, ordering, separation, and start size is preserved through interfaces.

## Claim 5 — consumer

Claim 5 is the central arithmetic identity. Its proof compares prime-adic valuations across three prime ranges:

1. small primes `p ≤ sqrt(k)`;
2. medium/large primes `sqrt(k) < p ≤ k`;
3. primes `p > k`.

The residue interfaces produced by Claim 4 are consumed here to force the required equality of valuation contributions.

## Quantitative finish

After Claim 5, product/LCM cancellation and interval-product estimates turn the exact identity into a strict LCM-ratio inequality. Prime-density input supplies the five required primes in controlled windows. An elementary growth threshold and the PNT-derived provider complete the strong eventual theorem.

## Infinitude mechanism

The infinitude result does **not** arise by scaling one finite witness. It arises because the construction works for every sufficiently large `k` (and therefore yields witnesses above every requested lower bound).

This distinction is encoded directly by `erdos678_unbounded_witnesses` before deriving set infinitude.

## Concrete semantic regressions

A real finite witness is retained:

`M(36,8) > M(47,9)`.

A tempting rejected candidate is also retained:

`not (M(495,8) > M(504,9))`.

The positive witness is evidence that the canonical definition is executable; the negative witness is evidence against reintroducing an earlier invalid generalization. Neither replaces the infinitude proof.

## Indexing discipline

The historical failed path exposed an off-by-one error around interval operators. The project therefore treats interval start and length as mathematical interfaces, not notation.

In particular, when an interval operator is defined by a start and a length, algebraic identities are accepted only after expanding the exact endpoints. The final public statement bridge proves the equivalence between the repository's length-based interval API and the `Finset.Ioc` public convention.
