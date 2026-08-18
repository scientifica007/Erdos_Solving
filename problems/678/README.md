# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-18): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 CLOSED. S2a CLOSED. S2b CLOSED. S2c CLOSED. S2d CLOSED / CLOSURE VERIFIED. S2e DETECTION EXECUTED / ARTIFACT VALIDATED / PENDING EVIDENCE INTEGRATION.**
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

S2d closure PR #36 merged as `5039d464f6196e6e4ede2b600723b8616aeeee4`; exact-main run `32103947182` / job `95609642835` recorded matching `verified_commit`, `No update necessary`, and **8808 jobs**.

## S2e — upgrade robustness — DETECTION EXECUTED / ARTIFACT VALIDATED

### Research question

For two exact forward Lean/Mathlib upgrade candidates frozen before observation, where does the archived internal #678 artifact first become incompatible, which failures belong to external dependency/package support versus project-owned source, and—only if a project-owned failure is eligible—what bounded semantic-preserving repair surface is required?

S2e is an exact-version transition experiment on the internal artifact. It is not a comparator benchmark and does not measure general maintainability.

### Frozen baseline and prospective controls

Baseline:

- source `5039d464f6196e6e4ede2b600723b8616aeeee4`;
- Lean `v4.33.0`;
- Mathlib input/resolved `v4.33.0` / `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical import check `No update necessary`;
- canonical build **8808 jobs**.

Prospective predeclaration was integrated through PR #38:

- head `c733ac4baae1a53b20d2e395eaab5c938683a74a`;
- exact-head run/job `32105032799` / `95612654549`;
- merge `0fcefd7ea8cb3753a80a3f93c2498841b1938e55`;
- post-merge run/job `32105520785` / `95614030394`;
- protocol SHA-256 `e81c6905693d7407dcf325bbe61e4709178b5f5479acac74cfcc41fe3bafbf96`;
- matrix SHA-256 `c774e472855bbc21765ef342e6b700d46b168e6337ed6cd4386d9dbe11927e3a`.

Frozen candidates:

1. **U1 — compiler-only forward pressure:** Lean `v4.34.0-rc1`; baseline Mathlib/PNT and manifest identities fixed; no `lake update`.
2. **U2 — root Lean + Mathlib RC:** Lean `v4.34.0-rc1`; Mathlib exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` (tag provenance `v4.34.0-rc1`); PNT+ remains `2667e414...`.

At freeze time PNT+ `main` equalled the baseline commit, so the experiment did not invent or silently substitute a newer coordinated provider.

Frozen no-repair pipeline:

- D0 exact candidate environment/provenance;
- D1 package graph / manifest resolution;
- D2 three project-owned Mathlib-only sentinels: `Intervals`, `ValuationBasic`, `Claim4Density`;
- D3 external `PrimeNumberTheoremAnd` support boundary;
- D4 project PNT boundary `Claim4RelativePrimePNT`, only if D3 is green;
- D5 canonical endpoint `Erdos678Final`, only if D3 is green;
- D6 `mk_all --check` + full `Formalization` build.

Failure ownership was prospectively frozen as apparatus/provenance, package resolution, Lean toolchain, Mathlib/transitive dependency, PNT dependency support, project-owned, or ambiguous.

### Scientific governance and exclusions

The apparatus was integrated only after predeclaration verification. Four execution attempts/candidate sets were excluded in full before the credited run:

| PR | run | reason | credited U1/U2 |
|---|---:|---|---:|
| #42 | `32114757196` | baseline full build exceeded instrumentation-local 2400 s before candidates | 0/0 |
| #45 | `32139077608` | baseline full build exceeded instrumentation-local 7200 s before candidates | 0/0 |
| #48 | `32161655865` | primary classifier omitted D1 package-resolution failures | 0/0 |
| #51 | `32168529883` | required complete-set aggregation failed before combiner because manual artifact transport received HTTP 401 at the blob redirect | 0/0 |

Candidate versions, D0–D6, package-resolution commands, sentinels, ownership taxonomy, repair budget, semantic header controls, and interpretation rules were not redesigned in response to these observations.

The artifact-transport correction was audited with **synthetic data only** in PR #52, run `32170073082`, aggregate job `95818872837`, using pinned `actions/download-artifact@d3f86a106a0bac45b974a628896c90dbdf5c8093`. Both downloads and the hardened combiner passed; no U1/U2 candidate was executed in that audit.

### Credited complete-set run

Execution carrier PR #53 was intentionally closed without merge after completion.

- exact workflow/head: `dfb7d1122e0e482626c9849f0e083ecbe71e58be`;
- run: **`32170243744`**;
- U1 job: `95819384522` — success;
- U2 job: `95819384599` — success;
- aggregate job: `95822552072` — success.

Artifacts:

- U1 `9337314559`, SHA-256 `d06ce516f34f509d307ab121242c60b7dca95ecff6646355783a544caa846ac7`;
- U2 `9337277099`, SHA-256 `fadbb09d97c96292838d25ed1cf89297a14918dfe4c24772e3e880ed464470c7`;
- complete set **`9337321640`**, 58,933 bytes, SHA-256 **`90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`**.

The complete ZIP was independently downloaded and rehashed with an exact digest match. It retains 40 files. `COMBINE_AUDIT.status=PASS`, ownership validation = PASS, apparatus failures = 0, provenance mismatches = 0, repair outputs = 0, and the raw U1/U2 `result.json` hashes match the values embedded in the aggregate.

Both mandatory baselines are green on the frozen source with `No update necessary` and the 8808-job build. Candidate modifications were isolated to temporary worktrees and tracked repository diff after execution was empty.

### Credited U1 result

U1 changes only the Lean toolchain to `v4.34.0-rc1`.

| stage | result | first retained ownership/evidence |
|---|---|---|
| D0 | green | exact candidate/provenance |
| D1 | green | baseline package graph retained |
| D2 `Intervals` | failed | `Batteries/Data/List/Basic.lean:577`, `mathlib_or_transitive_dependency` |
| D2 `ValuationBasic` | failed | `Batteries/Data/Float/Basic.lean:16`, same owner |
| D2 `Claim4Density` | failed | `Batteries/Data/Float/Basic.lean:16`, same owner |
| D3 PNT boundary | failed | `Mathlib/Tactic/Linter/Whitespace.lean:49`, same owner |
| D4/D5/D6 | not applicable | prerequisite boundary not green |

Deepest green stage: **D1**. Primary failure owner: **`mathlib_or_transitive_dependency`**. `dependency_support_blocked=true`. No project-owned #678 proof/source failure was reached.

### Credited U2 result

U2 changes Lean to `v4.34.0-rc1` and requests exact Mathlib `de5ce8a9...` while retaining the frozen PNT+ revision.

- D0: **green**.
- D1: **failed**.
- deepest green: **D0**.
- primary failure owner: **`package_resolution`**.
- D2–D6: not applicable.

`lake update mathlib` selected the requested Mathlib candidate, then reported that the project pins different versions of several transitive dependencies than Mathlib and terminated with `error: mathlib: failed to fetch cache`. This is retained as a package/supply-chain version-boundary observation for the exact frozen graph, not as a proof-quality defect.

### Repair phase

**Not applicable — no eligible project-owned failure was reached.**

The frozen repair budget was 12 batches / 10 project-owned files / 250 aggregate additions+deletions, with dependency-source edits forbidden and semantic endpoints/regressions immutable. But the repair phase is conditional: U1 was dependency-support blocked and U2 failed at D1 package resolution. Therefore zero repair batches were attempted, no project-owned source was edited, and no repair-surface metric exists for these candidates.

### Bounded conclusion

Both exact frozen forward candidates were blocked at dependency/package boundaries before an eligible project-owned repair surface could be observed. This is an exact-candidate version-boundary result only.

It does **not** support claims about general Lean/Mathlib compatibility, general maintainability, human repair difficulty/speed, expected future upgrade cost, proof quality of dependencies, or architecture superiority. Timing is apparatus metadata only.

Full evidence:

- `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`;
- `S2_UPGRADE_ROBUSTNESS_BASELINE.md`;
- `S2_UPGRADE_ROBUSTNESS_BASELINE.json`;
- exact raw reproducibility artifact `9337321640`.

## AI-for-science relevance

The auditable methodology record now contains several distinct failure modes that were retained rather than hidden: incomparable metric boundaries (S2a), missing provenance (S2b), mixed prospective repair results (S2c), semantic classifier invalidation (S2d), and in S2e baseline-runtime, primary-owner, and artifact-transport instrumentation failures followed by a credited dependency-boundary result. Hidden chain-of-thought is unnecessary for auditing these episodes; protocols, commits, CI runs, artifacts, exclusions, and corrections are sufficient.

## Integration and stop rule

The credited S2e result is artifact-validated but its repository evidence integration is still gated on canonical exact-head CI, merge unchanged, and exact-main post-merge verification. After that, a documentation-only S2e closure must be verified before S2f begins.

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
