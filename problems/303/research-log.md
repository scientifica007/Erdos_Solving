# Research Log — Erdős Problem #303

## Canonical statement

The exact user-supplied statement is the sole canonical statement during the blind phase:

> Is it true that in any finite colouring of the integers there exists a monochromatic solution to
> \[1/a=1/b+1/c\]
> with distinct $a,b,c$?

## Blind phase

Reference solution, solution discussion, and formal proof were not consulted during the blind attempt.

## Invariant Hunt

The equation is equivalent to
\[
bc=a(b+c),
\]
and hence
\[
(b-a)(c-a)=a^2.
\]

Thus every nonzero integer solution can be parametrized by a factorization of $a^2$: if $d\mid a^2$, then
\[
b=a+d,\qquad c=a+\frac{a^2}{d}.
\]

### LEMMA-303-001 — explicit two-parameter family

For integers $A,B$ with $AB(A+B)\ne0$ and $A\ne B$, set
\[
a=AB,\qquad b=A(A+B),\qquad c=B(A+B).
\]
Then
\[
\frac1a=\frac1b+\frac1c,
\]
and the three values are distinct away from the obvious degenerate cases.

A special one-parameter family is
\[
(a,b,c)=\bigl(t^3,t^2(t+1),t^3(t+1)\bigr).
\]

### LEMMA-303-002 — simple three-term reduction

For every integer $n\ne0,-1$,
\[
\frac1n=\frac1{n+1}+\frac1{n(n+1)}.
\]
Hence it would suffice to force
\[
c(n)=c(n+1)=c(n(n+1)).
\]

### PATH-303-A — multiplicative square via 2 and 3

Mapping $(i,j)\mapsto c(2^i3^j)$ suggests a monochromatic unit square, which would force $t,2t,3t,6t$ to have the same colour. A checkerboard colouring of the exponent lattice shows that a unit square is not forced by finite colouring alone. Larger homothetic configurations do not preserve the exact identity automatically.

Status: REJECTED AS A DIRECT ROUTE.

### PATH-303-B — polynomial van der Waerden shortcut

The polynomial family suggests polynomial Ramsey machinery. The standard polynomial van der Waerden theorem produces translated configurations of the form $x+p_i(d)$, while the present target is a zero-based homogeneous polynomial configuration. Direct invocation would therefore be an unjustified theorem substitution without an additional theorem or proof.

Status: PROMISING BUT NOT PROOF.

## Blind-failure decision

After repeated structural attempts, no justified Ramsey/partition-regularity step was derived from elementary arguments available within the blind phase. Continuing would risk importing an unproved theorem under a new name or manufacturing a false reduction.

Therefore the blind attempt is classified as **FAILED / INCOMPLETE**, not solved.

The reference solution may now be consulted under the project protocol, but the blind record above is immutable and must not be rewritten using hindsight.

## Integrity

- Blind mode during attempt: ON.
- Historical proof accessed before failure declaration: NO.
- Formal proof accessed before failure declaration: NO.
- Solution discussion accessed before failure declaration: NO.
- Candidate proof: NONE.
- Proof freeze: NOT APPLICABLE.

## Current status

**Blind phase closed as incomplete; transition to historical/reference comparison authorized by the explicit failure declaration.**
