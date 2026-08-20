# Erdős #678 Reproducibility Package — Workplan R0–R7

## Objective

Turn the completed #678 project into a clean reproducible research object that a new researcher or AI agent can inspect, rebuild, audit, and use as the common factual basis for the two planned scientific papers.

The historical directory `problems/678/` remains intact. The reproducibility package is a curated view, not a rewritten history.

## R0 — Design and scope freeze

**Goal:** define the clean-room package boundary before copying or generating material.

Rules:

- #678 only;
- no duplicate Lean source tree;
- historical failures/corrections remain in the archive;
- package claims must be traceable to persistent evidence;
- mathematical attribution and formal-verification attribution remain separate;
- no unsupported novelty or generality claims.

**Exit:** directory architecture, source-of-truth rules, and reproduction semantics fixed.

## R1 — Package skeleton and manifest

**Goal:** create a navigable package with machine-readable metadata.

Required outputs:

- `README.md`;
- `REPRODUCIBILITY_MANIFEST.json`;
- `REPRODUCE.md`;
- mathematics, formalization, verification, evaluation, evidence, papers, and scripts sections.

**Exit:** all required paths exist and the manifest validates against the repository.

## R2 — Claim–evidence model

**Goal:** make scientific claims auditable before manuscript prose is written.

Required outputs:

- `CLAIM_EVIDENCE_MATRIX.json`;
- stable claim IDs;
- classes: `established`, `bounded-observation`, `hypothesis`, `unsupported`;
- primary evidence path(s);
- admissible scope and limitations;
- publication allow/deny state.

**Exit:** every planned headline claim in either paper maps to an evidence-backed claim ID or is explicitly prohibited.

## R3 — Reproduction scripts

**Goal:** provide a single entry point for package and proof verification.

Required checks:

1. manifest and JSON consistency;
2. exact Lean toolchain pin;
3. exact Mathlib and PNT+ resolved revisions;
4. canonical theorem declarations present in the referenced source files;
5. positive and negative regression tests retained;
6. evidence paths present;
7. paper claim allowlists refer only to registered claims;
8. no `.lean` proof source duplicated inside this package;
9. `lake exe mk_all --check`;
10. full `lake build Formalization`.

**Exit:** `scripts/reproduce.sh` fails closed and emits an explicit success marker only after all checks pass.

## R4 — Clean-room CI reproduction

**Goal:** test the package from a fresh GitHub Actions checkout rather than relying on a local working environment.

Implementation rule:

- package-consistency verification is part of the canonical Lean Verification job;
- the existing canonical import-graph and full-build gate remains unchanged in meaning;
- verification credit belongs to the exact PR head and, after merge, the exact resulting `main` commit.

**Exit:** exact-head CI passes package validation plus canonical Lean verification.

## R5 — Independent-reader audit

**Goal:** make the package understandable without hidden project context.

Audit questions:

- Can the exact problem statement be recovered unambiguously?
- Is the Cambie attribution explicit?
- Can the final theorem dependency path be understood from the package?
- Are statement/index conventions explicit?
- Are failed/rejected witnesses preserved as regressions?
- Can every central paper claim be traced to evidence?
- Are excluded experiments and interpretation limits visible?

**Exit:** no material ambiguity remains between historical record, canonical result, and publication-facing fact base.

## R6 — Freeze v1

**Goal:** make the package a stable research object.

Freeze contents:

- package version `v1`;
- exact environment pins;
- theorem entry points;
- evidence index;
- claim matrix;
- reproduction command;
- exact merged repository commit as an immutable Git object.

A DOI or external archival release is a later publication operation and is not required for the repository-level v1 freeze.

**Exit:** merged v1 is reproducible by exact commit.

## R7 — Paper foundation

**Goal:** prevent Paper 1 and Paper 2 from drifting on shared facts while keeping their scientific contributions distinct.

Outputs:

- `papers/SHARED_FACT_BASE.md`;
- `papers/PAPER_1_CLAIMS.json`;
- `papers/PAPER_2_CLAIMS.json`.

Paper 1 focuses on formal verification, statement fidelity, differential verification, proof engineering, and bounded S1/S2 findings.

Paper 2 focuses on long-horizon AI-assisted scientific production, failure handling, provenance, admissibility, governance, and scientific-credit control.

**Exit:** both manuscripts can be drafted from one shared factual substrate without sharing the same contribution narrative.

## Integration gate

This package follows the repository integration discipline:

`dedicated branch → exact-head package + Lean verification → review diff → merge unchanged → exact-main post-merge verification`.

No other Erdős problem is activated by this work.
