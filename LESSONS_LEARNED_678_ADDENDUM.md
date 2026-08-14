# Project-Level Addendum — Erdős #678

## Purpose

This addendum records the lessons learned from the third benchmark experiment on Erdős Problem #678, including the transition from informal proof reconstruction to Lean/Mathlib machine checking and the failure of the proposed infinitude construction.

## L-678-005 — Separate infrastructure validation from mathematical validation

A successful Lean/Lake/Mathlib CI run proves that the formalization environment and the submitted Lean statements type-check. It does **not** prove that the mathematical strategy behind those statements is correct.

Protocol:

1. Validate the CI infrastructure with a minimal machine-checkable statement.
2. Validate a complete concrete mathematical witness.
3. Only then formalize general lemmas and the infinitude mechanism.

The first CI test used only elementary admissibility inequalities. This was intentionally classified as an infrastructure/sanity test, not as a proof of #678.

## L-678-006 — A concrete witness must verify the actual definition, not only the parameters

The candidate `(n,m,k) = (495,504,8)` was initially accepted because it satisfies the side conditions

`k >= 3` and `m >= n+k`.

That is insufficient. The defining inequality must also be checked:

`M(n,k) > M(m,k+1)`.

Direct computation instead gives

`M(495,8) < M(504,9)`.

Therefore `(495,504,8)` is a false witness and must never be used as evidence for the theorem.

A correct concrete witness used for the machine-checkable test is

`(n,m,k) = (36,47,8)`,

which satisfies the side condition and the required LCM inequality.

## L-678-007 — Interval endpoints are part of the mathematics

The decisive failure in the proposed `Q=P/M` construction was an off-by-one error in the interval corresponding to `M(t,k+1)`.

By definition,

`M(t,k+1) = lcm(t+1, ..., t+k+1)`.

The failed argument treated the relevant interval as

`[t, t+k]`,

which is instead the interval associated with a different quantity.

Consequently the claimed identity

`Q(t,k+1) / Q(t-k-1,k) = L_k`

was not established for the actual problem. The error occurs before the final product comparison, so the resulting infinitude argument is invalid.

Protocol rule:

> Whenever an argument compares indexed products, LCMs, gcds, sums, or sets, expand both definitions explicitly and write their exact index intervals before simplifying.

This is now a mandatory interval-audit step for #678 and analogous problems.

## L-678-008 — Do not rescue a proof by preserving its conclusion

Once a candidate construction fails a concrete Lean computation, the correct action is to invalidate the construction, not to modify isolated inequalities until the desired conclusion reappears.

For #678, the correct response to the failed `(495,504,8)` witness was:

`candidate -> exact computation -> rejection -> identify root cause -> document lesson`.

This prevents confirmation bias and keeps the research record auditable.

## L-678-009 — Use negative machine tests as regression tests

The formalization should contain both:

- a positive test for a known valid witness;
- a negative test for a previously proposed but false witness.

The negative test is valuable because it prevents accidental reintroduction of the invalid construction during later refactoring.

For this experiment:

- positive: `(36,47,8)`;
- negative: `(495,504,8)`.

## L-678-010 — Cloud CI is preferable when local Mathlib builds are operationally unsafe

The local environment showed severe I/O pressure during Lean/Mathlib processing and expanded `.lake` to several gigabytes. The project therefore moved machine verification to GitHub Actions.

The resulting architecture is:

`edit -> commit/push -> GitHub Actions -> Lean + Mathlib -> PASS/FAIL`.

The local machine is no longer required to perform the expensive Mathlib build merely to validate a proof candidate.

This does not eliminate the need for local testing when convenient; it establishes cloud CI as the authoritative reproducible check for the repository.

## L-678-011 — A single finite witness does not imply infinitude

The experiment reinforces the project-level infinitude audit rule:

1. `Witness`: prove at least one valid triple.
2. `Generator`: prove a transformation or parameter family producing valid triples.
3. `Distinctness`: prove infinitely many generated triples are distinct.
4. `Domain preservation`: prove every generated triple satisfies all side conditions.

A successful witness test establishes only layer 1.

The failed `t`-construction demonstrates why layers 2–4 must be independently audited.

## L-678-012 — Formalization should follow mathematical stabilization

Do not spend large computational effort formalizing a construction that has not survived exact finite checks.

Recommended order for future #678 attempts:

`paper derivation -> exact small cases -> concrete witness -> transformation check -> infinitude proof -> Lean formalization`.

Lean should be used early enough to catch definitional mistakes, but not as a substitute for checking whether the proposed mathematical mechanism is actually coherent.

## L-678-013 — Benchmark status after this experiment

At the end of this experiment:

- Lean 4.33 + Lake + Mathlib CI: **working**.
- Positive concrete witness `(36,47,8)`: **machine-checked**.
- Proposed witness `(495,504,8)`: **machine-refuted**.
- `Q=P/M` infinitude construction based on the `[t,t+k]` interval: **rejected**.
- General infinitude theorem for #678: **not established by our independent construction**.

The correct research status is therefore **OPEN FOR OUR RECONSTRUCTION**, regardless of any external status of the problem. An externally known proof must be treated as a separate source and independently understood before incorporation.

## L-678-014 — External formalization is a reference, not a substitute for understanding

Once an external Lean formalization or published proof is discovered, it may be used as a reference for locating the missing mathematical mechanism. It must not be silently copied into the project's independent proof record.

For future work, distinguish explicitly between:

- `independent discovery`;
- `external proof reconstruction`;
- `formal verification of an external proof`;
- `independent formal proof`.

These are different research achievements and must receive different labels in the project state.

## Updated protocol for future benchmarks

Before declaring a proposed solution successful:

- [ ] Exact statement copied from the authoritative source.
- [ ] Definitions expanded with exact index ranges.
- [ ] At least one concrete witness verified directly.
- [ ] Any proposed infinitude map checked symbolically and numerically.
- [ ] Generated instances shown distinct.
- [ ] Domain constraints preserved.
- [ ] Negative tests added for rejected constructions.
- [ ] Lean CI passes on the concrete mathematical claim.
- [ ] Only after all of the above: formalize the general theorem.
