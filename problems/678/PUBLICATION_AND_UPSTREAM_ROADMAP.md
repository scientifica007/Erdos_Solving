# Erdős #678 — Publication and Upstream Roadmap

## Objective

Maximize defensible external value from #678 without reopening the mathematics or overstating novelty.

Two distinct contribution tracks remain:

1. **formal verification / proof engineering:** an independently engineered Lean reconstruction of Cambie's proof with executable differential verification against the Aristotle/Alexeev formalization;
2. **AI-assisted scientific production:** a longitudinal, auditable case study of failure rejection, reconstruction, provenance control, metric design, reproducibility, and scientific claim calibration.

Cambie's theorem is known mathematics. We do not claim a new solution, independent new mathematical proof, or formalization priority.

## Track A — formal verification / proof engineering

Candidate title:

**A Modular Independent Lean Reconstruction of Cambie's Solution to Erdős Problem #678**

Possible subtitle:

**Differential verification, direct PNT short-interval interfaces, and regression-oriented proof engineering**

The analytic boundary remains a concrete technical differentiator: our development uses `prime_between -> Claim4RelativePrimeProvider`; the public comparator routes through a `pi_alt`/prime-counting layer. S2 measures consequences rather than assuming superiority from source layout.

## S0/S1 — CLOSED

S1 run `32028006457` established common-environment differential verification. Exact-head/post-merge integration closed through PR #22 and closure PR #27. S1 closure commit `7aff8d8d8680e90b34be64650c68c0fc778749fc` passed run `32045885504` with exact provenance, `No update necessary`, and 8808 jobs.

## S2 — ACTIVE

### S2a — dependency surface — CLOSED

S2a established a control, not a ranking: dependency-surface metrics are **boundary-sensitive** because PNT+ is an external Lake dependency internally but repository-local source in the comparator tree. Raw module/file/frontier counts therefore mix proof decomposition, packaging, and ownership.

S2a closed through PR #28 and closure PR #29. Closure merge `c0dff9a6da270ca2fca7da9b8af7d1e64a898ff5` passed run `32050862725`, job `95449629511`, with matching `verified_commit`, `No update necessary`, and 8808 jobs.

### S2b — controlled build behavior — CLOSED

The credited six-replicate run `32053575928` used the same pinned Lean 4.33 / Mathlib / PNT+ environment and alternating execution order. Its cold wall medians were `159.575 s` internal versus `156.280 s` comparator, but paired differences changed sign and ranged `-10.68..+11.73 s`; therefore there is **no stable wall-clock winner**.

Resource profiles differed materially: median total CPU `241.155 s` versus `486.475 s`, max RSS `7,183,766` versus `7,828,930 KiB`, with the internal layout using much more system CPU and the comparator much more user CPU. This is pinned-environment execution-profile evidence, not universal speed or architecture superiority.

The first six-job pilot remains excluded because required runner-version provenance was missing even though computation was green. The apparatus was made fail-closed and the whole experiment rerun.

PR #30 integrated the substantive evidence; closure PR #31 merged as `cc55073fceddb51e3fa2c1854f797fe989523985` and that exact merge passed run `32060186755`, job `95479480527`, with `No update necessary` and 8808 jobs.

### S2c — repair locality — EXECUTED / VALIDATED / PENDING INTEGRATION

Protocol: `S2_REPAIR_LOCALITY_PROTOCOL.md`.

Frozen manifest: `S2_REPAIR_LOCALITY_MUTATIONS.yaml`.

Result: `S2_REPAIR_LOCALITY_BASELINE.md/.json`.

#### Prospective design

The protocol and three matched mutations were frozen at commit `a2d1d11c3c2ad5d39b44be829add4c3a1d75abe1` **before the harness was created and before any observation**. The experiment measures declaration-name/API reference blast radius only; statement and proof-body changes are forbidden, no aliases are allowed, repair is exact downstream identifier substitution, and third-party edits must remain zero.

Matched logical layers:

- R1 analytic-input closure: `claim4RelativePrimeProviderOfPNT` ↔ `density_proof`;
- R2 eventual construction: `claim4_exists_cambie_lcm_ratio_eventually_of_pnt` ↔ `exists_xy_for_large_k`;
- R3 strong public endpoint: `cambie_lcm_ratio_eventually_with_large_start_real` ↔ `main_theorem_given_pnt`.

These are matched by logical role, not textual proposition identity. That limitation is retained explicitly.

#### Execution and artifact integrity

- frozen internal baseline: `cc55073fceddb51e3fa2c1854f797fe989523985`;
- apparatus commit: `00d340d3ccdc13418615b6526e9b736d9f9e03e7`;
- run `32062501296`, job `95486770197` — **SUCCESS**;
- comparator `6f906fef432892db5c910c48ad1a3728dd42cdac`, blob `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`;
- artifact ID `9299556049`;
- artifact SHA-256 `0369ec66c689572307660765b0c84cd86b6339f4f4d26a788c560ca11f7b7f4b`;
- independent downloaded-ZIP SHA-256 recomputation: **exact match**.

All six artifact×mutation cases produced the expected unresolved-symbol failure and all six legal identifier-only repairs returned green. Third-party/dependency touches were zero. All three internal repairs passed `lake exe mk_all --check` with `No update necessary` and full **8808-job** builds.

#### Raw result

| layer | internal repaired refs | comparator repaired refs |
|---|---:|---:|
| R1 analytic closure | 3 = 2 production + 1 verification | 1 production |
| R2 eventual construction | 2 = 1 production + 1 verification | 1 production |
| R3 strong endpoint | 2 verification, 0 production | 3 production |

The finding is **mixed and interface-layer dependent**:

- R1/R2 expose more static downstream references internally, partly through deliberate dedicated tests;
- R3 reverses at the production layer: the internal normalized strong endpoint has zero production downstream consumers, while the comparator endpoint has three;
- raw totals (`7` internal vs `5` comparator) are not a maintainability ranking;
- separating production and verification references changes the picture: internal totals `3` production + `4` verification, comparator `5` production under the frozen classification.

**Defensible S2c conclusion:** for these three predeclared matched interfaces, API/reference repair locality depends on logical layer and consumer class. **No uniform repair-locality advantage is observed.**

This is scientifically valuable negative/mixed evidence because it rejects a tempting inference from the modular source layout to general maintainability superiority.

S2c still does not measure human repair time, cognitive effort, semantic robustness, proof complexity, or upgrade robustness.

### S2d — semantic/index mutation resistance — NEXT AFTER S2c INTEGRATION

S2d will replay controlled semantic/index perturbations inspired by the historical off-by-one failure and measure the earliest rejection layer. It must be prospectively specified before observing any mutation outcome.

S2d is blocked until S2c:

1. completes state/evidence synchronization;
2. passes exact-head canonical CI on its final PR head;
3. merges;
4. passes post-merge canonical verification on the resulting exact `main` commit;
5. closes its integration state.

### S2e — upgrade robustness — PLANNED

Run isolated Lean/Mathlib upgrade probes and measure failure/repair surfaces with project-owned versus dependency-support attribution.

### S2f — independent audit — PLANNED

After quantitative S2 results stabilize, have an independent reviewer inspect statement, metric, assumption, dependency, and interpretation boundaries.

## Track B — AI-assisted scientific production

Candidate title:

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

The case does **not** show AI discovering #678. Its value is the observable process record: false generalization, machine rejection, retained negative knowledge, reconstruction mode, interface decomposition, pinned dependency closure, side-condition recovery, state/build synchronization, differential verification, verification-credit correction, infrastructure/proof-failure classification, public-artifact closure, metric-boundary validation, prospective experiment definition, and preservation of mixed/null comparative results.

S2 now contributes three concrete methodology episodes:

- **S2a:** a metric can be reproducible yet scientifically misleading if ownership/dependency boundaries make its proxy incomparable;
- **S2b:** a workflow can be computationally green yet scientifically inadmissible when a predeclared provenance field is missing; the full pilot was discarded and rerun;
- **S2c:** a predeclared comparison can yield a mixed result that contradicts a simple architectural story; the mutation set was not redesigned after observation, and the mixed result is retained.

These are externally auditable process/evidence episodes and do not require publishing hidden chain-of-thought.

### S4 empirical extension

After S2 stabilizes, derive a machine-readable episode dataset and annotate observable failure/intervention classes, restart/state controls, negative-memory effects, tool/model identities, cost/time, and human interventions. Do not publish hidden model chain-of-thought.

## Track C — upstream/community contribution

After S2 evidence:

- probe a minimal public-formalization refactor from `pi_alt` toward `prime_between` and measure actual proof/build effects before proposing upstream;
- consider compact statement-normalization lemmas for upstream use;
- package reusable positive/negative/off-by-one regressions where appropriate;
- preserve exact attribution to Cambie, Aristotle, Alexeev, PNT+ authors/maintainers, and benchmark projects.

The comparator remains an immutable external fetch rather than vendored material because no repository license was detected for it during the audit.

## Claim ladder

**Established:** known Cambie mathematics; prior Aristotle/Alexeev formalization; independent Lean reimplementation; direct `prime_between` boundary; machine-checked statement bridges; unchanged public-comparator compilation; matching selected standard-axiom footprint; public Apache-2.0 artifact; S1 differential verification; S2a boundary-sensitive structural baseline; S2b six-replicate resource baseline with no stable wall-time winner; S2c prospectively defined six-observation API/reference repair-locality baseline with zero third-party touches and a mixed interface-dependent result.

**Supported interpretation:** independent formal replication has differential-verification value; execution provenance and metric-boundary auditing are scientifically relevant; resource profiles differ under the S2b environment; S2c provides no uniform repair-locality winner and demonstrates that consumer class/interface layer materially affects static API repair blast radius.

**Still requires later evidence:** general maintainability, human repair effort, earlier semantic-drift rejection, upgrade robustness, causal explanations for S2b resource differences, causal benefit of project state protocols.

**Unsupported:** new solution, new independent mathematical proof, first Lean formalization, general architecture superiority, universal speed advantage, general maintainability superiority, autonomous AI authorship percentage.

## Stage plan

- **S0:** COMPLETE.
- **S1:** COMPLETE / VERIFIED.
- **S2:** ACTIVE.
  - **S2a:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2b:** COMPLETE / INTEGRATED / CLOSURE VERIFIED.
  - **S2c:** EXECUTED / ARTIFACT VALIDATED / PENDING PR INTEGRATION.
  - **S2d:** NOT STARTED; next only after S2c integration/closure.
  - **S2e:** NOT STARTED.
  - **S2f:** NOT STARTED.
- **S3:** NOT STARTED.
- **S4:** NOT STARTED.
- **S5:** NOT STARTED.

## Repository governance follow-up

The repository is Public and Apache-2.0 licensed. No ruleset was detected immediately after public transition. Protect `main` before accepting outside contributions so normal integration requires PR + Lean Verification and force pushes/deletions are blocked.

## Stop condition

All work in this roadmap concerns archived Erdős #678. It **does not** authorize selection, exploration, or formalization of another Erdős problem. `DEC-012` remains in force.
