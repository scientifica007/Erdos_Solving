# Shared Fact Base for the Two Erdős #678 Papers

This file defines facts that should remain synchronized across both planned manuscripts. It is not a manuscript draft. Paper-specific interpretation belongs in the respective claim allowlists and paper scaffolds.

## Mathematical identity

- Problem: Erdős Problem #678.
- Canonical repository definition: `M(n,k) = lcm{n+1,...,n+k}`.
- Successful mathematical source: Stijn Cambie (2024).
- The successful project route is an external-proof reconstruction.
- The project does not claim a new mathematical solution or new independent mathematical proof.

## Formalization identity

- Project artifact: independent Lean reimplementation.
- Prior public formal artifact recorded by the project: Aristotle/Boris Alexeev in `plby/lean-proofs` at the pinned comparator commit.
- First-formalization claim: false.
- Canonical internal endpoints:
  - `erdos678_unbounded_witnesses`;
  - `erdos678_good_lengths_infinite`.
- Public-facing bridge endpoints include:
  - `erdos678_formalConjectures_eventual_nonempty`;
  - `cambie_lcm_ratio_eventually_with_large_start_real`.

## Environment identity

- Lean: `leanprover/lean4:v4.33.0`.
- Mathlib resolved: `db584cd6d46c92f209a44c0f1c829460d327499d`.
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.
- Canonical checks:
  - `lake exe mk_all --check`;
  - `lake build Formalization`.
- Closed scientific-evaluation reference graph: 8808 jobs (historical metadata, not a strict invariant for future exact-commit reproductions).

## Statement-fidelity identity

The internal length-based interval API is formally bridged to the public `Finset.Ioc` convention. Index translation from Cambie's interval starts to benchmark variables is part of the proof layer and must not be treated as cosmetic notation.

## Concrete semantic identity

- Positive regression: `erdosM 36 8 > erdosM 47 9`.
- Negative regression: `¬ (erdosM 495 8 > erdosM 504 9)`.
- The finite positive witness is not the infinitude mechanism.

## S1 identity

A pinned common-environment differential verification against the Aristotle/Boris Alexeev artifact was completed and closure-verified. This supports controlled statement/formal-artifact comparison, not mathematical novelty or proof genealogy.

## S2 identity

- S2a: dependency-surface metrics are ownership/boundary sensitive.
- S2b: six credited paired replicates show no stable wall-clock winner; CPU/memory profiles differ materially under the pinned environment.
- S2c: repair locality is mixed/interface-dependent; no uniform winner.
- S2d: all six credited frozen semantic/index perturbation observations were rejected; zero survivors and zero proof repairs.
- S2e: U1 stopped at Mathlib/transitive dependency support after D1; U2 stopped at package resolution after D0; neither reached an eligible project-owned repair surface.

All S2 conclusions are bounded to their frozen protocols and environments.

## Scientific-credit identity

The project records multiple cases in which computationally successful output was excluded from scientific credit because predeclared provenance, classifier, aggregation, or apparatus requirements were not met.

Therefore both papers must preserve the distinction:

`computational success ≠ scientific admissibility ≠ unrestricted inference`.

## Paper separation

### Paper 1

Primary scientific object: the formal proof artifact and its verification/evaluation.

Core topics:

- independent Lean reconstruction;
- statement fidelity;
- proof architecture;
- differential verification;
- exact-head/exact-main verification credit;
- bounded S1/S2 proof-engineering evaluation;
- reproducibility.

### Paper 2

Primary scientific object: the long-horizon AI-assisted scientific workflow.

Core topics:

- failed independent trajectory and explicit mode change;
- negative knowledge retention;
- state synchronization;
- producer/consumer interfaces;
- provenance and scientific-credit controls;
- prospective experiment freezing;
- exclusions/corrections;
- failure ownership;
- publication-narrative synchronization.

## Shared forbidden claims

Neither paper may claim, without new external evidence:

- a new solution of #678;
- a new independent mathematical proof;
- the first Lean formalization;
- general architecture superiority;
- universal speed advantage;
- general maintainability superiority;
- general semantic-robustness superiority;
- general Lean/Mathlib compatibility or incompatibility;
- autonomous AI authorship percentage.

The machine-readable authority for manuscript claim use is `../CLAIM_EVIDENCE_MATRIX.json` together with the paper-specific claim allowlists.
