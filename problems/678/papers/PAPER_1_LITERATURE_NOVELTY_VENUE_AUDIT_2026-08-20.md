# Paper 1 — Literature, Novelty, and Venue Audit — 2026-08-20

**Paper:** *Independent Lean Reconstruction and Differential Verification of Cambie's Solution to Erdős Problem #678*  
**Audit date:** 2026-08-20  
**Scope:** Paper 1 only  
**Purpose:** close publication phase P2 before full prose drafting  
**Rule:** this audit supports positioning; it does not authorize first-of-kind or general-superiority claims.

## 1. Audit questions

This audit addresses four questions:

1. What are the primary mathematical and formal-artifact sources that Paper 1 must credit?
2. Which strands of prior formal-verification/proof-engineering work are closest to the paper's contribution?
3. What novelty statement is defensible without making an unsupported priority claim?
4. Which current publication venues are realistic, and what constraints do their current policies impose?

The search prioritizes primary papers, official proceedings, official repositories, and official venue pages. Secondary sources are not used to establish priority.

## 2. Primary mathematical source and statement provenance

### 2.1 Cambie's solution

The mathematical source is:

- Stijn Cambie, **“Resolution of an Erdős' problem on least common multiples,”** arXiv:2410.09138, 2024. DOI: https://doi.org/10.48550/arXiv.2410.09138

Cambie's abstract states that the Erdős question is answered affirmatively and that the ratio of the relevant least common multiples can be made arbitrarily large. Paper 1 must attribute the successful mathematics to Cambie and describe the project result as a Lean reconstruction/reimplementation of that proof rather than as a new mathematical solution.

### 2.2 Canonical problem reading

The project uses

`M(n,k) = lcm{n+1,...,n+k}`.

The intended conclusion varies `k`: the project proves witnesses above every lower bound on `k`, hence infinitely many good block lengths. This interpretation is aligned with the current Formal Conjectures statement for Erdős #678, which explicitly notes that a fixed `k` cannot support infinitely many valid pairs and presents eventual nonemptiness / infinitely many triples as the intended reading.

Current statement source:

- Formal Conjectures, `FormalConjectures/ErdosProblems/678.lean`, current repository snapshot audited on 2026-08-20: https://github.com/google-deepmind/formal-conjectures/blob/main/FormalConjectures/ErdosProblems/678.lean

The project does not rely on mutable `main` for its own proof credit; this current source is used here only to document contemporary statement context.

## 3. Prior public Lean artifact

The controlled comparator used by S1 is pinned independently of current upstream changes:

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- file: `src/latest/ErdosProblems/Erdos678.lean`;
- formal authors recorded in the source: **Aristotle** and **Boris Alexeev**;
- informal/mathematical author recorded in the source: **Stijn Cambie**.

Pinned source:

https://github.com/plby/lean-proofs/blob/6f906fef432892db5c910c48ad1a3728dd42cdac/src/latest/ErdosProblems/Erdos678.lean

This artifact predates the project's reconstruction and therefore rules out a first-formalization claim. S1 compares against this unchanged pinned artifact in a controlled common environment. Differential verification supports a controlled executable comparison and statement/axiom cross-check; it does not establish proof genealogy.

The current Formal Conjectures #678 entry also credits Alexeev using Aristotle and points to a public Lean proof, reinforcing the need to state prior formalization explicitly.

## 4. Literature map

The closest prior work is not a single paper but several distinct traditions. Paper 1 should position itself at their intersection without suggesting that any one component is unprecedented.

### 4.1 Large and research-level mathematical formalization

**Flyspeck / Kepler.** Thomas Hales et al., **“A Formal Proof of the Kepler Conjecture,”** *Forum of Mathematics, Pi* 5 (2017), e2. DOI: https://doi.org/10.1017/fmp.2017.1

This is a canonical example of a large formal verification of a major mathematical theorem, using HOL Light and Isabelle. It establishes the broader scientific legitimacy of machine-checked reconstruction/verification of known mathematics.

**Perfectoid spaces.** Kevin Buzzard, Johan Commelin, and Patrick Massot, **“Formalising Perfectoid Spaces,”** CPP 2020, pp. 299–312. DOI: https://doi.org/10.1145/3372885.3373830

This work reports on formalizing sophisticated contemporary mathematics in Lean and explicitly discusses formalization design/process. It is particularly relevant to Paper 1's proof-engineering perspective.

**Liquid Tensor Experiment.** Peter Scholze, **“Liquid Tensor Experiment,”** *Experimental Mathematics* 31(2), 2022, pp. 349–354. DOI: https://doi.org/10.1080/10586458.2021.1926016; project repository: https://github.com/leanprover-community/lean-liquid

The project is relevant as a major Lean formalization effort with an explicit blueprint connecting informal mathematics, dependency structure, and formal declarations. Paper 1 differs in scientific object and evaluation design, but shares the concern that formal proof structure and human-readable mathematical structure must be connected deliberately.

### 4.2 Statement formalization and fidelity

**Formal Conjectures.** Moritz Firsching et al., **“Formal Conjectures: An Open and Evolving Benchmark for Verified Discovery in Mathematics,”** arXiv:2605.13171, 2026. https://arxiv.org/abs/2605.13171

Formal Conjectures is directly relevant because it treats research-level mathematical statements as auditable Lean objects and emphasizes correctness/fidelity of formalized statements. Its current Erdős #678 file is also a direct public statement reference for this case.

Paper 1's statement-fidelity contribution is narrower and artifact-specific: it proves explicit bridges between the project's length-based interval API and the public `Finset.Ioc` convention, and it exposes the indexing translation used to derive the benchmark endpoint from the stronger theorem.

### 4.3 Proof reconstruction and independent routes

**Lean on Vampire Proofs.** Jonas Bodingbauer, Márton Hajdu, Laura Kovács, Axel Polaczek, and Michael Rawson, **“Lean on Vampire Proofs,”** ITP 2026, LIPIcs 382, 36:1–36:9. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.36

This work reconstructs proofs produced by the Vampire automated theorem prover as trusted Lean proofs. The reconstruction setting is different from reconstructing a published mathematical argument, but it is relevant to the general theme that an independently checked proof object can strengthen trust in an external proof source.

**Three Roads to de Finetti's Theorem in Lean 4.** Cameron Freer, ITP 2026, LIPIcs 382, 34:1–34:9. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.34

This work formalizes multiple distinct proof routes that converge on a common interface and explicitly notes the cross-checking value of independent routes. It is a useful comparator for Paper 1's emphasis on interfaces and cross-checking, although Paper 1 compares separately implemented public/internal artifacts rather than three routes inside one development.

### 4.4 End-to-end verification and trusted computational chains

**Keller's conjecture.** James Gallicchio, Cayden Codel, Jeremy Avigad, and Marijn J. H. Heule, **“An End-To-End Verification of Keller's Conjecture,”** ITP 2026, LIPIcs 382, 26:1–26:20. DOI: https://doi.org/10.4230/LIPIcs.ITP.2026.26

This work is relevant to the idea that proof credit depends on the whole trusted verification chain rather than a single successful computation. Paper 1's exact-head/exact-main discipline is repository/provenance-specific, but it belongs to the same broad concern with end-to-end evidence.

### 4.5 Blueprint and proof-engineering infrastructure

**LeanArchitect.** Thomas Zhu, Pietro Monticone, Jeremy Avigad, and Sean Welleck, **“LeanArchitect: Automating Blueprint Generation for Humans and AI,”** ITP 2026; arXiv:2601.22554. https://arxiv.org/abs/2601.22554

LeanArchitect addresses synchronization between informal exposition, Lean declarations, and dependency graphs. This is relevant to Paper 1's producer/consumer interfaces and reproducibility story, while the present paper evaluates a specific formal reconstruction rather than proposing blueprint tooling.

## 5. What the literature audit does and does not establish

### 5.1 Established positioning

The audit establishes that there is substantial prior work on:

- formal verification of major mathematical results;
- Lean formalization of contemporary research mathematics;
- formal statement datasets and fidelity auditing;
- proof reconstruction into trusted proof assistants;
- multiple-route proof cross-checking;
- end-to-end verification chains;
- blueprint/dependency tooling for large formalizations.

Therefore Paper 1 must not frame formal reconstruction, proof assistants, statement fidelity, independent routes, or proof engineering themselves as novel concepts.

### 5.2 Defensible contribution statement

The following positioning is supported:

> Paper 1 studies a specific combination of independently structured Lean reconstruction of a known mathematical proof, explicit semantic bridging to public statement conventions, controlled common-environment differential verification against a pinned prior formal artifact, prospectively frozen bounded proof-engineering experiments, and exact verification-credit provenance.

The audit did **not** identify an exact precedent containing this complete combination, but the search is not a proof of absence. Accordingly the manuscript should say that this combination is **the contribution of the present case study**, not that it is the first such work.

### 5.3 Priority language policy

Allowed:

- “we provide”;
- “we evaluate”;
- “in this case study”;
- “under the frozen protocol”;
- “the combination studied here”;
- “to our knowledge” only if a venue reviewer later requires a qualified literature statement and the literature audit is refreshed immediately before submission.

Avoid in Draft 1:

- “first”;
- “unprecedented”;
- “the first independent reconstruction”;
- “the first differential verification”;
- “the first empirical comparison”;
- any claim that no related methodology exists.

## 6. Relation to the prior Aristotle/Boris Alexeev artifact

Comparator fairness is a central review risk. The manuscript should make four facts explicit:

1. the public comparator is prior work and receives formalization credit accordingly;
2. the comparator is pinned and compiled unchanged for S1/S2 comparison;
3. the internal and comparator developments are structurally and packaging-wise different, so raw counts are not a common complexity scale;
4. favorable measurements for one artifact in one metric do not become an overall ranking.

The S2 results reinforce this policy. For example, S2b observed a substantially lower median total CPU time and somewhat lower peak memory for the internal artifact in the pinned common environment, while wall-clock differences changed sign across pairs and did not yield a stable winner. S2c likewise produced mixed repair-locality outcomes. The paper should publish these contrasts precisely, not compress them into a winner/loser narrative.

## 7. Venue audit

### 7.1 Rank 1 — Journal of Automated Reasoning (primary full-paper target)

Official scope: https://link.springer.com/journal/10817/aims-and-scope  
Official submission guidelines: https://link.springer.com/journal/10817/submission-guidelines

**Fit.** JAR states that it covers theory, implementation, and applications of logical reasoning by computer, including formal proof assistants, and explicitly identifies formalization of mathematics and successful verification case studies as relevant applications. This aligns directly with the manuscript's combination of formal proof, verification methodology, and empirical proof-engineering evaluation.

**Review model.** Current guidance states single-blind peer review.

**Manuscript constraints relevant to Draft 1.** Current guidance requests:

- abstract of 150–250 words;
- 4–6 keywords;
- editable source files; LaTeX is supported and the Springer Nature LaTeX template is encouraged;
- relevant declarations;
- Data Availability Statement for original research;
- public data deposition is strongly encouraged;
- supplementary information is supported.

No explicit general page limit was located in the current journal instructions. That makes JAR the strongest target for preserving the full S1/S2 argument, exclusions, and threats-to-validity discussion without forcing a premature compression.

**AI-use policy.** Current Springer guidance says LLMs do not meet authorship criteria. Generative LLM use should be documented in a Methods section or suitable alternative section; AI-assisted copy editing alone does not require declaration. Human authors retain accountability for the final text.

**Assessment:** **Primary target.** The Draft 1 should be written at full scientific length and later adapted to JAR format during P6 unless an explicit strategic decision selects CPP first.

### 7.2 Rank 2 — CPP 2027 (accelerated option)

Official CFP: https://popl27.sigplan.org/home/CPP-2027

CPP 2027 will be held 11–12 January 2027 in Mexico City, co-located with POPL 2027.

**Current deadlines:**

- abstract: 2026-09-03;
- paper: 2026-09-10;
- notification: 2026-11-10;
- camera-ready: 2026-11-25.

**Fit.** The CFP explicitly includes certified mathematical theorems, proof assistants including Lean, integration of interactive/automated provers, and AI/ML for formal verification. The review criteria ask authors to discuss design choices, alternatives, related formalization literature, comparisons with other libraries, proof-assistant features, and lessons for future formalization. These criteria strongly match Paper 1.

**Format.** Current CFP requires ACM `acmart` SIGPLAN format, 10pt, lightweight double-blind review, with a maximum of **12 pages including figures and tables but excluding bibliography and clearly marked appendices**. The main paper must remain self-contained without appendices.

**Artifacts.** Supplementary proof scripts and experimental data are strongly encouraged and must be uploaded at submission time rather than supplied only by URL.

**Preprints.** The CFP permits authors to disseminate drafts/preprints during the lightweight double-blind process.

**AI-use policy.** CPP follows ACM authorship/AI policy. It permits AI tools subject to accuracy, non-misrepresentation, author responsibility, and the requirement that the paper's intellectual contribution not be primarily generated by the tool.

**Assessment:** **Strong accelerated option, but conditional.** The 12-page main-paper limit creates a significant risk that S1 plus S2a–S2e and their limitations would be compressed into a result table without enough methodological explanation. CPP should be selected only after P4 tests a 12-page outline and confirms that no material claim boundary, exclusion, or threat to validity would be hidden.

### 7.3 Rank 3 — ITP 2027 (conditional future option)

Series site: https://itp-conference.github.io/

ITP is strongly aligned with interactive theorem proving, formalized mathematics, Lean, proof reconstruction, and proof-engineering research. ITP 2026 included, among other relevant examples, LeanArchitect, end-to-end Keller verification, Lean/Vampire proof reconstruction, and multi-route de Finetti formalization.

As of 2026-08-20, this audit did not find a sufficiently stable official ITP 2027 paper CFP containing final submission deadlines, page limits, artifact rules, and AI policy. Therefore those rules must **not** be inferred from ITP 2026.

**Assessment:** **Strong thematic fallback, policy status conditional.** Re-audit when the official ITP 2027 CFP is published.

## 8. Venue decision rule

Default decision:

> Write and review the full manuscript against JAR expectations first. Preserve CPP 2027 as an accelerated option only if the P4 adversarial review shows that a 12-page self-contained main paper can retain the mathematical statement, statement bridge, S1 method, all five S2 bounded findings, exclusions, and visible threats to validity.

This rule prioritizes scientific completeness over deadline-driven compression.

## 9. Draft-level bibliography set

The following references are approved anchors for Draft 1. They are not yet the final bibliography; P6 should verify final metadata and formatting against the selected venue.

1. Stijn Cambie. *Resolution of an Erdős' problem on least common multiples.* arXiv:2410.09138, 2024. DOI: 10.48550/arXiv.2410.09138.
2. Thomas Hales et al. *A Formal Proof of the Kepler Conjecture.* Forum of Mathematics, Pi 5:e2, 2017. DOI: 10.1017/fmp.2017.1.
3. Kevin Buzzard, Johan Commelin, Patrick Massot. *Formalising Perfectoid Spaces.* CPP 2020, pp. 299–312. DOI: 10.1145/3372885.3373830.
4. Peter Scholze. *Liquid Tensor Experiment.* Experimental Mathematics 31(2), 2022, pp. 349–354. DOI: 10.1080/10586458.2021.1926016.
5. Moritz Firsching et al. *Formal Conjectures: An Open and Evolving Benchmark for Verified Discovery in Mathematics.* arXiv:2605.13171, 2026.
6. Thomas Zhu, Pietro Monticone, Jeremy Avigad, Sean Welleck. *LeanArchitect: Automating Blueprint Generation for Humans and AI.* ITP 2026 / arXiv:2601.22554.
7. James Gallicchio, Cayden Codel, Jeremy Avigad, Marijn J. H. Heule. *An End-To-End Verification of Keller's Conjecture.* ITP 2026, LIPIcs 382, 26:1–26:20. DOI: 10.4230/LIPIcs.ITP.2026.26.
8. Cameron Freer. *Three Roads to de Finetti's Theorem in Lean 4.* ITP 2026, LIPIcs 382, 34:1–34:9. DOI: 10.4230/LIPIcs.ITP.2026.34.
9. Jonas Bodingbauer, Márton Hajdu, Laura Kovács, Axel Polaczek, Michael Rawson. *Lean on Vampire Proofs.* ITP 2026, LIPIcs 382, 36:1–36:9. DOI: 10.4230/LIPIcs.ITP.2026.36.
10. The pinned Aristotle/Boris Alexeev Erdős #678 Lean artifact at commit `6f906fef432892db5c910c48ad1a3728dd42cdac`.
11. The Formal Conjectures Erdős #678 statement file, with the exact repository revision to be frozen during P6.

## 10. P2 exit decision

Paper 1 satisfies the P2 exit criterion as of 2026-08-20:

- a current literature map exists;
- mathematical and prior-formalization attribution is explicit;
- a defensible non-priority novelty/positioning statement is fixed;
- three realistic venues are ranked;
- current rules for the primary and accelerated targets have been checked;
- AI-use, artifact/data, review-model, preprint, deadline, and format constraints relevant to planning have been recorded;
- ITP 2027 is correctly marked conditional rather than assigned guessed rules.

**Next phase:** P3 — complete Paper 1 Draft 1 using the baseline scaffold as the master manuscript architecture.
