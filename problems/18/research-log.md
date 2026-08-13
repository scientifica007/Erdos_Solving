# Research Log — Erdős Problem #18

## Attempt 1 — Recursive factorial decomposition

### Target

Show the stronger statement
\[
 h(n!)\le n-1 \qquad(n\ge2).
\]

This immediately implies Erdős's bound \(h(n!)<n\).

### Key construction

Take any \(r\) with
\[
1\le r\le n!.
\]
Write
\[
r=nq+s,\qquad 0\le s<n.
\]
Then
\[
q\le (n-1)!
\]
because \(r\le n!\).

Assume inductively that every integer up to \((n-1)!\) is a sum of at most \(n-2\) distinct divisors of \((n-1)!
\). Let \(D\) be such a divisor set for \(q\).

For every \(d\in D\), the integer \(nd\) divides
\[
n(n-1)!=n!.
\]
Thus the scaled set
\[
nD:=\{nd:d\in D\}
\]
consists of distinct divisors of \(n!\), and its sum is \(nq\).

If \(s=0\), this already represents \(r\) using at most \(n-2\) divisors.

If \(s>0\), then \(s<n\), hence \(s\mid n!\). Moreover no element of \(nD\) equals \(s\): every element of \(nD\) is divisible by \(n\), while \(0<s<n\). Therefore
\[
 nD\cup\{s\}
\]
is a set of distinct divisors of \(n!\), with sum
\[
 nq+s=r,
\]
and cardinality at most
\[
(n-2)+1=n-1.
\]

### Base case

For \(n=2\), the divisors of \(2!=2\) are \(1,2\), and both integers \(1,2\) require only one divisor. Hence
\[
 h(2!)=1=2-1.
\]

### Candidate conclusion

The induction gives
\[
 h(n!)\le n-1
\]
for every \(n\ge2\), hence
\[
 h(n!)<n.
\]

### Gap audit

- Quotient bound: verified from \(r\le n!\).
- Scaled divisors remain divisors of \(n!\): verified.
- Scaling preserves distinctness: verified because multiplication by positive \(n\) is injective.
- Remainder is a divisor of \(n!\): verified since \(1\le s<n\).
- Remainder is disjoint from scaled divisors: verified by divisibility and \(0<s<n\).
- Number of summands: at most \(n-1\).
- Base case: verified directly.

## Freeze status

NOT YET FROZEN. The argument is currently a candidate proof and must receive a second independent critical pass before any comparison with the historical/reference proof.
