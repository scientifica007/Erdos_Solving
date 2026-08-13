# Erdős #214 — Complete Methodological Postmortem

## Final status

- Initial blind attempt: FAILED.
- Candidate proof: RETRACTED.
- First audit: FAILED.
- Proof freeze: REVOKED.
- Blind restart: INCOMPLETE.
- Later blind phase: TERMINATED after external-context contamination.
- Final classification: `INCONCLUSIVE / CONTAMINATED`.

## 1. Geometry is not monochromaticity

The first candidate correctly constructed a unit square, but one vertex was the distinguished point `p ∈ S`. Thus the square had a mixed colour pattern and was not a red square.

**Rule:** whenever a proof claims a configuration is monochromatic, audit the colour/state of every constituent explicitly. Metric or incidence correctness is insufficient.

## 2. A correct local construction can support a false implication

The invalid step was effectively: three constructed vertices are outside `S`, therefore the fourth is also outside `S`. The fourth was actually `p ∈ S`.

**Rule:** audit each logical implication separately from the geometric construction that precedes it.

## 3. The first audit itself was inadequate

The audit checked distances, square geometry, and special cases but failed to check the colour pattern. The candidate was therefore incorrectly marked frozen.

**Rule:** adversarial audit must try to falsify semantic invariants, not only verify algebraic/geometric subclaims.

## 4. Correct local invariant for a unit square

Assuming there is no red unit square, every unit square contains at least one blue vertex. It cannot contain three or four blue vertices because among any three square vertices two are adjacent at distance `1`. If it contains two blue vertices, they must be opposite diagonally.

Therefore the valid pattern is:

- one blue vertex, or
- two opposite blue vertices.

The earlier statement “exactly one blue vertex” was false and was explicitly corrected.

## 5. Valid propagation rules were obtained

Two reliable local rules survived audit:

1. If `p` is blue, every point at distance `1` from `p` is red.
2. If a unit edge has red endpoints, then the opposite edge of either adjacent unit square has endpoints of opposite colours.

These rules did not by themselves produce a global contradiction.

## 6. Finite searches were exploratory only

Axis-aligned grids, rotated grids, translated grid unions, randomized two-grid unions, and square-completion closures remained finitely satisfiable in the tested ranges.

This does **not** establish a global colouring and does **not** prove that no finite obstruction exists elsewhere.

**Rule:** finite satisfiability is evidence about a tested family, not a theorem about the entire geometric problem.

## 7. Stop expanding a low-yield configuration family

After repeated satisfiable instances from regular and nearly regular lattices, increasing size was no longer the most informative action.

**Rule:** record diminishing returns and change mathematical representation rather than only enlarging the same family.

## 8. Invariant claims need minimal-counterconfiguration tests

The incorrect “exactly one blue per square” claim could have been rejected immediately by considering two opposite diagonal vertices.

**Rule:** every newly claimed invariant must be tested against the smallest plausible counterconfiguration before being promoted to an established lemma.

## 9. Local propagation, finite obstruction, and global theorem are different proof levels

#214 repeatedly moved between these levels too quickly. A valid propagation rule is not a finite obstruction; a finite obstruction is not automatically a global theorem unless the configuration is embedded correctly; and the absence of a small obstruction is not evidence of global colourability.

**Rule:** label every research result explicitly as `local lemma`, `finite CSP`, `obstruction`, or `global theorem`.

## 10. Blind-mode contamination terminates the experiment

During the later investigation, an external web search for a general Euclidean-Ramsey theorem exposed target-specific information about #214, including the historical stronger result. At that moment the experiment ceased to be blind.

The correct classification is therefore:

`INCONCLUSIVE / CONTAMINATED`.

It must not be retrospectively described as an independent blind discovery.

## 11. External web search must be prohibited during blind mode

The #214 contamination demonstrates that even a seemingly generic theorem search can reveal the target author, theorem class, stronger result, or proof architecture.

**Hard rule:** before proof freeze, blind solving must not use external web search, historical papers, target discussions, or target-specific external material that could reveal the solution architecture.

General theorem lookup is deferred until after freeze, or must rely only on information already known before the benchmark began.

## 12. Restart chronology must remain separate

The restart was useful because it corrected the first proof's failure mode without rewriting history. The original invalid candidate remains retrievable from Git history, while restart notes form a separate chronological record.

**Rule:** never overwrite a failed attempt with hindsight. Retract it and start a new attempt record.

## 13. Freeze is a mathematical gate, not a file label

The first incorrect freeze proved that a Git flag cannot substitute for mathematical validation.

A proof may be declared frozen only after a successful adversarial audit covering all relevant semantic, logical, geometric, algebraic, domain, and colour constraints.

## 14. Required specialized audit checklist for coloring/Ramsey proofs

Before freeze, explicitly verify:

- every vertex/constituent has the claimed colour;
- “outside `S`” really means the target colour;
- no mixed-colour constituent has been overlooked;
- all forbidden same-colour distances are checked;
- the target is exactly a copy, congruent copy, homothetic copy, or whatever notion is required;
- quantifiers and domains are preserved;
- all propagation directions are justified;
- finite computations are not being promoted to global claims.

## 15. What #214 changed in the project

The benchmark did not produce an independent proof. Its value is methodological:

`invalid candidate → inadequate audit → explicit retraction → corrected restart invariants → low-yield finite search → external-context contamination → blind termination`.

This sequence should be treated as a canonical failure-mode example for future benchmarks.
