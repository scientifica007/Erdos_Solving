# Research Log — Erdős Problem #303

## Canonical statement

The exact user-supplied statement is the sole canonical statement during the blind phase:

> Is it true that in any finite colouring of the integers there exists a monochromatic solution to
> \[
> \frac{1}{a}=\frac{1}{b}+\frac{1}{c}
> \]
> with distinct $a,b,c$?

## Blind phase

Reference solution, solution discussion, and formal proof have not been consulted.

## Invariant Hunt

The Diophantine equation can be rewritten as
\[
bc=a(b+c),
\]
and then factored as
\[
(b-a)(c-a)=a^2.
\]
Thus every solution can be parametrized by choosing a divisor $d$ of $a^2$:
\[
b=a+d,\qquad c=a+\frac{a^2}{d}.
\]

A particularly useful subfamily is obtained by taking $a=2t$, $d=2t$-scaled so that
\[
(a,b,c)=(2t,6t,3t).
\]
Indeed,
\[
\frac1{2t}=\frac1{6t}+\frac1{3t},
\]
and the three integers are distinct for $t\ne0$.

Therefore the problem would follow from the following stronger-looking finite-colouring statement:
\[
\text{every finite colouring of }\mathbb Z\text{ has }t\ne0
\text{ with }c(t)=c(2t)=c(3t)=c(6t).
\]

This is now the main target of the blind attack. A natural reformulation is to colour the exponent lattice by
\[
(i,j)\mapsto c(2^i3^j),
\]
so that a monochromatic unit square would give
\[
t,2t,3t,6t
\]
all the same colour. The remaining task is therefore to justify the required monochromatic configuration in the exponent lattice using only a theorem that is legitimate to invoke or prove during the blind phase.

## Status

**Candidate proof: NOT FROZEN.**

The parametrization and the reduction to the multiplicative configuration $\{t,2t,3t,6t\}$ are established structural reductions. The Ramsey/Gallai step has not yet been justified and is therefore not being treated as a proof.
