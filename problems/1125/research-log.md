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

We want to prove that $f$ is nondecreasing.

### Path A — midpoint contradiction (rejected)

Take $x<y$, put $h=(y-x)/2$, and $m=(x+y)/2$. If $f(y)<f(x)$, the hypothesis at $x$ gives
\[
2f(x)\le f(m)+f(y),
\]
hence
\[
f(m)>f(x)>f(y).
\]
This is suggestive, but applying the hypothesis again at $m$ does not by itself produce a contradiction. Further dyadic applications can propagate inequalities but do not yet close the argument. This path is therefore **not a proof**.

### Path B — fixed arithmetic progression (insufficient)

For a fixed step $d>0$, write
\[
a_n=f(x+nd).
\]
The hypothesis gives, for every $n\ge0$,
\[
2a_n\le a_{n+1}+a_{n+2},
\]
or equivalently for increments $b_n=a_{n+1}-a_n$,
\[
2b_n+b_{n+1}\ge0.
\]
This one-dimensional recurrence does not by itself force monotonicity on a finite arithmetic progression; finite sequences satisfying these inequalities can still decrease at some locations. Therefore the proof must exploit the fact that the step $h$ is an arbitrary positive real and that different arithmetic progressions interact.

### Lemma LEMMA-1125-001 — midpoint amplification

If $x<y$ and $f(x)>f(y)$, then for $m=(x+y)/2$,
\[
f(m)>f(x)>f(y).
\]
This follows directly from the hypothesis with $h=(y-x)/2$.

### Lemma LEMMA-1125-002 — negative-increment cascade

Define
\[
g_h(x):=f(x+h)-f(x).
\]
The hypothesis with step $h/2$ gives
\[
g_h(x)+g_{h/2}(x)\ge0.
\]
Suppose $g_h(x)<0$. Since
\[
g_h(x)=g_{h/2}(x)+g_{h/2}\!\left(x+\frac h2\right),
\]
and $g_{h/2}(x)\ge -g_h(x)>0$, we obtain
\[
g_{h/2}\!\left(x+\frac h2\right)
=g_h(x)-g_{h/2}(x)
\le 2g_h(x)<0.
\]
Thus a negative increment produces a negative increment of half the length, ending at the same right endpoint, with magnitude at least doubled.

Iterating from a hypothetical strict descent $f(x)>f(y)$, with $h=y-x$, gives
\[
x_n=y-(y-x)2^{-n}
\]
and
\[
f(y)-f(x_n)\le 2^n(f(y)-f(x))<0.
\]
Hence
\[
f(x_n)\to +\infty
\]
while $x_n\uparrow y$.

This is a genuine structural consequence of non-monotonicity.

### Lemma LEMMA-1125-003 — all positive rational steps on an affine rational orbit

Fix $x\in\mathbb R$ and $d>0$. For the sequence
\[
a_q:=f(x+qd),\qquad q\in\mathbb Q,
\]
the original hypothesis implies, for every $q\in\mathbb Q$ and every rational $r>0$,
\[
2a_q\le a_{q+r}+a_{q+2r}.
\]
Thus after restricting to any affine copy of $\mathbb Q$, the condition remains available simultaneously at **all rational positive step sizes**, not merely at one fixed lattice step. This is the first explicit point where the interaction between different arithmetic progressions enters the blind analysis.

### Computational exploration — no finite certificate found

A finite linear-programming search over several dyadic rational grids was used only as exploratory guidance. No nonnegative finite combination of the local inequalities on the tested grids produced a direct certificate of $f(0)\le f(1)$. This is not a mathematical impossibility result; it only indicates that a short finite linear-combination proof is unlikely to appear on those grids.

### Why the cascade is not yet a contradiction

The conclusion only gives unboundedness above along a sequence approaching $y$. Because no continuity, measurability, or local boundedness is assumed, this alone is compatible with $f(y)\in\mathbb R$.

The next target is to exploit Lemma LEMMA-1125-003: the blow-up generated along one dyadic chain must interact with other rational-step progressions and eventually force incompatible bounds at a fixed point.

## Blind-phase integrity

The historical proof, solution discussion, and papers specifically proving the statement have not been consulted for the mathematical construction. Only the user-supplied canonical statement, standard mathematical knowledge, and exploratory computation have been used.

## Status

**Candidate proof: NOT FROZEN.**

The current research state consists of structural lemmas only. No historical/reference proof has been consulted during this independent phase.
