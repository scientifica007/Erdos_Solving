# Erdős #678 — S2e Upgrade-Robustness Evidence Baseline

## Status

S2e no-repair detection is **executed successfully, independently artifact-validated, and pending repository evidence integration**. The mathematics of #678 remains frozen and archived.

This baseline is a compact persisted summary. The exact reproducibility record is the complete GitHub Actions artifact `9337321640` from workflow run `32170243744`; the repository JSON summary is not claimed to be byte-identical to the raw artifact.

## Frozen design and baseline

Prospective definitions were integrated before apparatus creation:

- protocol: `S2_UPGRADE_ROBUSTNESS_PROTOCOL.md`;
- candidate matrix: `S2_UPGRADE_ROBUSTNESS_MATRIX.yaml`;
- protocol SHA-256: `e81c6905693d7407dcf325bbe61e4709178b5f5479acac74cfcc41fe3bafbf96`;
- matrix SHA-256: `c774e472855bbc21765ef342e6b700d46b168e6337ed6cd4386d9dbe11927e3a`;
- predeclaration PR: #38;
- predeclaration head: `c733ac4baae1a53b20d2e395eaab5c938683a74a`;
- exact-head CI: run `32105032799`, job `95612654549`;
- predeclaration merge: `0fcefd7ea8cb3753a80a3f93c2498841b1938e55`;
- exact-main post-merge CI: run `32105520785`, job `95614030394`.

Frozen source baseline:

- commit: `5039d464f6196e6b47494f0a6fae869e3362d082`;
- Lean: `v4.33.0`;
- Mathlib input: `v4.33.0`;
- Mathlib resolved: `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical baseline import check: `No update necessary`;
- canonical baseline build: **8808 jobs**.

Frozen candidates:

1. **U1 — `U1-lean-4.34.0-rc1-compiler-only`:** Lean `v4.34.0-rc1`, baseline Mathlib/PNT source and manifest identities unchanged, no `lake update`.
2. **U2 — `U2-lean-mathlib-4.34.0-rc1-root-upgrade`:** Lean `v4.34.0-rc1` plus Mathlib exact commit `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11` (tag provenance `v4.34.0-rc1`), with PNT+ fixed at `2667e414...`.

At freeze time PNT+ `main` equalled the baseline PNT commit, so no newer coordinated provider revision was substituted.

## Apparatus and governance record

Core apparatus was integrated through PR #40 and post-merge verified. Subsequent changes were instrumentation-only and never altered candidate versions, D0–D6 stages, sentinels, package-resolution commands, ownership taxonomy, repair eligibility/budget, immutable regressions, or interpretation rules.

Important instrumentation checkpoints:

- core apparatus commit: `1b241344377d80e9cc4532ec1b92f884e71dc837`;
- runtime/D1-owner wrapper commit used by the credited artifact: `fdfee69c0672067469d6916f630c61e345579ed7`;
- hardened complete-set combiner commit: `4e18481d34ccf609cd5ee7ea2726f2ef1a7f0c63`;
- integrated instrumentation main commit before credited execution: `eaf77afd8db3e9e3c32770b953eb2c0ef8a61be7`;
- exact-main canonical verification of that commit: run `32164784651`, job `95801720316`, with exact `verified_commit`, pinned PNT+/Mathlib, `No update necessary`, and 8808 jobs.

### Excluded complete runs / candidate sets

All exclusions were made under fail-closed rules; none was selected because of an inconvenient scientific outcome.

| episode | run | exclusion | credited U1/U2 |
|---|---:|---|---:|
| PR #42 | `32114757196` | mandatory baseline full build exceeded instrumentation-local 2400 s before candidates | 0/0 |
| PR #45 | `32139077608` | mandatory baseline full build exceeded instrumentation-local 7200 s before candidates | 0/0 |
| PR #48 | `32161655865` | D1 primary-owner classifier omitted package-resolution failures, producing a primary-measurement misclassification | 0/0 |
| PR #51 | `32168529883` | required aggregate artifact was not produced because manual cross-job artifact transport forwarded GitHub authorization across a blob redirect and received HTTP 401 | 0/0 |

The PR #51 candidate outputs were retained only as non-credited diagnostics. Because the execution carrier prospectively required the complete-set aggregate artifact for credit, neither candidate was promoted after the transport failure.

Artifact transport was then audited prospectively with synthetic data only in PR #52: run `32170073082`, aggregate job `95818872837`. The pinned official `actions/download-artifact@d3f86a106a0bac45b974a628896c90dbdf5c8093` downloaded both synthetic artifacts with digest verification; the hardened combiner returned PASS. No Lean candidate was executed in that audit.

## Credited complete-set detection

Execution carrier PR #53 was closed without merge after completion. Its workflow is not part of persistent project state.

- exact workflow/head commit: `dfb7d1122e0e482626c9849f0e083ecbe71e58be`;
- workflow run: **`32170243744`**;
- U1 job: `95819384522` — success;
- U2 job: `95819384599` — success;
- aggregate job: `95822552072` — success.

Artifacts:

- U1: `9337314559`, 32,730 bytes, SHA-256 `d06ce516f34f509d307ab121242c60b7dca95ecff6646355783a544caa846ac7`;
- U2: `9337277099`, 18,865 bytes, SHA-256 `fadbb09d97c96292838d25ed1cf89297a14918dfe4c24772e3e880ed464470c7`;
- complete frozen set: **`9337321640`**, 58,933 bytes, SHA-256 **`90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`**.

Independent download and rehash of the complete ZIP matched the GitHub SHA-256 exactly. The ZIP contains 40 retained files, including `result.json`, `SUMMARY.md`, `COMBINE_AUDIT.json`, raw U1/U2 results, provenance records, baseline logs, D0–D3 logs, configuration diffs, and scope audits.

The complete artifact reports:

- `status = executed-success`;
- `credited_candidate_count = 2` with exactly the two frozen candidate IDs;
- exact frozen baseline/predeclaration/protocol/matrix provenance;
- `COMBINE_AUDIT.status = PASS`;
- ownership validation = PASS;
- apparatus failures = 0;
- provenance mismatches = 0;
- repair outputs present = 0;
- raw U1/U2 result hashes match the hashes stored in the aggregate.

Raw result SHA-256 values:

- U1 `result.json`: `e142963b42bcc24d2361d54bbcbd5a29430c74c83a124ea2712f65bf810a9148`;
- U2 `result.json`: `2ebb741302ef11ba7dbaacfb501620185f64c9da4a64548075353ecd27138092`.

Both mandatory baselines were green with the frozen Lean/Mathlib/PNT identities, `No update necessary`, and the 8808-job canonical build. Candidate changes were isolated to temporary worktrees; tracked repository diff after each run was empty; third-party source repair remained forbidden; no proof repair was performed.

## Credited U1 outcome

Candidate: compiler-only Lean `v4.34.0-rc1`, old Mathlib/PNT stack unchanged.

- D0 environment/provenance: **green**.
- D1 package graph: **green**.
- D2 `Intervals`: failed first in `Batteries/Data/List/Basic.lean:577`, owner `mathlib_or_transitive_dependency`.
- D2 `ValuationBasic`: failed first in `Batteries/Data/Float/Basic.lean:16`, owner `mathlib_or_transitive_dependency`.
- D2 `Claim4Density`: failed first in `Batteries/Data/Float/Basic.lean:16`, owner `mathlib_or_transitive_dependency`.
- D3 PNT support boundary: failed first in `Mathlib/Tactic/Linter/Whitespace.lean:49`, owner `mathlib_or_transitive_dependency`.
- D4/D5: not applicable because D3 was not green.
- D6: not applicable.
- deepest green stage: **D1**.
- primary failure owner: **`mathlib_or_transitive_dependency`**.
- full no-repair survivor: false.
- `dependency_support_blocked = true`.

No project-owned proof/source failure was reached. The credited statement is limited to this exact compiler-only candidate and pinned dependency stack.

## Credited U2 outcome

Candidate: Lean `v4.34.0-rc1` + exact Mathlib `de5ce8a9...`, PNT+ pinned to the frozen baseline revision.

- D0 environment/provenance: **green**.
- D1 package resolution: **failed**.
- deepest green stage: **D0**.
- primary failure owner: **`package_resolution`**.
- D2–D6: not applicable.
- full no-repair survivor: false.

`lake update mathlib` selected the exact frozen Mathlib candidate, then the package/cache path reported that the project pins different versions of several transitive dependencies than Mathlib and terminated with `error: mathlib: failed to fetch cache`. This is retained as an exact-candidate package/supply-chain version-boundary result. It is not evidence of a defect in the #678 proof.

## Repair phase

**Not applicable: no eligible project-owned failure was reached.**

The frozen protocol permits project-owned repair only for an eligible project-owned detection failure. U1 was dependency-support blocked before such a failure; U2 stopped at D1 package resolution. Therefore no repair run is missing, no repair batch was attempted, and no line-count/repair-surface outcome exists to report for these candidates.

## Bounded conclusion

For the two prospectively frozen forward candidates:

- U1 survived candidate identity and package resolution, then encountered Mathlib/transitive dependency incompatibility before any project-owned proof failure could be measured;
- U2 reached the requested Lean/Mathlib identity but was blocked at package/cache resolution under the pinned PNT/project dependency graph;
- neither candidate was eligible for project-owned repair under the frozen rules.

This supports an exact-version **dependency/version-boundary** result only. It does **not** support general Lean/Mathlib compatibility claims, general maintainability, expected future upgrade cost, human repair difficulty or speed, proof-quality criticism of dependency maintainers, or architecture superiority. Timing values are apparatus metadata only.
