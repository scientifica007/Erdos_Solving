# Erdős Problem #678 — Cambie Proof Analysis and Lean Roadmap

## Status

The independent construction attempted in our experiment was rejected. The concrete witness `M(36,8) > M(47,9)` is machine-verified, but it does not by itself yield infinitely many solutions.

This document records the structure of Cambie's 2024 proof and the revised formalization strategy. It is an analysis/reimplementation roadmap, not a claim of an independent new proof.

## 1. Stronger theorem actually proved

Cambie proves the stronger statement: for every constant `C >= 1`, for all sufficiently large `k`, there exist `0 < x < y` with `y > x + k` such that

`lcm{x,...,x+k-1} > C * lcm{y,...,y+k}`.

Thus Erdős #678 follows immediately by taking `C = 1` and translating

`n = x - 1`, `m = y - 1`.

Source: S. Cambie, *Resolution of an Erdős' problem on least common multiples*, arXiv:2410.09138 (2024).

## 2. Core mechanism

The proof does **not** scale one concrete witness. Instead it chooses `x` and `y` simultaneously by prescribing their residues modulo prime powers.

Set

`M = lcm(1,2,...,k)`

and decompose it as

`M = m * product_{sqrt(k) < p <= k} p`

where

`m = product_{p <= sqrt(k)} p^(floor(log_p k))`.

For primes `sqrt(k) < p <= k`, the proof defines admissible residue intervals for `x mod p` and `y mod p` so that the numbers of multiples of `p` in the two consecutive intervals differ in exactly the desired direction.

The small-prime part is controlled by requiring

`x ≡ 1 (mod m)` and `y ≡ 0 (mod m)`.

The large-prime residue constraints are then combined with the Chinese Remainder Theorem.

## 3. Claim 4 — density of CRT-generated residues

Cambie proves a general combinatorial lemma: if linear combinations of CRT basis weights cover every residue modulo a squarefree modulus, and each coordinate set excludes at most an `epsilon` fraction, then sufficiently short consecutive integer intervals still contain a permitted combination.

This is the mechanism used to locate suitable representatives `x` and `y` close to each other while satisfying many simultaneous modular restrictions.

This claim should be formalized independently of the LCM problem.

## 4. Choice of x and y

Using prime-density results, Cambie chooses:

- two primes just above `k/2` to construct a suitable `y` in a controlled size range;
- three primes just below `k` to construct an `x < y` with `y-x > k` and with `x` close enough to `y`.

The exact quantitative bounds are chosen so that the final LCM ratio exceeds the arbitrary constant `C`.

Thus the infinitude mechanism is:

`large k -> prime-density window -> CRT residue system -> x,y -> exact p-adic identity -> size estimate`.

It is **not** a transformation of one fixed solution.

## 5. Claim 5 — central arithmetic identity

The key identity is

`[ y(y+1)...(y+k) / lcm(y,...,y+k) ]`

`=`

`[ M * x(x+1)...(x+k-1) / lcm(x,...,x+k-1) ]`.

Equivalently, the reciprocal-LCM factors of the two intervals differ by exactly `M = lcm(1,...,k)`.

Cambie proves this by comparing the `p`-adic valuation of both sides for every prime `p`.

### Small primes `p <= sqrt(k)`

Since an interval of length `k` or `k+1` contains at most one multiple of `p^(floor(log_p k)+1)`, the capped valuation contributed by the LCM can be controlled explicitly. The congruences

`x ≡ y+1 ≡ 1 (mod m)`

make the corresponding capped valuation sums match.

### Large primes `sqrt(k) < p <= k`

There is at most one multiple of `p^2` in the relevant intervals. Therefore it is enough to compare the number of multiples of `p` in the two interval numerators. The admissible residue intervals for `x mod p` and `y mod p` were designed precisely to force equality of the valuations after inserting the factor `M`.

### Primes `p > k`

They occur at most once in either interval, so their contribution to the reciprocal-LCM factors is zero.

This Claim 5 is the best first target for a clean independent Lean formalization because it is local, arithmetic, and separates the CRT existence machinery from the final size estimate.

## 6. Final analytic/combinatorial estimate

From Claim 5, Cambie obtains

`lcm{x,...,x+k-1} / lcm{y,...,y+k}`

`= M * x(x+1)...(x+k-1) / [y(y+1)...(y+k)]`.

The selected ranges for `x` and `y` imply a lower bound of the form

`M/(y+k) * (x/y)^k`,

which is then bounded below by a quantity exceeding arbitrary fixed `C` for sufficiently large `k`.

This is the quantitative reason that a single construction yields infinitely many triples: the construction works for every sufficiently large `k`, not because one witness can be scaled.

## 7. Prime-density dependency

The published proof uses density of primes in intervals around `k/2` and near `k` (citing Baker–Harman–Pintz). The later Lean formalization reported on ErdősProblems uses a conditional Prime Number Theorem hypothesis `pi_alt`; the site notes that the formalized theorem is therefore conditional on that hypothesis unless the relevant PNT results are imported from PNT+.

Therefore we must distinguish:

- **Mathematical proof in Cambie's paper:** unconditional, using the cited prime-density input.
- **Current online Lean formalization reported by the site:** conditional on a PNT-style axiom/hypothesis in the posted version.

## 8. Revised Lean roadmap

Do not formalize the whole theorem immediately.

### Stage A — already completed

1. Lean/Lake/Mathlib CI infrastructure.
2. Correct concrete witness `M(36,8) > M(47,9)`.
3. Negative regression test for the false `(495,504,8)` witness.

### Stage B — arithmetic core

4. Formalize finite-interval LCMs and reciprocal-LCM factors.
5. Formalize Claim 5 as a theorem about `p`-adic valuations.
6. Split Claim 5 by prime ranges: `p <= sqrt(k)`, `sqrt(k) < p <= k`, `p > k`.

### Stage C — CRT combinatorial engine

7. Formalize Claim 4 independently.
8. Formalize the residue-box construction for `x` and `y`.
9. Prove existence of representatives satisfying the residue constraints and the required size separation.

### Stage D — quantitative finish

10. Formalize the lower bound for the LCM ratio.
11. Import or axiomatize only the exact prime-density statement needed, with the dependency explicitly named.
12. Derive the final theorem for sufficiently large `k`.
13. Deduce Erdős #678.

## 9. Lessons from our failed attempt

The failed `Q`-ratio construction had the right high-level instinct — compare product/LCM factors prime-by-prime — but attempted to force a global identity from a single CRT parameter `t`. The fatal issue was interval indexing:

`M(t,k+1) = lcm(t+1,...,t+k+1)`,

not `lcm(t,...,t+k)`.

Cambie's proof avoids this trap by constructing **two different endpoints `x` and `y`** and proving the exact valuation identity directly.

This is a major methodological lesson: when working with interval operators, formalize the interval endpoints first and only then derive algebraic identities.
