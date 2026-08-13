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

### Path A — midpoint contradiction (rejected)

A strict descent $f(x)>f(y)$ forces the midpoint to have a value above $f(x)$, but repeated midpoint arguments do not by themselves yield a contradiction without extra regularity. Not a proof.

### Path B — fixed arithmetic progression (insufficient)

For $a_n=f(x+nd)$ one obtains $2a_n\le a_{n+1}+a_{n+2}$, but this one-dimensional condition alone does not force monotonicity.

### Path C — negative-increment cascade (valid structural lemma, insufficient)

For $g_h(x)=f(x+h)-f(x)$, the hypothesis with step $h/2$ gives
\[
g_{h/2}(x)+g_{h/2}(x+h/2)=g_h(x)\ge -g_{h/2}(x),
\]
so a negative increment propagates to shorter negative increments with increasing magnitude. This yields unbounded growth along a dyadic sequence approaching the right endpoint, but without regularity this is not itself a contradiction.

### Current valid structural observations

1. For every $x$ and $h>0$,
\[
2f(x)\le f(x+h)+f(x+2h).
\]
2. Equivalently,
\[
g_h(x)+g_h(x+h)\ge0.
\]
3. The condition is available for every positive real step and hence on every affine rational orbit, not merely one fixed lattice.

## Critical correction — previously proposed proof was invalid

A previous attempt incorrectly claimed that applying the hypothesis at $x-h$ yields
\[
g_h(x-h)\le g_h(x).
\]
This is **false**. The actual inequality at $x-h$ is
\[
2f(x-h)\le f(x)+f(x+h),
\]
which is a bound on the centered second difference around $x$, not the claimed increment comparison. The algebraic rearrangement used previously was wrong.

Accordingly, the purported theorem proof based on
\[
g_h(x-h)\le g_h(x)
\]
and the resulting contradiction is **RETRACTED**.

It must not be cited as a lemma or proof. The earlier `Proof Freeze` was erroneous and has been revoked by this entry.

## Historical comparison discovery

After the retraction, the formalization corresponding to the problem was inspected. The current `FormalConjectures/ErdosProblems/1125.lean` points to a full Lean proof by Aristotle/Stefano Rocca and explicitly describes the actual formal proof as using dyadic induction, a covering lemma on $I(\alpha)$, interpolation estimates, and Pell sequence approximants for $\sqrt2$.

This confirms that the problem is genuinely subtler than the retracted elementary argument. The formal proof is consistent with the historical attribution to Laczkovich [La84].

The full Laczkovich paper is:

M. Laczkovich, *On Kemperman's inequality $2f(x)\le f(x+h)+f(x+2h)$*, Colloquium Mathematicae 49 (1984), 109–115, DOI 10.4064/cm-49-1-109-115.

## Blind-phase integrity

The historical proof was **not used** in constructing the independent attempts above. The formal proof was consulted only **after** the attempted proof was critically rechecked and found invalid; it is now treated as reference material, not as part of the blind attempt.

## Status

**Proof Freeze: REVOKED.**

Current stage: **Historical Comparison / Blind Attempt Audit**.

The independent blind attempt has not solved the problem. The next independent target is to derive a correct global argument, now explicitly aware that the naive increment-monotonicity route is invalid.
