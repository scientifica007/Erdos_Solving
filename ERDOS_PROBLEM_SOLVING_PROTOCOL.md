# Erdős Problem Solving Protocol v1

## 1. Purpose and authority

This document converts the durable lessons of the completed Erdős #678 benchmark into the standard operational method for future mathematical benchmarks in this repository.

It is a **project-level protocol**, not a narrative postmortem. Its authority comes from `DEC-013`. Read it together with:

- `CONSTITUTION.md` — epistemic and scientific principles;
- `DECISIONS.md` — binding project decisions;
- `AI_AGENT_GUIDE.md` — agent operating rules;
- `RESEARCH_RECORD_SCHEMA.md` — default research-record structure;
- the active problem's canonical statement, roadmap, state files, and evidence ledger.

A stricter constitutional, decision-level, user-supplied, or problem-specific rule takes precedence. Any deliberate deviation from this protocol must be recorded explicitly with its rationale and any required authorization.

The empirical basis is `LESSONS_LEARNED_678_ADDENDUM.md`, especially lessons L-678-005 through L-678-042 and the final reusable checklist. This protocol generalizes those lessons without assuming that every future problem requires the same proof architecture or experimental apparatus.

## 2. Scope and non-goals

The protocol governs a mathematical benchmark from authorization through archival closure.

It is designed to prevent recurrent failure classes:

1. solving the wrong statement or a nearby variant;
2. leaking reference solutions into an intended blind attempt;
3. mistaking finite/computational evidence for a general proof;
4. formalizing an unstable or false construction;
5. crediting Lean files or runs outside the canonical verification graph;
6. confusing mathematical, dependency, infrastructure, and provenance failures;
7. overstating originality, robustness, maintainability, or other scientific conclusions beyond the evidence.

The protocol does **not** guarantee solvability, novelty, formal tractability, publication value, or success. It governs how progress and failure are investigated, verified, classified, and recorded.

## 3. Lifecycle state machine

The default lifecycle is:

`G0 authorization/synchronization -> G1 statement/status-metadata audit -> G2 research-mode freeze -> G3 falsification-first validation -> G4 mathematical stabilization -> G5 literature/provenance comparison -> G6 formalization -> G7 exact-head verification -> G8 scientific evaluation when warranted -> G9 integration/synchronization -> G10 archival closure/postmortem`

A later gate may expose a defect that sends the work back to an earlier gate. That is legitimate scientific correction. Hiding or relabeling the regression is not.

No phase is earned by elapsed time or prose confidence. It is earned by evidence satisfying its exit criteria.

---

## G0 — Authorization and repository synchronization

### Entry condition

A user or governing project decision authorizes work on a specific mathematical target.

### Required actions

1. Read the current `main` head and canonical build graph.
2. Check actual CI/workflow status at the credited head.
3. Read `PROJECT_STATE.md`, relevant README files, the active roadmap, decisions, and live evidence/experiment ledgers.
4. Resolve material state drift before substantive mathematical work.
5. Confirm that no user-transition gate or project decision forbids activation of the target.

### Exit criteria

- target activation is authorized;
- repository code, CI, and operational documentation materially agree;
- the starting/recovery commit is identified;
- current blockers are accurately classified.

### #678 inheritance

State drift is a verification defect. A correct theorem file does not compensate for an incorrect operational checkpoint.

---

## G1 — Canonical statement and external-status metadata audit

This gate establishes what problem is being studied without prematurely consuming solution content that could invalidate a later blind mode.

### Required actions

1. Record the exact canonical statement from an authoritative source.
2. Expand definitions whose indexing, endpoints, quantifiers, domains, or conventions can affect truth.
3. Distinguish the original problem from variants, equivalent formulations, strengthened forms, and convenient formal encodings.
4. Establish only the **external status/existence metadata** that can be checked without reading target-specific solution content: for example `open`, `solved`, `partially solved`, `status uncertain`, and whether a formalization is known to exist.
5. If status cannot be established safely without exposing a reference proof, defer the unresolved part until after G2 instead of breaking blind separation.
6. Record dates, sources, and unresolved ambiguities.

### Mandatory questions

- Are the variables, domains, inequalities, and quantifiers identical to the benchmark?
- Are interval endpoints and indexing conventions explicit?
- Are noncanonical representatives or zero conventions translated explicitly?
- Is the external status known without consuming prohibited proof content?
- Is a formalization known to exist, without inspecting it when blind mode may apply?

### Exit criteria

The repository contains a statement/status-metadata record precise enough to identify the target, while preserving the option of a valid blind experiment.

### #678 inheritance

Indexing is mathematics. The decisive off-by-one failure in #678 is the standing warning that exact ranges must be expanded before simplification.

---

## G2 — Research-mode freeze and source-access boundary

Before substantive proof research, select and record the research mode.

Typical modes:

- **blind independent attempt**;
- **open literature-assisted research**;
- **external-proof reconstruction**;
- **formal verification/reimplementation of a known proof**;
- **comparative/scientific evaluation of existing formal artifacts**.

If blind mode is selected, `DEC-002` applies: historical/reference proofs, solution discussions, and formalizations specifically proving the target remain inaccessible until the candidate proof is frozen and audited.

If non-blind mode is selected, record which external sources may be used and how provenance will be attributed.

A mode change is allowed only when explicit and timestamped. Earlier work is not retrospectively relabeled.

### Exit criteria

- research mode is explicit;
- allowed/prohibited source access is explicit;
- novelty and attribution vocabulary appropriate to the mode is fixed.

### #678 inheritance

Independent discovery, external-proof reconstruction, formal verification, and independent formal reimplementation are distinct achievements and must not be collapsed into “we solved it.”

---

## G3 — Falsification-first finite validation

Before investing heavily in a general construction, attack its smallest falsifiable consequences.

### Required checks when applicable

1. Verify at least one complete positive instance of the **actual target definition**, not merely its side conditions.
2. Search for small counterexamples to each new construction or lemma.
3. Test boundary values and equality/strictness transitions.
4. Expand exact products, sums, LCM/GCD ranges, modular representatives, and finite sets.
5. For infinitude claims, audit separately:
   - witness existence;
   - generator/family;
   - distinctness or unboundedness;
   - domain preservation.
6. Preserve important rejected candidates as negative regressions.

### Failure rule

If exact valid computation falsifies a construction, invalidate the construction first. Do not alter isolated inequalities or assumptions merely to recover the desired conclusion.

Correct workflow:

`candidate -> exact test -> rejection -> root-cause analysis -> retained regression -> revised mathematics`

### Exit criteria

The current construction survives the finite/boundary tests realistically available and contradicts no retained negative regression.

### #678 inheritance

A concrete witness is not an infinitude proof; side-condition success is not target-definition success.

---

## G4 — Mathematical stabilization and proof architecture

Expensive formalization should follow mathematical stabilization, while lightweight formal checks may be used early to expose definitional mistakes.

### Required actions

1. Decompose the proof into named obligations and interfaces.
2. Separate **producer** layers from **consumer** layers when a construction supplies data consumed by later theorems.
3. Preserve downstream-critical information through theorem layers: positivity, strict bounds, location, cardinality, nondivisibility, distinctness, domain membership, or whatever final translation requires.
4. Prefer stronger parameterized theorems when they genuinely follow and simplify the final deduction.
5. For infinitude, prefer a reusable unbounded-witness theorem when natural; derive set-theoretic infinitude afterward.
6. Make final variable/index translations explicit rather than treating them as formatting.
7. Audit assumptions and imported deep theorems before declaring proof completion.

### Proof-credit vocabulary

Use the narrowest justified label:

- heuristic;
- computational evidence;
- lemma;
- proof sketch;
- rigorous proof;
- frozen candidate proof awaiting audit;
- machine-checked proof.

### Exit criteria for proof freeze

- complete argument exists at the claimed level;
- quantifiers, boundaries, and domain constraints are audited;
- no substantive hidden gap remains;
- under blind mode, the candidate is frozen before reference comparison.

### #678 inheritance

The successful #678 architecture became tractable after separating producer contracts, consumer theorems, CRT coordinate behavior, density interfaces, and final-index translation.

---

## G5 — Literature comparison and provenance classification

After proof freeze—or earlier only when G2 explicitly permits literature assistance—compare the result with the literature and known formalizations.

### Required classification

Record separately:

- external problem status;
- whether the mathematics is known;
- whether the proof route matches or differs from known proofs;
- whether an external formalization exists;
- whether the repository artifact is copied, ported, independently reimplemented, or independently derived;
- what novelty, if any, is actually supported.

### Rule

Attribution and verification are orthogonal. Known mathematics can be independently machine-verified; a machine-checked artifact can still carry no novelty claim.

### Exit criteria

Every public-facing originality/provenance claim is no stronger than the evidence.

---

## G6 — Formalization architecture and trust boundary

When Lean formalization is part of the benchmark, use these defaults.

### Definitions and interfaces

1. Prefer APIs that encode intended length/cardinality directly when endpoint ambiguity is dangerous.
2. Name translations between paper conventions and canonical formal representations.
3. Test producer/consumer boundaries, not only helpers in isolation.
4. When a definition is opaque or expensive to reduce, test proved interfaces instead of forcing evaluation merely for convenience.

### Dependencies

1. Inspect the actual Mathlib/library API before speculative rewrites.
2. Pin important external formal dependencies by exact commit/version when reproducibility depends on them.
3. Record which deep external theorems are imported versus reproved.
4. Respect ownership rules in experiments; do not silently repair third-party dependency source when forbidden.

### Trusted computing base

Prefer kernel-checked mechanisms when practical. `native_decide` is not categorically forbidden, but expansion of the trust base requires justification when ordinary kernel checking is feasible.

### Build-graph liveness

A Lean file is **not integrated** merely because it exists or compiles alone. It is live only when reachable from the canonical build graph and covered by the canonical verification command.

Repository default gate:

- `lake exe mk_all --check`;
- full reachable `lake build`.

### Exit criteria

All credited theorems are reachable, assumption-audited, dependency-recorded, and tested at appropriate interfaces.

---

## G7 — Machine verification and exact-head credit

Machine-check credit belongs to an exact repository state, not a nearby commit.

### Required rule

The exact pull-request head containing the credited claims must pass canonical verification. After merge, the exact resulting `main` state must be verified again when required by project integration policy.

### Record at minimum

- commit SHA;
- workflow/run ID;
- relevant job ID(s);
- Lean version;
- resolved Mathlib/dependency versions when material;
- import-graph check result;
- full build conclusion;
- useful build metadata such as job count when available;
- post-build operational failures separately from mathematical compilation.

### CI interpretation

A successful build log inside a failed job is not a green CI run. Conversely, cache, runner, package, or infrastructure failure must not be mislabeled as a mathematical proof failure.

### Exit criteria

The exact credited head is green and its evidence is reproducibly locatable.

### #678 inheritance

Exact-head CI is the unit of machine-check credit.

---

## G8 — Scientific evaluation and experiment governance

This gate is conditional. It applies when the project makes empirical comparative claims about formalizations, robustness, repair locality, performance, semantic rejection, upgrade behavior, or similar properties.

### Before execution

1. Freeze the scientific question and outcome metrics prospectively.
2. Freeze candidate versions/matrix when feasible.
3. Define ownership boundaries.
4. Define admissible/excluded runs and apparatus-failure rules.
5. Define artifact aggregation and provenance checks.
6. State explicitly what the experiment cannot conclude.

### After execution

1. Preserve null, inconvenient, blocked, mixed, and negative outcomes.
2. Distinguish at least:
   - infrastructure failure;
   - artifact/provenance failure;
   - package-resolution failure;
   - dependency-owned failure;
   - project-owned failure;
   - semantic detection/rejection;
   - eligible repair surface.
3. Exclude executions that violate prospectively frozen evidence contracts even when their internal technical result is favorable.
4. Do not extrapolate bounded candidate results into general maintainability, architecture superiority, future upgrade cost, proof quality, or human repair difficulty without experiments designed to support those claims.

### Exit criteria

Every scientific claim maps to admitted evidence; broader unsupported claims remain explicitly excluded.

### #678 inheritance

S2e showed that technically informative runs can still be scientifically inadmissible when required provenance/aggregation contracts fail, and that credited conclusions must stay bounded to the frozen candidates.

---

## G9 — Integration and documentation synchronization

`DEC-011` is the default integration policy.

### Required sequence for substantive changes

1. dedicated branch;
2. pull request to `main`;
3. exact PR-head canonical verification;
4. synchronized state/roadmap/README/decision documentation where required;
5. merge the verified head unchanged;
6. exact-main post-merge verification when required;
7. record immutable provenance.

### Synchronization rule

A phase transition is incomplete while code, CI, `PROJECT_STATE.md`, the active roadmap, and current-status README files materially disagree.

Historical records preserve chronology but must be labeled `HISTORICAL SNAPSHOT` or `SUPERSEDED` when their embedded state is no longer current.

### Exit criteria

The integrated repository tells one materially consistent story about the current scientific state.

---

## G10 — Closure, archival state, and postmortem

A benchmark is not closed merely because its main theorem is proved.

### Closure checklist

- canonical statement/final theorem correspondence audited;
- proof/formalization status precisely classified;
- exact credited CI recorded;
- external provenance and novelty classification recorded;
- valuable negative paths retained;
- obsolete blockers and PRs closed or clearly superseded;
- evidence ledger and state documents synchronized;
- publication/upstream status separated from mathematical completion;
- final postmortem completed;
- sufficiently general lessons promoted to project guidance.

### Archive rule

An archived problem remains a reproducible research object. Closure documentation is part of the evidence, not cosmetic housekeeping.

### #678 inheritance

Some of the most reusable lessons became visible only after observing the entire proof, formal verification, CI, provenance, evaluation, and closure chain.

---

## 4. Standard claim vocabulary

Prefer explicit distinctions:

- `open / solved / status-uncertain` — external problem status;
- `independent attempt` — research-process classification;
- `rejected construction` — falsified mathematical path;
- `external-proof reconstruction` — known mathematics reconstructed from a source;
- `independent formal reimplementation` — formal artifact independently written from the mathematical proof rather than copied from an existing formalization;
- `rigorous proof` — human-level argument with no known substantive gap;
- `machine-checked` — exact encoded statement accepted by the designated proof assistant at the credited repository state;
- `integrated` — reachable from the canonical build graph and merged under project policy;
- `post-merge verified` — exact integrated head rechecked after merge;
- `archived` — mathematically/experimentally closed with synchronized state and provenance.

Do not infer one label from another.

## 5. Standard failure taxonomy

When a pipeline fails, classify the earliest relevant owner rather than writing only “CI failed”. Use the narrowest applicable class:

- `statement_or_definition`;
- `mathematical_counterexample`;
- `proof_gap`;
- `formalization_or_elaboration`;
- `project_owned_code`;
- `dependency_owned_code`;
- `package_resolution`;
- `infrastructure_or_runner`;
- `artifact_transport_or_provenance`;
- `post_build_operational`;
- `scientific_contract_violation`.

A repaired blocker can expose a masked blocker, so rebuild the full reachable graph after repairs.

## 6. Minimum reusable evidence package

Every substantial benchmark must retain enough evidence to answer:

1. What exact statement was studied?
2. What was known externally at the relevant date?
3. What research mode and source-access boundary applied?
4. Which constructions were rejected, and why?
5. What exact claim was ultimately proved or not proved?
6. Which assumptions and dependencies were used?
7. What exact repository commit is credited?
8. Was every credited artifact reachable from the canonical build graph?
9. Which exact CI run verifies that state?
10. What originality/provenance label is justified?
11. What conclusions are explicitly **not** justified?
12. What is the next authorized action, if any?

`RESEARCH_RECORD_SCHEMA.md` is the default record structure; problem-specific ledgers may strengthen it.

## 7. Mandatory stop conditions

An agent must stop phase advancement and report the blocker when any of the following holds:

- target activation lacks required authorization;
- the canonical statement remains materially ambiguous;
- repository state and CI materially contradict authoritative state documents;
- blind-mode source separation would be violated;
- a proposed construction is falsified by an exact valid test;
- a substantive proof gap remains at the claimed completion level;
- a credited Lean file is not reachable from the canonical graph;
- exact-head CI is red for the claim being credited;
- provenance or prospective experiment-admission requirements fail;
- novelty/scientific claims exceed the evidence;
- a governing user-transition gate forbids the next benchmark.

Stopping is a valid scientific outcome. The protocol forbids converting an unresolved blocker into a stronger claim merely to preserve momentum.

## 8. Versioning and amendments

This is **Protocol v1**, promoted from the #678 benchmark on 2026-08-20.

Future benchmarks may generate new lessons. A lesson becomes a project-level amendment only when it is sufficiently general, auditable, and explicitly integrated through the project decision/integration process. Problem-specific quirks should remain problem-specific.

## 9. Current transition constraint

At adoption of v1, `DEC-012` remains binding: completion of #678 and adoption of this protocol do **not** authorize selection, research, or formalization of another Erdős problem. A future target requires explicit user authorization before G0 can activate it.
