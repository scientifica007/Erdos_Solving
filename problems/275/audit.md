# Independent Audit — Erdős Problem #275

> **HISTORICAL AUDIT SNAPSHOT — COMPLETED.** This audit passed. The proof was subsequently frozen in `frozen-proof.md` and compared with the reference in `comparison.md`.

## Audit target

Candidate proof in `candidate-proof.md` based on an exponential polynomial.

## A. Modulus-one case

If any $n_i=1$, then $a_i\pmod 1$ is all of $\mathbb Z$, so the theorem is immediate. Therefore the proof may assume all $n_i>1$.

**PASS.**

## B. Root-of-unity encoding

For $\omega_i=e^{2\pi i/n_i}$, exact order $n_i$ gives
\[
\omega_i^{m-a_i}=1\iff n_i\mid(m-a_i)\iff m\equiv a_i\pmod{n_i}.
\]
Thus
\[
F(m)=\prod_i(1-\omega_i^{m-a_i})
\]
vanishes whenever at least one congruence covers $m$.

**PASS.**

## C. Number of exponential terms

Expanding the product is indexed by subsets $S\subseteq\{1,\ldots,r\}$, hence gives at most $2^r$ terms. Different subsets may produce the same base $\lambda_S=\prod_{i\in S}\omega_i$; after combining equal bases the number $M$ of distinct bases satisfies $M\le2^r$.

All bases are nonzero because every $\omega_i$ lies on the unit circle.

**PASS.**

## D. Vandermonde zero lemma

Suppose
\[
G(m)=\sum_{j=1}^{M}c_j\lambda_j^m
\]
with distinct nonzero $\lambda_j$, and suppose $G(t),\ldots,G(t+M-1)=0$.
Set $d_j=c_j\lambda_j^t$. Then
\[
\sum_j d_j\lambda_j^s=0,\qquad s=0,\ldots,M-1.
\]
The coefficient matrix is the Vandermonde matrix $(\lambda_j^s)_{s,j}$, with determinant
\[
\prod_{i<j}(\lambda_j-\lambda_i)\ne0.
\]
Therefore $d_j=0$ for every $j$, hence $c_j=0$.

**PASS.**

## E. Number of zeros versus number of bases

The covered block supplies $2^r$ consecutive integer zeros. Since $M\le2^r$, it contains at least $M$ consecutive zeros. Therefore the zero lemma applies and $F$ is identically zero as a function on $\mathbb Z$ (indeed as an exponential polynomial).

**PASS.**

## F. Contradiction at an uncovered integer

If $m_0$ is uncovered, then for every $i$,
\[
m_0-a_i\not\equiv0\pmod{n_i},
\]
so $\omega_i^{m_0-a_i}\ne1$ and each factor $1-\omega_i^{m_0-a_i}$ is nonzero. A finite product of nonzero complex numbers is nonzero, hence $F(m_0)\ne0$, contradicting $F\equiv0$.

**PASS.**

## G. Translation invariance

No special position of the covered interval is used. The argument applies to any block of $2^r$ consecutive integers. No normalization is needed.

**PASS.**

## H. Hidden assumptions

- Congruence classes may have repeated moduli: allowed; the proof does not require distinct $n_i$.
- Congruence classes may overlap: allowed; a single zero factor is enough.
- The uncovered integer may lie anywhere: allowed.
- Negative integer arguments cause no problem because all $\lambda_j\ne0$, so $\lambda_j^m$ is defined for every $m\in\mathbb Z$.

**PASS.**

## Audit conclusion

No logical gap has been found in the candidate proof.

**AUDIT RESULT: PASS.**

The proof is eligible for Proof Freeze. Historical/reference material remains unopened.
