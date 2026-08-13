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

### Current structural observation

A strict descent
\[
f(x)>f(y),\qquad x<y,
\]
forces midpoint amplification: for $m=(x+y)/2$,
\[
f(m)>f(x)>f(y).
\]
The open problem is to turn the resulting multiscale amplification into a contradiction without assuming continuity, measurability, local boundedness, or any other regularity condition.

## Blind-phase integrity

The historical proof, solution discussion, and papers specifically proving the statement have not been consulted for the mathematical construction. Only the problem statement and general structural analysis are being used in the current blind phase.

## Status

**Candidate proof: NOT FROZEN.**

The problem remains in the structural-analysis phase. Any future argument must explicitly close the regularity-free gap before being treated as a proof.
