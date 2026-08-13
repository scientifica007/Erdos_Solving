# Erdős Problem #678 — Lean Test Plan

## Goal

Turn the salvaged construction into a Lean-checkable theorem in layers. The first target is the concrete witness for `p = 5`, followed by the general valuation/CRT lemmas.

## Layer 0 — Concrete witness

Define

```text
M(n,k) = Nat.lcm of all integers n+i, 1 <= i <= k.
```

Prove the concrete statement

```text
M 495 8 > M 504 9
```

and the domain conditions

```text
495 >= 1
504 >= 495 + 8
8 >= 3.
```

This is the first formalization gate because it requires no CRT, no p-adic valuation theory, and no asymptotic estimate.

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

For prime `p >= 5`, set `k = 2*p - 2` and

```text
L = lcm 1 2 ... k
A = L / p.
```

Prove the existence of `t` satisfying

```text
t ≡ -1 [MOD p]
t ≡ 0  [MOD q^(floor(log_q k))]   for every prime q <= k, q != p.
```

For Lean, package this as an existence theorem first; only later define the least positive representative.

## Layer 4 — Exact Q-ratio

Prove

```text
Q(t,k+1) / Q(t-k-1,k) = L
```

in a rational-valued formulation, or prove equality of every prime valuation. This is the central arithmetic lemma.

## Layer 5 — Correct product estimate

The exact ratio is

```text
M(t-k-1,k) / M(t,k+1)
  = (L/t) * product_{j=1}^k ((t-j)/(t+j)).
```

The original draft incorrectly reversed an inequality here. The salvaged proof instead needs the lower bound

```text
product_{j=1}^k ((t-j)/(t+j))
  >= 1 - k*(k+1)/t.
```

A Lean-friendly lemma is

```text
prod_one_sub_le_sum
```

or an explicitly proven finite-product inequality for factors in `[0,1]`.

## Layer 6 — Elementary LCM growth bound

The general proof needs a bound strong enough to show

```text
L_k > p^2 * k * (k+1)
```

for `k = 2*p - 2` and `p >= 7`.

If formalizing `L_k >= 2^(k-1)` is inconvenient, replace it by a directly proved weaker bound sufficient for the target inequality. The theorem used here should be isolated so the main construction does not depend on a large imported analytic theorem.

## Layer 7 — General infinitude theorem

Package the full result as

```text
Theorem exists_infinite_family :
  ∀ p >= 7, Prime p →
    let k := 2*p - 2
    ∃ n m, m >= n + k ∧ M n k > M m (k+1)
```

Then deduce infinitude because infinitely many primes `p >= 7` give distinct values of `k`.

## Important audit gates

Lean formalization must explicitly prevent the earlier failure modes:

- no use of the false identity `M (t*n) k = t * M n k`;
- no replacement of `<` by `>` in the final product estimate;
- no assertion `L_k / p = L_(k-1)`;
- exact indexing of the intervals `[t-k,t-1]` and `[t,t+k]`;
- explicit treatment of primes `q > k`;
- explicit proof that the generated triples are distinct.

## Current environment

The current execution environment does not contain `lean` or `lake`, so this file is the formalization specification, not a compiler-verified Lean proof yet.
