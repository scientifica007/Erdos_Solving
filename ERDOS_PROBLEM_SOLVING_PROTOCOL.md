# Erdős Problem Solving Protocol v1

## 1. Purpose and authority

This document converts the durable lessons of the completed Erdős #678 benchmark into the standard operational method for future mathematical benchmarks in this repository.

It is a **project-level protocol**, not a narrative postmortem. Its authority comes from `DEC-013`. It must be read together with:

- `CONSTITUTION.md` — epistemic and scientific principles;
- `DECISIONS.md` — binding project decisions;
- `AI_AGENT_GUIDE.md` — agent operating rules;
- `RESEARCH_RECORD_SCHEMA.md` — minimum research-record structure;
- the active problem's canonical statement, roadmap, state files, and evidence ledger.

This protocol does not supersede stricter problem-specific controls. When a problem-specific protocol is stricter, the stricter rule applies. Any deliberate deviation from this protocol must be recorded explicitly with rationale and authorization where required.

The immediate empirical basis is `LESSONS_LEARNED_678_ADDENDUM.md`, especially the final reusable checklist and lessons L-678-005 through L-678-042. The protocol generalizes those lessons without claiming that every future problem will require the same proof architecture or scientific-evaluation apparatus.

## 2. Scope and non-goals

The protocol governs the lifecycle of a mathematical benchmark from authorization through archival closure.

It is designed to prevent five recurrent failure classes:

1. solving the wrong statement or a variant;
2. mistaking finite/computational evidence for a general proof;
3. formalizing an unstable or false construction;
4. crediting files, runs, or claims not actually covered by the canonical verification graph;
5. overstating originality, robustness, maintainability, or scientific conclusions beyond the evidence.

The protocol does **not** guarantee that an Erdős problem is solvable, formally tractable, novel, or suitable for publication. It specifies how progress and failure are to be investigated, verified, classified, and recorded.

## 3. Lifecycle state machine

A problem may advance only through justified gates. The default lifecycle is:

`authorization -> synchronization -> statement/status audit -> research-mode freeze -> falsification-first validation -> proof development -> proof freeze/audit -> provenance classification -> formalization -> exact-head verification -> scientific evaluation when warranted -> integration -> archival closure -> postmortem`

A later gate may reveal a defect that forces a return to an earlier gate. Such a return is not a protocol failure; hiding it is.

No phase label is earned by chronology alone. It is earned by evidence satisfying that phase's exit criteria.

---

## G0 — Authorization and repository synchronization

### Entry condition

A user or governing project decision authorizes work on a specific mathematical target.

### Required actions

1. Read the current `main` head and canonical build graph.
2. Check actual CI/workflow status at the credited head.
3. Read `PROJECT_STATE.md`, relevant README files, active roadmap, decision register, and any live experiment/evidence ledgers.
4. Resolve material drift before substantive mathematical work.
5. Confirm that no user-transition gate or project decision forbids activation of the target.

### Exit criteria

- target activation is authorized;
- repository state and documentation materially agree;
- the recovery/starting commit is identified;
- current blockers are accurately classified.

### #678 lesson carried forward

State drift is itself a verification defect. A mathematically correct file does not compensate for an incorrect operational checkpoint.

---

## G1 — Canonical statement and external-status audit

### Required actions

1. Record the exact canonical statement from an authoritative source.
2. Expand definitions whose indexing, endpoints, quantifiers, domains, or conventions can affect truth.
3. Distinguish the original problem from variants, equivalent formulations, strengthened forms, and convenient formal encodings.
4. Check the current external status of the problem: open, solved, partially solved, reformulated, or uncertain.
5. Search for known proofs and formalizations only to the extent allowed by the active research mode.
6. Record dates, sources, and unresolved ambiguities.

### Mandatory questions

- Are the variables, domains, inequalities, and quantifiers identical to the benchmark?
- Are interval endpoints and indexing conventions explicit?
- Is a zero-residue or representative convention being translated correctly?
- Does an external solution already exist?
- Does an external formalization already exist?

### Exit criteria

The repository contains a statement/status record precise enough that an independent reviewer can tell exactly what is being attempted and what is already known externally.

### #678 lesson carried forward

Indexing is mathematics. The off-by-one error discovered in #678 is the canonical warning: exact ranges must be expanded before algebraic simplification.

---

## G2 — Research-mode freeze and provenance separation

Before a long proof attempt, select and record the research mode.

Typical modes are:

- **blind independent attempt**;
- **open literature-assisted research**;
- **external-proof reconstruction**;
- **formal verification/reimplementation of a known proof**;
- **comparative or scientific evaluation of existing formal artifacts**.

If blind mode is selected, `DEC-002` applies: reference proofs specifically proving the target remain inaccessible until the candidate proof is frozen and audited.

The mode may later change, but the transition must be explicit and timestamped. Earlier work must not be retrospectively relabeled.

### Exit criteria

- research mode is explicit;
- source-access rules are explicit;
- novelty/originality vocabulary appropriate to that mode is fixed.

### #678 lesson carried forward

Independent discovery, external-proof reconstruction, formal verification, and independent formal reimplementation are different achievements and must never be collapsed into “we solved it.”

---

## G3 — Falsification-first finite validation

Before investing heavily in a general construction, attack its smallest falsifiable consequences.

### Required checks when applicable

1. Verify at least one complete positive instance of the **actual target definition**, not merely its side conditions.
2. Search for small counterexamples to each new lemma or construction.
3. Test boundary values and equality/strictness transitions.
4. Expand exact products, sums, LCM/GCD ranges, modular representatives, and finite sets.
5. For an infinitude argument, audit separately:
   - witness existence;
   - generator/family;
   - distinctness/unboundedness;
   - domain preservation.
6. Preserve important rejected candidates as negative regressions.

### Failure rule

If exact finite computation falsifies a proposed construction, invalidate the construction first. Do not alter isolated inequalities or hypotheses merely to preserve the desired conclusion.

Correct sequence:

`candidate -> exact test -> rejection -> root-cause analysis -> retained regression -> revised mathematics`

### Exit criteria

The current construction has survived the finite/boundary tests that are realistically available, and no known negative regression contradicts it.

### #678 lesson carried forward

A concrete witness is not an infinitude proof, and side-condition success is not target-definition success.

---

## G4 — Mathematical stabilization and proof architecture

Expensive formalization should follow mathematical stabilization, while lightweight formal checks may be used early to expose definitional errors.

### Required actions

1. Decompose the proof into named obligations and interfaces.
2. Separate **producer** layers from **consumer** layers whenever a construction supplies data consumed by a later theorem.
3. Preserve downstream-critical information through theorem layers: positivity, strict bounds, location, cardinality, nondivisibility, distinctness, domain membership, or whatever the final translation needs.
4. Prefer stronger parameterized statements when they simplify the final theorem and genuinely follow from the proof.
5. For infinitude, prefer a reusable unbounded-witness statement when natural; derive set-theoretic infinitude afterward.
6. Make final variable/index translations explicit rather than treating them as formatting.
7. Audit assumptions and dependency theorems before declaring the proof complete.

### Proof-credit levels

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
- quantifiers and boundary cases have been audited;
- known gaps are zero or explicitly disqualifying;
- the proof is frozen before blind-mode reference comparison when `DEC-002` applies.

### #678 lesson carried forward

The successful #678 formal architecture became tractable when producer contracts, consumer theorems, CRT coordinate behavior, density interfaces, and final-index translation were separated rather than compressed into one theorem.

---

## G5 — Literature comparison and provenance classification

After the independent proof is frozen—or earlier when blind separation is not active—compare the result with the literature.

### Required classification

Record separately:

- external problem status;
- whether the mathematics is known;
- whether the proof route matches or differs from known proofs;
- whether an external formalization exists;
- whether the repository's formal artifact is copied, ported, independently reimplemented, or genuinely independent;
- what novelty, if any, is actually supported.

### Rule

Attribution and verification are orthogonal. A known proof can be independently machine-verified; a machine-checked artifact can still have no novelty claim.

### Exit criteria

Every public-facing claim uses provenance language no stronger than the evidence.

---

## G6 — Formalization architecture and trust boundary

When Lean formalization is part of the benchmark, use the following defaults.

### Definitions and interfaces

1. Prefer APIs that encode intended cardinality/length directly when endpoint ambiguity is dangerous.
2. Name translations between paper conventions and canonical formal representations.
3. Test producer/consumer boundaries, not only internal helper lemmas.
4. When a definition is opaque or expensive to reduce, test theorem interfaces instead of forcing evaluation merely for convenience.

### Dependencies

1. Inspect the actual Mathlib/library API before speculative proof rewrites.
2. Pin important external formal dependencies by exact commit/version when scientific reproducibility depends on them.
3. Record which deep external theorems are imported versus reproved.
4. Do not silently repair third-party dependency source when an experiment's ownership contract forbids it.

### Trusted computing base

Prefer kernel-checked mechanisms when practical. Tools such as `native_decide` are not universally forbidden, but expanding the trusted base requires an explicit reason when ordinary kernel checking is feasible.

### Build-graph liveness

A Lean file is **not integrated** merely because it exists or compiles in isolation. It is live only if it is reachable from the canonical build graph and covered by the canonical verification command.

For this repository the default canonical gate is:

- `lake exe mk_all --check`;
- full reachable `lake build`.

### Exit criteria

All credited theorems are reachable, assumption-audited, dependency-recorded, and test-covered at the appropriate interfaces.

---

## G7 — Machine verification and exact-head credit

Machine-check credit belongs to a specific repository state, not to a nearby commit.

### Required rule

The exact pull-request head containing the claims being credited must pass the canonical verification. After merge, the exact resulting `main` state must be verified again when required by the governing integration policy.

### Record at minimum

- commit SHA;
- workflow/run ID;
- relevant job ID(s);
- Lean version;
- resolved Mathlib/dependency versions when material;
- import-graph check result;
- full build conclusion;
- number of jobs or equivalent build evidence when useful;
- any post-build failure distinct from mathematical compilation.

### CI interpretation

A successful compilation log inside a failed job is not a green CI run. Conversely, an infrastructure or cache failure must not be mislabeled as a mathematical proof failure.

### Exit criteria

The exact credited head is green under the canonical check and the evidence is reproducibly locatable.

### #678 lesson carried forward

Exact-head CI is the unit of machine-check credit.

---

## G8 — Scientific evaluation and experiment governance

This gate is conditional. It applies when the project makes empirical comparative claims about formalizations, robustness, repair locality, performance, semantic rejection, upgrade behavior, or similar properties.

### Before execution

1. Freeze the question and outcome metrics prospectively.
2. Freeze candidate matrix/versions when feasible.
3. Define ownership boundaries.
4. Define admissible/excluded runs and apparatus-failure rules.
5. Define artifact aggregation and provenance checks.
6. State what the experiment **cannot** conclude.

### After execution

1. Preserve null, inconvenient, blocked, mixed, and negative outcomes.
2. Distinguish:
   - infrastructure failure;
   - artifact/provenance failure;
   - package resolution failure;
   - dependency-owned failure;
   - project-owned failure;
   - semantic detection/rejection;
   - eligible repair surface.
3. Exclude runs that violate prospectively frozen evidence contracts even when their internal technical result appears favorable.
4. Do not extrapolate from bounded candidate versions to general maintainability, architecture superiority, future upgrade cost, proof quality, or human difficulty without an experiment designed to support that claim.

### Exit criteria

Every scientific claim maps to an admitted artifact/run and every unsupported broader claim remains explicitly excluded.

### #678 lesson carried forward

S2e demonstrated that a technically informative execution can still be scientifically inadmissible if a required artifact/provenance contract fails; later credited conclusions remained deliberately bounded to the exact frozen candidates.

---

## G9 — Integration and documentation synchronization

`DEC-011` is the default integration policy.

### Required sequence for substantive changes

1. dedicated branch;
2. pull request to `main`;
3. exact PR-head canonical verification;
4. synchronized state/roadmap/README/decision documentation in the same PR where required;
5. merge the verified head unchanged;
6. exact-main post-merge verification when required;
7. record immutable provenance.

### Synchronization rule

A phase transition is incomplete while code, CI, `PROJECT_STATE.md`, the active roadmap, and current-status README files materially disagree.

Historical records retain chronology but must be labeled `HISTORICAL SNAPSHOT` or `SUPERSEDED` when their embedded operational state is no longer current.

### Exit criteria

The integrated repository tells one materially consistent story about the current scientific state.

---

## G10 — Closure, archival state, and postmortem

A benchmark is not closed merely because its main theorem is proved.

### Closure checklist

- canonical statement and final theorem correspondence audited;
- proof/formalization status precisely classified;
- exact credited CI recorded;
- external provenance and novelty classification recorded;
- negative paths worth retaining preserved;
- obsolete blockers and PRs closed or clearly superseded;
- evidence ledger and state documents synchronized;
- publication/upstream status separated from mathematical completion;
- final postmortem completed;
- reusable lessons promoted to project-level guidance where justified.

### Archive rule

The archived problem remains a reproducible research object. Closure documentation is part of the evidence, not cosmetic housekeeping.

### #678 lesson carried forward

A completed benchmark deserves a final postmortem pass because some of the most reusable lessons become visible only after the entire proof, verification, CI, provenance, and closure chain has been observed.

---

## 4. Standard claim vocabulary

Agents and documents should prefer the following explicit distinctions:

- `open / solved / status-uncertain` — external problem status;
- `independent attempt` — research process classification;
- `rejected construction` — falsified mathematical path;
- `external-proof reconstruction` — known mathematics reconstructed from a source;
- `independent formal reimplementation` — formal artifact independently written from the mathematical proof, not copied from an existing formalization;
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

A repaired blocker may expose a masked blocker, so the full reachable graph must be rerun after each repair.

## 6. Minimum reusable evidence package

For every substantial benchmark, maintain enough information to answer:

1. What exact statement was studied?
2. What was known externally at the relevant date?
3. What research mode was used?
4. Which constructions were rejected, and why?
5. What exact claim was ultimately proved or not proved?
6. Which dependencies and assumptions were used?
7. What exact repository commit is credited?
8. Was the credited artifact reachable from the canonical build graph?
9. Which CI run verifies that exact state?
10. What originality/provenance label is justified?
11. What conclusions are explicitly **not** justified?
12. What is the next authorized action, if any?

`RESEARCH_RECORD_SCHEMA.md` is the default record structure; problem-specific ledgers may strengthen it.

## 7. Mandatory stop conditions

An agent must stop advancement and report the blocker when any of the following is true:

- target activation lacks required authorization;
- canonical statement remains materially ambiguous;
- repository state and CI materially contradict authoritative state documents;
- a proposed construction is falsified by an exact valid test;
- a substantive proof gap remains;
- a credited Lean file is not reachable from the canonical graph;
- exact-head CI is red for the claim being credited;
- provenance/experiment admission requirements are not satisfied;
- novelty or scientific claims exceed the evidence;
- a governing user-transition gate forbids the next benchmark.

Stopping is a valid scientific outcome. The protocol forbids converting an unresolved blocker into a stronger claim merely to preserve momentum.

## 8. Versioning and amendments

This is **Protocol v1**, promoted from the #678 benchmark on 2026-08-20.

Future benchmarks may generate new lessons. A lesson becomes a project-level protocol amendment only when it is sufficiently general, auditable, and explicitly integrated through the project decision/integration process. Problem-specific quirks should remain problem-specific rather than bloating the general protocol.

## 9. Current transition constraint

At the time v1 is adopted, `DEC-012` remains binding: completion of #678 and adoption of this protocol do **not** authorize selection, research, or formalization of another Erdős problem. A future target requires explicit user authorization before G0 can activate it.
