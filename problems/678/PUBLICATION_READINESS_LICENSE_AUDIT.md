# Erdős #678 — Publication-Readiness License Audit

## Purpose

This is an operational publication-readiness audit for the #678 scientific dossier. It records license metadata that affects how a future public artifact should be packaged.

It is not a legal opinion. Before public release, repository owners/maintainers should make the licensing choices and, where needed, obtain permission or clarification from upstream authors.

## Current observations — 2026-08-17

### 1. This repository: `scientifica007/Erdos_Solving`

- visibility: private;
- GitHub repository license metadata: none detected;
- current public-release authorization: none — the repository must remain private unless the user explicitly authorizes publication.

Publication implication:

> Before releasing a public source/artifact snapshot, choose and add an explicit license for the material owned by this project, and make the provenance/third-party boundaries clear.

The license choice itself is a user/project-owner decision and is not made automatically by this audit.

### 2. Public comparator: `plby/lean-proofs`

At the current comparison repository state:

- visibility: public;
- GitHub repository license metadata: none detected;
- no root `LICENSE` file was found by the audit at the pinned comparator state;
- the #678 source is attributed to Aristotle and Boris Alexeev as formal authors and Stijn Cambie as mathematical author.

Publication implication:

> Do not vendor or redistribute the comparator source inside our future artifact solely because the repository is public. Keep the current reproduction model—fetch a pinned external commit/blob at experiment time—unless an explicit license or permission to redistribute is established.

This is one reason the successful S1 experiment intentionally fetched the public source ephemerally, verified its commit/blob, compiled it unchanged, and did not persist it in this repository.

If a future paper/artifact needs a vendored comparator snapshot, first request licensing/redistribution clarification from the comparator maintainers or otherwise establish the applicable license.

### 3. `AxiomMath/PrimeNumberTheoremAnd`

GitHub reports:

- license: Apache License 2.0 (`Apache-2.0`).

Our formalization consumes this project as a pinned Git dependency rather than copying its source into the #678 modules.

Publication packaging should preserve the exact dependency revision:

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### 4. `google-deepmind/formal-conjectures`

GitHub reports:

- license: Apache License 2.0 (`Apache-2.0`).

Our scientific comparison uses its #678 statement as a reference/normalization target. We do not need to redistribute the project to state or machine-check our internal bridge.

## Recommended artifact boundary

For the first public #678 artifact, prefer this packaging model:

1. distribute only material owned/licensed for this project plus normal package-manager dependencies;
2. pin external repositories by immutable commit/revision;
3. fetch the public comparator ephemerally in reproduction scripts instead of vendoring it;
4. verify comparator commit and file blob before compilation;
5. cite mathematical and formal authors explicitly;
6. include a `THIRD_PARTY_NOTICES`/provenance document describing dependencies and comparison inputs;
7. choose an explicit license for this project's own code/docs before changing visibility or publishing a release.

This keeps reproducibility and redistribution as separate concerns: a comparison can be fully reproducible from an external pin without copying third-party source into our artifact.

## License/provenance checklist before public release

- [ ] User explicitly authorizes public release / visibility change.
- [ ] Project-owned code license chosen and committed.
- [ ] Documentation/data license choice recorded if different from code.
- [ ] Copyright/author attribution policy recorded.
- [ ] `THIRD_PARTY_NOTICES` created.
- [ ] Mathlib and all direct dependency licenses checked at pinned revisions.
- [x] PNT+ repository currently reports Apache-2.0.
- [x] Formal Conjectures currently reports Apache-2.0.
- [x] Public comparator is consumed by pin rather than vendored.
- [ ] Comparator redistribution rights clarified before any vendoring.
- [ ] Paper bibliography/provenance credits Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and relevant benchmark projects appropriately.

## Scientific-process value

This audit is part of the broader AI-assisted-production lesson from #678:

> A research artifact is not publication-ready merely because the theorem is machine-checked. Reproducibility, provenance, licensing, attribution, and redistribution boundaries are separate closure obligations.

This is another reason to preserve an explicit archival/publication stage after theorem completion.

## Scope gate

This audit concerns publication readiness of archived #678 only. It does not authorize publication, a visibility change, or work on another Erdős problem. `DEC-012` remains in force.
