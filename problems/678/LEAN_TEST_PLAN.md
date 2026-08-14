# Erdős Problem #678 — Lean Test Plan

## Goal

Turn a *correct* solution of #678 into a Lean-checkable theorem in layers. The first concrete-witness gate is now based on the independently verified instance

`M(36,8) > M(47,9)`.

The earlier proposed `(n,m,k) = (495,504,8)` construction has been rejected after direct arithmetic found the inequality to be false. See `FORMALIZATION_CORRECTION_2026-08-14.md`.

## Layer 0 — Concrete witness

Define

```text
M(n,k) = Nat.lcm of all integers n+i, 1 <= i <= k.
```

Prove the concrete statement

```text
M 36 8 > M 47 9
```

and the domain condition

```text
47 >= 36 + 8
8 >= 3.
```

Also retain a regression test showing that the rejected candidate is false:

```text
¬ (M 495 8 > M 504 9)
```

This gate requires no CRT, no p-adic valuation theory, and no asymptotic estimate.

## Layer 1 — Product/LCM decomposition

For positive `n` and `k`, define

```text
P(n,k) = product over i in {1,...,k} of (n+i)
Q(n,k) = P(n,k) / M(n,k)
```

The preferred Lean route is to avoid division in `Nat` while proving structural lemmas: either work in `ℚ`/`ℤ` after proving divisibility, or formulate the valuation identities directly.

## Layer 2 — Valuation formula

For prime `q`, define

```text
N_r(n,k,q) = card { i in Finset.Icc 1 k | q^r ∣ n+i }
```

and prove

```text
v_q(Q(n,k)) = Σ r, (N_r(n,k,q) - indicator (N_r(n,k,q) > 0)).
```

This should preferably be split into:

1. valuation of a finite product;
2. valuation of a finite LCM;
3. finite-support reduction for `r`.

## Layer 3 — The CRT construction

No general CRT construction is accepted until its interval indexing has been re-derived from the exact definitions of `M(n,k)`, `P(n,k)`, and `Q(n,k)`.

Earlier reasoning incorrectly compared the right-hand interval `[t,t+k]` with `M(t,k+1)`. The actual interval is

```text
[t+1,t+k+1].
```

Therefore the former `Q`-ratio lemma is invalid and must not be reused.

## Layer 4 — Re-derive the exact Q-ratio

Any future construction must prove the exact ratio for the actual intervals

```text
[t-k,t-1]
[t+1,t+k+1].
```

before any product estimate is attempted.

The formalization must explicitly track all endpoint shifts.

## Layer 5 — Product estimate

Only after the exact `Q`-ratio is proved for the true intervals should we derive a product estimate. No inequality direction is accepted without a Lean-checked lemma.

## Layer 6 — General infinitude theorem

A general theorem must separately establish:

- admissibility of each generated triple;
- the strict LCM inequality;
- infinitude/distinctness of the generated triples.

## Important audit gates

Lean formalization must explicitly prevent earlier failure modes:

- no use of the false identity `M (t*n) k = t * M n k`;
- no replacement of `<` by `>` in the final product estimate;
- no assertion `L_k / p = L_(k-1)`;
- exact indexing of both LCM intervals after every substitution;
- direct numerical validation of every proposed witness before encoding a positive theorem;
- explicit treatment of primes `q > k`;
- explicit proof that generated triples are distinct.

## Current environment

Lean 4.33.0 and Mathlib v4.33.0 are configured under `formalization/`. GitHub Actions performs the machine-checking using the Mathlib cache. Local full builds are not required.
