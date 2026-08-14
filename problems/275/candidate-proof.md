# Candidate Proof — Erdős Problem #275

> **HISTORICAL CANDIDATE SNAPSHOT.** This candidate later passed `audit.md`, was frozen in `frozen-proof.md`, and was compared with the reference in `comparison.md`.

## Status

**Status at the time of this snapshot: under audit. Final status: audit passed and proof frozen.**

## Claim

If $r$ congruence classes cover $2^r$ consecutive integers, then their union covers every integer.

## Step 1 — Remove the trivial modulus

If some modulus $n_i=1$, then that congruence class is all of $\mathbb Z$, so the theorem is immediate. Hence assume
\[
n_i>1\quad(1\le i\le r).
\]

## Step 2 — Build an exponential polynomial

For each $i$, let
\[
\omega_i=e^{2\pi i/n_i}.
\]
Then $\omega_i$ is a nontrivial $n_i$-th root of unity, and
\[
1-\omega_i^{m-a_i}=0
\]
exactly when
\[
m\equiv a_i\pmod{n_i}.
\]
Define
\[
F(m)=\prod_{i=1}^r\bigl(1-\omega_i^{m-a_i}\bigr),\qquad m\in\mathbb Z.
\]
Whenever $m$ is covered by at least one congruence, one factor vanishes, so $F(m)=0$.

Therefore, if the system covers $2^r$ consecutive integers, then $F$ vanishes at $2^r$ consecutive integer arguments.

## Step 3 — Expand into at most $2^r$ exponential terms

Expanding the product gives
\[
F(m)=\sum_{S\subseteq\{1,\dots,r\}}
(-1)^{|S|}\left(\prod_{i\in S}\omega_i^{-a_i}\right)
\left(\prod_{i\in S}\omega_i\right)^m.
\]
Thus $F(m)$ is an exponential polynomial with at most $2^r$ distinct bases $\lambda_S=\prod_{i\in S}\omega_i$ after merging duplicate bases.

## Step 4 — Zero lemma for exponential polynomials

Lemma: if
\[
G(m)=\sum_{j=1}^{M}c_j\lambda_j^m,
\]
where the $\lambda_j$ are distinct nonzero complex numbers, and $G$ vanishes at $M$ consecutive integers, then all $c_j=0$ and hence $G\equiv0$.

Proof: after translating the first zero to $m=0$, the equations
\[
\sum_{j=1}^{M}c_j\lambda_j^t=0,\qquad t=0,\dots,M-1,
\]
form a Vandermonde system. Its determinant is
\[
\prod_{1\le i<j\le M}(\lambda_j-\lambda_i)\ne0.
\]
Hence every coefficient is zero.

Since $F$ has at most $2^r$ distinct bases and has $2^r$ consecutive zeros, the zero lemma implies
\[
F(m)=0\qquad\text{for every }m\in\mathbb Z.
\]

## Step 5 — Contradiction with an uncovered integer

If the original system did not cover all integers, choose $m_0$ outside all congruence classes. Then
\[
m_0\not\equiv a_i\pmod{n_i}
\]
for every $i$, so every factor satisfies
\[
1-\omega_i^{m_0-a_i}\ne0.
\]
Therefore
\[
F(m_0)\ne0,
\]
contradicting $F\equiv0$.

Hence all integers are covered.

## Critical audit points

1. The implication $1-\omega_i^{m-a_i}=0\iff m\equiv a_i\pmod{n_i}$ is valid because $\omega_i$ has exact order $n_i$.
2. Duplicate exponential bases must be merged before applying the Vandermonde argument; the number of distinct bases is at most $2^r$.
3. The zero lemma requires exactly as many consecutive zeros as the number of distinct bases, and we have at least that many because the original interval has length $2^r$.
4. The case $n_i=1$ is handled separately.
5. No claim is made that this is the historical proof until comparison is performed after freeze.
