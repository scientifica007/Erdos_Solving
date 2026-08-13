# Research Log — Erdős Problem #18

## Attempt 1 — Recursive factorial decomposition

### Target

Show the stronger statement
\[
 h(n!)\le n-1 \qquad(n\ge2).
\]

This immediately implies Erdős's bound \(h(n!)<n\).

### Normalized inductive claim

To avoid a boundary gap when an Euclidean quotient is zero, use the slightly stronger constructive claim:

> For every \(n\ge2\) and every integer \(m\) with \(0\le m\le n!\), there exists a set \(D\) of distinct divisors of \(n!\) such that \(|D|\le n-1\) and \(m=\sum_{d\in D}d\).

For \(m=0\), take \(D=\varnothing\).

This claim implies \(h(n!)\le n-1\).

### Base case: \(n=2\)

The divisors of \(2!=2\) are \(1,2\). The numbers \(0,1,2\) are represented respectively by

- \(\varnothing\),
- \(\{1\}\),
- \(\{2\}\).

Thus the claim holds with at most \(1=2-1\) divisor.

### Inductive step

Assume the claim for \(n-1\), where \(n\ge3\). Let
\[
0\le m\le n!.
\]
Write the Euclidean division
\[
m=nq+r,\qquad 0\le r<n.
\]
Since \(m\le n(n-1)!\), we have
\[
q\le (n-1)!.
\]

By the induction hypothesis there is a set \(D\) of distinct divisors of \((n-1)!\) with
\[
q=\sum_{d\in D}d,
\qquad |D|\le n-2.
\]
This includes the case \(q=0\), where we take \(D=\varnothing\).

Define
\[
nD:=\{nd:d\in D\}.
\]
For each \(d\in D\), since \(d\mid(n-1)!\), we have
\[
nd\mid n(n-1)!=n!,
\]
so every element of \(nD\) is a divisor of \(n!\). Multiplication by the positive integer \(n\) is injective, so the elements of \(nD\) remain distinct, and
\[
\sum_{x\in nD}x=nq.
\]

If \(r=0\), take the divisor set \(nD\). Its cardinality is at most \(n-2<n-1\), and its sum is \(m\).

If \(r>0\), then
\[
1\le r<n,
\]
so \(r\mid n!\). Moreover every element of \(nD\) is divisible by \(n\), whereas \(0<r<n\). Hence
\[
 r\notin nD.
\]
Therefore
\[
 nD\cup\{r\}
\]
is a set of distinct divisors of \(n!\), and
\[
\sum_{x\in nD\cup\{r\}}x=nq+r=m.
\]
Its cardinality is at most
\[
(n-2)+1=n-1.
\]

This completes the induction.

### Independent critical audit

1. **Domain:** the induction has been strengthened to include \(m=0\), closing the \(q=0\) boundary case.
2. **Quotient bound:** from \(m\le n! = n(n-1)!\), \(q=\lfloor m/n\rfloor\le(n-1)!\).
3. **Divisor scaling:** \(d\mid(n-1)!\Rightarrow nd\mid n!\).
4. **Distinctness:** \(d\mapsto nd\) is injective because \(n>0\).
5. **Remainder divisor:** \(1\le r<n\Rightarrow r\mid n!\).
6. **Disjointness:** every scaled divisor is a multiple of \(n\), while \(0<r<n\).
7. **Sum preservation:** the scaled set sums to \(nq\); adjoining \(r\) gives \(nq+r=m\).
8. **Cardinality:** at most \(n-2\) terms when \(r=0\), and at most \(n-1\) terms when \(r>0\).
9. **Base case:** checked directly for \(n=2\).

No use was made of the historical/reference proof in constructing this argument.

## Freeze status

**FROZEN — candidate proof accepted for comparison.**

The next phase is deliberately separate: retrieve the historical/reference proof and compare it against this independently constructed argument. The comparison must not retroactively alter the frozen proof.
