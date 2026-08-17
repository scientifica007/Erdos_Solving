# Erdős Problem #678 — Machine-Checked Cambie Reconstruction

> **Mathematical status (2026-08-17): COMPLETE / MACHINE-CHECKED / INTEGRATED / POST-MERGE VERIFIED / ARCHIVED.**
>
> **Scientific-evaluation status: S1 COMPLETE / INTEGRATED / POST-MERGE VERIFIED. S2 ACTIVE; current substage S2a measures dependency-surface structure.**
>
> The successful route is an external-proof reconstruction of Cambie (2024) and an independent Lean reimplementation. It is neither a new mathematical proof nor the first Lean formalization. Per `DEC-012`, no other Erdős problem may be activated without explicit user authorization.

## Canonical result

Let `M(n,k) = lcm{n+1,...,n+k}`. The final Lean graph includes `erdos678_unbounded_witnesses`, `erdos678_good_lengths_infinite`, and the stronger preceding Cambie construction.

The analytic dependency is pinned to `AxiomMath/PrimeNumberTheoremAnd@2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`, and the application adapter consumes its machine-checked `prime_between` theorem. No custom prime-density axiom remains in the credited theorem.

## Scientific classification

- mathematical author/result: Stijn Cambie / known solution;
- independent mathematical attempt in this repository: rejected;
- project mode: external-proof reconstruction;
- formal artifact: independent Lean reimplementation;
- new mathematical proof claim: **no**;
- first Lean formalization claim: **no**;
- prior public formalization: Aristotle + Boris Alexeev;
- executable differential verification against pinned public artifact: **yes**.

## S1 — CLOSED

S1 experiment run `32028006457` built the canonical graph with **8808 jobs** and compiled `plby/lean-proofs@6f906fef432892db5c910c48ad1a3728dd42cdac` `Erdos678.lean` unchanged inside this repository's Lean 4.33 / Mathlib / PNT+ environment.

Machine-checked bridges align interval semantics, the Formal-Conjectures-style eventual-nonempty reading, unbounded/infinite admissible lengths, and the public real-factor `C ≥ 1` strong-theorem domain. Selected internal/public endpoints exposed `[propext, Classical.choice, Quot.sound]` only.

PR #22 passed exact-head run `32043807200`, merged as `358cd541ff81a2b59611b7addfc90ae17e03b36f`, and passed post-merge verification in run `32044314748` attempt 2. Closure PR #27 merged as `7aff8d8d8680e90b34be64650c68c0fc778749fc` and passed post-merge run `32045885504` with exact checkout provenance, `No update necessary`, and 8808 jobs.

## S2a — dependency surface — ACTIVE

S2a asks a narrower question than “which proof is better?”: **what is the reproducible module/import dependency structure of the two already-verified artifacts under explicit source/ownership boundaries?**

Protocol: `S2_DEPENDENCY_SURFACE_PROTOCOL.md`.

Analyzer: `experiments/s2_dependency_surface.py`.

Fixed comparator identity:

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- entry blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.

Canonical-result profile:

- internal entry: `Formalization.Erdos678.Erdos678Final`;
- comparator entry: `ErdosProblems.Erdos678`.

The analyzer recursively parses Lean imports and records local modules/edges/depth, external frontier, source lines, declaration-command counts, and full auditable edge lists. Crucially it separates `artifact_owned`, `repository_local_support`, and `third_party_repository_local_support`.

This prevents a packaging artifact from becoming a scientific conclusion: PNT+ is external through Lake in this project, while the comparator repository physically contains `src/latest/PrimeNumberTheoremAnd/...`.

**Interpretation limit:** S2a structural counts do not by themselves establish lower coupling, easier maintenance, faster builds, or greater robustness. Those require later S2 controlled experiments.

## Public artifact

The repository is Public and project-owned material is Apache-2.0. `THIRD_PARTY_NOTICES.md` records third-party/provenance boundaries. The comparator remains an immutable external fetch and is not vendored because no repository license was detected for it during the audit.

No repository ruleset was detected immediately after public transition. Protecting `main` in GitHub remains a governance task before accepting outside contributions.

## Operational stop rule

#678 mathematics remains frozen/archived. **Do not select, activate, resume, research, or formalize another Erdős problem until the user explicitly authorizes the transition.**
