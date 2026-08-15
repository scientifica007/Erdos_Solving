# Project-Level Addendum — Erdős #678

## Purpose

This addendum records lessons learned from the Erdős Problem #678 benchmark, including the failed independent infinitude construction, the transition to Cambie-proof reconstruction, and the subsequent Lean formalization consolidation.

## L-678-005 — Separate infrastructure validation from mathematical validation

A successful Lean/Lake/Mathlib CI run proves that the submitted Lean statements type-check. It does **not** prove a stronger mathematical strategy that was not encoded.

Protocol:

1. Validate CI infrastructure.
2. Validate a complete concrete mathematical witness.
3. Only then formalize general lemmas and an infinitude mechanism.

## L-678-006 — A concrete witness must verify the actual definition, not only the parameters

The candidate `(n,m,k) = (495,504,8)` satisfied side conditions but failed the defining inequality. Therefore side-condition success can never substitute for direct evaluation of the target expression.

The retained positive witness is `(36,47,8)`; the rejected `(495,504,8)` case is retained as a negative regression.

## L-678-007 — Interval endpoints are part of the mathematics

The decisive failure in the proposed `Q=P/M` construction was an off-by-one error:

`M(t,k+1) = lcm(t+1,...,t+k+1)`,

not the LCM of `[t,t+k]`.

Protocol rule:

> Whenever an argument compares indexed products, LCMs, gcds, sums, or sets, expand the exact index ranges before simplifying.

## L-678-008 — Do not rescue a proof by preserving its conclusion

Once a construction fails an exact finite computation, invalidate the construction first. Do not alter isolated inequalities merely to recover the desired conclusion.

Correct workflow:

`candidate -> exact computation -> rejection -> root cause -> documented lesson`.

## L-678-009 — Use negative machine tests as regression tests

A rejected construction can still contribute permanent value. Keep both:

- positive regression: `(36,47,8)`;
- negative regression: `(495,504,8)`.

This prevents later refactors from accidentally reintroducing a known false construction.

## L-678-010 — Cloud CI is preferable when local Mathlib builds are operationally unsafe

The project uses GitHub Actions as the authoritative reproducible Lean check. The workflow is conceptually:

`edit -> commit/push -> GitHub Actions -> Lean + Mathlib -> PASS/FAIL`.

Local testing remains optional when convenient; it is not the authoritative gate.

## L-678-011 — A single finite witness does not imply infinitude

For an infinitude claim audit four separate layers:

1. `Witness`.
2. `Generator` or parameter family.
3. `Distinctness`.
4. `Domain preservation`.

Passing layer 1 says nothing by itself about layers 2–4.

## L-678-012 — Formalization should follow mathematical stabilization

Lean should be used early enough to expose definitional mistakes, but expensive formalization should not proceed far on a construction that has not survived exact finite checks.

## L-678-013 — Correct benchmark classification

Current classification:

- external #678 status: **proved**;
- our independent attempt: **rejected**;
- current work: **external-proof reconstruction / independent Lean reimplementation**;
- full Claim 5 in this repository: **machine-checked under explicit residue hypotheses**;
- full #678 theorem in this repository: **not yet formalized**.

These labels must not be collapsed into “solved by us”.

## L-678-014 — External formalization is a reference, not a substitute for understanding

Distinguish explicitly:

- `independent discovery`;
- `external proof reconstruction`;
- `formal verification of an external proof`;
- `independent formal proof`.

They are different research achievements.

## L-678-015 — Encode interval length, not an ambiguous endpoint offset

The consolidation replaced the earlier interval abstraction with a canonical API whose second argument is a **length**:

`intervalFinset(start,len) = {start,...,start+len-1}`.

Then

`erdosM(n,k) = intervalLCM(n+1,k)`

contains exactly `k` terms by construction.

This is not cosmetic API design. It removes the exact ambiguity that caused the earlier proof failure.

Reusable rule:

> When an indexing convention has already produced an off-by-one mathematical error, redesign the formal interface so that the intended cardinality is explicit.

## L-678-016 — A live Lean module must be reachable from the canonical build graph

The earlier workflow manually enumerated Lean files. That allowed a dangerous state: a newly created file could fail while CI stayed green simply because the workflow did not list it.

The consolidated architecture imports every live #678 module through the canonical `Formalization.lean` dependency graph, and GitHub Actions runs `lake build` as the authoritative check.

Reusable rule:

> A Lean file is not integrated merely because it exists in the repository. It is live only when the canonical build graph reaches it and CI checks it automatically.

## L-678-017 — Prefer kernel-checked closed regressions when practical

The first consolidated closed examples used `native_decide`. Mathlib's linter correctly noted that `native_decide` expands the trusted computing base to the compiler.

For these finite regression cases, ordinary `decide` was practical, so the live tree was changed to use it. A repository-wide check then confirmed there was no remaining `native_decide`.

This does not make `native_decide` universally forbidden; it establishes a preference for the smaller trust base when computationally feasible.

## L-678-018 — Inspect the actual Mathlib API before repairing proof scripts

During finite-product valuation formalization, guessed API usage failed:

- `Finset.prod_ne_zero` did not exist in the current Mathlib interface;
- the actual useful theorem was `Finset.prod_ne_zero_iff`;
- direct `rw` on a pretty-printed product expression was brittle because elaboration had changed its syntactic shape.

The successful repair inspected the Mathlib source and rewrote the proof as a structured `calc` chain that retained `s.prod id` explicitly.

Reusable rule:

> On an API or elaboration failure, inspect the library theorem and reformulate around its actual statement rather than stacking speculative rewrites.

## L-678-019 — Consolidation gates are mathematical risk controls

The formalization consolidation was not merely repository housekeeping. It established all of the following before further Claim 5 work:

- one authoritative operational state;
- one canonical roadmap;
- a length-safe interval model;
- explicit abstraction-vs-oracle regression checks;
- a clean production Lean tree;
- a canonical Lake build graph;
- a machine-checked finite-product valuation theorem;
- green CI;
- no repository occurrences of `sorry`, `axiom`, or `native_decide` at the gate checkpoint.

GitHub Actions run `31827146122` is the green machine-check checkpoint for this consolidation.

## Updated protocol for future benchmarks

Before declaring a proposed solution successful:

- [ ] Exact statement copied from the authoritative source.
- [ ] Definitions expanded with exact index ranges.
- [ ] At least one concrete witness verified directly.
- [ ] Any proposed infinitude map checked symbolically and numerically.
- [ ] Generated instances shown distinct.
- [ ] Domain constraints preserved.
- [ ] Negative tests added for rejected constructions.
- [ ] All live Lean files are reachable from the canonical build graph.
- [ ] Lean CI passes on the exact mathematical claims being credited.
- [ ] No hidden `sorry` or undeclared axiom is used in the claimed core.
- [ ] Only after all of the above: credit the exact level of mathematical/formal achievement reached.

## L-678-020 — State drift is a verification failure

After the medium-prime range was completed, implementation advanced into the small-prime range while `README.md`, `PROJECT_STATE.md`, and the canonical roadmap continued to report older phases and green CI. The canonical head later became red after importing the small-prime Claim 5 graph.

A correct theorem file cannot compensate for an incorrect operational checkpoint. State drift can cause a later agent to skip the actual blocker, credit an unchecked theorem, or continue from the wrong phase.

Protocol rule:

> A phase transition is not complete until code, CI, `PROJECT_STATE.md`, the active roadmap, and every current-status README agree.

Historical documents retain their original chronology, but any embedded status superseded by later work must be labeled explicitly.

## L-678-021 — A repaired blocker can expose a masked blocker

The first live small-prime run named failures in `SmallPrimeWindows.lean` and `SmallPrimeValuation.lean`. After both were repaired, the graph reached `SmallPrimeSup.lean` and exposed an unresolved summand metavariable.

Reusable rule:

> Never infer that the first red run lists every integration defect. Rebuild the entire reachable graph and credit completion only when the terminal module is reached.

## L-678-022 — Import-graph completeness must be executable policy

The project had already declared that every Lean file must be reachable, but the aggregator remained hand-maintained. Enabling `lake exe mk_all --check` immediately rejected that mismatch and forced `Formalization.lean` to equal the generated canonical import list.

Reusable rule:

> “Every file is imported” must be checked by CI, not remembered by an agent or inferred from a directory listing.

## L-678-023 — Regressions should exercise theorem interfaces

Direct `decide` evaluation of concrete `padicValNat` expressions did not reduce and consumed substantial CI time before failing. Concrete instantiations of `claim5_small_prime_range` instead checked the theorem interface, the exponent boundaries `e = 1` and `e = 0`, and all required hypotheses. A separate negative test records failure of the deliberately violated congruence.

Reusable rule:

> When a definition is opaque or non-reducible, test the proved interface and discharge concrete hypotheses; do not force kernel reduction or enlarge the trusted computing base merely for convenience.



## L-678-024 — Separate a theorem consumer from its construction layer

The full Claim 5 assembly became short and auditable only after the residue data were named as two explicit interfaces. The assembly module consumes those interfaces, combines the three already verified prime ranges, proves the nonzero side conditions, and obtains natural-number equality from every prime valuation. It does not pretend to construct the residues supplied later by Claim 4 and CRT.

Reusable rule:

> When a proof has a construction layer and a consequence layer, formalize their interface first. Completing the consumer theorem under that exact interface is real progress, but it must not be credited as completing the producer.

## L-678-025 — Coverage and cardinality do not discharge the CRT producer

Cambie's Claim 4 starts from weighted combinations that cover every residue modulo the product of the coordinate primes. Because the coefficient domain and the residue space have the same finite cardinality, that coverage also yields uniqueness. It does not remove the need to prove that the concrete weights have the required coordinate behavior or that the coefficient vector representing one is a unit in every prime coordinate.

The Lean decomposition therefore separated three obligations:

1. a generic finite counting consumer;
2. modular injectivity under an explicit coprimality or nondivisibility premise;
3. a weighted representation contract that the actual CRT basis must produce.

The later `Claim4CRT.lean` layer now discharges the third obligation for the concrete pair and triple bases used by Cambie, including the unit/nondivisibility facts. The arbitrary-finite-family generalization remains outside the credited result.

Reusable rule:

> When a paper compresses a finite CRT argument into “coverage”, audit cardinality, uniqueness, coordinate congruences, and unit conditions separately. A conditional consumer theorem is progress, but it does not by itself constitute the producer proof.

## L-678-026 — Replace broad arithmetic automation with the exact order contradiction

An early green version closed the final strict-cardinality contradiction in `Claim4Density.lean` with `omega`. The theorem compiled, but that module took about 248 seconds in run `31851839365`. Replacing the tactic with the direct order proof

`exact (not_lt_of_ge hcard) hunion`

reduced the same module to about 56 seconds in run `31852630076`, without changing the statement or trusted assumptions.

Reusable rule:

> When the remaining goal is already a contradiction between a proved lower bound and a strict upper bound, apply the matching order lemma directly before invoking general arithmetic automation.

## L-678-027 — A successful build can still be a red CI run

Run `31853895481` passed the generated import-graph check, reached every new Claim 4 module, and printed `Build completed successfully (8735 jobs)`. GitHub nevertheless concluded the job with failure because the subsequent `.lake` cache archive exhausted the runner disk while diagnostic output was still being written.

The repair kept Mathlib's artifact cache but set the official `lean-action` input `use-github-cache: false`. Run `31854637490` then explicitly skipped both GitHub `.lake` cache restore and save, retained `mk_all --check` and the full build, and completed successfully.

Reusable rule:

> Credit CI by the job conclusion as well as the mathematical build log. When a post-build cache step exhausts a disposable runner, disable that redundant archive through the action's supported input before adding broad disk-deletion commands or weakening verification.

## L-678-028 — Prove CRT representations coordinatewise, then compose

For the pair basis, the weights are `q,p`; for the triple basis they are `q*r,p*r,p*q`. The robust Lean proof did not expand a global remainder equality. It proved that the intended coordinate contributes `z`, proved that every other coordinate vanishes, and combined the local congruences with `Nat.modEq_and_modEq_iff_modEq_mul`.

Run `31856460100` caught an important API-direction mistake: the theorem states the conjunction of local congruences **iff** the product-modulus congruence, so local-to-global composition uses `.mp`, not `.mpr`. The corrected pair proof passed in run `31856857400`; the nested triple composition passed in run `31857628246`.

Reusable rule:

> For CRT code, isolate the one-coordinate and off-coordinate congruences, audit the direction of the library equivalence, and compose only after every local obligation is explicit.

## L-678-029 — Test across the producer/consumer boundary

Testing only the inverse congruences would not establish that the new producer genuinely feeds the existing weighted-density consumer. The strengthened regression layer therefore includes:

- concrete pair and triple `Claim4WeightedRepresentation` instances;
- existence of bounded, nondivisible coordinate multipliers;
- a negative example falsifying the **complete** pair representation contract when one multiplier is divisible by its coordinate prime;
- direct instantiations of both pair and triple density endpoints with concrete primes and exclusion budgets.

Run `31858024749` checks this boundary in the canonical graph.

Reusable rule:

> When a conditional theorem gains a concrete producer, add at least one regression that invokes the final consumer without re-supplying the discharged contract, plus a negative regression at the full-contract level.
