# Research Log — Erdős Problem #1125

## Canonical statement

The canonical statement is the exact text supplied by the user:

> Let $f:\mathbb{R}\to \mathbb{R}$ be such that
> \[
> 2f(x) \leq f(x+h)+f(x+2h)
> \]
> for every $x\in\mathbb{R}$ and $h>0$. Must $f$ be monotonic?

No stronger, weaker, or paraphrased statement is substituted during the blind phase.

## Independent attack

We prove that $f$ is nondecreasing.

### Path A — midpoint contradiction (rejected)

Take $x<y$, put $h=(y-x)/2$, and $m=(x+y)/2$. If $f(y)<f(x)$, the hypothesis at $x$ gives
\[
2f(x)\le f(m)+f(y),
\]
hence
\[
f(m)>f(x)>f(y).
\]
This is suggestive, but repeated midpoint arguments did not by themselves yield a contradiction without additional regularity assumptions. This path is **not a proof**.

### Path B — fixed arithmetic progression (insufficient)

For a fixed step $d>0$, write
\[
a_n=f(x+nd).
\]
The hypothesis gives
\[
2a_n\le a_{n+1}+a_{n+2},
\]
or, with $b_n=a_{n+1}-a_n$,
\[
2b_n+b_{n+1}\ge0.
\]
This one-dimensional recurrence does not by itself force monotonicity. The proof must use the availability of every positive real step size.

### Lemma LEMMA-1125-001 — increments are nondecreasing in the base point

Fix $h>0$ and define
\[
g_h(x):=f(x+h)-f(x).
\]
Apply the original hypothesis at $x-h$ with the same step $h$:
\[
2f(x-h)\le f(x)+f(x+h).
\]
Rearranging gives
\[
f(x)-f(x-h)\le f(x+h)-f(x),
\]
that is,
\[
\boxed{g_h(x-h)\le g_h(x)}.
\]
Thus, for every fixed $h>0$, the function $g_h$ is nondecreasing on $\mathbb R$.

This is the crucial structural fact missing from the earlier fixed-lattice approach.

### Lemma LEMMA-1125-002 — adjacent increments have nonnegative sum

The original hypothesis at $x$ gives
\[
2f(x)\le f(x+h)+f(x+2h),
\]
which is exactly
\[
\boxed{g_h(x)+g_h(x+h)\ge0}.
\]

### Theorem — $f$ is nondecreasing

Fix arbitrary $x\in\mathbb R$ and $h>0$. We prove
\[
g_h(x)\ge0.
\]

Assume for contradiction that
\[
g_h(x)<0.
\]
By Lemma LEMMA-1125-001, since $x-h<x$,
\[
g_h(x-h)\le g_h(x)<0.
\]
But Lemma LEMMA-1125-002 applied at $x-h$ gives
\[
g_h(x-h)+g_h(x)\ge0.
\]
The left-hand side is strictly negative, a contradiction.

Therefore
\[
g_h(x)\ge0
\]
for every $x\in\mathbb R$ and every $h>0$, i.e.
\[
f(x+h)\ge f(x).
\]
Hence for every $x<y$ (take $h=y-x>0$),
\[
\boxed{f(x)\le f(y)}.
\]
Thus $f$ is nondecreasing, so the answer to the problem is **Yes**.

## Independent audit

- Domain check: $x-h\in\mathbb R$ for every real $x$ and $h>0$.
- Direction check: the hypothesis at $x-h$ yields exactly $g_h(x-h)\le g_h(x)$.
- Pair-sum check: the hypothesis at $x$ yields exactly $g_h(x)+g_h(x+h)\ge0$.
- Contradiction check: $g_h(x)<0$ and $g_h(x-h)\le g_h(x)$ imply both terms in $g_h(x-h)+g_h(x)$ are strictly negative, contradicting its nonnegativity.
- Quantifier check: $x$ and $h>0$ were arbitrary, so the conclusion holds globally.
- No continuity, measurability, boundedness, or other regularity assumption was used.

## Blind-phase integrity

The historical proof, solution discussion, and papers specifically proving the statement were **not consulted** in constructing or auditing the proof.

## Proof status

**FROZEN — independent candidate proof passed audit.**

The exact frozen core is:

1. For fixed $h>0$, $g_h(x)=f(x+h)-f(x)$ is nondecreasing in $x$.
2. For every $x$, $g_h(x)+g_h(x+h)\ge0$.
3. A negative $g_h(x)$ would force both $g_h(x-h)$ and $g_h(x)$ to be negative, contradicting step 2 at $x-h$.
4. Therefore $g_h(x)\ge0$ for all $x,h>0$, so $f$ is nondecreasing.

The next phase is deliberately separate: retrieve the historical/reference proof and compare it with this frozen argument without modifying the frozen proof.
