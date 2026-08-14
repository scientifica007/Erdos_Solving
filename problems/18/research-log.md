# Research Log — Erdős Problem #18

> **CURRENT REPOSITORY STATUS — COMPLETED SUB-RESULT CHECKPOINT / NO ACTIVE ATTEMPT.** The proof below concerns a known lemma only. It must not be presented as progress on the open asymptotic questions without new evidence.

## Critical correction: target was misclassified

The first version of this experiment incorrectly treated the known inequality
\[
h(n!)<n
\]
as though it were the solution of Erdős Problem #18. That is incorrect.

The **full Problem #18 remains OPEN** and currently carries a **$250 prize**. The official problem asks asymptotically stronger questions about \(h(m)\) for practical numbers and about \(h(n!)\), namely whether
\[
h(m)<(\log\log m)^{O(1)}
\]
for infinitely many practical \(m\), whether
\[
h(n!)=n^{o(1)},
\]
and even whether
\[
h(n!)=(\log n)^{O(1)}.
\]
The official site explicitly distinguishes Erdős's known bound \(h(n!)<n\) from these open questions.

## What our independent attempt actually established

We independently reconstructed the known sub-result in the stronger form
\[
 h(n!)\le n-1 \qquad(n\ge2).
\]

This is a useful validation experiment for the research workflow, but **it is not a solution of Problem #18**.

### Normalized inductive claim

For every \(n\ge2\) and every integer \(m\) with \(0\le m\le n!\), there exists a set \(D\) of distinct divisors of \(n!\) such that \(|D|\le n-1\) and
\[
m=\sum_{d\in D}d.
\]

For \(m=0\), take \(D=\varnothing\).

### Base case

For \(n=2\), the divisors of \(2!=2\) are \(1,2\). The numbers \(0,1,2\) are represented by \(\varnothing\), \(\{1\}\), and \(\{2\}\), respectively. Hence at most \(1=2-1\) divisor is required.

### Inductive step

Assume the claim for \(n-1\), where \(n\ge3\). Let
\[
0\le m\le n!.
\]
Write
\[
m=nq+r,\qquad 0\le r<n.
\]
Since \(m\le n(n-1)!\), we have
\[
q\le(n-1)!.
\]

By induction, represent \(q\) as a sum of at most \(n-2\) distinct divisors \(D\) of \((n-1)!\). Scale them by \(n\):
\[
nD=\{nd:d\in D\}.
\]
Every \(nd\) divides \(n!\), the scaled elements remain distinct, and their sum is \(nq\).

If \(r=0\), this already gives a representation of \(m\) with at most \(n-2\) divisors.

If \(r>0\), then \(1\le r<n\), hence \(r\mid n!\). Every element of \(nD\) is divisible by \(n\), while \(0<r<n\), so \(r\notin nD\). Therefore
\[
nD\cup\{r\}
\]
is a distinct divisor set of \(n!\) summing to \(m\), with at most \(n-1\) elements.

Thus
\[
 h(n!)\le n-1<n.
\]

## Independent critical audit

1. The induction includes \(m=0\), so the quotient-zero boundary case is covered.
2. \(q\le(n-1)!\) follows directly from \(m\le n!\).
3. \(d\mid(n-1)!\Rightarrow nd\mid n!\).
4. Multiplication by positive \(n\) is injective, so distinctness is preserved.
5. \(1\le r<n\Rightarrow r\mid n!\).
6. The remainder is disjoint from the scaled divisor set.
7. The sum is preserved exactly.
8. The number of summands is at most \(n-1\).
9. The base case is explicit.

## Historical-source search

The original source [Er81h, p.172] records that Erdős “easily observed” \(h(n!)<n\). This confirms that the inequality is an established sub-result, not the solution of Problem #18.

The earlier American Mathematical Monthly reference, **58 (1951), 496–497**, concerns a different older Monthly problem and is not the proof of the present Problem #18.

## Research status

**Known sub-result independently reconstructed.**

**Problem #18 itself remains OPEN.**

Any future claim concerning the actual open questions must be evaluated independently and must not be conflated with the known inequality \(h(n!)<n\).
