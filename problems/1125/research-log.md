# Research Log — Erdős Problem #1125

## Canonical statement

The canonical statement is the exact text supplied by the user:

> Let $f:\mathbb{R}\to \mathbb{R}$ be such that
> \[
> 2f(x) \leq f(x+h)+f(x+2h)
> \]
> for every $x\in \mathbb{R}$ and $h>0$. Must $f$ be monotonic?

No stronger, weaker, or paraphrased statement is substituted during the blind phase.

## Independent attack

We prove that $f$ is nondecreasing.

Take arbitrary $x<y$. Put
\[
h=\frac{y-x}{2}>0,
\qquad m=\frac{x+y}{2}.
\]
Suppose, for contradiction, that
\[
f(y)<f(x).
\]

Apply the hypothesis at $x$ with this value of $h$. Since $x+h=m$ and $x+2h=y$,
\[
2f(x)\leq f(m)+f(y),
\]
so
\[
f(m)\geq 2f(x)-f(y)>f(x)>f(y).
\]

Now apply the hypothesis at the midpoint $m$ with the same $h$. Since $m+h=y$ and $m+2h=\frac{3y-x}{2}$, this gives
\[
2f(m)\leq f(y)+f\!\left(\frac{3y-x}{2}\right).
\]

This second inequality alone does not immediately contradict the previous lower bound. Therefore we need one further observation: apply the hypothesis at $m$ with step $h/2$. Since $m+h/2=\frac{3x+y}{4}$ and $m+h=y$,
\[
2f(m)\leq f\!\left(\frac{3x+y}{4}\right)+f(y).
\]
This still does not directly force a contradiction.

The independent attack therefore requires a further structural lemma; the elementary midpoint argument above is not yet a complete proof.

## Status

**Candidate proof: NOT FROZEN.**

The attempted midpoint contradiction has a genuine gap and is recorded only as an exploratory path. No historical/reference proof has been consulted.
