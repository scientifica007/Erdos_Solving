# Erdős Problem #678 — Experiment Postmortem

## Experiment classification

- Blind proof attempt: INVALIDATED
- Candidate argument: numerically correct example, globally invalid extension
- Reference research: consulted only after the flaw was identified
- Final status: lesson-bearing failure

## Canonical statement

Let `M(n,k) = lcm{n+1,...,n+k}`. Are there infinitely many `m,n,k>=3` with `m>=n+k` such that `M(n,k) > M(m,k+1)`?

## What we found before reference access

A concrete inequality was found:

`M(36,8) > M(47,9)`.

The numerical comparison itself is correct.

The attempted infinitude argument then asserted the scaling identity

`M(tn,k) = t M(n,k)`

and similarly for `M(tm,k+1)`.

This identity is false because

`M(tn,k) = lcm(tn+1,...,tn+k)`,

whereas

`t M(n,k) = lcm(t(n+1),...,t(n+k))`.

The intervals being lcm'd are different.

Therefore the argument proving infinitely many solutions was invalid even though its starting example was valid.

## Audit lesson

A valid witness does not validate an extension mechanism. Whenever a proof turns one example into infinitely many examples, the proposed symmetry/induction/translation/scaling map must be checked by direct substitution into the exact statement.

In particular, for a claimed transformation `T` one must verify:

1. `T` maps admissible tuples to admissible tuples;
2. every domain constraint is preserved (`k>=3`, `m>=n+k`, etc.);
3. each defined quantity transforms according to the claimed identity;
4. the strict inequality is preserved;
5. the transformed instances are genuinely distinct.

## Reusable rule — No assumed scaling symmetry

Do not infer homogeneity merely because an expression contains an LCM, product, norm, determinant, or another apparently scale-sensitive operation. Check the actual arguments of the operator after scaling.

The correct question is not:

`"Does the quantity look homogeneous?"`

but:

`"After the proposed transformation, is the exact input set to the operator the transformed version of the original input set?"`

## Deeper lesson — Example vs. infinite family

For existence-of-infinitely-many problems, separate the proof into two explicit layers:

`Layer A: existence of one witness`

`Layer B: a valid infinitude mechanism`

A proof may pass Layer A and completely fail Layer B.

## Reference comparison

After the invalid scaling step was isolated, the historical literature was consulted. The known result is much stronger than the single witness: Cambie (2024) proves that for sufficiently large `k` one can make the ratio between the two relevant LCMs arbitrarily large. Historical examples include

`M(96,7) > M(104,8)`

and

`M(132,7) > M(139,8)`.

The published result therefore requires genuine number-theoretic structure; simple scaling of one witness is not the mechanism.

## Protocol update

For any benchmark asking for infinitely many objects, add an explicit `Infinitude Mechanism Audit` before accepting a proof:

- witness verified independently;
- infinitude map identified;
- map checked against the exact statement;
- preservation identities proved, not guessed;
- distinctness verified.
