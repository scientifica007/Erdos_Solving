# Erdős #678 — Publication-Readiness License Audit

## Purpose

This is an operational publication-readiness audit for the #678 scientific dossier. It records license metadata that affects how a public artifact should be packaged.

It is not a legal opinion. Repository owners/maintainers remain responsible for licensing choices and, where needed, obtaining permission or clarification from upstream authors.

## Current observations — 2026-08-17

### 1. This repository: `scientifica007/Erdos_Solving`

- visibility at this checkpoint: private;
- GitHub repository license metadata: none detected;
- user authorization: **public-visibility preparation and intended public transition explicitly authorized**;
- actual visibility transition: not yet executed at this checkpoint;
- project-owned license: undecided.

Publication implication:

> Choose and add an explicit license for material owned by this project before, or immediately with, the public transition so that scientific reuse rights are not ambiguous.

The license choice itself is a user/project-owner decision and is not made automatically by this audit.

### 2. `leanprover-community/mathlib4`

GitHub reports:

- license: Apache License 2.0 (`Apache-2.0`).

The successful S1 common-environment experiment resolved Mathlib revision:

`db584cd6d46c92f209a44c0f1c829460d327499d`.

Mathlib is consumed as a normal external package dependency and is not vendored by this project.

### 3. `AxiomMath/PrimeNumberTheoremAnd`

GitHub reports:

- license: Apache License 2.0 (`Apache-2.0`).

Our formalization consumes this project as a pinned Git dependency rather than copying its source into the #678 modules.

Publication packaging preserves the exact dependency revision:

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### 4. `google-deepmind/formal-conjectures`

GitHub reports:

- license: Apache License 2.0 (`Apache-2.0`).

Our scientific comparison uses its #678 statement as a reference/normalization target. We do not need to redistribute the project to state or machine-check our internal bridge.

### 5. Public comparator: `plby/lean-proofs`

At the audited comparison state:

- visibility: public;
- GitHub repository license metadata: none detected;
- no root `LICENSE` file was found by the audit at the pinned comparator state;
- the #678 source is attributed to Aristotle and Boris Alexeev as formal authors and Stijn Cambie as mathematical author.

Publication implication:

> Do not vendor or redistribute the comparator source inside our artifact solely because the repository is public. Keep the current reproduction model—fetch a pinned external commit/blob at experiment time—unless an explicit license or permission to redistribute is established.

The successful S1 experiment fetched the public source ephemerally, verified its commit/blob, compiled it unchanged, and did not persist it in this repository.

If a future paper/artifact needs a vendored comparator snapshot, first request licensing/redistribution clarification from the comparator maintainers or otherwise establish the applicable license.

## Recommended artifact boundary

For the first public #678 artifact, use this packaging model:

1. distribute only project-owned/licensed material plus normal package-manager dependencies;
2. pin external repositories by immutable commit/revision;
3. fetch the public comparator ephemerally in reproduction scripts instead of vendoring it;
4. verify comparator commit and file blob before compilation;
5. cite mathematical and formal authors explicitly;
6. maintain root `THIRD_PARTY_NOTICES.md` describing dependencies and comparison inputs;
7. choose an explicit license for this project's own code/docs before or at the visibility change.

This keeps reproducibility and redistribution separate: a comparison can be fully reproducible from an external pin without copying third-party source into our artifact.

## License/provenance checklist before public release

- [x] User explicitly authorizes preparation for public release / visibility change.
- [ ] Repository visibility actually changed to public.
- [ ] Project-owned code license chosen and committed.
- [ ] Documentation/data license choice recorded if different from code.
- [ ] Copyright/author attribution policy recorded.
- [x] `THIRD_PARTY_NOTICES.md` created.
- [x] Mathlib repository currently reports Apache-2.0.
- [x] PNT+ repository currently reports Apache-2.0.
- [x] Formal Conjectures currently reports Apache-2.0.
- [x] Public comparator is consumed by immutable pin rather than vendored.
- [ ] Comparator redistribution rights clarified before any vendoring.
- [ ] Paper bibliography/provenance credits Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and relevant benchmark projects appropriately.

## Related public-release audit

See `problems/678/PUBLIC_RELEASE_AUDIT_2026-08-17.md` for the broader secret/workflow/repository-exposure preflight and controlled public-transition sequence.

## Scientific-process value

This audit is part of the broader AI-assisted-production lesson from #678:

> A research artifact is not publication-ready merely because the theorem is machine-checked. Reproducibility, provenance, licensing, attribution, redistribution boundaries, secret hygiene, and public-CI hardening are separate closure obligations.

## Scope gate

This audit concerns publication readiness of archived #678 only. It does not authorize work on another Erdős problem. `DEC-012` remains in force.
