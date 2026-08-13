# Frozen Independent Proof — Erdős Problem #214

**Freeze status: FROZEN**

**Reference solution accessed before freeze: NO**

## Theorem

Let $S\subset\mathbb R^2$ have no two points at Euclidean distance $1$. Then $\mathbb R^2\setminus S$ contains four points forming a unit square.

## Proof

If $S=\varnothing$, the complement is all of $\mathbb R^2$, so the conclusion is immediate.

Assume $S\ne\varnothing$ and choose $p\in S$. Suppose, for contradiction, that $\mathbb R^2\setminus S$ contains no unit square.

Take any point $q$ with $|q-p|=\sqrt2$. Put $w=q-p$. Since $|w|=\sqrt2$, there exist orthonormal unit vectors $u,v$ such that
\[
w=u+v.
\]
Then
\[
q=p+u+v,
\]
and the four points
\[
p,\quad p+u,\quad q,\quad p+v
\]
form a unit square: each of the four consecutive side vectors is a unit vector ($u,v,-u,-v$).

Because $p\in S$ and $S$ contains no two points at distance $1$, both $p+u$ and $p+v$ lie outside $S$. Under our supposition that the complement contains no unit square, the remaining vertex $q$ must therefore lie in $S$; otherwise the four vertices above would form a unit square entirely in the complement.

Since $q$ was arbitrary on the circle $C(p,\sqrt2)$, we obtain
\[
C(p,\sqrt2)\subseteq S.
\]

Now that circle contains two points at distance $1$. After translating and rotating, take $p=(0,0)$ and
\[
q_1=(1,1),
\qquad
q_2=\left(\frac{3+\sqrt7}{4},\frac{3-\sqrt7}{4}\right).
\]
Both points have squared distance $2$ from $p$, while
\[
|q_1-q_2|^2
=\left(\frac{\sqrt7-1}{4}\right)^2+\left(\frac{\sqrt7+1}{4}\right)^2
=1.
\]
Thus $q_1,q_2\in S$ are at distance $1$, contradicting the defining property of $S$.

Therefore $\mathbb R^2\setminus S$ contains a unit square.
\quad\square

## Audit status

- Empty-set case: PASS.
- Construction of orthonormal $u,v$ with $u+v=q-p$: PASS.
- Four constructed points form a unit square: PASS.
- Since $p\in S$, the two adjacent vertices at distance $1$ from $p$ are outside $S$: PASS.
- The argument applies to every $q$ on $C(p,\sqrt2)$: PASS.
- Explicit unit-distance pair on $C(p,\sqrt2)$: PASS.
- No continuity, measurability, density, or compactness assumptions: PASS.
- Reference solution or discussion consulted before freeze: NO.
