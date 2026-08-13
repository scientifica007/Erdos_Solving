# Historical Comparison — Erdős Problem #275

## Result

The independent proof was frozen before consulting the reference material. The later comparison shows that it uses the same core mathematical mechanism as the short 2020 proof by Balister, Bollobás, Morris, Sahasrabudhe, and Tiba, while presenting it in a different but closely equivalent form.

## Independent proof

We defined
\[
F(m)=\prod_{i=1}^r(1-\omega_i^{m-a_i}),
\qquad \omega_i=e^{2\pi i/n_i}.
\]
The covered block gives $2^r$ consecutive zeros. Expanding produces an exponential polynomial with at most $2^r$ distinct nonzero bases. A Vandermonde argument says that such a function cannot have that many consecutive zeros unless it is identically zero. An uncovered integer would make every factor nonzero, giving the contradiction.

## Reference proof

The 2020 paper first translates the interval and takes the least common multiple $q$ of the moduli. It maps integers to the cyclic group of $q$-th roots of unity and constructs a polynomial
\[
P(z)=\prod_i \left(z^{q/d_i}-\omega^{a_iq/d_i}\right)
\]
whose zero set contains the covered roots. Expanding $P$ shows that it belongs to a vector space spanned by at most $2^k$ monomials. The paper then constructs $2^k+1$ linearly independent shifted copies $P_m$, contradicting the dimension bound.

## Comparison

The two arguments share the same core invariant:

> A system of $r$ congruences creates an object living in a complex vector space of dimension at most $2^r$, while coverage of $2^r$ consecutive integers forces enough consecutive vanishing/linear constraints to make that object identically zero; an uncovered point then gives a contradiction.

The independent proof packages the mechanism as an exponential polynomial in the integer variable $m$ and applies a Vandermonde zero lemma directly. The reference proof packages it as a polynomial in a root-of-unity variable and applies a dimension/linear-independence argument.

Thus the result is **not an independent mathematical idea in the strong sense**: it rediscovered the same finite-dimensional / root-of-unity mechanism used by the short reference proof. However, the exact presentation and the Vandermonde formulation were obtained independently before the reference was opened.

## Historical context

The erdosproblems.com record attributes the original theorem to independent work of Selfridge and Crittenden–Vanden Eynden. The 2020 paper explicitly states that Crittenden and Vanden Eynden first proved the conjecture and that the 2020 paper gives a simpler proof.

## Protocol assessment

- Problem-level status verified before challenge: yes.
- Canonical statement locked: yes.
- Reference proof accessed before freeze: no.
- Candidate proof audited: yes.
- Proof frozen before comparison: yes.
- Historical comparison performed after freeze: yes.
- Independent discovery classification: **equivalent/rederivation of the reference mechanism, not a distinct core method**.
