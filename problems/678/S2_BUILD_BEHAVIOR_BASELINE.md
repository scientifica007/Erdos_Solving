# Erdős #678 — S2b Controlled Build-Behavior Baseline

## Status

**EXECUTED SUCCESSFULLY / VALIDATED / PENDING PR INTEGRATION.**

This baseline measures artifact-owned cold and warm Lake build behavior under the predeclared controls in `S2_BUILD_BEHAVIOR_PROTOCOL.md`. It is descriptive engineering evidence, not a general architecture ranking.

## Credited execution identity

- workflow: `Erdos 678 S2b Build Behavior`;
- run: `32053575928` — **SUCCESS**;
- exact apparatus commit: `c2ef703c954e462096162a3b4a59a5e0f8d48488`;
- replicates: **6/6 successful**, no retries, no exclusions;
- Lean: `4.33.0`;
- Mathlib input/resolved revision: `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- comparator: `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator source blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- GitHub runner software: `2.336.0`;
- runner image: `ubuntu24 / 20260810.271.1`;
- CPU count: 4 in every replicate.

The comparator source was fetched at the fixed commit/blob and compiled byte-for-byte as temporary target `Formalization.Erdos678Benchmark.Comparator` inside the same pinned Lake environment as the internal target `Formalization.Erdos678.Erdos678Final`. Network/toolchain/dependency/cache preparation and validation prebuilds were outside the timed region.

## Pilot exclusion

The earlier apparatus commit `a349010e295afa52d040feacbb2d02d5c081c548`, run `32052134207`, also completed 6/6 jobs successfully, but every result recorded `runner_version: unknown`. Because runner-version evidence was a **predeclared protocol invariant**, the entire pilot was excluded before its timing values were interpreted. No observation was selected or rejected based on performance. The corrected apparatus fails closed when runner/image provenance is unavailable.

This distinction is methodologically important: successful computation is not by itself a valid scientific measurement.

## Artifact evidence

| rep | order | job | artifact id | SHA-256 digest |
|---:|---|---:|---:|---|
| 1 | internal-first | `95458495483` | `9296089666` | `0ae4abb0a926d87e0ee934c38e3781bdd1acf662aa886f94056749d9c688868d` |
| 2 | comparator-first | `95458495190` | `9296073673` | `30ef2e618283d3164113931ddab48a3e2c5a4d642f9f90413b903a4bb25e55a3` |
| 3 | internal-first | `95458495351` | `9295948207` | `39460c4c00e49f2c3cb3f5e7b02ac4bf6871dc3aa734ad9f8fdad4ccd48b868c` |
| 4 | comparator-first | `95458495136` | `9296067771` | `d078a33dd396edf08b685eaa192a66c8d43159268fa3ddf76797c41a17c5b41c` |
| 5 | internal-first | `95458495633` | `9295931091` | `fab91859fd85623c1f703c0999bc1a881101553e92799428c9e0952e30ad0997` |
| 6 | comparator-first | `95458495066` | `9295940038` | `bd64b13cb21451a8c7a5bf54235579db6720b044ace51af0bda38387ba81321e` |

All downloaded ZIP digests matched the digests reported by GitHub. Every `result.json` passed identity checks for apparatus commit, replicate/order, comparator commit/blob, Lean, Mathlib, PNT+, runner software/image, and zero build exit codes.

## Raw paired wall-clock observations

Seconds. `Δ = internal − comparator`; negative means internal was faster in that replicate.

| rep | order | internal cold | comparator cold | internal warm | comparator warm | cold Δ | cold I/C |
|---:|---|---:|---:|---:|---:|---:|---:|
| 1 | internal-first | 160.80 | 162.34 | 4.56 | 4.17 | -1.54 | 0.991 |
| 2 | comparator-first | 161.59 | 151.93 | 4.15 | 4.36 | +9.66 | 1.064 |
| 3 | internal-first | 157.11 | 165.81 | 4.68 | 4.65 | -8.70 | 0.948 |
| 4 | comparator-first | 149.56 | 160.24 | 4.53 | 4.32 | -10.68 | 0.933 |
| 5 | internal-first | 158.35 | 146.62 | 4.24 | 4.24 | +11.73 | 1.080 |
| 6 | comparator-first | 162.45 | 152.32 | 4.31 | 4.45 | +10.13 | 1.067 |

The paired cold differences have **both signs** and span `-10.68` to `+11.73` seconds. Their median difference is `+4.06 s` and median ratio is `1.027`. This six-run sample therefore does **not** provide a stable wall-clock winner.

## Predeclared robust summaries

| artifact | condition | wall median s | min | max | MAD | IQR |
|---|---|---:|---:|---:|---:|---:|
| internal | cold | 159.575 | 149.56 | 162.45 | 2.240 | 3.973 |
| comparator | cold | 156.280 | 146.62 | 165.81 | 5.205 | 9.788 |
| internal | warm | 4.420 | 4.15 | 4.68 | 0.160 | 0.295 |
| comparator | warm | 4.340 | 4.17 | 4.65 | 0.105 | 0.168 |

The cold wall medians differ by only about `2.1%` relative to the comparator median, while replicate-to-replicate paired differences are larger and change sign. Warm measurements are nearly identical but represent **no-change incremental checks**, not theorem compilation speed.

## Resource-behavior result

| cold metric | internal median | comparator median | descriptive relation |
|---|---:|---:|---|
| user CPU seconds | 176.105 | 480.580 | internal ≈ 36.6% of comparator |
| system CPU seconds | 64.840 | 5.990 | internal ≈ 10.8× comparator |
| total CPU seconds (user+sys, per-replicate median) | 241.155 | 486.475 | internal paired median ratio ≈ 0.503 |
| max RSS KiB | 7,183,766 | 7,828,930 | internal ≈ 8.2% lower |
| Lake `Built` progress lines | 46 | 1 | reflects the known modular decomposition |

The user-CPU and RSS direction is consistent across all six replicates. The internal/comparator user-CPU ratios are approximately `0.341–0.388`; max-RSS ratios are approximately `0.917–0.918`. Conversely, internal system CPU is roughly `10.5–11.1×` the comparator in every replicate.

### Interpretation

Under this exact common environment, the two artifacts reach similar cold wall times through different execution profiles. The modular internal artifact rebuilds 46 Lake modules and uses materially more system CPU. The single comparator artifact reports one rebuilt module but uses much more user CPU and somewhat higher peak RSS. The internal artifact's median total CPU consumption is about half the comparator's in this experiment, despite having more source modules and artifact-owned source lines.

A plausible engineering interpretation is that the modular graph exposes more process/file/build-system overhead while avoiding part of the expensive monolithic elaboration workload of the comparator. **That causal explanation is an inference, not established by S2b.** The experiment directly establishes only the measured resource profiles under the pinned environment.

## Scientific conclusion

S2b does **not** support a claim that one artifact is generally faster: wall-clock ordering is unstable in the six paired runs. It does provide reproducible evidence that **source decomposition can materially change CPU-system/user balance and peak-memory behavior even when wall time is similar**.

This directly complements S2a: S2a showed that source-boundary counts are packaging-sensitive; S2b shows that, after normalizing the dependency environment, the two artifact-owned proof layouts still exhibit substantially different resource profiles.

## Interpretation limits

S2b alone does not establish general architecture superiority, lower proof complexity, easier maintenance, smaller repair blast radius, better semantic-error detection, better upgrade robustness, or performance outside this pinned toolchain/runner regime. Six hosted-runner observations are descriptive engineering evidence, not a population-level performance benchmark.

## Machine-readable representation

`S2_BUILD_BEHAVIOR_BASELINE.json` stores the six observations, artifact IDs/digests, robust summaries, metric-array schema, paired wall values, and derived CPU summaries. `experiments/s2_build_behavior_aggregate.py` independently fails closed on incomplete or mixed runner/image/toolchain identities before aggregation.

## Next gate

This result is **executed but not integrated**. The S2b branch must now synchronize state/roadmap/evidence, open a PR, pass canonical exact-head Lean Verification, merge, and pass post-merge verification on `main`. S2c must not start before that sequence closes.

`DEC-012` remains in force: no other Erdős problem is authorized.
