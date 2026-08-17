# Erdős #678 — Publication and Upstream Roadmap

## Objective

Maximize defensible external value from #678 without reopening the mathematics or overstating novelty.

Two distinct contribution tracks remain:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal, auditable case study of failure rejection, reconstruction, provenance control, metric design, reproducibility, statement fidelity, and scientific claim calibration.

Cambie's theorem is known mathematics. We do not claim a new solution, independent new mathematical proof, or formalization priority.

## Track A — formal verification / proof engineering

Candidate title:

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

## S0/S1 — CLOSED

S1 established common-environment differential verification against the pinned Aristotle/Alexeev source. Exact-head/post-merge integration and closure are verified.

## S2 — ACTIVE

### S2a — dependency surface — CLOSED / CLOSURE VERIFIED

S2a established a control, not a ranking: dependency-surface metrics are boundary-sensitive because PNT+ lies on different repository ownership boundaries in the two artifacts. Raw file/module counts mix proof decomposition, packaging, and ownership.

### S2b — controlled build behavior — CLOSED / CLOSURE VERIFIED

The credited six-replicate run `32053575928` found no stable wall-clock winner under the pinned common environment. Resource profiles differed materially, but the result is execution-profile evidence rather than universal speed or architecture superiority. A green pilot was excluded in full when predeclared runner-version provenance was missing; the apparatus was made fail-closed and the experiment rerun.

### S2c — repair locality — CLOSED / CLOSURE VERIFIED

S2c froze three matched declaration-rename mutations before harness creation and observation. All six artifact×mutation observations produced the expected unresolved-symbol break and all six legal identifier-only repairs returned green with zero third-party/dependency edits.

The result was deliberately retained as **mixed/interface-dependent**:

| layer | internal repaired refs | comparator repaired refs |
|---|---:|---:|
| R1 analytic closure | 3 = 2 production + 1 verification | 1 production |
| R2 eventual construction | 2 = 1 production + 1 verification | 1 production |
| R3 strong endpoint | 2 verification, 0 production | 3 production |

No uniform repair-locality or maintainability advantage is supported.

PR #32 integrated the substantive evidence. Closure PR #33 final head `3439b58f1e05e2cb21ee1c9374857eb3b4197163` passed run `32070637072`, job `95512851767`, then merged as `47b85a2f2f5be6e6e4ede2b600723b8616aeeee4`. That exact merge passed post-merge run `32071325525`, job `95514986697`, with matching `verified_commit`, `No update necessary`, and **8808 jobs**. S2c is fully closed.

### S2d — semantic/index mutation resistance — PREDECLARED / NOT EXECUTED

#### Research question

When small, type-correct semantic/index perturbations are injected at matched logical interfaces, where is the first observable rejection in each artifact? If a changed statement remains true, can it survive all machine checks and thereby expose the distinction between proof correctness and statement fidelity?

#### Historical anchor

The motivating failure is the retained 2026-08-14 interval-index error: the attempted construction treated `M(t,k+1)` as the block `[t,t+k]` rather than the canonical `[t+1,t+k+1]`. The project later introduced a length-based interval API, independent concrete regressions, statement bridges, and an explicit off-by-one-safe final translation.

#### Frozen mutation set

The protocol and machine-readable manifest are:

- `S2_SEMANTIC_INDEX_MUTATION_PROTOCOL.md`;
- `S2_SEMANTIC_INDEX_MUTATIONS.yaml`.

Exactly three matched mutation pairs are predeclared:

1. **I1 canonical start shift left one** — shift the same-length canonical block from `n+1..n+k` to `n..n+k-1` at the primitive interval convention. This is the closest controlled replay of the historical error.
2. **I2 long block drops final term** — change the strong theorem's `k+1`-term long block to `k` terms with the same start.
3. **I3 strengthened separation control** — change `n+k≤m` to `n+(k+1)≤m` at matched canonical endpoints. This is deliberately a possible semantic-survival control, because a changed but still true theorem may pass verification.

Each mutation is applied independently to a pristine baseline. No repair phase is allowed. The outcome is either first semantic rejection at a predeclared logical stratum or survival through canonical verification.

Internal rejection strata are frozen as:

`L0 mutation source` → `L1 concrete semantic oracle` → `L2 local endpoint regression` → `L3 statement bridge` → `L4 mk_all` → `L5 full canonical build`.

The comparator remains monolithic: the full pinned source is compiled and the first error line/enclosing declaration is recorded. Synthetic splitting is forbidden.

#### Predeclaration gate

At this checkpoint:

- S2d harness: **not created**;
- mutations executed: **0/6**;
- outcomes observed: **none**.

The predeclaration-only PR must first pass exact-head canonical CI, merge, and pass exact-main post-merge verification. Only then may an apparatus branch be created and the six frozen observations executed.

### S2e — upgrade robustness — PLANNED

Run isolated Lean/Mathlib upgrade probes and measure failure/repair surfaces with project-owned versus dependency-support attribution.

### S2f — independent audit — PLANNED

After quantitative S2 results stabilize, have an independent reviewer inspect statement, metric, assumption, dependency, and interpretation boundaries.

## Track B — AI-assisted scientific production

Candidate title:

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

The case does **not** show AI discovering #678. Its value is the externally auditable process record.

S2 now contributes four methodology episodes:

- **S2a:** a metric can be reproducible yet scientifically misleading when ownership/dependency boundaries make the proxy incomparable;
- **S2b:** a workflow can be computationally green yet scientifically inadmissible when a predeclared provenance field is missing;
- **S2c:** a predeclared comparison can yield a mixed result that contradicts a simple architectural story, and that result must be retained;
- **S2d design:** machine checking can reject semantic drift at different layers, but a changed-yet-true target may survive, so statement fidelity is a separate control from proof validity.

These are externally auditable process/evidence episodes and do not require publishing hidden chain-of-thought.

## Track C — upstream/community contribution

After S2 evidence:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure actual proof/build effects before proposing upstream;
- consider compact statement-normalization lemmas for upstream use;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

The comparator remains an immutable external fetch rather than vendored material because no repository license was detected for it during the audit.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; common-environment differential verification; closure-verified S2a structural control; closure-verified S2b resource baseline; closure-verified S2c repair-locality baseline with a mixed interface-dependent result.

**Predeclared but not yet evidenced:** S2d semantic/index rejection-depth behavior. No S2d outcome may be claimed until the frozen experiment is executed and integrated.

**Still requires later evidence:** general maintainability, human repair effort, general semantic robustness, upgrade robustness, causal explanations for S2b resource differences, causal benefit of state protocols.

**Unsupported:** new solution, new independent mathematical proof, first Lean formalization, general architecture superiority, universal speed advantage, general maintainability superiority, autonomous AI authorship percentage.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2b:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2c:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2d:** PREDECLARED / NOT EXECUTED / PENDING PREDECLARATION INTEGRATION.
  - **S2e:** NOT STARTED.
  - **S2f:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. Protect `main` before accepting outside contributions so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.