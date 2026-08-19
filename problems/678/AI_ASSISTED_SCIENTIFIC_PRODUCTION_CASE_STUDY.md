# Erdős #678 — AI-Assisted Scientific Production Case Study

## Status

**Revision 2 — evidence cutoff: 2026-08-18.**

This document treats the completed Erdős #678 effort as a longitudinal empirical case study in **AI-assisted production, verification, evaluation, and governance of research-grade mathematical material**.

The mathematical theorem itself is not new. Stijn Cambie supplied the successful mathematics in 2024. This repository records a failed independent mathematical attempt followed by an **external-proof reconstruction** and an **independent Lean reimplementation** of Cambie's argument. A public Lean formalization by Aristotle and Boris Alexeev predates this reconstruction. Accordingly, this case study makes no claim of a new solution, a new independent mathematical proof, or a first formalization.

The experimental object is the production process. The observable record spans 2026-08-13 through the final scientific-evaluation closure on 2026-08-18. It includes the transition from an attractive but invalid independent idea to a machine-checked reconstruction, differential verification against a public formal artifact, controlled structural/build/repair/mutation experiments, a forward-version robustness experiment, and the governance rules used to decide which outputs were scientifically admissible.

The evidential record does **not** depend on hidden model reasoning. It consists of externally auditable artifacts: repository history, written candidate arguments, failed constructions, formal statements, Lean files, regression tests, dependency pins, protocols frozen before observation, candidate/mutation manifests, CI runs, pull requests, machine-readable evidence, excluded runs, corrections, artifact hashes, state documents, and explicit human/user decisions.

Authoritative end-state references are `PROJECT_STATE.md`, `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md`, and `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`. At the evidence cutoff, the mathematics, S1, and S2a–S2e are closed and machine-verified; S2 is complete.

---

## 1. Why #678 is a useful AI-for-science case

Many theorem-proving benchmarks reduce evaluation to a binary endpoint: theorem closed or theorem not closed. The #678 record exposes a richer sequence of scientific and engineering failure modes:

1. a genuine finite witness was discovered and verified;
2. that witness encouraged a false scaling generalization;
3. a later quotient construction contained an interval-indexing mismatch;
4. exact computation and formal checking rejected the invalid path;
5. failed paths were preserved as provenance and negative-regression knowledge;
6. the project explicitly switched from independent exploration to reconstruction of an external published proof;
7. a long dependency chain was decomposed into formal producer/consumer interfaces;
8. an initially external prime-density gap was discharged through a pinned machine-checked PNT+ dependency;
9. final statement translation required recovering information that an earlier endpoint had discarded;
10. theorem credit was tied to canonical build-graph reachability and exact repository commits;
11. a green pull-request run was later found to support a weaker provenance claim than its metadata suggested, producing a verification-credit correction;
12. common-environment differential verification was completed against an unchanged pinned public comparator;
13. raw dependency-surface metrics were shown to be ownership-boundary sensitive;
14. a computationally successful build-behavior pilot was excluded because predeclared provenance was incomplete;
15. prospectively frozen repair-locality mutations produced a mixed result rather than a uniform winner;
16. a computationally successful semantic-mutation pilot was excluded because its logical classifier was defective;
17. several upgrade-robustness runs were excluded because of instrumentation, classification, or aggregation defects while candidate definitions remained frozen;
18. the credited upgrade experiment legitimately terminated at dependency/package boundaries with no eligible project-owned repair phase;
19. post-merge documentation drift was treated as a process defect and repaired;
20. completion of one benchmark was explicitly prevented from auto-activating another research target.

This sequence separates notions that are often conflated:

- plausible reasoning versus valid reasoning;
- a verified example versus a verified general theorem;
- local lemma closure versus global theorem closure;
- formal source text versus a reachable/buildable proof artifact;
- mathematical correctness versus statement fidelity;
- machine verification versus novelty or historical attribution;
- computational success versus scientific admissibility;
- CI metadata versus the exact tree actually executed;
- an observed failure versus ownership of that failure;
- theorem completion versus reproducible integration;
- reproducible integration versus publication-grade scientific evidence.

---

## 2. Research questions

### RQ1 — Can formal verification stop a productive-looking but invalid mathematical trajectory?

The #678 record contains two concrete early failures: false scaling intuition around a valid witness and an incorrect interval endpoint in a later quotient construction. The observable question is not merely whether Lean rejects a statement, but whether the workflow converts rejection into durable knowledge instead of repeatedly rediscovering the same invalid strategy.

### RQ2 — What controls preserve target fidelity during long-horizon AI-assisted formalization?

Controls developed during #678 include canonical statement locking, a length-based interval API, explicit separation of paper indexing from Erdős indexing, state/roadmap synchronization, historical-snapshot labeling, and a dedicated final index-translation layer.

### RQ3 — Which proof-engineering abstractions help a long proof survive context changes and local repair?

The development moved toward explicit contracts: Claim 4 density interfaces, weighted representation contracts, pair/triple CRT producers, Claim 5 residue interfaces, prime-window providers, a relative-prime provider, and final strong-theorem endpoints.

### RQ4 — How should an AI-assisted scientific workflow change mode after independent discovery fails?

The project explicitly reclassified the successful path as **external-proof reconstruction**. The scientific question is how value can continue to be produced without inflating originality claims after reference-proof access occurs.

### RQ5 — What should count as “verified” in an AI-produced mathematical artifact?

For #678, theorem credit ultimately required both semantic reachability from the canonical graph and verification of the exact repository tree receiving credit. The S1 verification-credit-drift episode further showed that run metadata alone is not sufficient evidence of which commit was actually executed.

### RQ6 — Can process artifacts themselves become reusable scientific output?

The archive contains failed hypotheses, negative tests, theorem-interface evolution, dependency decisions, exact CI checkpoints, exclusion decisions, machine-readable protocols, artifact hashes, and postmortem rules. These are data about formal-scientific production, not merely project-management residue.

### RQ7 — Can computational success be scientifically inadmissible?

S2b, S2d, and S2e contain complete or partially successful computations that were excluded because prospectively required provenance, classification, or complete-set aggregation contracts were not satisfied. This makes scientific admissibility itself an observable workflow property.

### RQ8 — What is gained by prospectively freezing experiments before observation?

S2c–S2e predeclared mutations/candidates, admissibility rules, ownership classes, repair budgets, and interpretation boundaries. The record therefore supports analysis of whether inconvenient mixed, null, early-stopping, or dependency-blocked outcomes were retained rather than redesigned after observation.

---

## 3. Experimental timeline

The dates below are repository-observable milestones. They do not imply that every intermediate reasoning action or model invocation was logged.

### Phase A — finite evidence and invalid generalization — 2026-08-13

The project recorded the failed scaling argument and audited the missing infinitude mechanism.

A valid finite witness, `M(36,8) > M(47,9)`, survived verification. A separate candidate `(495,504,8)` was machine-refuted and retained as a negative regression.

**Lesson:** a correct example can increase confidence in an incorrect generator. Evidence for existence and evidence for infinitude must be tracked separately.

### Phase B — formal infrastructure and statement repair — 2026-08-14

The project created the Lean environment, CI verification, corrected witness regressions, a length-based interval API, and valuation modules.

The interval API was a response to a real semantic failure: `M(n,k)` is the LCM of `n+1,...,n+k`; translating between start points, endpoints, and lengths cannot be left implicit.

**Lesson:** API design can be part of mathematical correctness when notation encodes indexing conventions.

### Phase C — external-proof reconstruction

After the independent route was rejected, the project analyzed Cambie's construction and decomposed it into explicit formal obligations.

The proof was split into Claim 4 and Claim 5 layers, then into CRT, density, valuation, prime-range, scale, placement, and final-translation components.

**Lesson:** after a mode switch from discovery to reconstruction, progress depends on making proof obligations explicit rather than continuing open-ended search under an inaccurate novelty label.

### Phase D — long-horizon interface stabilization

The middle phase progressively built generic density lemmas, modular/weighted CRT interfaces, pair/triple producers, application boxes, scaled affine residue connections, representative separation, prime windows, constructed scales, room bounds, and the Claim 5 product/LCM estimate.

State and roadmap files were repeatedly synchronized so later sessions could resume from stable boundaries.

**Lesson:** versioned external memory is a control against context decay, but its causal benefit remains to be tested prospectively.

### Phase E — analytic dependency closure

The project replaced an abstract prime-density boundary with a pinned import of `AxiomMath/PrimeNumberTheoremAnd` and an adapter from `prime_between` to the relative-prime provider consumed by the construction.

Pinned PNT+ revision:

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

**Lesson:** a formal proof's reproducibility and trust boundary includes dependency provenance, not only theorem text.

### Phase F — final theorem translation

The strong Cambie endpoint initially discarded placement information needed for the canonical Erdős variables `n=x-1` and `m=y-1`. The final layer recovered `k < x` from already proved bounds and threaded it through the endpoint before translation.

**Lesson:** an intermediate interface can be locally sufficient and globally inadequate if it discards downstream-critical invariants.

### Phase G — mathematical integration and archival closure — through 2026-08-17

The mathematical reconstruction was merged through PR #17 after canonical verification. Post-merge verification succeeded on `main`. Documentation synchronization, the explicit post-#678 authorization gate, and the lessons-learned postmortem followed through PRs #18–#20.

This phase is the **mathematical/formalization closure snapshot**, not the end of the later scientific evaluation.

**Lesson:** theorem proving has a distinct closure phase involving integration, attribution, documentation consistency, reproducibility, and explicit stop conditions.

### Phase H — S1 differential verification and provenance correction — 2026-08-17

S1 built the internal canonical graph and then fetched the pinned public Aristotle/Alexeev #678 source from `plby/lean-proofs` commit `6f906fef432892db5c910c48ad1a3728dd42cdac`, identity-checked it, and compiled it unchanged under the same pinned Lean/Mathlib/PNT+ environment.

Core S1 experiment:

- run `32028006457`;
- exact experiment head `b1e3fc60f6dc4f125a125121a2abbcf3610ed749`;
- canonical internal graph: 8808 jobs;
- selected endpoints in both artifacts reported only `[propext, Classical.choice, Quot.sound]`.

S1 also exposed **verification-credit drift**: a historical pull-request run associated with one PR-head SHA had actually checked out a synthetic integration-tree commit. The scientific correction narrowed the claim instead of invalidating a successful build, and the workflow was repaired to record the executed SHA explicitly.

The repository was made public under Apache-2.0 after a release/security/license audit, and S1 was integrated through exact-head and post-merge gates.

**Lesson:** AI-assisted formal science needs verification of provenance claims as well as verification of mathematical propositions.

### Phase I — S2a dependency surface — 2026-08-17

S2a measured structural/dependency surfaces under pinned conditions.

Credited experiment:

- run `32047324807`;
- post-merge canonical graph: 8808 jobs.

Result: raw module/file/frontier counts are **boundary sensitive** because the internal artifact and comparator package dependency ownership differently. Those counts therefore cannot be interpreted directly as proof complexity or architecture quality.

**Lesson:** reproducible metrics can still be scientifically misleading if the ownership boundary is not normalized.

### Phase J — S2b controlled build behavior

A first computationally green pilot, run `32052134207`, completed six successful jobs but was excluded in full because the runner version required by the predeclared provenance schema was missing. This was not performance-selected exclusion.

The credited experiment, run `32053575928`, used six paired replicates with zero retries and zero exclusions.

Observed wall-clock summary:

- internal cold median: 159.575 s;
- comparator cold median: 156.280 s;
- paired difference range: -10.68 s to +11.73 s;
- conclusion: **no stable wall-clock winner**.

Resource profiles differed materially under the pinned environment, including median total CPU and maximum RSS, but the experiment did not establish general speed or maintainability superiority.

**Lesson:** a computationally successful run can still be scientifically inadmissible when a prospectively required provenance field is absent.

### Phase K — S2c repair locality

S2c froze three API-reference mutations prospectively and produced six observations.

Credited run `32062501296` retained:

- 6 observable breaks;
- 6 legal repairs returning green;
- 0 third-party dependency files touched.

Result: repair-reference blast radius was **mixed and interface-layer dependent**. No uniform repair-locality or maintainability winner was observed.

**Lesson:** prospective experiments must retain mixed results rather than forcing an architecture ranking.

### Phase L — S2d semantic/index mutation resistance

S2d froze three one-unit semantic/index perturbations, anchored in part to the historical interval-shift failure. Across two artifacts this yielded six observations.

A computationally successful pilot, run `32074822049`, was excluded in full because the comparator's main-theorem logical classifier was defective. No post-hoc relabeling was used and the frozen mutations/protocol were not changed.

Credited run `32076614547` produced:

- 6 semantic rejections;
- 0 semantic survivors;
- 0 proof repairs;
- 0 third-party dependency-source touches.

First rejection location depended on both mutation and artifact structure; the internal staged strata and comparator declaration classes were not treated as a common ordinal scale.

**Lesson:** semantic robustness evidence requires independent oracles/classifiers whose own validity is part of the experimental apparatus.

### Phase M — S2e forward-version upgrade robustness — 2026-08-18

S2e froze, before candidate execution, an internal baseline, two forward Lean/Mathlib candidates, D0–D6 detection stages, failure-ownership taxonomy, theorem fingerprints, third-party repair prohibition, project-only repair eligibility, and repair budgets.

Baseline:

- source `5039d464f6196e6b47494f0a6fae869e3362d082`;
- Lean 4.33.0;
- resolved Mathlib `db584cd6d46c92f209a44c0f1c829460d327499d`;
- PNT+ `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`;
- canonical graph: 8808 jobs.

Frozen candidates:

1. U1: Lean 4.34.0-rc1 compiler-only, baseline Mathlib/PNT/manifest fixed;
2. U2: Lean 4.34.0-rc1 plus exact root Mathlib `de5ce8a9a66a4aa68a9bdbb35b63a06d34d9ca11`, PNT+ fixed.

Four complete attempts/candidate sets were excluded before scientific credit:

- run `32114757196`: instrumentation-local baseline timeout before candidates;
- run `32139077608`: replacement timeout again stopped before candidates;
- run `32161655865`: D1 package-resolution ownership was omitted by the top-level classifier;
- run `32168529883`: candidate jobs were coherent, but the prospectively required aggregate artifact was not produced because artifact transport failed with HTTP 401.

A synthetic-only transport audit then validated the replacement aggregation path without executing candidates.

The credited complete-set execution was run `32170243744` on exact workflow head `dfb7d1122e0e482626c9849f0e083ecbe71e58be`.

Credited aggregate artifact:

- artifact ID `9337321640`;
- 40 retained files;
- SHA-256 `90f7285496372570e6b7e90e5c3b0dc0437299bcf1a824ddaea33f635171001c`;
- independent re-download/re-hash matched exactly;
- combine audit PASS;
- ownership validation PASS;
- apparatus failures in credited set: 0;
- provenance mismatches: 0;
- repair outputs: 0.

U1 reached D1 and then failed first in Mathlib/transitive dependency code at D2/D3. Deepest green stage: D1. Primary owner: `mathlib_or_transitive_dependency`. No project-owned proof failure was reached.

U2 reached D0 and failed at D1 package resolution before project compilation. Primary owner: `package_resolution`.

Because neither candidate exposed an eligible project-owned failure, the repair phase was **not applicable**: zero repair batches, zero project-owned files repaired, zero third-party dependency-source touches.

**Lesson:** a prospectively frozen experiment may terminate legitimately before the originally imagined repair phase; absence of an eligible measurement is itself a bounded result and must not be replaced by a post-hoc surrogate.

### Phase N — scientific-evaluation closure and state synchronization — 2026-08-18

S2e evidence and scientific-ledger closure were integrated through separate exact-head/post-merge gates. The final state documents were synchronized afterward so that `PROJECT_STATE.md`, the root/problem READMEs, and the publication roadmap agreed that S1 and S2a–S2e were complete.

The authoritative pre-Rev.2 synchronization merge was `c02af74cf0bcc4ce47bd4f5d74c41a00c637e044`; its exact `main` verification completed successfully with `No update necessary` and 8808 jobs.

**Lesson:** operational-state synchronization and publication-narrative synchronization are distinct layers. A project can have a correct authoritative checkpoint while an analytical case-study document remains frozen at an earlier snapshot; publication-facing documents therefore require their own explicit evidence cutoff.

---

## 4. Observable failure taxonomy

| Failure class | #678 instance | Detection/control |
|---|---|---|
| False algebraic generalization | scaling a valid witness | exact computation; proof audit; retained lesson |
| Index/interval semantic drift | wrong block in `M(t,k+1)` | length-based interval API; regression tests |
| Example-to-family overreach | finite witness treated as route to infinitude | explicit generator/distinctness audit |
| Local/global proof gap | local components available before full construction | roadmap gates and explicit dependency graph |
| Hidden analytic dependency | prime-density assumption | pinned PNT+ dependency and adapter |
| Interface information loss | final endpoint lacked `k < x` | strengthened downstream endpoint |
| Build-graph false confidence | source file can exist off canonical graph | generated import-graph check + full build |
| Documentation/state drift | prose lagged merged repository state | synchronization gate |
| Attribution drift | external proof mistaken for independent discovery | explicit reconstruction classification |
| Verification-credit drift | run metadata stronger than executed-tree evidence | in-job `verified_commit`; provenance correction |
| Infrastructure/proof conflation | HTTP 502 / billing / runner failures | earliest-layer failure classification |
| Metric-boundary confounding | dependency surface counts compare unequal ownership boundaries | S2a boundary audit |
| Provenance-contract failure | successful S2b pilot lacked required runner-version provenance | whole-run exclusion and rerun |
| Mixed-result suppression risk | S2c did not produce a uniform repair winner | prospective freeze + retain mixed result |
| Logical-classifier defect | S2d pilot classifier invalid | whole-run exclusion; no post-hoc relabel |
| Instrumentation timeout | S2e baseline timeout before candidate execution | exclude run; repair apparatus only |
| Failure-owner classifier defect | S2e D1 package-resolution owner missing | exclude complete set; repair classifier |
| Artifact-aggregation failure | S2e required complete-set artifact not produced | exclude complete set; transport audit |
| Dependency-support boundary | U1 fails first in Mathlib/transitive source | ownership taxonomy; third-party repair forbidden |
| Package-resolution boundary | U2 stops before project compilation | D1 ownership classification |
| Reporting-schema gap | no dedicated final repair enum for D1 package-resolution stop | record gap; do not change enum post-observation |
| Task-scope drift | automatic transition after completion | explicit user gate `DEC-012` |

This taxonomy is descriptive for this case. Reusing it as a general benchmark annotation scheme requires validation across additional projects.

---

## 5. Control mechanisms that emerged

### 5.1 Statement lock

The canonical target is fixed before proof work advances. Variant readings are recorded rather than silently substituted.

### 5.2 Blind-mode / reference-mode separation

Independent exploration and external-proof reconstruction are distinct modes. Access to a reference proof changes the scientific claim and is recorded.

### 5.3 Proof freeze before comparison

Independent work is frozen before reference comparison when possible, preventing retroactive contamination of provenance claims.

### 5.4 Negative-regression retention

Rejected candidates and known-invalid formulas remain executable tests or documented anti-patterns.

### 5.5 Interface-first decomposition

Long proof chains are split around explicit producer/consumer contracts so work can be resumed and locally tested without silently changing downstream semantics.

### 5.6 Canonical build graph

A theorem is not credited merely because a `.lean` file exists. It must be reachable from the canonical graph, and graph completeness is executable policy.

### 5.7 Exact executed-tree provenance

CI credit belongs to the exact tree actually checked out and built, not merely the SHA suggested by surrounding PR metadata.

### 5.8 Documentation as verified operational state

Project-state documents, roadmap, and README must agree with repository head before phase advancement.

### 5.9 Prospective protocol freezing

For S2c–S2e, mutation/candidate identity, measurement stages, admissibility rules, and interpretation boundaries were frozen before observation.

### 5.10 Whole-run / complete-set exclusion discipline

When a predeclared primary measurement, classifier, provenance field, or aggregate artifact was invalid, the affected run or complete candidate set was excluded rather than partially mined for convenient results.

### 5.11 Failure ownership taxonomy

Infrastructure, package resolution, dependency support, and project-owned source failures are classified separately so that repair effort is not attributed to the wrong layer.

### 5.12 Bounded repair eligibility

S2e permitted project-owned repair only after an eligible project-owned detection failure and forbade dependency-source repair. A missing legal repair surface therefore produced `not applicable`, not an invented repair metric.

### 5.13 Independent artifact validation

The credited S2e complete-set artifact was independently downloaded and rehashed; aggregate ownership/provenance checks were retained with the result.

### 5.14 Scientific evidence ledger

Allowed claims, excluded experiments, exact commits/runs, interpretation limits, and unresolved claims are externalized in a machine-readable ledger.

### 5.15 Explicit stop gate

Completion is not treated as permission to begin another research target automatically.

These controls are outputs of the process in their own right. The #678 case shows that reliable AI-assisted formal science includes **governance of scientific credit**, not merely production of proof terms.

---

## 6. Quantitative record

### 6.1 Mathematical-closure snapshot — 2026-08-17

At archival head `4596a360257a3f659d2a260b4cb00b22d0ffa94c`:

- 78 #678 Lean files;
- 7046 lines in the #678 Lean directory;
- 31 test/regression files, 1384 lines;
- 47 non-test files, 5662 lines;
- mathematical canonical build: 8806 jobs.

These numbers are preserved as a historical snapshot because they describe the artifact before S1 added the external-statement bridge layer.

### 6.2 Final scientific-evaluation snapshot — 2026-08-18

Between the mathematical-closure snapshot and the final evaluation state, the #678 Lean tree added:

- `ExternalStatementBridge.lean`: 133 lines;
- `ExternalStatementBridgeTests.lean`: 45 lines.

Thus the final evaluated #678 Lean tree contains:

- **80 Lean files**;
- **7224 Lean lines**;
- **32 test/regression files, 1429 lines**;
- **48 non-test files, 5795 lines**.

The final canonical graph contains **8808 jobs**.

These line/file totals are structural descriptors, not quality or effort scores.

### 6.3 Scientific-evaluation checkpoints

| Stage | Credited run | Core observable |
|---|---:|---|
| S1 differential verification | `32028006457` | comparator compiled unchanged in common environment; statement/axiom bridges |
| S2a dependency surface | `32047324807` | metric boundary sensitivity |
| S2b build behavior | `32053575928` | 6 paired replicates; no stable wall-clock winner |
| S2c repair locality | `32062501296` | 6 breaks / 6 legal green repairs; mixed result |
| S2d semantic/index mutations | `32076614547` | 6/6 semantic rejections; 0 survivors |
| S2e upgrade robustness | `32170243744` | 2 exact candidates; dependency/package boundary result |

### 6.4 Repository history is not an AI-step count

The final state-synchronization commit is 209 repository commits ahead of the earlier `4596a360...` archival snapshot. This is not a clean measure of AI effort or model invocations because the interval includes documentation, experiment apparatus, integration, exclusions, synchronization, and other repository operations.

Publication should therefore use a filtered event log rather than raw commit count as a proxy for “AI steps.”

### 6.5 Missing measurements

The archive still does **not** provide a publication-grade retrospective record of:

- model invocation count;
- token count;
- inference cost;
- exact wall-clock human attention;
- per-attempt prompt text;
- automated versus human-authored line attribution;
- standardized human edit/debug durations.

These measurements must not be reconstructed speculatively.

---

## 7. Proposed publication dataset

The repository can be converted into a machine-readable case-study dataset without publishing private chain-of-thought.

Each research episode should include fields such as:

```yaml
episode_id: string
timestamp_start: ISO-8601
timestamp_end: ISO-8601 | null
problem: 678
mode: blind-discovery | audit | external-proof-reconstruction | formalization | integration | scientific-evaluation
stage: optional S1 | S2a | S2b | S2c | S2d | S2e
objective: string
input_artifact_refs:
  - commit/file/theorem/protocol identifiers
observable_hypothesis_or_task: string
prospectively_frozen: boolean
admissibility_contract: optional string
result: success | failure | partial | mixed | excluded | superseded
failure_class: optional taxonomy label
failure_owner: optional infrastructure | package_resolution | dependency | project | apparatus
output_commit: optional SHA
ci_run: optional run id
artifact_id: optional integer
artifact_digest: optional sha256
human_intervention: none | scope | mathematical | engineering | approval
reference_solution_accessed: boolean
canonical_state_after: string
claim_boundary: string
notes: concise externally observable summary
```

Important exclusion:

> Do not store or publish hidden model chain-of-thought. Publish externally observable hypotheses, protocols, actions, artifacts, test outcomes, exclusions, corrections, and human decisions.

---

## 8. Observed findings versus unresolved causal hypotheses

The 17 August version treated several ideas uniformly as retrospective hypotheses. The final record requires a stricter distinction.

### O1 — Negative-regression retention was used successfully as process memory

Historical invalid constructions were preserved and did not disappear from the archive. However, the project did not run a randomized with/without-memory experiment.

**Status:** observed mechanism; causal effectiveness not established.

### O2 — Externalized state supported repeated long-horizon restarts

The project operationally relied on `PROJECT_STATE.md`, roadmaps, and synchronized READMEs.

**Status:** observed workflow practice; causal reduction in context failure remains untested.

### O3 — Contract-scoped repair locality did not produce a uniform winner

S2c prospectively tested three reference mutations and found mixed/interface-dependent repair footprints.

**Status:** bounded empirical result; the earlier hypothesis of a general locality advantage is **not established**.

### O4 — Exact executed-tree provenance corrected an overstrong verification claim

The verification-credit-drift episode demonstrated a concrete mismatch between metadata interpretation and executed commit, followed by a workflow correction.

**Status:** documented failure/correction; general causal benefit across CI systems is untested.

### O5 — Discovery/reconstruction separation preserved conservative attribution in this project

The final archive clearly records the rejected independent attempt, Cambie's mathematical authorship, and prior Aristotle/Alexeev formalization.

**Status:** observed governance outcome; controlled comparison against workflows without provenance fields remains future work.

### O6 — Prospective freezing preserved inconvenient outcomes in S2

The archive retained no-winner, mixed, early-stopping, dependency-blocked, and excluded-run outcomes without post-observation candidate substitution.

**Status:** strong descriptive evidence of protocol adherence in one project; not evidence that this governance design is optimal in general.

### Remaining causal hypotheses

- negative-regression memory reduces recurrence of known hallucination classes;
- externalized state improves restart accuracy relative to equivalent repositories without state artifacts;
- prospective admissibility contracts reduce selective reporting;
- explicit ownership taxonomies reduce invalid repair attribution;
- independent human auditors locate assumptions and statement boundaries faster in the modular artifact;
- provenance logging changes merge/no-merge behavior across AI agents and CI systems.

These require new controlled experiments before causal language is justified.

---

## 9. Relationship to current literature

### 9.1 Formal Conjectures

*Formal Conjectures: An Open and Evolving Benchmark for Verified Discovery in Mathematics* emphasizes statement fidelity, research-level Lean benchmarks, and proof/disproof as a mechanism for auditing formal statements.

#678 provides a concrete case where statement semantics, fixed-versus-varying parameters, and interval indexing materially affected what could be credited.

### 9.2 AI-driven formal proof search on Erdős problems

*Advancing Mathematics Research with AI-Driven Formal Proof Search* evaluates agentic systems on open Erdős and other research problems.

The final #678 mathematics was already known, so this project's AI research value lies primarily in long-horizon reconstruction, verification, scientific evaluation, and provenance governance rather than autonomous theorem discovery.

### 9.3 LeanMarathon

*LeanMarathon: Toward Reliable AI Co-Mathematicians through Long-Horizon Lean Autoformalization* identifies statement drift, dependency tangling, context decay, and nonlocal corruption from local repair as central long-horizon problems.

The #678 workflow encountered related categories and developed explicit roadmaps, contract boundaries, state synchronization, CI gates, and later prospective experimental controls.

### 9.4 FormalScience

*FormalScience: Scalable Human-in-the-Loop Autoformalisation of Science with Agentic Code Generation in Lean* emphasizes semantic alignment and semantic drift.

The historical interval-indexing error is a mathematics-specific semantic-drift instance; S2d then turned selected semantic/index perturbations into a prospectively frozen mutation experiment.

### 9.5 Aristotle case-study literature

The Grasshopper case study distinguishes verified helper lemmas from an unresolved main theorem. #678 supplies a complementary positive case in which the full endpoint eventually reached the canonical graph, but the subsequent S1/S2 record shows that theorem closure is only one layer of scientific evaluation.

### 9.6 Multiple formal routes as cross-checks

The ITP 2026 paper *Three Roads to de Finetti's Theorem in Lean 4* uses independent proof routes and a common interface as a cross-check.

For #678, the previously proposed differential-verification idea is no longer future work: S1 actually built the pinned Aristotle/Alexeev source unchanged in the common environment and established machine-checked statement bridges and selected axiom-footprint comparisons.

---

## 10. What remains before publication-grade AI case study

Several items proposed in Revision 1 are now complete: common-environment differential verification (S1), repair-locality experiments (S2c), and a substantial semantic/index mutation suite (S2d). The remaining publication work is narrower.

1. **Filtered episode log.** Reconstruct a publication dataset from commits/PRs/CI/artifacts without inventing missing model metadata.
2. **Immutable archival release.** Pin the publication artifact to a release/tag and, ideally, a DOI-backed archive; public GitHub visibility alone is not archival persistence.
3. **Artifact snapshots.** Package the failed independent route, mathematical-closure snapshot, S1 bridge layer, S2 protocols/results, and final state with checksums.
4. **Controlled restart experiment.** Compare agent restart accuracy with and without synchronized state/roadmap artifacts.
5. **Independent human audit task.** Measure how quickly reviewers can locate assumptions, PNT boundary, canonical statement semantics, negative regressions, and final index translation.
6. **Optional historical-scaling mutation extension.** S2d covered three one-unit semantic/index mutations; a separate prospective suite could encode the earlier false scaling construction if publication scope benefits.
7. **Prospective model telemetry for future experiments.** Record model identifier, invocation count, token/cost information when available, tool calls, wall clock, and human intervention categories prospectively rather than reconstructing them.
8. **Literature and venue policy audit at submission time.** Update related work and AI-disclosure requirements for the chosen venue.

These remaining tasks strengthen reproducibility and causal interpretation. They are not prerequisites for treating the existing repository as a serious technical case-study dossier.

---

## 11. Two scientific products inside one project

### Product A — formal mathematics / proof engineering

Focus:

- independent Lean reconstruction of known mathematics;
- direct `prime_between` interface;
- statement bridges;
- common-environment differential verification;
- dependency/build/repair/mutation/upgrade evaluation;
- conservative comparison without architecture-superiority claims.

Primary evidence: Lean code, pinned comparator, common-environment experiments, and machine-readable S1/S2 artifacts.

### Product B — AI-assisted scientific-production case study

Focus:

- transition from failed discovery to faithful reconstruction;
- error and exclusion taxonomy;
- state/provenance controls;
- long-horizon workflow;
- exact executed-tree CI credit;
- prospectively frozen experiments;
- scientific admissibility rules;
- retention of mixed/null/blocked outcomes;
- lessons for auditable AI co-mathematics.

Primary evidence: repository/CI history, protocols, exclusions, artifacts, evidence ledger, and selected future controlled human/agent experiments.

These products share the same mathematical artifact but answer different scientific questions. Keeping them conceptually separate prevents the AI-methodology contribution from being confused with a claim of new mathematics.

---

## 12. Threats to validity

### Single-case limitation

#678 is one theorem in one mathematical domain. Workflow findings may not generalize to algebra, geometry, or projects with different library and dependency structure.

### Retrospective instrumentation

The project was not initially designed as a controlled AI experiment. Important model-level measurements were not logged from the beginning.

### Human/AI contribution entanglement

Repository artifacts do not provide reliable line-by-line attribution among AI generation, human direction, and automated tooling. Claims must therefore concern the **AI-assisted workflow**, not autonomous AI authorship percentages.

### External-proof mode

After the independent attempt failed, the successful mathematics came from a published proof. The study measures reconstruction, verification, and process reliability, not original discovery of the theorem.

### Architecture confounding

The internal artifact is deliberately modular and regression-heavy while the comparator is much more monolithic. S2a showed that ownership/dependency boundaries themselves confound structural metrics; S2c did not establish a general maintainability winner.

### Single apparatus / platform dependence

Much of the experimental evidence uses GitHub Actions, a specific pinned Lean/Mathlib/PNT+ environment, and specific runner images. The conclusions are bounded to those apparatus conditions unless replicated elsewhere.

### Post-hoc narrative risk

The overall case study is retrospective. S2c–S2e mitigate but do not eliminate this threat because their candidate/mutation protocols were frozen prospectively only after the earlier project history already existed.

### Publication-narrative drift

The first version of this case study stopped at the 17 August mathematical/postmortem snapshot while the authoritative operational state later advanced through S1/S2 on 18 August. Revision 2 explicitly records this as a document-layer synchronization issue rather than silently rewriting the earlier chronology.

### Archival persistence

The repository is public and Apache-2.0 licensed, so the earlier “private-repository reproducibility” limitation no longer applies. The remaining risk is absence of an immutable DOI-backed publication snapshot.

---

## 13. Data-integrity rules for any paper based on #678

1. Cite Cambie as the mathematical proof author.
2. Cite Aristotle and Boris Alexeev as prior formal authors.
3. State that the project's independent mathematical attempt was rejected.
4. State when reference-proof access occurred and classify the successful route as reconstruction.
5. Never infer AI cost, token count, or autonomous-work percentages from git history.
6. Distinguish theorem source presence from canonical build reachability.
7. Distinguish CI metadata from the exact executed commit/tree.
8. Pin all comparison commits, dependency revisions, protocols, and mutation/candidate identities.
9. Preserve failed and excluded artifacts when they are part of the experimental evidence.
10. Retain mixed, null, early, or dependency-blocked outcomes rather than replacing them with post-hoc alternatives.
11. Label historical snapshots rather than silently rewriting them.
12. Separate apparatus/infrastructure failures from proof failures.
13. Separate package/dependency failures from project-owned proof failures.
14. Do not publish hidden chain-of-thought; publish observable actions, protocols, artifacts, corrections, and decisions.
15. Do not claim causal benefit where only one-case descriptive evidence exists.

---

## 14. Claim ladder

### Established for this repository and frozen experiments

- Cambie's mathematics is known and externally authored;
- the project completed an independent Lean reimplementation of the reconstruction;
- prior Aristotle/Alexeev formalization exists;
- final statement bridges are machine-checked;
- the pinned public comparator compiles unchanged in the common S1 environment;
- selected endpoints in both artifacts have the same standard-axiom footprint under S1;
- S2a dependency-surface metrics are ownership-boundary sensitive;
- S2b found no stable wall-clock winner across the six paired credited runs and observed materially different resource profiles;
- S2c produced mixed/interface-dependent repair-locality results rather than a uniform winner;
- S2d rejected all six prospectively frozen semantic/index observations with zero proof repairs;
- S2e's two exact frozen forward candidates stopped at dependency/package boundaries before an eligible project-owned repair surface;
- several computationally successful or partially coherent runs were scientifically excluded under predeclared provenance/classification/aggregation rules.

### Still requires new evidence

- causal benefit of externalized state;
- causal benefit of negative-regression memory;
- general semantic robustness;
- general maintainability or auditability superiority;
- human repair/debugging effort;
- expected cost of a future coordinated Lean/Mathlib/PNT+ upgrade;
- causal explanation of S2b CPU/memory differences;
- compatibility of version tuples other than the frozen S2e candidates;
- generality of the proposed failure taxonomy across projects.

### Unsupported and prohibited as publication claims

- new solution to Erdős #678;
- new independent mathematical proof;
- first Lean formalization;
- general architecture superiority;
- universal speed advantage;
- general maintainability superiority;
- general Lean/Mathlib incompatibility;
- autonomous AI authorship percentage;
- reconstruction of missing token/cost/human-time telemetry from repository history.

---

## 15. Recommended case-study thesis

A defensible thesis for the AI dimension is:

> **Research-level AI-assisted formalization is not only a proof-search problem. In the multi-day #678 reconstruction and its subsequent scientific evaluation, reliability depended on explicit target semantics, failure retention, contract-scoped decomposition, externalized state, pinned dependencies, canonical build reachability, exact executed-tree provenance, prospectively frozen experiments, admissibility rules, failure ownership, and evidence-preserving integration. Formal verification rejected invalid mathematical trajectories, while repository and experimental governance determined which computational outputs were entitled to scientific credit.**

A second, narrower thesis supported by the S1/S2 episodes is:

> **Verification of mathematical propositions and verification of scientific provenance are separate obligations. A green build can coexist with an overstrong commit-credit claim, incomplete measurement provenance, a defective classifier, or an invalid aggregate artifact; reliable AI-assisted formal science must audit those layers independently.**

These theses are stronger and more useful than the slogan “AI formalized a theorem” because they identify falsifiable mechanisms and failure modes for making AI-generated scientific material auditable over long horizons.

---

## 16. Archival conclusion

The #678 project produced two forms of value:

1. a machine-checked independent Lean reconstruction of known mathematics, with common-environment differential verification and a bounded scientific evaluation suite;
2. an unusually detailed, externally auditable record of how AI-assisted scientific material can fail, recover, be excluded, be reclassified, and eventually receive carefully bounded scientific credit.

Revision 1 captured the path through mathematical closure on 17 August 2026. Revision 2 extends the evidence cutoff through the completed S1/S2 evaluation and final state synchronization on 18 August 2026.

The second form of value is no longer merely a proposal for future controlled work: the archive already contains prospectively frozen repair, mutation, and upgrade experiments together with excluded runs and mixed/boundary results. Publication-grade work should now focus on dataset extraction, immutable archiving, independent audit, and carefully scoped causal follow-up experiments rather than repeating experiments that S1/S2 have already completed.
