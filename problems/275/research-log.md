# Research Log — Erdős Problem #275

## Phase 1 — Canonical Statement

The canonical benchmark statement is locked exactly as supplied in `problems/275/README.md`.

## Phase 2 — Blind Independent Solving

Reference solution has not been consulted.

### Initial structural observation

A system of $r$ congruences is a finite union of arithmetic progressions. We are told that its union contains $2^r$ consecutive integers. The target is to prove that the complement is empty globally.

### Candidate Path A — counting only

Density estimates alone do not immediately imply global coverage because the moduli may overlap heavily.

Status: **REJECTED / insufficient**.

### Candidate Path B — inductive reduction by parity

Parity splitting suggests a reduction, but odd and even moduli do not transform uniformly under the split.

Status: **REJECTED / incomplete**.

### Candidate Path C — minimal counterexample

Assuming an uncovered integer and using the covered block following it suggested a recursive/binary argument, but no complete reduction was obtained.

Status: **REJECTED / incomplete**.

### Candidate Path D — exponential-polynomial encoding

For each modulus $n_i>1$, let $\omega_i=e^{2\pi i/n_i}$ and define
\[
F(m)=\prod_{i=1}^r(1-\omega_i^{m-a_i}).
\]
Every covered integer is a zero of $F$. Expanding the product expresses $F$ as an exponential polynomial with at most $2^r$ distinct bases.

A Vandermonde zero lemma shows that an exponential polynomial with $M$ distinct nonzero bases cannot have $M$ consecutive zeros unless it is identically zero. Since the covered block has $2^r$ consecutive zeros and $M\le2^r$, this gives $F\equiv0$.

If an uncovered integer $m_0$ existed, every factor in $F(m_0)$ would be nonzero, contradicting $F(m_0)=0$.

Status: **CANDIDATE PROOF FOUND — READY FOR INDEPENDENT AUDIT**.

## Integrity

- Blind mode: ON.
- Historical proof accessed: NO.
- Formal proof accessed: NO.
- Solution discussion accessed: NO.

## Status

**Candidate proof: READY FOR AUDIT.**
