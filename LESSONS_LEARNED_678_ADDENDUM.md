# Project-Level Addendum — Erdős #678

## New protocol rule: Infinitude Mechanism Audit

A proof claiming infinitely many solutions must be decomposed into two independently audited layers:

1. **Witness layer:** establish at least one valid instance.
2. **Infinitude layer:** prove a transformation, induction, parameter family, or other mechanism that generates infinitely many valid instances.

Passing the first layer does not provide evidence for the second.

## L-678-001 — Never assume scaling symmetry

For a quantity `Q(x)` involving an operator on an indexed set, scaling the symbolic variables does not imply `Q(tx)=tQ(x)`. The exact input set of the operator must be transformed and compared.

For LCM intervals,

`M(tn,k) = lcm(tn+1,...,tn+k)`

is not `t M(n,k)`, because `t M(n,k)` is the LCM of `t(n+1),...,t(n+k)`.

## L-678-002 — Check the transformation against the exact statement

For an infinitude map `T`, audit separately:

- all domain constraints;
- the defining quantities;
- the inequality or equation;
- strictness/non-strictness;
- distinctness of generated instances.

## L-678-003 — Numerical correctness does not validate the proof mechanism

A proposed proof may contain a correct example and still be invalid because the step that generalizes that example is false.

## L-678-004 — Tag false symmetry assumptions explicitly

Add `false-symmetry` or `scaling-symmetry-unverified` to research logs when a proof attempts to generalize by symmetry. Require a direct substitution check before the step can enter a candidate proof.
