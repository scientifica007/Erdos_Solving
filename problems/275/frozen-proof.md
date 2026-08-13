# Frozen Independent Proof — Erdős Problem #275

**Freeze status:** FROZEN

**Freeze condition:** Candidate proof passed independent audit with all checks in `audit.md` marked PASS.

## Theorem

If $r$ congruence classes cover $2^r$ consecutive integers, then they cover every integer.

## Frozen proof

If some modulus equals $1$, that congruence class is all of $\mathbb Z$, so assume $n_i>1$ for all $i$.

For each $i$ let
\[
\omega_i=e^{2\pi i/n_i}.
\]
Then $\omega_i$ has exact order $n_i$. Define
\[
F(m)=\prod_{i=1}^r(1-\omega_i^{m-a_i}),\qquad m\in\mathbb Z.
\]
If $m$ belongs to any congruence class $a_i\pmod{n_i}$, then the $i$th factor is zero. Hence the given block of $2^r$ consecutive covered integers consists of zeros of $F$.

Expanding,
\[
F(m)=\sum_{S\subseteq\{1,\dots,r\}}
(-1)^{|S|}\left(\prod_{i\in S}\omega_i^{-a_i}\right)
\left(\prod_{i\in S}\omega_i\right)^m.
\]
After combining equal bases, this is an exponential polynomial with $M\le2^r$ distinct nonzero bases.

An exponential polynomial with $M$ distinct nonzero bases cannot vanish at $M$ consecutive integers unless it is identically zero: after translating the first zero to exponent $0$, the $M$ equations form a nonsingular Vandermonde system.

Since $F$ has $2^r\ge M$ consecutive zeros, $F(m)=0$ for every integer $m$.

If some integer $m_0$ were uncovered, then $m_0\not\equiv a_i\pmod{n_i}$ for every $i$, so every factor $1-\omega_i^{m_0-a_i}$ would be nonzero. Thus $F(m_0)\ne0$, contradiction.

Therefore every integer is covered.

## Provenance

This is an independent proof developed before opening the historical/reference solution.
