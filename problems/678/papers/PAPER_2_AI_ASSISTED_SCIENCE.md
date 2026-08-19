# Paper 2 — AI-Assisted Scientific Production

## Working title

**From Failed Conjecture to Machine-Checked Reconstruction: A Long-Horizon AI-Assisted Formalization Case Study of Erdős #678**

Alternative working title:

**Governing Scientific Credit in Long-Horizon AI-Assisted Formal Mathematics: Evidence from Erdős Problem #678**

## Manuscript status

- Status: **scaffold opened; not yet submission-ready**
- Evidence cutoff for the initial manuscript: **2026-08-18**
- Empirical case: Erdős #678, 2026-08-13 through 2026-08-18
- Core source narrative: `AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md` Revision 2
- Scope: AI-assisted scientific production, verification, experimental governance, and provenance
- Governance: `DEC-012` remains binding; this manuscript does not authorize work on another Erdős problem

## Contribution boundary

This paper is a **longitudinal case study of AI-assisted scientific production**. It is not a paper claiming autonomous mathematical discovery.

It must not claim:

- that the AI independently solved Erdős #678;
- that the successful mathematics is new;
- a percentage of authorship attributable to AI without a defensible measurement protocol;
- causal superiority of the workflow controls unless prospectively tested;
- general productivity, reliability, or maintainability conclusions from one case;
- hidden chain-of-thought access as scientific evidence.

The successful mathematical argument is Cambie’s. The observable scientific object is the workflow that moved from failed independent exploration to external-proof reconstruction, machine verification, differential verification, controlled evaluation, exclusion/correction episodes, and archival closure.

## Core research question

> What is required to make AI-assisted production of mathematical material auditable, restartable, scientifically admissible, and resistant to provenance or interpretation drift over a long-horizon project?

## Central thesis

A defensible thesis is:

> Reliability in long-horizon AI-assisted mathematics is a scientific-workflow governance problem as much as a theorem-proving problem: mathematical outputs, verification credit, experimental protocols, provenance, exclusion rules, ownership of failures, and interpretation boundaries all require explicit external controls.

## Candidate abstract

**TODO — draft only after the related-work and venue audit are complete.**

The abstract should summarize:

1. why theorem-closed / theorem-not-closed is an insufficient model of long-horizon AI-assisted formal work;
2. the #678 longitudinal case and failed-to-reconstruction mode transition;
3. the externally auditable data record rather than hidden reasoning traces;
4. the major failure classes observed;
5. the governance controls introduced;
6. S1/S2 episodes showing that green computation can still be scientifically inadmissible;
7. mixed/null/boundary outcomes retained rather than optimized away;
8. limitations of a single retrospectively instrumented case.

## 1. Introduction

### 1.1 Motivation

AI-assisted formal mathematics is often evaluated by endpoint success. A long-running research workflow has additional failure surfaces:

- wrong conjecture;
- wrong statement;
- wrong indexing convention;
- hidden dependency assumption;
- local proof success without global reachability;
- wrong commit receiving verification credit;
- computationally successful but scientifically inadmissible experiments;
- post-observation metric or classifier repair that can contaminate interpretation;
- documentation/state drift;
- attribution drift.

### 1.2 Case-study choice

Explain why #678 is useful:

- a finite witness was real;
- an induced generalization was false;
- exact/formal checks rejected attractive paths;
- project mode changed explicitly;
- the final theorem was machine checked;
- later scientific evaluation generated both credited and excluded runs;
- the project preserved negative, mixed, null, and dependency-boundary evidence.

### 1.3 Contributions

Proposed contribution list:

1. An auditable longitudinal case record from failed independent exploration through machine-checked reconstruction and post-theorem evaluation.
2. A failure taxonomy spanning mathematical, semantic, interface, build-graph, provenance, classifier, instrumentation, aggregation, and dependency-boundary failures.
3. A set of external workflow controls for long-horizon AI-assisted formal science.
4. Empirical episodes demonstrating why computational success is not sufficient for scientific credit.
5. A distinction between bounded observed findings and causal hypotheses about workflow benefit.
6. A reusable event/episode schema that does not require exposing hidden chain-of-thought.
7. A publication-narrative synchronization lesson: operational restart state and manuscript-facing evidence state can drift independently.

## 2. Research questions

### RQ1 — Failure rejection

Can exact computation and formal verification stop an attractive but invalid trajectory and convert it into durable negative knowledge?

### RQ2 — Target fidelity

Which external controls reduce statement/index/interface drift during long-horizon AI-assisted formalization?

### RQ3 — Proof-engineering continuity

How do explicit producer/consumer contracts support repair and context changes across a long proof?

### RQ4 — Mode transition and attribution

How should the workflow change after independent discovery fails and a successful external proof is consulted?

### RQ5 — Verification credit

What must be true before a repository commit can legitimately receive “machine-verified” scientific credit?

### RQ6 — Scientific admissibility

How should prospectively frozen protocols, provenance requirements, exclusion rules, failure ownership, and complete-set aggregation constrain interpretation of AI-assisted experiments?

### RQ7 — Externalized project state

How should operational state, evidence state, and publication-facing narrative be synchronized so the project is restartable without silently rewriting history?

## 3. Case and data model

### 3.1 What is observed

The dataset must be limited to externally auditable artifacts such as:

- commits and branches;
- pull requests;
- files and diffs;
- candidate arguments explicitly persisted in the repository;
- theorem statements and Lean source;
- tests and negative regressions;
- dependency pins;
- frozen experiment protocols/manifests;
- CI runs and jobs;
- artifacts and hashes;
- exclusions and corrections;
- user/human decisions explicitly recorded;
- state and roadmap documents.

### 3.2 What is not observed

Do not claim access to or publish:

- hidden model chain-of-thought;
- unrecorded internal deliberation;
- invented token/cost/model-invocation counts;
- invented human-attention times;
- invented prompt statistics;
- unsupported AI-versus-human line attribution.

### 3.3 Episode schema

Candidate publication schema:

- episode ID;
- timestamps;
- phase/mode;
- objective;
- input artifact refs;
- explicit hypothesis or protocol state;
- observed output;
- failure class;
- correction/exclusion disposition;
- output commit;
- CI run/job;
- artifact ID/hash;
- human intervention category;
- reference-proof access state;
- scientific-credit state;
- notes/limitations.

## 4. Longitudinal timeline

### Phase A — finite evidence and invalid generalization

- preserve the valid finite witness;
- preserve the rejected scaling/generalization path;
- explain why finite evidence did not supply an infinitude mechanism.

### Phase B — infrastructure and statement repair

- canonical statement lock;
- interval/index discipline;
- exact computation/formal rejection of off-by-one constructions.

### Phase C — explicit switch to external-proof reconstruction

- reference-proof access changes attribution status;
- novelty claim narrowed rather than blurred.

### Phase D — long-horizon interface stabilization

- proof contracts;
- producer/consumer separation;
- local repair without changing theorem meaning.

### Phase E — analytic dependency closure

- replacement of a hidden/opaque analytic gap with pinned machine-checked PNT+ support.

### Phase F — final theorem translation

- strong theorem endpoint;
- unbounded witnesses;
- final Erdős indexing translation.

### Phase G — integration and archival closure

- exact-head CI;
- merge unchanged;
- exact-main verification;
- lessons and stop gate.

### Phase H — S1 differential verification and verification-credit audit

- common-environment comparator build;
- statement bridges;
- axiom audit;
- correction of verification-credit drift.

### Phase I — S2a/S2b structural and build evaluation

- ownership-sensitive structural metrics;
- provenance-defective successful pilot excluded;
- credited build/resource study.

### Phase J — S2c/S2d repair and semantic mutation evaluation

- mixed repair-locality result;
- semantic/index mutation rejection;
- classifier-defective successful pilot excluded.

### Phase K — S2e upgrade-boundary evaluation and closure

- prospectively frozen candidates;
- multiple excluded apparatus/classification/aggregation runs;
- credited complete-set result;
- external dependency/package boundary with no eligible project repair.

## 5. Failure taxonomy

### 5.1 Mathematical failures

- false algebraic/scaling generalization;
- example-to-family overreach;
- local/global proof gap.

### 5.2 Semantic and representation failures

- interval/index drift;
- information loss at an interface;
- statement-fidelity drift.

### 5.3 Dependency and integration failures

- hidden analytic dependency;
- canonical build-graph false confidence;
- dependency ownership boundary;
- package-resolution boundary.

### 5.4 Scientific-credit failures

- verification-credit drift;
- provenance inadmissibility;
- classifier/oracle defect;
- incomplete-set aggregation;
- instrumentation timeout/failure;
- artifact-transport failure.

### 5.5 State and governance failures

- state/document drift;
- publication-narrative drift;
- attribution drift;
- task-scope drift.

## 6. Workflow controls

### 6.1 Statement lock and explicit indexing conventions

### 6.2 Negative regressions

Retain falsified examples/constructions so the same failure is not silently rediscovered.

### 6.3 Mode separation

Separate independent exploration from external-proof reconstruction.

### 6.4 Interface-first proof engineering

Use explicit producer/consumer contracts and preserve downstream invariants.

### 6.5 Canonical graph reachability

A theorem file not reachable from the canonical graph does not receive project-level verification credit.

### 6.6 Exact-head / exact-main provenance

Pre-merge and post-merge verification are distinct gates.

### 6.7 Prospective experimental freezing

Freeze protocols, candidates, mutations, budgets, provenance requirements, ownership rules, and interpretation boundaries before observation.

### 6.8 Fail-closed scientific admissibility

A computationally successful run may still be excluded if required provenance/classification/aggregation is invalid.

### 6.9 No post-observation rescue

Do not redesign the experiment or relabel inconvenient outcomes merely to obtain a preferred conclusion.

### 6.10 Evidence ledger and immutable artifact identity

Record runs, artifacts, hashes, exclusions, corrections, dependency blockers, and mixed/null outcomes.

### 6.11 Explicit stop gate

Completion of one benchmark must not automatically activate the next research target.

## 7. Empirical episodes

### 7.1 Negative-regression episode

Analyze how the valid finite witness and rejected generalization were preserved.

### 7.2 Index-drift episode

Analyze the off-by-one construction failure and the resulting length-safe API/control.

### 7.3 Verification-credit-drift episode

Show why green CI metadata did not by itself prove literal PR-head execution.

### 7.4 S2b provenance-exclusion episode

A successful pilot was excluded because predeclared runner provenance was incomplete.

### 7.5 S2c mixed-result episode

A prospectively frozen experiment did not produce a uniform architecture winner; the mixed result was retained.

### 7.6 S2d classifier-defect episode

A computationally successful mutation run was excluded because a primary logical classifier was wrong.

### 7.7 S2e instrumentation and boundary episodes

Separate:

- baseline runtime apparatus failures;
- primary-owner classifier defect;
- artifact aggregation/transport failure;
- credited candidate outcomes;
- valid dependency/package boundaries that did not expose project-owned repair work.

## 8. Bounded findings versus causal hypotheses

### Observed bounded findings

The paper may report directly observed facts such as:

- formal rejection of specific invalid constructions;
- successful final reconstruction;
- exact-head provenance correction;
- exclusion of specific runs under predeclared rules;
- mixed S2c outcome;
- six S2d semantic rejections;
- exact S2e boundary outcomes.

### Causal hypotheses requiring stronger evidence

Examples:

- negative regression memory reduces repeated failures;
- externalized state improves restart reliability;
- interface contracts reduce repair locality/cost;
- exact-head CI reduces erroneous scientific credit;
- explicit mode separation improves attribution discipline.

These should be labeled as hypotheses unless a prospective comparison supports a causal claim.

## 9. Quantitative record

Preserve two explicit snapshots rather than overwriting history.

### Mathematical-closure snapshot — 2026-08-17

- 78 #678 Lean files;
- 7046 Lean lines;
- 31 test files / 1384 lines;
- 47 non-test files / 5662 lines;
- canonical build: 8806 jobs.

### Final scientific-evaluation snapshot — 2026-08-18

- 80 #678 Lean files;
- 7224 Lean lines;
- 32 test files / 1429 lines;
- 48 non-test files / 5795 lines;
- canonical build: 8808 jobs.

### Controlled experiment counts

Report only values verified from the evidence ledger/result artifacts. At minimum:

- S2b: six credited paired replicates plus an excluded provenance-defective pilot;
- S2c: three frozen mutations × two artifacts = six break/repair observations;
- S2d: three frozen semantic/index mutations × two artifacts = six semantic rejections, zero survivors, zero proof repairs;
- S2e: two exact frozen candidates, one credited complete set, multiple excluded complete runs, zero eligible project repair batches.

Do not invent missing telemetry.

## 10. Related work

**TODO — requires current literature audit before drafting.**

Relevant categories include:

- AI-assisted interactive theorem proving;
- autonomous or agentic Lean formalization;
- long-horizon formalization workflows;
- statement fidelity and formal-conjecture auditing;
- human-in-the-loop formalization;
- scientific workflow provenance and reproducibility;
- empirical software engineering / mutation-style evaluation where methodologically relevant.

Priority and novelty claims must be verified against current primary sources.

## 11. Threats to validity

### 11.1 Single-case design

One theorem cannot establish general AI-science performance.

### 11.2 Retrospective instrumentation

Much of the early case record predates the final publication-oriented data schema.

### 11.3 Human–AI entanglement

The workflow contains explicit user/human decisions and cannot support autonomous-agent attribution percentages.

### 11.4 External-proof mode

The successful mathematical phase is reconstruction, limiting conclusions about independent mathematical discovery.

### 11.5 Architecture confounding

Internal and comparator artifacts differ in decomposition, ownership, and dependency packaging.

### 11.6 Missing telemetry

No defensible complete record of token use, monetary cost, model calls, human attention time, or prompt-level attribution exists for the full case.

### 11.7 Archival persistence

The repository is public and Apache-2.0, but publication should still create an immutable archival release/DOI.

## 12. Discussion

Candidate discussion points:

- scientific credit must be governed, not inferred from green computation;
- failed and excluded runs can be positive scientific evidence about method reliability;
- prospective freezing is especially important when an AI system can rapidly alter code, classifiers, or interpretation;
- ownership classification prevents dependency ecosystem failures from being mislabeled as proof-maintainability failures;
- mixed/null results should remain visible;
- externalized state is necessary for restartability but does not automatically keep manuscript narratives synchronized;
- attribution must change when the workflow changes from discovery to reconstruction.

## 13. Conclusion

A target conclusion should remain bounded:

> The #678 case supports a governance-centered view of long-horizon AI-assisted formal science. Mathematical verification, scientific-credit provenance, prospective experimental control, exclusion discipline, failure ownership, and publication-state synchronization are separate obligations. The case demonstrates these obligations concretely, while causal and cross-project generalization remains future work.

## Data and artifact availability

Repository: public, Apache-2.0.

Publication-grade release still needs an immutable archival snapshot / DOI or equivalent identifier.

The dataset should expose external artifacts and episode metadata, not hidden reasoning traces.

## Internal evidence sources

Primary drafting sources:

- `PROJECT_STATE.md`
- `problems/678/AI_ASSISTED_SCIENTIFIC_PRODUCTION_CASE_STUDY.md`
- `problems/678/PUBLICATION_NARRATIVE_SYNC_2026-08-19.md`
- `problems/678/PUBLICATION_AND_UPSTREAM_ROADMAP.md`
- `problems/678/SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `problems/678/AI_CASE_EPISODE_VERIFICATION_CREDIT_DRIFT.md`
- `problems/678/S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- S2 protocols, excluded-run notes, result files, and artifacts
- `problems/678/LESSONS_LEARNED_678_ADDENDUM.md`

## Publication-grade dataset tasks

- [ ] construct the filtered episode log from externally auditable artifacts;
- [ ] define immutable episode IDs and evidence references;
- [ ] preserve excluded/mixed/null episodes;
- [ ] separate retrospective observations from prospectively tested hypotheses;
- [ ] decide whether a restart experiment is required for the target venue;
- [ ] obtain independent human audit of selected episodes/claims;
- [ ] create immutable archival release/DOI;
- [ ] document missing telemetry explicitly rather than imputing it.

## Submission-readiness checklist

- [ ] select target venue;
- [ ] audit current venue AI-use/authorship/disclosure policy;
- [ ] complete publication-grade related-work search using primary sources;
- [ ] freeze the paper’s research questions and claim ladder;
- [ ] build the episode dataset and claim-to-evidence map;
- [ ] produce timeline/failure-taxonomy/governance-control figures;
- [ ] verify all quantitative values against repository evidence;
- [ ] decide which remaining experiments are blockers versus optional strengthening;
- [ ] obtain independent human methodological review;
- [ ] create archival release/DOI;
- [ ] draft abstract after claims and evidence are frozen;
- [ ] final audit for novelty, causality, attribution, and reproducibility wording.
