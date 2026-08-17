# Third-Party Notices and Scientific Provenance

This file records third-party software, formal artifacts, and mathematical sources used by or compared with `Erdos_Solving` in the Erdős #678 work.

It is a provenance and redistribution-boundary record. It does **not** grant a license to project-owned material in this repository. The repository owner must choose and add a root project license separately.

## Mathlib

- Repository: `leanprover-community/mathlib4`
- Role: direct Lean mathematical library dependency resolved through Lake.
- Resolved revision in the successful S1 common-environment experiment: `db584cd6d46c92f209a44c0f1c829460d327499d`.
- GitHub license metadata checked on 2026-08-17: Apache License 2.0 (`Apache-2.0`).
- Packaging boundary: consumed as an external package dependency; project source does not vendor Mathlib.

## PrimeNumberTheoremAnd

- Repository: `AxiomMath/PrimeNumberTheoremAnd`
- Role: formal analytic-number-theory dependency used to discharge the prime-density boundary in Erdős #678.
- Pinned revision: `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.
- Consumed theorem boundary: `prime_between`, adapted by `Formalization.Erdos678.Claim4RelativePrimePNT.claim4RelativePrimeProviderOfPNT`.
- GitHub license metadata checked on 2026-08-17: Apache License 2.0 (`Apache-2.0`).
- Packaging boundary: consumed as a pinned external Git/Lake dependency; project #678 modules do not vendor its source.

## Formal Conjectures

- Repository: `google-deepmind/formal-conjectures`
- Role: external formal-statement/reference target for normalizing the semantics of Erdős #678.
- Comparison snapshot recorded in the #678 evidence ledger: commit `398958d3964d738886bd24433918c365df4a2aab`.
- GitHub license metadata checked on 2026-08-17: Apache License 2.0 (`Apache-2.0`).
- Packaging boundary: referenced for statement comparison; no Formal Conjectures source needs to be redistributed in this repository.

## Public Aristotle/Alexeev comparator

- Repository: `plby/lean-proofs`.
- Erdős #678 formal authorship recorded by the comparison source/project materials: Aristotle and Boris Alexeev.
- Common-environment comparator commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`.
- Comparator file blob used by the successful S1 experiment: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.
- GitHub repository license metadata checked on 2026-08-17: no declared repository license was detected.
- Root-license audit at the pinned comparator state: no root `LICENSE` file was found by this project's audit.
- Packaging boundary: **do not vendor or redistribute this comparator source solely because it is publicly readable.** The reproducibility script fetches the immutable external commit/file at experiment time, verifies the expected commit/blob, compiles it unchanged, and discards the temporary copy.
- If a future artifact needs to redistribute a snapshot, establish the applicable license or obtain permission first.

## Mathematical provenance — Erdős Problem #678

- The successful mathematical route in this repository reconstructs Stijn Cambie's 2024 proof of Erdős Problem #678.
- Cambie is the mathematical author of the proof being reconstructed.
- This project does not claim a new independent mathematical proof or first formalization.
- The project's contribution is classified separately as an independent Lean reimplementation, differential-verification artifact, proof-engineering study, and AI-assisted scientific-production case study.

Mathematical citation/attribution is distinct from software redistribution licensing. Any paper or public artifact should cite the original mathematical work explicitly in its bibliography.

## Reproducibility principle

Third-party dependencies and comparison sources should be pinned by immutable revision whenever feasible. Reproducibility does not require copying third-party source into this repository when an immutable external fetch plus integrity check is sufficient.

## Project-owned material

No statement in this notice licenses project-owned code, documentation, research records, or datasets. A root project license remains an explicit repository-owner decision and should be added before or at public release.
