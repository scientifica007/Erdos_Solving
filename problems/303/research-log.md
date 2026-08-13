# Research Log — Erdős Problem #303

## Canonical statement

The exact user-supplied statement is the sole canonical statement during the blind phase:

> Is it true that in any finite colouring of the integers there exists a monochromatic solution to
> \\[\frac{1}{a}=\frac{1}{b}+\frac{1}{c}\]
> with distinct $a,b,c$?

## Blind phase

Reference solution, solution discussion, and formal proof have not been consulted.

## Invariant Hunt

The equation is equivalent to
\\[
bc=a(b+c),
\\]
and hence
\\[
(b-a)(c-a)=a^2.
\\]
Thus every nonzero integer solution is parametrized by a factorization of $a^2$: if $d\mid a^2$, then
\\[
b=a+d,\qquad c=a+\frac{a^2}{d}.
\\]

### LEMMA-303-001 — explicit infinite polynomial family

For integers $A,B$ with $AB(A+B)\ne0$ and $A\ne B$, set
\\[
a=AB,\qquad b=A(A+B),\qquad c=B(A+B).
\\]
Then
\\[
\\frac1a=\\frac1b+\\frac1c,
\\]
and $a,b,c$ are distinct whenever the chosen parameters avoid the obvious degenerate cases. This follows from
\\[
(b-a)(c-a)=A^2B^2=a^2.
\\]

A special one-parameter family is obtained by $A=t$, $B=t^2$:
\\[
(a,b,c)=\\bigl(t^3,\ t^2(t+1),\ t^3(t+1)\\bigr).
\\]
This is a genuine polynomial family of distinct positive solutions for $t\ge2$.

### LEMMA-303-002 — simple three-term reduction

For every integer $n\ne0,-1$,
\\[
\\frac1n=\\frac1{n+1}+\\frac1{n(n+1)}.
\\]
Hence the full problem would follow from the finite-colouring configuration
\\[
c(n)=c(n+1)=c(n(n+1)).
\\]
This is a valid reduction but no theorem guaranteeing this configuration has yet been established.

### PATH-303-A — multiplicative square via $2$ and $3$ (rejected)

Mapping $(i,j)\mapsto c(2^i3^j)$ suggested seeking a monochromatic unit square. A checkerboard colouring of the exponent lattice shows that a unit square is not forced by finite colouring alone. Gallai/Ramsey arguments may force larger homothetic patterns, but those do not preserve the exact reciprocal identity automatically.

Status: **REJECTED AS A DIRECT ROUTE**.

### PATH-303-B — polynomial van der Waerden shortcut (not justified)

The polynomial family above tempts one to invoke polynomial van der Waerden. The standard theorem produces configurations of the form $x+p(d)$, whereas the needed configuration is the zero-based set $\{p_1(d),p_2(d),p_3(d)\}$. Therefore a direct invocation would be an unjustified theorem substitution unless an appropriate zero-based polynomial partition-regularity result is proved or explicitly established.

Status: **PROMISING BUT NOT PROOF**.

### Current bottleneck

We now need a legitimate finite-colouring theorem or a new elementary argument that forces one of the explicit polynomial/rational parametrized solution families to become monochromatic. The blind phase remains open.

## Integrity

- Blind mode: ON.
- Historical proof accessed: NO.
- Formal proof accessed: NO.
- Solution discussion accessed: NO.

## Status

**Candidate proof: NOT FROZEN.**

Only structural reductions and explicitly verified identities are recorded as established lemmas. No coloring theorem has been inserted without justification.
