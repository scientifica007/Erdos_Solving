# Erdős #678 — S2a Dependency-Surface Protocol

## Purpose

S2a establishes a reproducible **structural dependency baseline** for the two formal artifacts already compared in S1:

- this repository's machine-checked reconstruction of Cambie's #678 proof;
- the pinned public Aristotle/Alexeev `Erdos678.lean` artifact.

The purpose is measurement, not ranking. S2a does **not** claim that fewer/more modules, imports, lines, or graph edges imply a better proof architecture.

## Fixed inputs

### Internal artifact

- repository: `scientifica007/Erdos_Solving`;
- measurement commit: the exact S2a workflow checkout commit, recorded by the generated JSON;
- canonical result entry module: `Formalization.Erdos678.Erdos678Final`;
- source root for module resolution: `formalization/`.

### Public comparator

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- entry path: `src/latest/ErdosProblems/Erdos678.lean`;
- entry blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- module root: `src/latest/`.

The comparator is fetched ephemerally by immutable commit/blob. Its source is not vendored into this repository.

## Why naive file counts are invalid

The two repositories package dependencies differently.

In `Erdos_Solving`, `PrimeNumberTheoremAnd` is a pinned **external Lake dependency**. In the comparator repository, the source tree contains `src/latest/PrimeNumberTheoremAnd/...` alongside the #678 source. Therefore a raw “number of files in the repository” metric would mix:

1. proof architecture;
2. dependency packaging choice;
3. third-party code ownership.

S2a explicitly separates these dimensions.

## Ownership classes

Every reachable Lean module physically present in the measured source tree is classified as one of:

- `artifact_owned`: source attributed to the formal artifact being measured;
- `repository_local_support`: other source physically in the same repository but not classified as artifact-owned;
- `third_party_repository_local_support`: third-party dependency source physically present in the repository tree.

For this experiment:

- internal modules under `Formalization.Erdos678.*` are `artifact_owned`;
- comparator `ErdosProblems.Erdos678` is `artifact_owned`;
- comparator `PrimeNumberTheoremAnd.*` modules are `third_party_repository_local_support`.

This classification is structural/provenance metadata. It is not a legal license determination and does not alter `THIRD_PARTY_NOTICES.md`.

## Graph definition

For each artifact, the analyzer starts at the canonical result entry module and recursively parses Lean `import` commands after removing nested block comments and line comments.

A module import is classified as:

- **local edge** if the imported module resolves to a `.lean` file under that artifact's measured source root;
- **external edge** otherwise.

The resulting graph is the transitive local-import closure of the entry module. External imports are retained as a frontier rather than recursively expanded into Mathlib/Lake package source.

This is intentionally a **module/import graph**, not a theorem-dependency graph.

## Recorded metrics

For each side S2a records:

- reachable local module count;
- reachable local import-edge count;
- maximum local import depth from the entry module;
- local leaf-module count;
- direct entry imports;
- unique external-frontier modules;
- external-frontier package families (first module-name component);
- module count by ownership class;
- raw source-line count by ownership class;
- top-level declaration-command count by ownership class;
- complete reachable-module and local/external-edge lists for auditability.

The declaration count is a syntax-level source statistic derived from top-level commands such as `theorem`, `lemma`, `def`, `structure`, etc. It is **not** a measure of proof difficulty.

## Reproduction command

From repository root:

```bash
python3 problems/678/experiments/s2_dependency_surface.py --repo-root .
```

Generated outputs default to:

```text
problems/678/experiments/out/s2_dependency_surface.json
problems/678/experiments/out/s2_dependency_surface.md
```

The CI experiment prints both outputs to its log. Generated `out/` files are experiment outputs; the durable S2 result will be committed only after the executed run is inspected and its exact commit/pins are recorded.

## Interpretation constraints

S2a results may support statements such as:

- “the two artifacts have different module/import decompositions”;
- “one repository physically carries a dependency that the other consumes externally”;
- “the measured local graph has N modules/edges/depth under the stated ownership convention.”

S2a **cannot by itself** support:

- “architecture A is better/simpler”;
- “architecture A has lower mathematical dependency complexity”;
- “architecture A is easier to maintain”;
- “architecture A builds faster”;
- “architecture A is more robust to changes.”

Those require later controlled S2 experiments: build behavior, repair locality, semantic mutation resistance, and upgrade probes.

## Validity checks

An S2a run is creditable only if:

1. the workflow records the internal checkout commit;
2. the comparator commit and entry blob equal the fixed S1 pins;
3. the analyzer exits successfully;
4. the generated JSON records the exact internal commit and fixed comparator identity;
5. canonical Lean Verification for the same PR head remains green before merge.

## Scientific-process relevance

The experiment itself encodes a lesson from #678: **metric definition is part of scientific validity**. A convenient number can be reproducible yet still answer the wrong question if dependency packaging, ownership, and source boundaries are conflated.

## Scope gate

S2a concerns archived Erdős #678 only. It does not authorize any other Erdős problem. `DEC-012` remains in force.
