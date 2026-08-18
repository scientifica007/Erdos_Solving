# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-18): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b CLOSED. S2c CLOSED. S2d CLOSED / CLOSURE VERIFIED. S2e CLOSED / CLOSURE VERIFIED. S2 COMPLETE.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let `M(n,k) = lcm{n+1,...,n+k}`. The final Lean graph includes `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and the stronger Cambie construction. The analytic dependency is pinned to `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

## Closed scientific stages

- **S1:** executable common-environment differential verification against Aristotle/Alexeev; closure-verified.
- **S2a:** dependency-surface counts are ownership/boundary sensitive; closure-verified.
- **S2b:** no stable wall-clock winner under the pinned common environment, with materially different CPU/memory profiles; closure-verified.
- **S2c:** repair-locality result is mixed/interface-dependent; no uniform maintainability winner; closure-verified.
- **S2d:** three prospectively frozen semantic/index perturbations were rejected in both artifacts; 6/6 credited rejections, zero proof repairs and zero dependency-source edits; closure-verified.
- **S2e:** exact-version upgrade-robustness experiment completed and closure-verified; both frozen forward candidates stopped at dependency/package boundaries before an eligible project-owned repair surface was reached.

## S2e — upgrade robustness — CLOSED / CLOSURE VERIFIED

### Research question

For two exact forward Lean/Mathlib upgrade candidates frozen before observation, where does the archived internal #678 artifact first become incompatible, which failures belong to external dependency/package support versus project-owned source, and—only if a project-owned failure is eligible—what bounded semantic-preserving repair surface is required?

S2e is an exact-version transition experiment on the internal artifact. It is not a comparator benchmark and does not measure general maintainability.

### Frozen baseline and controls

Baseline:

- source `5039d464f6196e6e4ede2b600723b8616aeeee4`;
- Lean `v4.33.0`;
- Mathlib input/resolved `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical import check `No update necessary`;
- canonical build **8808 jobs**.

Prospective predeclaration was integrated through PR #38, with protocol SHA-256 `e81c6905693d7407dcf325bbe61e4709178b5f5479acac74cfcc41fe3bafbf96` and matrix SHA-256 `c774e472855bbc21765ef342e6b700d46b168e6337ed6cd4386d9dbe11927e3a`.

Frozen candidates:

1. **U1 — compiler-only forward pressure:** Lean `v4.34.0-rc1`; baseline Mathlib/PNT and manifest identities fixed; no `lake update`.
2. **U2 — root Lean + Mathlib RC:** Lean `v4.34.0-rc1`; Mathlib exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` (tag provenance `v4.34.0-rc1`); PNT+ remains `2667e414...`.

Frozen no-repair pipeline: D0 candidate identity → D1 package resolution → D2 three Mathlib-only sentinels → D3 external PNT support → D4 project PNT boundary → D5 canonical endpoint → D6 canonical import/full graph. Failure ownership and the project-only repair contract were frozen before candidate observation.

### Scientific governance and exclusions

Four complete attempts/candidate sets were excluded before the credited run:

| PR | run | reason | credited U1/U2 |
|---|---:|---|---:|
| #42 | `32114757196` | baseline build exceeded instrumentation-local 2400 s before candidates | 0/0 |
| #45 | `32139077608` | replacement 7200 s instrumentation timeout also stopped before candidates | 0/0 |
| #48 | `32161655865` | primary classifier omitted valid D1 package-resolution ownership | 0/0 |
| #51 | `32168529883` | required complete-set aggregate was not produced after artifact-transport HTTP 401 | 0/0 |

PR #52 then performed a synthetic-only transport audit; no U1/U2 candidate was executed there. The candidate versions, D0–D6 stages, ownership taxonomy, repair budget, semantic controls, and interpretation rules were not redesigned after observations.

### Credited complete-set run

Execution carrier PR #53 was intentionally closed without merge after completion.

- exact workflow/head: `dfb7d1122e0e482626c9849f0e083ecbe71e58be`;
- run: **`32170243744`**;
- U1 job: `95819384522` — success;
- U2 job: `95819384599` — success;
- aggregate job: `95822552072` — success.

Complete artifact **`9337321640`**, 58,933 bytes, SHA-256 **`90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`**. Independent re-download/re-hash matched exactly. It retains 40 files; `COMBINE_AUDIT.status=PASS`, ownership validation = PASS, apparatus failures = 0, provenance mismatches = 0, repair outputs = 0.

### Credited U1 result

U1 changes only the Lean toolchain to `v4.34.0-rc1`.

| stage | result | retained ownership/evidence |
|---|---|---|
| D0 | green | exact candidate/provenance |
| D1 | green | baseline package graph retained |
| D2 `Intervals` | failed | `Batteries/Data/List/Basic.lean:577`, `mathlib_or_transitive_dependency` |
| D2 `ValuationBasic` | failed | `Batteries/Data/Float/Basic.lean:16`, same owner |
| D2 `Claim4Density` | failed | `Batteries/Data/Float/Basic.lean:16`, same owner |
| D3 PNT boundary | failed | Mathlib/transitive dependency source |
| D4/D5/D6 | not applicable | prerequisite boundary not green |

Deepest green = **D1**. Primary failure owner = **`mathlib_or_transitive_dependency`**. No project-owned #678 proof/source failure was reached.

### Credited U2 result

U2 changes Lean to `v4.34.0-rc1` and requests exact Mathlib `de5ce8a9...` while retaining the frozen PNT+ revision.

- D0: **green**.
- D1: **failed**.
- deepest green: **D0**.
- primary failure owner: **`package_resolution`**.
- D2–D6: not applicable.

The package graph stops before project compilation. This is retained as a package/supply-chain version-boundary observation for the exact frozen graph, not as a proof-quality defect.

### Repair phase

**Not applicable — no eligible project-owned failure was reached.**

The frozen repair budget was 12 batches / 10 project-owned files / 250 aggregate additions+deletions, with dependency-source edits forbidden and semantic endpoints/regressions immutable. Because U1 was dependency-support blocked and U2 stopped at D1 package resolution, zero repair batches were attempted and no repair-surface metric exists for these candidates.

### Integration and closure

Persistent result files:

- `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`;
- `S2_UPGRADE_ROBUSTNESS_RESULT.md`;
- `S2_UPGRADE_ROBUSTNESS_RESULT.json`;
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`.

Evidence PR #55 final head `9176ba2669299cb60a6cd78324f2e7d6994a8d48` passed exact-head run `32174316252` / job `95832572901`, merged as `a0dffadfbba22325103170a8222d8adb10ffe6e9`, and that exact merge passed post-merge run `32175057976` / job `95834940169` with `No update necessary` and **8808 jobs**.

Closure PR #57 final head `51aacbfb0fa56582baba4b6b5c6bc9730c0615ce` passed exact-head run `32176992624` / job `95841104500`, merged unchanged as `872be99ac79e3d905dd6d696e626d424331a1faa`, and that exact `main` commit passed post-merge run `32177665772` / job `95843195690` with matching `verified_commit`, pinned dependencies, `No update necessary`, and **8808 jobs**.

### Bounded conclusion

Both exact frozen forward candidates were blocked at dependency/package boundaries before an eligible project-owned repair surface could be observed. This is an exact-candidate version-boundary result only.

It does **not** support claims about general Lean/Mathlib compatibility, general maintainability, human repair difficulty/speed, expected future upgrade cost, proof quality of dependencies, or architecture superiority. Timing is apparatus metadata only.

## AI-for-science relevance

The auditable methodology record includes incomparable metric boundaries (S2a), missing provenance (S2b), mixed prospective repair results (S2c), semantic classifier invalidation (S2d), and in S2e baseline-runtime, primary-owner, and artifact-transport instrumentation failures followed by a credited dependency-boundary result. Protocols, commits, CI runs, artifacts, exclusions, and corrections provide the audit trail.

## Stop rule

S2 is complete. #678 remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
