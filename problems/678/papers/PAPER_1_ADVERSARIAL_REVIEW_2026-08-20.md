# Paper 1 — P4 Adversarial Scientific Review — 2026-08-20

**Paper:** *Lean Reconstruction and Differential Verification of Cambie's Solution to Erdős Problem #678*  
**Review phase:** P4  
**Review date:** 2026-08-20  
**Reviewed baseline:** `b6525ec6ba384586c0ed9d1fe2a4f5935ff38780`  
**Scope:** Paper 1 and its publication-facing claim/evidence wording only  
**Mathematics / Lean / S1–S2 experiments:** frozen; no new mathematical or experimental result is introduced by P4.

## 1. Review standard

P4 reviews Draft 1 as a skeptical expert reviewer rather than as an editorial proofreader. A finding is **high severity** when, if left unresolved, it could materially misstate attribution, statement fidelity, comparator fairness, experimental scope, reproducibility, or the strength of a central claim. A **medium** finding can mislead a careful reader or weaken auditability but does not invalidate the underlying result. A **low** finding is non-blocking but worth recording for publication provenance.

The P4 exit criterion is:

> No unresolved high-severity attribution, statement-fidelity, reproducibility, numerical, comparator-fairness, or validity objection remains.

## 2. Adversarial findings and dispositions

| ID | Severity | Reviewer objection | Disposition |
|---|---|---|---|
| P4-H1 | High | The Draft 1 title and repeated phrase “independent Lean reconstruction” can be read as a genealogical or independent-proof claim before the reader reaches the narrower disclaimer. | **Resolved.** The title drops “Independent”; publication prose uses **separately structured Lean reimplementation/reconstruction**. The text continues to deny independent mathematical discovery, genealogically unrelated proof, new mathematics, and first-formalization priority. |
| P4-H2 | High | Section 5.2 attributes “separately structured / non-vendored implementation” to S1 itself, although this is a provenance/process fact rather than an experimental output of differential verification. | **Resolved.** Draft 2 explicitly separates repository provenance from what S1 establishes experimentally. S1 is limited to the controlled common-environment compilation, statement-bridge comparison, and selected theorem-level axiom-footprint cross-check. |
| P4-H3 | High | The large S2b CPU contrast is visible, but Draft 1 does not explain the timed unit well enough for a reviewer to judge comparator fairness. A reader could incorrectly infer an isolated causal architecture benchmark. | **Resolved.** Draft 2 states that dependencies/prerequisites were prepared outside the timed region, cold cleanup removed only artifact-owned outputs, both targets used the same pinned project environment, and the comparator source was copied byte-for-byte into a temporary target. The result is explicitly described as **artifact-owned rebuild behavior as packaged**, not a causal estimate of architecture quality. |
| P4-M1 | Medium | Reference [6] had the ITP 2026 LeanArchitect author order wrong and omitted the proceedings pages/DOI. | **Resolved.** Official ITP 2026 metadata gives Thomas Zhu, Pietro Monticone, Sean Welleck, Jeremy Avigad; LIPIcs 382, 25:1–25:16; DOI `10.4230/LIPIcs.ITP.2026.25`. |
| P4-M2 | Medium | Reference [11] pointed to mutable Formal Conjectures `main`, weakening reproducibility of statement-context claims. | **Resolved.** Draft 2 freezes the audited Formal Conjectures repository revision `9f5ee773841921f460b4a26a3552f5eca4accaa0` and #678 file blob `b6612bf9419ab37830cad78fa8e46280236182ac`. |
| P4-M3 | Medium | The AI-use placeholder stated one exact disclosure location even though publisher guidance is mutable and current Springer guidance is expressed in more than one venue-level formulation. | **Resolved.** Draft 2 keeps only stable policy facts: LLMs are not authors; generative-AI use beyond copy editing must be transparently documented; exact placement/wording is rechecked at P6 against the selected venue's current policy. |
| P4-M4 | Medium | Draft 1's internal checklist and threats section still described P4 as future work after the review had been performed. | **Resolved.** Manuscript status becomes Draft 2, P4 is marked complete, and the text states that internal adversarial review reduces manuscript risk but does not replace external replication or peer review. |
| P4-L1 | Low | The current Formal Conjectures #678 source contains a prose example comment whose displayed `M(36,8) > M(48,9)` label does not match the immediately following theorem `lcmInterval 47 9 < lcmInterval 36 8`, while `lcmInterval n k` is defined as the LCM of `(n,n+k]`. | **Recorded, no project-theorem change.** The present paper's positive regression is independently machine checked as `erdosM 36 8 > erdosM 47 9`; the publication argument relies on exact theorem/code semantics and the project's formal bridge, not on that mutable upstream prose comment. |

## 3. Independent attribution and statement checks

### 3.1 Mathematical source

Stijn Cambie's arXiv paper `2410.09138` (2024), *Resolution of an Erdős' problem on least common multiples*, states that the Erdős question is answered affirmatively and that the relevant LCM ratio can be made arbitrarily large. P4 therefore confirms that the manuscript's successful mathematics must remain attributed to Cambie.

### 3.2 Prior public Lean artifact

The pinned comparator is:

- repository: `plby/lean-proofs`;
- commit: `6f906fef432892db5c910c48ad1a3728dd42cdac`;
- file: `src/latest/ErdosProblems/Erdos678.lean`;
- blob: `f2331e8bcc71bc36cce7724a0c54fafd8d64d480`.

Its source explicitly records Stijn Cambie as informal author and Aristotle/Boris Alexeev as formal authors. This independently rules out a first-formalization claim for the present project.

### 3.3 Project statement bridge

`formalization/Formalization/Erdos678/ExternalStatementBridge.lean` proves, among other endpoints:

- `intervalFinset_succ_eq_Ioc`;
- `erdosM_eq_Ioc_lcm`;
- `erdos678_formalConjectures_eventual_nonempty`;
- `cambie_lcm_ratio_eventually_with_large_start_real`.

The bridge establishes code-level equivalence between the project's length-based convention and `Finset.Ioc` semantics. P4 found no unsupported statement-equivalence assertion in the manuscript once the claims are restricted to these theorem-level interfaces.

### 3.4 Contemporary Formal Conjectures context

P4 audited Formal Conjectures at repository commit

`9f5ee773841921f460b4a26a3552f5eca4accaa0`.

At that revision:

- `FormalConjectures/ErdosProblems/678.lean` blob: `b6612bf9419ab37830cad78fa8e46280236182ac`;
- the main #678 theorem uses eventual nonemptiness over varying `k`;
- the file explicitly explains why fixed-`k` infinitude is not the intended reading;
- `Finset.lcmInterval n k` is defined in `FormalConjecturesForMathlib/Algebra/GCDMonoid/Finset.lean` as the LCM of `Finset.Ioc n (n+k)`.

The upstream prose-example discrepancy recorded as P4-L1 is therefore treated as another reason to privilege exact code semantics and pinned revisions over mutable prose labels.

## 4. Independent numerical and experimental checks

P4 rechecked every numerical quantity printed in Draft 1 against the frozen result files / scientific evidence ledger.

### S1

- credited run: `32028006457`;
- credited job: `95381414710`;
- selected axiom footprint for the compared endpoints: `[propext, Classical.choice, Quot.sound]`.

No P4 change to the S1 result was required; only its interpretation boundary was sharpened.

### S2b

Against `S2_BUILD_BEHAVIOR_BASELINE.json`:

- internal cold median: `159.575 s`;
- comparator cold median: `156.280 s`;
- paired internal-minus-comparator wall-time range: `[-10.68 s, +11.73 s]`;
- internal median total CPU: `241.155 s`;
- comparator median total CPU: `486.475 s`;
- internal median maximum RSS: `7,183,766 KiB`;
- comparator median maximum RSS: `7,828,930 KiB`;
- six credited paired replicates; zero retries; zero exclusions.

The ratio of the two printed CPU medians is approximately `0.496`, so Draft 1's qualitative phrase “roughly half” is arithmetically accurate. P4 retains the exact numbers and bounded resource-profile interpretation while adding the missing timed-unit/comparator-fairness description.

### S2c

Against `S2_REPAIR_LOCALITY_BASELINE.json` / ledger:

- three frozen API-reference mutations;
- six observations across the two artifacts;
- six observable breaks;
- six legal repairs returned to green;
- zero third-party dependency-source files touched;
- mixed/interface-dependent repair locality; no uniform winner.

### S2d

Against the credited ledger/result:

- three frozen semantic/index perturbations;
- six observations;
- six semantic rejections;
- zero survivors;
- zero proof repairs;
- zero third-party dependency-source touches;
- credited run `32076614547`, artifact `9303987121`.

### S2e

Against the frozen result/ledger:

- two exact candidates U1/U2;
- U1 stopped in dependency-owned source after D1;
- U2 stopped at package resolution after D0;
- neither reached an eligible project-owned repair surface;
- credited complete-set run `32170243744`, artifact `9337321640`.

No printed S1/S2 numerical result required correction during P4.

## 5. Bibliographic recheck

P4 independently checked the primary metadata used in Draft 1 for:

1. Cambie 2024 (`arXiv:2410.09138`);
2. Hales et al., *A Formal Proof of the Kepler Conjecture*, DOI `10.1017/fmp.2017.1`;
3. Buzzard–Commelin–Massot, *Formalising Perfectoid Spaces*, DOI `10.1145/3372885.3373830`;
4. Scholze, *Liquid Tensor Experiment*, DOI `10.1080/10586458.2021.1926016`;
5. *Formal Conjectures*, `arXiv:2605.13171`;
6. LeanArchitect, ITP 2026, DOI `10.4230/LIPIcs.ITP.2026.25`;
7. Gallicchio et al., Keller verification, DOI `10.4230/LIPIcs.ITP.2026.26`;
8. Freer, *Three Roads to de Finetti's Theorem in Lean 4*, DOI `10.4230/LIPIcs.ITP.2026.34`;
9. Bodingbauer et al., *Lean on Vampire Proofs*, DOI `10.4230/LIPIcs.ITP.2026.36`;
10. the pinned Aristotle/Boris Alexeev source artifact;
11. the exact Formal Conjectures #678 revision frozen above.

The only material bibliographic error found was P4-M1, now corrected.

## 6. Comparator-fairness judgment

The S2b protocol is adequate for the narrow claim it makes. It does **not** compare two abstract proof architectures under a normalized source decomposition. Instead, it compares artifact-owned rebuild behavior of the two packaged formal artifacts under one pinned dependency environment:

- external dependencies are prepared/prebuilt outside timing;
- each replicate measures both artifacts on the same hosted runner;
- run order alternates;
- comparator source is immutable and byte-validated;
- cold cleanup is restricted to artifact-owned outputs;
- all six credited pairs are retained.

This supports descriptive resource-profile observations. It does not identify architecture as the causal source of the CPU/memory contrast, and Draft 2 now says so directly.

## 7. Remaining non-P4 submission tasks

These are **not unresolved high-severity P4 objections**; they belong to P5/P6 submission packaging:

- freeze the final submission/release commit;
- create/select an immutable external archival identifier/DOI when practical or required;
- choose JAR versus a compressed CPP 2027 path;
- convert bibliography to the selected venue's style and recheck mutable policy metadata;
- finalize authorship/contribution/competing-interest metadata;
- finalize the AI-use disclosure against the selected venue's current policy;
- perform the final pre-submission claim/link audit.

## 8. P4 verdict

**PASS after the Draft 2 revisions recorded above.**

At P4 closure:

- unresolved high-severity findings: **0**;
- corrected high-severity findings: **3**;
- corrected medium findings: **4**;
- recorded non-blocking low findings: **1**.

P4 does not assert that the manuscript is submission-ready. It asserts that Draft 2 has no remaining high-severity internal objection in the categories required by the publication workplan. The next gated phase is P6 submission-candidate preparation; it requires separate authorization and venue-specific work.