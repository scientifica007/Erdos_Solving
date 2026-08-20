# Erdős #678 — Formalization Architecture and Dependencies

## Canonical source tree

The proof source is **not copied** into this reproducibility package. The canonical Lean tree remains:

`formalization/Formalization/Erdos678/`

The package validates declarations and test files in that tree.

## Environment pins

The executable repository state pins:

- Lean: `leanprover/lean4:v4.33.0`;
- Mathlib input: `v4.33.0`;
- Mathlib resolved commit: `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

These values are checked from `formalization/lean-toolchain` and `formalization/lake-manifest.json`, not merely copied from historical prose.

## Canonical commands

From `formalization/`:

```bash
lake exe mk_all --check
lake build Formalization
```

The first command verifies that the generated canonical import graph is synchronized. The second compiles the reachable project graph.

## Primary theorem endpoints

### Canonical benchmark

File: `formalization/Formalization/Erdos678/Erdos678Final.lean`

- `erdos678_unbounded_witnesses`
- `erdos678_good_lengths_infinite`

`erdos678_unbounded_witnesses` is the stronger operational endpoint: for every requested lower bound on `k`, it produces a valid triple above that bound.

### Public statement bridge

File: `formalization/Formalization/Erdos678/ExternalStatementBridge.lean`

- `erdosM_eq_Ioc_lcm`
- `erdos678_formalConjectures_eventual_nonempty`
- `erdos678_valid_pair_lengths_unbounded`
- `erdos678_valid_pair_good_lengths_infinite`
- `cambie_lcm_ratio_eventually_with_large_start_real`

These declarations connect the internal interval API to public `Finset.Ioc` semantics and lift the strong natural multiplicative factor to the public real-factor convention.

## Reachable regression files

The package requires:

- `ConcreteTests.lean` — explicit arithmetic oracle plus positive/negative regressions;
- `Erdos678FinalTests.lean` — final unbounded/infinite endpoint regressions;
- `ExternalStatementBridgeTests.lean` — statement-equivalence regressions and axiom-print endpoints.

## Proof dependency layers

The closed roadmap can be read as the following architecture:

1. interval/product/LCM primitives;
2. valuation and reciprocal-LCM arithmetic;
3. Claim 5 prime-range decomposition;
4. Claim 4 finite density and modular CRT machinery;
5. pair/triple concrete CRT producers;
6. exact residue boxes and scaled representatives;
7. prime-window construction and placement;
8. quantitative product-to-LCM estimate;
9. PNT+ relative-prime provider;
10. strong Cambie theorem;
11. final large-start-preserving index translation;
12. unbounded witnesses and infinitude;
13. external statement bridge.

## Analytic dependency closure

The project does not introduce a custom prime-density axiom for the final result. It imports pinned PNT+ support and uses a kernel-checked prime-between consequence to build the eventual relative-prime provider.

The scientific claim should therefore be phrased as a machine-checked reconstruction under the repository's explicit pinned dependencies, not as a standalone source file detached from its dependency graph.

## Trust and verification boundary

Project-level machine-verification credit requires all of the following:

- declaration appears in the canonical source tree;
- source is reachable from the generated import graph;
- `lake exe mk_all --check` is synchronized;
- the full canonical build succeeds;
- historical verification claims name the exact commit/run they concern.

A locally elaborating or unreachable Lean file is not sufficient for project-level credit.
