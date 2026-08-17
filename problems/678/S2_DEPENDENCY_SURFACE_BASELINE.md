# Erdős #678 — S2a Dependency-Surface Baseline

## Status

**EXECUTED / SUCCESS — pending integration of the S2a PR.**

This baseline measures **module/import structure under explicit source and ownership boundaries**. It does not measure mathematical proof difficulty and does not establish architecture superiority.

## Execution identity

- workflow: `Erdos 678 S2a Dependency Surface`;
- run: `32047324807`;
- job: `95438118197`;
- exact internal experiment commit: `4685fca552ae4a0270dfa3823d46fde48efa5ade`;
- runner: Ubuntu 24.04;
- comparator repository: `plby/lean-proofs`;
- comparator commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- comparator entry: `src/latest/ErdosProblems/Erdos678.lean`;
- comparator entry blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- generated-evidence artifact id: `9293347138`;
- artifact name: `erdos678-s2a-dependency-4685fca552ae4a0270dfa3823d46fde48efa5ade`;
- artifact digest: `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`.

The workflow validated that the internal JSON commit equals `GITHUB_SHA` and that the comparator commit/blob equal the fixed S1 identities before accepting the measurement.

## Canonical-result profile

Internal entry:

`Formalization.Erdos678.Erdos678Final`

Public comparator entry:

`ErdosProblems.Erdos678`

| Structural metric | Erdos_Solving | Public comparator |
|---|---:|---:|
| direct entry imports | 4 | 2 |
| reachable repository-local modules | 46 | 10 |
| reachable repository-local import edges | 58 | 10 |
| maximum local import depth | 33 | 4 |
| local leaf modules | 3 | 4 |
| unique external-frontier modules | 14 | 27 |
| external-frontier families | 2 | 2 |
| artifact-owned modules | 46 | 1 |
| artifact-owned source lines | 5546 | 2546 |
| artifact-owned top-level declaration commands | 237 | 108 |
| reachable third-party repository-local support modules | 0 | 9 |
| third-party repository-local support source lines | 0 | 6943 |
| third-party repository-local support declaration commands | 0 | 381 |

External-frontier families:

- Erdos_Solving: `Mathlib`, `PrimeNumberTheoremAnd`;
- public comparator: `Batteries`, `Mathlib`.

Direct entry imports:

- Erdos_Solving: `CambieStrongTheorem`, `Claim5ProductEstimate`, `Claim4FiveStripsFromRelativePrime`, `Claim4RelativePrimePNT`;
- public comparator: `Mathlib`, `PrimeNumberTheoremAnd.Consequences`.

## What the measurement actually shows

The two verified artifacts have materially different **decomposition and packaging topologies**.

In this repository, the #678 result is decomposed into a long chain of project-owned modules. PNT+ appears at the external dependency frontier through the pinned Lake package.

In the comparator, the #678 proof itself is concentrated in one artifact-owned source module, while nine reachable `PrimeNumberTheoremAnd.*` modules are physically present in the comparator repository and therefore appear in the repository-local import closure. Those nine modules are classified as **third-party repository-local support**, not as Aristotle/Alexeev #678 proof modules.

This is the principal scientific result of S2a: **dependency-surface metrics are boundary-sensitive**. The same conceptual analytic dependency can appear as an external frontier on one side and as repository-local source on the other. A raw file/module count would therefore conflate proof decomposition, packaging, and ownership.

## What the measurement does not show

The table must not be read as evidence that either artifact is mathematically simpler, better engineered, easier to maintain, less coupled, faster, or more robust.

Specific cautions:

- `46 vs 1` artifact-owned modules primarily exposes modular decomposition versus a concentrated source file;
- `33 vs 4` local depth is conditioned on the chosen physical source boundary;
- `14 vs 27` external-frontier modules is **not** a direct coupling comparison, because the comparator expands PNT+ inside its repository-local closure while this project stops at the external PNT+ package boundary;
- source-line and declaration-command counts are syntax-level implementation statistics, not proof-complexity measures.

The correct next question is not “which number is smaller?” but whether the different decomposition produces measurable effects under controlled interventions.

## Consequences for S2 design

S2b–S2e should use S2a as a boundary-control layer:

1. build measurements must record cache/package state and must not infer complexity from source topology;
2. repair-locality experiments should mutate matched interfaces rather than arbitrary files;
3. semantic-mutation tests should compare where an invalid change is rejected, not merely how many files exist;
4. upgrade experiments must distinguish failures in project-owned modules from failures in external or repository-local third-party support.

## AI-for-science process value

S2a adds a distinct lesson to the #678 case study:

> Reproducibility is not sufficient for a valid scientific metric. An automated system can measure the wrong boundary perfectly. Ownership, packaging, and resolution rules must be fixed before numbers are interpreted.

This is directly relevant to AI-assisted scientific production because an agent can otherwise optimize or compare artifacts using a mechanically reproducible but conceptually invalid proxy.

## Operational observation

The run completed successfully but GitHub emitted a non-blocking warning that the pinned `actions/checkout@11d5960...` action targets Node 20 and is currently being forced onto Node 24. This is not part of the dependency-surface result, but it is retained as a maintenance/environment-drift observation for later infrastructure/upgrade work.

## Exit criterion

S2a is scientifically executed. It becomes an integrated project checkpoint only after this branch passes the canonical exact-head Lean Verification PR gate, merges to `main`, and the merged head is verified. S2b does not start before that integration closes.
