# Erdős #678 — Publication-Readiness License Audit

## Purpose

This operational audit records licensing/provenance decisions affecting the public #678 artifact. It is not legal advice.

## Current status — 2026-08-17

### Project-owned material — CLOSED

The repository owner selected **Apache License 2.0** for project-owned material. The full standard license text is committed at root `LICENSE` and was merged to `main` via license-only PR #26 at

`87cf560451ef5aa4714069d52a3851c1f8547f70`.

The repository is now public, and GitHub recognizes its license metadata as `Apache-2.0`.

Unless a file or third-party notice states otherwise, project-owned code, documentation, configuration, and research artifacts are distributed under Apache-2.0.

### Mathlib

`leanprover-community/mathlib4` reports Apache-2.0. The successful S1 experiment resolved Mathlib revision

`db584cd6d46c92f209a44c0f1c829460d327499d`.

Mathlib is consumed as an external dependency and is not vendored by this project.

### PrimeNumberTheoremAnd

`AxiomMath/PrimeNumberTheoremAnd` reports Apache-2.0. The formalization consumes it as a pinned Git dependency at

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

### Formal Conjectures

`google-deepmind/formal-conjectures` reports Apache-2.0. The project uses its #678 statement as a reference/normalization target; redistribution of the project is unnecessary for the internal bridge.

### Public comparator: `plby/lean-proofs`

At the audited comparison state:

- visibility: public;
- no repository license metadata was detected;
- no root `LICENSE` file was found at the audited pin;
- #678 source is attributed to Aristotle and Boris Alexeev as formal authors and Stijn Cambie as mathematical author.

Therefore the comparator remains **external and non-vendored**. The S1 reproduction model fetches an immutable commit/blob ephemerally, verifies identity, compiles it unchanged, and does not persist comparator source in this repository.

If a future artifact needs a vendored comparator snapshot, first establish applicable redistribution rights or obtain clarification/permission from its maintainers.

## Public artifact boundary

The current packaging rule is:

1. distribute project-owned material under Apache-2.0;
2. preserve third-party notices and independent licenses;
3. pin external dependencies by immutable revision;
4. fetch the public comparator ephemerally instead of vendoring it;
5. verify comparator commit/blob before compilation;
6. cite mathematical and formal authors explicitly;
7. maintain root `THIRD_PARTY_NOTICES.md`.

This separates reproducibility from redistribution: comparison can be reproducible from immutable external pins without copying source whose redistribution status is unclear.

## Checklist

- [x] User authorized public-release preparation and public transition.
- [x] Repository visibility changed to public.
- [x] Project-owned license chosen: Apache-2.0.
- [x] Root `LICENSE` committed and merged to `main`.
- [x] GitHub recognizes repository license as Apache-2.0.
- [x] `THIRD_PARTY_NOTICES.md` created.
- [x] Mathlib currently reports Apache-2.0.
- [x] PNT+ currently reports Apache-2.0.
- [x] Formal Conjectures currently reports Apache-2.0.
- [x] Public comparator remains an immutable external fetch rather than vendored.
- [ ] Comparator redistribution rights must be clarified before any future vendoring.
- [ ] Final paper bibliography/provenance must credit Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and relevant benchmark projects as appropriate.

## Scientific-process value

A theorem being machine-checked is not sufficient for publication readiness. Reproducibility, provenance, licensing, attribution, redistribution boundaries, secret hygiene, and CI execution provenance are separate closure obligations.

## Scope gate

This audit concerns archived #678 only. It does not authorize work on another Erdős problem. `DEC-012` remains in force.
