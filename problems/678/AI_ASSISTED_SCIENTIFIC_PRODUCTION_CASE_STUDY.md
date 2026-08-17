# Erdős #678 — AI-Assisted Scientific Production Case Study

## Status

This document treats the completed #678 effort as an empirical case study in **AI-assisted production of research-grade mathematical material**.

The mathematical theorem itself is not new: the successful proof is a Lean reconstruction of Stijn Cambie's 2024 solution. The experimental object here is the production process: how an AI-assisted workflow moved from an attractive but invalid independent idea to a machine-checked reconstruction, how errors were exposed and retained, and which software/research controls were needed to close a long-horizon formalization reliably.

The objective is not to present hidden model reasoning. The evidential record consists only of externally auditable artifacts: repository history, written candidate arguments, failed constructions, formal statements, Lean files, regression tests, dependency pins, CI runs, pull requests, state documents, and explicit user/human decisions.

---

## 1. Why #678 is a useful AI-for-science case

Many theorem-proving benchmarks reduce evaluation to a binary endpoint: theorem closed or theorem not closed. #678 exposes a richer sequence of scientific failure modes:

1. a genuine finite witness was discovered/verified;
2. that witness encouraged a false scaling generalization;
3. a later quotient construction contained an interval-indexing mismatch;
4. formal checking rejected the invalid path;
5. the failed path was preserved as provenance and as negative-regression knowledge;
6. the project switched modes from independent exploration to reconstruction of an external published proof;
7. a long dependency chain was decomposed into formal interfaces;
8. an initially external prime-density gap was discharged through a pinned formal PNT+ dependency;
9. final statement translation required recovering information that an earlier endpoint had discarded;
10. the theorem was integrated only after canonical graph and exact-head CI checks;
11. post-merge documentation drift itself was treated as a correctness/process defect and repaired.

This sequence is scientifically informative because it separates several notions that are frequently conflated:

- plausible reasoning versus valid reasoning;
- a verified example versus a verified general theorem;
- local lemma closure versus global theorem closure;
- formal proof text versus reachable/buildable proof artifact;
- mathematical correctness versus statement fidelity;
- machine verification versus attribution/novelty;
- theorem completion versus reproducible integration.

---

## 2. Research questions

The repository can support a formal case study around the following research questions.

### RQ1 — Can formal verification stop a productive-looking but invalid mathematical trajectory early enough to save the project?

The #678 record contains two concrete failures:

- false scaling intuition around `M(t*n,k) = t*M(n,k)`;
- an incorrect interval endpoint in a later `Q = P/M` construction.

The key observable is not merely that Lean rejected a proof. It is whether the workflow converted rejection into durable knowledge instead of repeatedly rediscovering the same invalid strategy.

### RQ2 — What controls preserve target fidelity during long-horizon AI-assisted formalization?

Relevant controls developed during #678 include:

- canonical statement locking;
- a length-based interval API;
- explicit distinction between paper indexing and Erdős indexing;
- a state protocol and canonical roadmap;
- historical-snapshot labeling;
- documentation synchronization gates;
- a final dedicated index-translation layer.

### RQ3 — Which proof-engineering abstractions help an AI-assisted process survive long dependency chains?

The development increasingly moved from direct theorem proving to producer/consumer contracts:

- Claim 4 density contracts;
- weighted representation contracts;
- pair/triple CRT producers;
- Claim 5 residue interfaces;
- prime-window providers;
- relative-prime provider;
- final strong-theorem endpoint.

The hypothesis is that contract-scoped work reduces context loss and prevents local repairs from silently changing downstream semantics.

### RQ4 — How should an AI scientific workflow change mode after independent discovery fails?

The project explicitly reclassified the successful path as **external-proof reconstruction** rather than continuing to present it as independent discovery.

This mode switch is central to scientific integrity. It allows the AI system to continue producing value without inflating originality claims.

### RQ5 — What should count as “verified” in an AI-produced mathematical artifact?

For #678, the project eventually adopted the stricter criterion:

> a theorem receives machine-check credit only when it is reachable from the canonical build graph and the exact repository head passes CI.

This is stronger than “a Lean file containing the theorem exists” or “a local snippet type-checks once.”

### RQ6 — Can the resulting process artifacts themselves become reusable scientific output?

The #678 record includes failed hypotheses, negative tests, theorem-interface evolution, dependency decisions, exact CI checkpoints, and postmortem rules. These are data about formal-scientific production, not merely project-management residue.

---

## 3. Experimental timeline

The dates below are repository-observable milestones, not a claim that every intermediate reasoning action was logged.

### Phase A — finite evidence and invalid generalization

On 2026-08-13 the project recorded the failed scaling argument and the audit of the missing infinitude mechanism.

A valid finite witness, `M(36,8) > M(47,9)`, survived formal verification. A separate candidate `(495,504,8)` was machine-refuted and retained as a negative regression.

**Experimental lesson:** a correct example can increase confidence in an incorrect generator. Evidence for existence and evidence for infinitude must be tracked separately.

### Phase B — formal infrastructure and statement repair

On 2026-08-14 the project created the Lean environment, CI verification, corrected witness regressions, a length-based interval API, and valuation modules.

The interval API was a response to a real semantic failure: `M(n,k)` means the LCM of `n+1,...,n+k`, so translating between start points and lengths cannot be left implicit.

**Experimental lesson:** data-model/API design is part of mathematical correctness when notation carries indexing conventions.

### Phase C — external-proof reconstruction

After the independent route was rejected, the project analyzed Cambie's construction and decomposed it into formal obligations.

The reconstruction split the paper's proof into Claim 4 and Claim 5 layers, then further into modular CRT, density, valuation, prime-range, scale, and placement components.

**Experimental lesson:** after a mode switch from discovery to reconstruction, success depends on making proof obligations explicit rather than continuing open-ended search.

### Phase D — long-horizon interface stabilization

The largest middle phase progressively built:

- generic density lemmas;
- modular/weighted CRT interfaces;
- pair and triple producers;
- exact application boxes;
- scaled affine residue connections;
- representative separation;
- prime windows;
- constructed scales and quantitative room bounds;
- Claim 5 product/LCM estimate.

During this phase the project repeatedly synchronized roadmap and state documents so that a future agent invocation could resume from a stable boundary.

**Experimental lesson:** external memory in versioned artifacts is a control against context decay.

### Phase E — analytic dependency closure

The project replaced an abstract prime-density boundary with a pinned import of `AxiomMath/PrimeNumberTheoremAnd` and a direct adapter from `prime_between` to the natural-number relative-prime provider needed downstream.

The dependency was pinned to revision:

`2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`.

**Experimental lesson:** a formal proof's trust and reproducibility boundary includes dependency provenance, not only theorem text.

### Phase F — final theorem translation

The strong Cambie endpoint originally discarded placement information that later became necessary for the canonical Erdős variables `n=x-1`, `m=y-1`.

The final layer therefore recovered `k < x` from existing quantitative bounds and carried it through the pipeline before the off-by-one translation.

**Experimental lesson:** local abstraction can accidentally erase facts required by the eventual user-facing theorem. Interface design should preserve downstream invariants or explicitly document what is discarded.

### Phase G — integration and archival closure

The mathematical reconstruction was merged through PR #17 after exact-head CI. Post-merge verification succeeded on `main`. Documentation synchronization and the explicit post-#678 authorization gate were then merged through PRs #18 and #19. A final lessons-learned postmortem was merged through PR #20.

**Experimental lesson:** long-horizon scientific production has a closure phase distinct from theorem proving: integration, reproducibility, attribution, documentation consistency, and stop conditions.

---

## 4. Observable failure taxonomy

The #678 experience supports a concrete taxonomy of AI-assisted mathematical failure.

| Failure class | #678 instance | Detection/control |
|---|---|---|
| False algebraic generalization | scaling a valid witness | theorem/proof audit; retained lesson |
| Index/interval semantic drift | wrong block in `M(t,k+1)` | length-based interval API; regression tests |
| Example-to-family overreach | finite witness treated as route to infinitude | explicit generator/distinctness audit |
| Local/global proof gap | local components available before full construction | roadmap gates and explicit dependency graph |
| Hidden analytic dependency | prime-density assumption | pinned PNT+ dependency and adapter |
| Interface information loss | final endpoint lacked `k < x` | E4 strengthened endpoint |
| Build-graph false confidence | source file could exist off the canonical graph | generated-import graph check + canonical build |
| State/document drift | docs lagged merged theorem state | documentation synchronization gate |
| Attribution drift | external proof could be mistaken for independent discovery | explicit `external-proof-reconstruction` classification |
| Task-scope drift | automatic transition to another problem after completion | explicit user gate `DEC-012` |

This taxonomy can be reused as annotation labels in future AI-for-math experiments.

---

## 5. Control mechanisms that emerged

### 5.1 Statement lock

The canonical target is fixed before proof work advances. Variant readings are recorded rather than silently substituted.

### 5.2 Blind-mode / reference-mode separation

Independent exploration and external-proof reconstruction are distinct project modes. Access to a reference solution changes the scientific claim and is recorded.

### 5.3 Proof freeze before comparison

When independent work exists, it should be frozen before consulting a reference, allowing later comparison without retroactively contaminating provenance.

### 5.4 Negative regression retention

Rejected candidates and known-invalid formulas remain executable tests or documented anti-patterns.

### 5.5 Interface-first decomposition

Long proof chains are split around explicit producer/consumer contracts so work can be resumed and tested locally.

### 5.6 Canonical build graph

A theorem is not credited merely because a `.lean` file exists. It must be imported into the canonical graph, and graph generation/checking must be stable.

### 5.7 Exact-head CI

CI credit belongs to the exact commit being merged. Subsequent edits require a new run.

### 5.8 Documentation as verified state

Project-state documents, roadmap, and README must agree with repository head before the mathematical phase is advanced.

### 5.9 Explicit stop gate

Completion is not treated as permission to begin an unrelated research target automatically.

These controls are scientific-process outputs in their own right. They represent mechanisms for reducing hallucination, provenance ambiguity, and long-horizon state loss.

---

## 6. Quantitative record currently available

The existing repository provides several measurable dimensions.

### Formal artifact size

At archival head `4596a360...`:

- 78 #678 Lean files;
- 7046 lines in the #678 Lean directory;
- 31 test/regression files, 1384 lines;
- 47 non-test files, 5662 lines.

### Canonical build scale

The final mathematical canonical build completed successfully with **8806 jobs**.

Key successful checkpoints include:

- E2/PNT bridge run `31975809856`;
- E3 strong theorem run `31975821891`;
- E4 synchronized mathematical run `31977861568`;
- post-merge main run `32011189766`;
- post-postmortem main run `32021192337`.

### Repository history

The first explicit #678 failure-learning commits appear on 2026-08-13; the final postmortem merge occurred on 2026-08-17.

A broad repository comparison from checkpoint `c568951...` to archival head `4596a360...` spans 274 repository commits. That number is **not** a clean measure of #678 effort because the interval also includes synchronization changes elsewhere in the repository. Publication should therefore use a filtered event log rather than treating raw commit count as “AI steps.”

### Missing measurements

The current archive does **not** provide a publication-grade record of:

- model invocation count;
- token count;
- inference cost;
- exact wall-clock human attention;
- per-attempt prompt text;
- automated versus human-authored line attribution;
- standardized edit/repair durations.

These should not be reconstructed speculatively.

---

## 7. Proposed experimental dataset

The repository can be converted into a machine-readable case-study dataset without storing private chain-of-thought.

Each research episode should contain fields such as:

```yaml
episode_id: string
timestamp_start: ISO-8601
timestamp_end: ISO-8601 | null
problem: 678
mode: blind-discovery | audit | external-proof-reconstruction | formalization | integration
objective: string
input_artifact_refs:
  - commit/file/theorem identifiers
observable_hypothesis_or_task: string
result: success | failure | partial | superseded
failure_class: optional taxonomy label
output_commit: optional SHA
ci_run: optional run id
human_intervention: none | scope | mathematical | engineering | approval
reference_solution_accessed: boolean
canonical_state_after: string
notes: concise externally observable summary
```

Important exclusion:

> Do not store or publish hidden model chain-of-thought. Record hypotheses, actions, artifacts, test results, corrections, and externally observable decisions instead.

This is sufficient for process research while avoiding dependence on inaccessible internal reasoning traces.

---

## 8. Retrospective experimental hypotheses

The archived material already suggests several hypotheses, but they require prospective testing before strong causal claims.

### H-AI-1 — Negative-regression memory reduces repeated hallucination

If known-invalid claims are encoded as regressions/anti-patterns, later agent runs should be less likely to reintroduce them.

**Prospective test:** seed future formalization tasks with or without the failure ledger and compare recurrence rates of known error classes.

### H-AI-2 — Externalized state reduces long-horizon context failure

A canonical state file and roadmap should improve restart accuracy after context resets.

**Prospective test:** give agents identical repositories with and without synchronized state artifacts and measure time/edits to identify the next valid proof obligation.

### H-AI-3 — Contract-scoped formalization improves repair locality

Explicit interfaces should limit the blast radius of failed proof attempts.

**Prospective test:** introduce controlled API changes and compare number of unrelated declarations modified.

### H-AI-4 — Exact-head CI prevents false completion claims

When the verification result is attached to a precise commit rather than a branch name or remembered local state, stale-verification errors should disappear.

**Prospective test:** simulate documentation/code edits after a green run and measure whether the workflow catches invalidated credit.

### H-AI-5 — Separating discovery from reconstruction improves scientific attribution

Explicit mode transitions should reduce incorrect novelty claims after a reference proof is consulted.

**Prospective test:** evaluate final reports from workflows with/without provenance fields.

---

## 9. Comparison with current literature

### 9.1 Formal Conjectures

*Formal Conjectures: An Open and Evolving Benchmark for Verified Discovery in Mathematics* (arXiv:2605.13171) emphasizes statement fidelity, research-level Lean benchmarks, and the role of AI-generated proofs/disproofs in auditing formal statements.

#678 provides a compact concrete case: an ambiguous fixed-`k` reading was formally disprovable, while the intended varying-`k` interpretation is solved by Cambie's result.

### 9.2 AI-driven formal proof search on Erdős problems

*Advancing Mathematics Research with AI-Driven Formal Proof Search* (arXiv:2605.22763) evaluates agentic systems on open Erdős problems and other research conjectures.

Our #678 case differs because the final mathematics was already known. The research value is therefore not autonomous mathematical discovery but the reliability of **long-horizon reconstruction, verification, and integration**.

### 9.3 LeanMarathon

*LeanMarathon: Toward Reliable AI Co-Mathematicians through Long-Horizon Lean Autoformalization* (arXiv:2606.05400) identifies statement drift, dependency tangling, context decay, and nonlocal corruption from local repair as central long-horizon problems.

The #678 workflow independently encountered the same failure categories and evolved similar controls: explicit proof graph/roadmap, contract boundaries, state synchronization, and CI-gated progress. A comparative analysis could test which controls generalize across systems.

### 9.4 FormalScience

*FormalScience: Scalable Human-in-the-Loop Autoformalisation of Science with Agentic Code Generation in Lean* (ACL 2026) emphasizes semantic alignment and characterizes semantic drift.

Our interval-indexing failure is a mathematics-specific instance of semantic drift: the formal expression can look structurally reasonable while referring to a different interval than intended.

### 9.5 Aristotle case-study literature

The Grasshopper case study (arXiv:2605.20120) distinguishes verified helper lemmas from an unresolved main theorem. #678 supplies a complementary positive case where the local-to-global gap was eventually closed and the full endpoint reached the canonical build graph.

### 9.6 Multiple formal routes as cross-checks

The ITP 2026 paper *Three Roads to de Finetti's Theorem in Lean 4* uses independent proof routes and a common interface as a cross-check during AI-assisted development.

A normalized compatibility layer between our #678 development and the Aristotle/Alexeev artifact would turn the same idea into a differential-verification experiment for a recent research-level number-theory proof.

---

## 10. What would make this publishable as an AI case study

The current archive is rich enough for a serious technical report. For a stronger empirical paper, add a reproducibility layer with the following evidence.

1. **Filtered episode log** reconstructed from commits/CI without invented model metadata.
2. **Artifact snapshots** for the failed independent route, intermediate reconstruction interfaces, and final theorem.
3. **Mutation suite** encoding the historical interval/scaling mistakes.
4. **Restart experiment** testing agents with and without state/roadmap artifacts.
5. **Repair-locality experiment** on modular versus monolithic #678 artifacts.
6. **Common-environment differential proof check** against `plby/lean-proofs`.
7. **Human audit task** measuring how quickly an independent reviewer can identify assumptions, statement semantics, and final theorem boundary.
8. **Prospective logging protocol** for future experiments, including model identifier, invocation count, cost, tool calls, wall clock, and human intervention categories.

The case study should explicitly separate retrospective observations from prospective experiments. The former establish what happened; the latter are needed for causal claims about workflow design.

---

## 11. Two scientific products hidden inside one project

The #678 archive can support two distinct outputs.

### Product A — formal-mathematics / proof-engineering artifact

Focus:

- independent reconstruction;
- direct `prime_between` interface;
- modular proof architecture;
- differential comparison with Aristotle/Alexeev;
- statement bridge and regression suite.

Primary evidence: Lean code and common-environment experiments.

### Product B — AI-assisted scientific-production case study

Focus:

- transition from failed discovery to faithful reconstruction;
- error taxonomy;
- state/provenance controls;
- long-horizon workflow;
- exact-head CI and canonical graph verification;
- lessons for reliable AI co-mathematics.

Primary evidence: repository/CI history plus prospective controlled experiments.

These products share the same mathematical artifact but answer different scientific questions. Keeping them conceptually separate prevents the AI-methodology contribution from being confused with a claim of new mathematics.

---

## 12. Threats to validity

A credible publication must state the limitations clearly.

### Single-case limitation

#678 is one theorem in one mathematical domain. Workflow conclusions may not generalize to algebra, geometry, or proof developments with very different library support.

### Retrospective instrumentation

The project was not initially designed as a controlled AI experiment. Important measurements such as token/cost/time-by-agent were not logged from the beginning.

### Human/AI contribution entanglement

Repository artifacts do not by themselves provide a reliable line-by-line attribution between AI generation, human direction, and automated tooling. Claims should therefore be about the **AI-assisted workflow**, not autonomous AI authorship of every artifact.

### External-proof mode

After the independent attempt failed, the successful mathematics came from a published proof. The study measures reconstruction/verification ability, not original theorem discovery.

### Architecture confounding

The modular artifact is larger and includes many dedicated tests. Any maintenance comparison must normalize for different goals and environments before drawing conclusions.

### Private-repository reproducibility

External scientific verification will require a public, immutable artifact snapshot or equivalent archival release. Repository visibility should not be changed without explicit authorization.

---

## 13. Data-integrity rules for any paper based on #678

1. Cite Cambie as the mathematical proof author.
2. Cite Aristotle/Boris Alexeev as prior formal authors.
3. State that our independent mathematical attempt was rejected.
4. State when reference-proof access occurred and classify the successful work as reconstruction.
5. Never infer AI cost, token count, or autonomous-work percentages from git history.
6. Distinguish theorem source files from reachable canonical build status.
7. Pin all comparison commits and dependency revisions.
8. Preserve failed artifacts when they are part of the experimental evidence.
9. Label historical snapshots rather than silently rewriting them.
10. Do not expose private chain-of-thought; publish observable research actions and artifacts instead.

---

## 14. Recommended case-study thesis

A defensible thesis for the AI dimension is:

> Research-level AI-assisted formalization is not only a proof-search problem. In a multi-day reconstruction of Erdős #678, the decisive reliability mechanisms were explicit target semantics, failure retention, contract-scoped proof decomposition, externalized state, pinned analytic dependencies, reachable-build verification, and exact-head integration gates. The formal prover rejected invalid mathematical trajectories, while the repository protocol converted those failures into reusable scientific-process knowledge.

This thesis is stronger and more useful than claiming that "AI formalized a theorem," because it identifies testable mechanisms for making AI-generated scientific material auditable and recoverable over long horizons.

---

## 15. Archival conclusion

The #678 experiment produced two forms of value:

1. a machine-checked independent Lean reconstruction of known mathematics;
2. an unusually detailed, auditable record of how AI-assisted scientific material can fail, recover, and eventually meet a strict verification/integration standard.

The second form is not a by-product to discard. With a filtered event log and controlled follow-up experiments, it can become a scientific contribution in its own right.