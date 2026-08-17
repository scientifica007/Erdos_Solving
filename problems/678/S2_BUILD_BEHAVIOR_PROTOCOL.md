# Erdős #678 — S2b Controlled Build-Behavior Protocol

## 1. Scientific question

S2b asks a narrower question than “which proof is better?”:

> Under one pinned Lean/Mathlib/PNT+ environment, how do the two #678 formal artifacts behave when their **artifact-owned compilation outputs** are cold versus immediately re-used warm?

The experiment measures build behavior, not mathematical quality, proof complexity, maintainability, or general architecture superiority.

S2a established a mandatory control: repository-local module counts are boundary-sensitive because PNT+ is packaged externally in `Erdos_Solving` and repository-locally in `plby/lean-proofs`. S2b therefore compiles the public comparator source unchanged **inside the `Erdos_Solving` pinned Lake environment**. This holds the external dependency environment constant and treats the comparator's one #678 source file as the comparator-owned artifact.

## 2. Fixed identities

The measurement workflow must record and validate all of the following before crediting any timing:

- internal repository commit: the exact workflow push SHA;
- internal semantic target: `Formalization.Erdos678.Erdos678Final`;
- comparator repository: `plby/lean-proofs`;
- comparator commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator source path: `src/latest/ErdosProblems/Erdos678.lean`;
- comparator blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- Lean: `4.33.0`;
- Mathlib: `v4.33.0` / manifest revision resolved by the pinned project;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- runner label: `ubuntu-24.04`;
- actual runner image version, runner version, OS release, CPU count, and memory: recorded in each result.

The comparator source is fetched into runner-local temporary storage, validated by commit and blob, and copied byte-for-byte into a temporary module path in the checked-out workspace. The copied file is not committed or redistributed.

## 3. Measurement unit

A replicate is one fresh GitHub-hosted runner job that measures **both** artifacts. Pairing both artifacts on one runner reduces machine-to-machine variation.

Six independent replicates are required. Order alternates to control first-measurement and page-cache/thermal effects:

1. internal → comparator;
2. comparator → internal;
3. internal → comparator;
4. comparator → internal;
5. internal → comparator;
6. comparator → internal.

No result is excluded merely because it is slow. A replicate may be excluded only for a predeclared infrastructure failure such as network/toolchain download failure, runner cancellation, or identity-validation failure. Such failures are reported and the same replicate/order is retried; proof/build failures are **not** silently retried or discarded.

## 4. Environment preparation — outside the timed region

Each replicate performs these operations before timing:

1. checkout the exact experiment commit;
2. install the pinned Lean toolchain and restore/download the pinned Mathlib cache;
3. validate Lean/Mathlib/PNT identities;
4. fetch and validate the comparator commit/blob;
5. copy the exact comparator source to the temporary benchmark module path;
6. prebuild both benchmark targets once to validate target resolution and populate all external/prerequisite artifacts.

Network, checkout, toolchain installation, dependency download, cache download/decompression, comparator fetch, and this validation/prebuild phase are **not counted as artifact build time**. Their timestamps/identity are retained as environment/setup metadata.

This choice is deliberate: S2b measures artifact-owned compilation behavior after dependencies are available, rather than internet/cache-service latency.

## 5. Cold condition

“Cold” means **artifact-owned Lake outputs are absent while the pinned dependency environment remains prepared**.

### Internal artifact

Before its cold measurement, remove generated outputs under the build-tree namespace corresponding to `Formalization/Erdos678`, while preserving external dependency package outputs. Then run:

```text
lake build Formalization.Erdos678.Erdos678Final
```

Only targets required by that semantic endpoint are rebuilt. Deleting the wider #678 output namespace is allowed because Lake determines the reachable target graph; unrelated source modules are not credited merely because their stale outputs were removed.

### Comparator artifact

The exact comparator source is exposed temporarily as `Formalization.Erdos678Benchmark.Comparator`. Before its cold measurement, remove only the generated outputs for `Formalization/Erdos678Benchmark`, then run:

```text
lake build Formalization.Erdos678Benchmark.Comparator
```

No comparator PNT+ source is vendored. Both targets consume this repository's already-prepared external PNT+ dependency.

## 6. Warm condition

Immediately after a successful cold build of an artifact, run the **same target again without source or output changes**. This warm result measures no-change incremental behavior / Lake up-to-date checking. It is not interpreted as compilation speed.

## 7. Metrics

For every cold and warm target invocation record:

- wall-clock seconds;
- user CPU seconds;
- system CPU seconds;
- maximum resident set size (KiB);
- exit code;
- target name;
- replicate number;
- within-run order;
- cold/warm condition;
- output/log path;
- count of lines matching Lake `Built` progress entries, as an observational workload indicator only.

Use `/usr/bin/time` or an equivalent OS-level measurement wrapper. Raw command output must be retained in the uploaded run artifact.

## 8. Aggregation

For each artifact × condition, report all six observations and predeclared robust summaries:

- median;
- minimum and maximum;
- median absolute deviation (MAD);
- interquartile range (IQR) when well-defined for the six observations.

Also report paired cold-time ratios/differences per replicate, but **do not** turn them into a superiority claim. With six hosted-runner samples this is descriptive engineering evidence, not a population-level performance benchmark.

Do not report only the fastest run. Do not silently remove outliers.

## 9. Validity controls

A replicate is scientifically valid only if:

- checked-out SHA equals the workflow SHA;
- comparator commit/blob validation passes;
- `lean --version` is 4.33.0;
- the project lock/manifest resolves the expected PNT+ revision;
- both prebuild targets succeed before timing;
- cold cleanup removes the intended artifact-owned outputs and does not delete external package outputs;
- both cold and warm commands succeed;
- generated JSON carries the runner and identity metadata.

The experiment script must fail closed if any identity check fails.

## 10. Interpretation boundaries

Allowed after successful execution:

- descriptive cold artifact-owned rebuild differences under this exact common environment;
- descriptive warm/no-change incremental differences;
- resource-use observations under the recorded GitHub runner population;
- evidence about how source decomposition affects a Lake rebuild under these controls.

Not allowed from S2b alone:

- “our architecture is faster” in general;
- “our proof is simpler”;
- “our proof is easier to maintain”;
- “the comparator is inefficient”;
- extrapolation to different Lean/Mathlib versions, machines, cache policies, or proof developments;
- interpreting warm no-op time as theorem compilation performance.

## 11. Relationship to later stages

- S2c will test **repair locality** under matched source/interface mutations.
- S2d will test **semantic mutation rejection**.
- S2e will test **upgrade robustness**.

S2b results must not be used as substitutes for those experiments.

## 12. Reproducibility artifact

The workflow must upload one artifact per replicate containing:

- machine-readable JSON result;
- concise Markdown summary;
- raw timed-command logs;
- `/usr/bin/time` metric files;
- exact comparator identity record;
- environment metadata.

A later consolidation step may combine all six replicate artifacts into the committed S2b baseline. The baseline is not credited until experiment identity, all replicate inclusion/exclusion decisions, and the aggregate calculation are auditable.

## 13. Stop rule

S2b concerns archived Erdős #678 only. `DEC-012` remains in force: this protocol does not authorize work on another Erdős problem.
