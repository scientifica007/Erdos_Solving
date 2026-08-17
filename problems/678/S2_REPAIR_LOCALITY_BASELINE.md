# Erdős #678 — S2c Repair-Locality Baseline

## Status

**EXECUTED SUCCESSFULLY / ARTIFACT VALIDATED / PENDING PR INTEGRATION.**

S2c measures only the predeclared **symbol/API reference-repair blast radius** produced by declaration-name breaks that preserve propositions and proof bodies. It is not a general maintainability experiment.

The protocol and matched mutation manifest were frozen at commit `a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1`, before the experiment harness existed and before any repair observation was collected.

## Execution identity

- protocol: `S2_REPAIR_LOCALITY_PROTOCOL.md`;
- frozen mutation manifest: `S2_REPAIR_LOCALITY_MUTATIONS.yaml`;
- frozen internal source baseline: `cc55073fceddb51e3fa2c1854f797fe989523985`;
- experiment apparatus commit: `00d340d3ccdc13418615b6526e9b736d9f9e03e7`;
- workflow: `Erdos 678 S2c Repair Locality`;
- run: `32062501296` — **SUCCESS**;
- job: `95486770197` — **SUCCESS**;
- comparator: `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator source blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- comparator source SHA-256: `186a651174c7f8f7ef1e7d7d86f262ff51889a55c6767ca116b08a009fe8a4db`;
- Lean: `4.33.0`;
- Mathlib: `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- hosted runner: `2.336.0`;
- image: `ubuntu24 / 20260810.271.1`;
- CPU count: 4.

The internal and comparator baselines both compiled green before mutation. The internal baseline build recorded `Build completed successfully (8808 jobs)`.

## Artifact integrity

The workflow uploaded artifact:

- ID: `9299556049`;
- name: `erdos678-s2c-00d340d3ccdc13418615b6526e9b736d9f9e03e7`;
- size: `89,822` bytes;
- GitHub-reported SHA-256: `0369ec66c689572307660765b0c84cd86b6339f4f4d26a788c560ca11f7b7f4b`.

The ZIP was downloaded independently after the run; its locally recomputed SHA-256 was exactly the same. The archive contains `result.json`, `summary.md`, baseline logs, and mutation/repaired logs for all six artifact×mutation observations.

`S2_REPAIR_LOCALITY_BASELINE.json` is the persisted machine-readable `result.json` from that artifact.

## Predeclared mutations

| ID | logical layer | internal declaration | comparator declaration |
|---|---|---|---|
| R1 | analytic-input closure | `claim4RelativePrimeProviderOfPNT` | `density_proof` |
| R2 | eventual large-k construction | `claim4_exists_cambie_lcm_ratio_eventually_of_pnt` | `exists_xy_for_large_k` |
| R3 | strong public endpoint | `cambie_lcm_ratio_eventually_with_large_start_real` | `main_theorem_given_pnt` |

Every mutation renamed only the declaration identifier, added no compatibility alias, changed no proposition or mathematical proof body, and was executed independently from the pristine baseline. Legal repair consisted only of exact downstream old-name → new-name identifier substitution.

## Primary results

| mutation | artifact | observable break | repaired refs | production files/modules | verification files/modules | repaired reference lines | third-party touches | repaired green |
|---|---|---|---:|---:|---:|---:|---:|---|
| R1 | internal | yes | 3 | 2 | 1 | 3 | 0 | yes |
| R1 | comparator | yes | 1 | 1 | 0 | 1 | 0 | yes |
| R2 | internal | yes | 2 | 1 | 1 | 2 | 0 | yes |
| R2 | comparator | yes | 1 | 1 | 0 | 1 | 0 | yes |
| R3 | internal | yes | 2 | 0 | 1 | 2 | 0 | yes |
| R3 | comparator | yes | 3 | 1 | 0 | 3 | 0 | yes |

All six declaration-only mutations produced the expected unresolved-symbol failure. All six legal repairs returned their artifact to green. Total third-party/dependency files touched: **0**.

For each internal repair, `lake exe mk_all --check` returned success with `No update necessary`, and the full `Formalization` build succeeded with **8808 jobs**.

## Exact repair sites

### R1 — analytic-input closure

Internal declaration: `Claim4RelativePrimePNT.lean:20`.

Downstream repair sites:

- production: `Claim4RelativePrimePNT.lean:78`;
- production: `Erdos678Final.lean:112`;
- verification: `Claim4RelativePrimePNTTests.lean:11`.

The first build rejection occurred at `Claim4RelativePrimePNT.lean:78` with unknown identifier `claim4RelativePrimeProviderOfPNT`.

Comparator declaration: `Erdos678.lean:2111`; the only downstream repair was production line `2449`. Its first rejection was there.

**Observed blast radius:** internal `3` references across two production modules plus one verification module; comparator `1` production reference in its monolithic source.

### R2 — eventual construction

Internal declaration: `Claim4RelativePrimePNT.lean:68`.

Downstream repair sites:

- production: `CambieStrongTheorem.lean:25`;
- verification: `Claim4RelativePrimePNTTests.lean:18`.

The first build rejection occurred at `CambieStrongTheorem.lean:25`.

Comparator declaration: `Erdos678.lean:1952`; the only downstream repair was production line `2011`.

**Observed blast radius:** internal `2` references across one production and one verification module; comparator `1` production reference.

### R3 — strong public endpoint

Internal declaration: `ExternalStatementBridge.lean:106`.

The declaration has **no downstream production consumer** in the internal artifact. Both repair sites are verification-only:

- `ExternalStatementBridgeTests.lean:31`;
- `ExternalStatementBridgeTests.lean:38`.

The first rejection occurred at the first test reference, line `31`.

Comparator declaration: `Erdos678.lean:2447`; downstream production references occur at lines `2461`, `2469`, and `2514`.

**Observed blast radius:** internal `2` verification references and zero production references; comparator `3` production references.

## Scientific interpretation

The result is **mixed and layer-dependent**. It does not support a simple claim that either artifact has uniformly smaller API repair blast radius.

- At R1 and R2, the internal artifact exposes more static downstream references than the comparator. Part of that additional coupling is deliberate verification instrumentation in dedicated `*Tests.lean` modules.
- At R3, the direction reverses at the production layer: the normalized strong endpoint in the internal artifact has no production consumer after its declaration, whereas the comparator's strong endpoint has three downstream production references.
- Summing all reference sites (`7` internal vs `5` comparator) is reported only as a bookkeeping total and **must not be interpreted as a maintainability ranking**. The mutations match logical roles, not identical proposition syntax, and the comparator packages nearly all project proof code in one source module.
- Counting production references separately gives `3` internal versus `5` comparator across the three mutations, while verification references are `4` internal versus `0` comparator under this experiment's classification. This highlights that tests/audits themselves intentionally create observable API coupling.

The defensible S2c conclusion is therefore:

> **For these three predeclared matched logical interfaces, API/reference repair locality depends strongly on the interface layer and on whether verification consumers are counted separately from production consumers. No uniform repair-locality advantage is observed.**

This is useful negative/mixed evidence: it blocks a tempting but unsupported inference from the modular source layout to general maintainability superiority.

## Methodological value for the AI-assisted case study

S2c provides a third control episode after S2a and S2b:

1. S2a showed that reproducible metrics can be scientifically misleading when ownership/dependency boundaries are wrong.
2. S2b showed that a computationally green run can still be scientifically inadmissible when predeclared provenance is missing.
3. S2c shows that a predeclared comparison can produce a **mixed result that contradicts a simple architectural narrative**, and that the appropriate response is to preserve the mixed result rather than redesign the metric after seeing it.

No hidden chain-of-thought is needed for this evidence; the protocol commit, manifest, harness, run, artifact, failures, legal repairs, and verification outputs are externally auditable.

## Interpretation limits

S2c does **not** establish:

- general maintainability;
- human repair time or cognitive effort;
- semantic-error resistance;
- proof complexity;
- upgrade robustness;
- architecture superiority.

Timing fields retained in `result.json` are apparatus metadata only and are explicitly not repair-cost measurements.

## Next gate

The S2c baseline is executed and validated but not yet integrated. Before S2d:

1. synchronize state/roadmap/README/evidence with this exact result;
2. open the S2c PR;
3. require canonical exact-head Lean Verification on the final PR head;
4. merge only if green;
5. verify the exact resulting `main` merge commit;
6. close S2c documentation/evidence state if needed;
7. only then predeclare S2d semantic/index mutation resistance.

`DEC-012` remains in force: no other Erdős problem is authorized.
