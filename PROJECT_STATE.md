# Project State

> **Operational checkpoint synchronized on 2026-08-17.**
>
> **Erdős Problem #678 is complete, machine-checked, integrated into `main`, post-merge verified, and archived as a completed mathematical benchmark. The user has subsequently authorized scientific comparison, reproducibility, publication-positioning, and AI-process analysis of this archived artifact only.**
>
> - D4 final reachable repair: `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495` — **SUCCESS**, **8766 jobs**.
> - E1 mathematical exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909` — **SUCCESS**, **8770 jobs**.
> - E2 prime-density exit: `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856` — **SUCCESS**, **8800 jobs**.
> - E3 strong Cambie exit: `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891` — **SUCCESS**, **8804 jobs**.
> - E4 mathematical exit: `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757` — **SUCCESS**, **8806 jobs**.
> - Final synchronized E4 head: `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`, run `31977861568` — **SUCCESS**, `No update necessary`, **8806 jobs**.
> - Mathematical integration: PR #17 merged into `main` as `8fd1b20541ac7782f52429db3a2cc4c887547372` on 2026-08-17.
> - Post-merge mathematical verification: run `32011189766` — **SUCCESS**, `No update necessary`, full build **8806 jobs**.
> - Scientific-dossier baseline on `main`: `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`, post-merge run `32026434043` — **SUCCESS**.
>
> **User gate:** no other Erdős problem may be selected, activated, resumed, researched, or formalized until the user explicitly authorizes that transition. Current post-archive work is limited to scientific evaluation of #678 itself.

This file is the authoritative operational restart checkpoint. Mathematical credit comes from reachable Lean builds and the commit actually checked out in execution logs, not from source presence or GitHub metadata alone.

## Global operating rules

- `DEC-011` supersedes `DEC-004`: `main` is the stable integration branch; substantive work uses a dedicated branch and pull request.
- `DEC-012` requires explicit user authorization before any transition from archived #678 to another Erdős problem.
- Do not merge a mathematical change unless canonical Lean CI is green for the credited pull-request head.
- For PR verification credit, inspect/log the commit actually checked out; a run's `head_sha` metadata is not by itself proof that `actions/checkout` built that commit.
- State documents must agree with the reachable Lean graph and credited CI evidence.
- Do not treat a file name, source presence, GitHub metadata, or an AI-generated argument as proof by itself.
- Distinguish external problem status, project reconstruction, independent discovery, machine verification, and post-archive scientific evaluation.
- Preserve rejected paths, negative regressions, contamination events, revoked claims, and verification-credit corrections.
- For interval arguments, endpoints and length remain explicit mathematical data.
- A Lean module is live only when the canonical aggregator reaches it and the build succeeds.

## Current project

```yaml
current_problem: 678
current_phase: archived
current_stage: complete-integrated-main-verified-scientific-evaluation-s1
current_mode: external-proof-reconstruction
blind_mode: false
reference_solution_accessed: true
proof_frozen: true

external_problem_status: proved
project_reconstruction_status: proved-machine-checked-integrated-main-verified
independent_attempt_status: rejected
reference_proof: Cambie-2024
reference_understanding_status: reconstructed-through-final-index-translation

current_target: scientific-comparison-s1-of-archived-erdos678
scientific_evaluation_authorized: true
scientific_evaluation_scope: erdos678-only
scientific_dossier_baseline: 0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e
scientific_dossier_postmerge_ci_run: 32026434043
s1_semantic_bridge_status: machine-checked-integration-tree-verified
s1_integration_tree_ci_run: 32033822601
s1_true_exact_head_ci_status: pending-after-workflow-correction
s1_differential_reproducibility_status: workflow-added-awaiting-green-run

small_prime_claim5_status: machine-checked
full_claim5_status: machine-checked
claim4_status: machine-checked
lcm_ratio_status: machine-checked-eventually-for-every-positive-C
full_erdos678_formalization_status: proved-machine-checked-integrated-main-verified

premerge_canonical_ci_run: 31977861568
premerge_canonical_ci_commit: eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f
premerge_canonical_build_jobs: 8806
main_integration_commit: 8fd1b20541ac7782f52429db3a2cc4c887547372
main_postmerge_ci_run: 32011189766
main_postmerge_ci_status: success
main_postmerge_build_jobs: 8806
build_graph_audit: mk-all-check-passed-postmerge-main
ci_blocker: none
phase_e_gate: closed
user_transition_gate: explicit-authorization-required
next_action: complete S1 scientific differential verification of archived #678; do not transition to another Erdős problem without explicit user authorization
```

## Trusted machine-checked result for Erdős #678

The reachable formal graph proves the complete canonical infinite-family conclusion.

### Arithmetic, Claim 5, and Claim 4 / Phase D

Machine-checked components include:

- length-based consecutive intervals and canonical `erdosM`;
- the valid finite witness `M(36,8) > M(47,9)`;
- the rejected `(495,504,8)` candidate retained as a negative regression;
- finite-product, finite-LCM, reciprocal-LCM, and prime-power valuation primitives;
- Claim 5 in all prime ranges and the assembled natural-number identity;
- finite density, modular and weighted CRT arguments;
- pair/triple CRT-basis producers and exact residue boxes;
- constructed scales, factorizations, dependent placement, target windows, and sharp prime-window budgets.

### E1 — quantitative LCM-ratio estimate — PASSED

The graph proves exact interval-LCM divisibility into the interval product, cancellation-safe cross multiplication, product comparison, and strict transfer from product inequalities to LCM inequalities.

E1 exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909`.

### E2 — sharp prime density — PASSED

No opaque prime-existence hypothesis remains. The proof pins `AxiomMath/PrimeNumberTheoremAnd` at revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`, derives a natural-number relative-prime provider from its kernel-checked `prime_between` consequence, and converts that provider to the five required additive strips.

E2 exit: `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856`.

No custom prime-density axiom is introduced.

### E3 — strong eventual Cambie theorem — PASSED

The elementary large-`k` condition is discharged with

`claim4CambieLargeKThreshold C = max 9 (3840*C + 3)`

and combined with the PNT threshold in `cambie_lcm_ratio_eventually`.

E3 exit: `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891`.

### E4 — canonical Erdős #678 theorem — PASSED

`Erdos678Final.lean` performs the off-by-one-safe translation from interval starts to canonical variables. In particular:

- `claim4_cambie_k_lt_x_of_bounds` recovers `k < x` from verified bounds;
- `cambie_lcm_ratio_eventually_with_large_start` retains sufficient start information;
- `erdos678_unbounded_witnesses` proves that for every `B : ℕ` there exist `n m k` with `B ≤ k`, `3 ≤ n,m,k`, `n+k ≤ m`, and `erdosM m (k+1) < erdosM n k`;
- `erdos678_good_lengths_infinite` proves that the set of valid block lengths is infinite.

E4 mathematical exit: `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757`.

Final synchronized E4 head: `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f`, run `31977861568`.

## Integration, archival, and scientific-evaluation state

PR #17 was merged as mathematical merge commit `8fd1b20541ac7782f52429db3a2cc4c887547372`. The merged mathematical commit passed run `32011189766`, with `No update necessary` and 8806 jobs.

Subsequent archival/lessons/scientific-positioning PRs preserved the theorem while preparing the artifact for external comparison. The scientific dossier is currently anchored at `main@0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`, whose post-merge run `32026434043` succeeded.

PR #24 is the active #678-only S1 experiment. It adds a machine-checked semantic bridge to the public `Finset.Ioc` convention and a controlled differential-reproducibility workflow.

Run `32033822601` successfully built the S1a bridge, reported `No update necessary`, completed 8808 jobs, and printed only `propext`, `Classical.choice`, and `Quot.sound` for all four bridge endpoints. Log inspection also showed that the old PR workflow checked synthetic merge commit `5983f901...`, not literal PR head `610d525...`. The evidence has therefore been reclassified as integration-tree verification and the workflow is being corrected to explicit PR-head checkout before final S1 credit.

**Mathematical archival classification remains unchanged:** #678 is complete; no mathematical layer is reopened. The only active work is scientific evaluation of the archived artifact.

## Verification chronology

| Substep | Exact/reference head | Canonical run | Result |
|---|---|---:|---|
| D4 final reachable repair | `eb5ffebffcb199cc76c83a941da955f4ecfebde5` | `31963803495` | SUCCESS, 8766 jobs |
| E1 mathematical exit | `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a` | `31968714909` | SUCCESS, 8770 jobs |
| E2 PNT exit | `6d06401bd2ee3aca116fd4ac592bf14d5e43694c` | `31975809856` | SUCCESS, 8800 jobs |
| E3 strong Cambie exit | `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94` | `31975821891` | SUCCESS, 8804 jobs |
| E4 mathematical exit | `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941` | `31976903757` | SUCCESS, 8806 jobs |
| E4 synchronized documentation head | `eb917ee8ff469c68d3f80c5b23abc3d2dbf17a0f` | `31977861568` | SUCCESS, 8806 jobs |
| mathematical merge on `main` | `8fd1b20541ac7782f52429db3a2cc4c887547372` | `32011189766` | SUCCESS, `No update necessary`, 8806 jobs |
| scientific dossier on `main` | `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e` | `32026434043` | SUCCESS |
| S1a PR integration tree | head `610d525...`, checked merge `5983f901...` | `32033822601` | SUCCESS, `No update necessary`, 8808 jobs; not literal exact-head checkout |

Historical PR-event runs labeled “exact-head” in older prose should be interpreted cautiously unless their checkout logs explicitly show the PR head. This does not invalidate the merged #678 theorem: the final mathematical merge commit and later `main` commits received successful post-merge verification. It does tighten how pre-merge evidence is described going forward.

## Exact boundary after archival

The mathematical reconstruction of Erdős #678 is complete, machine-checked, integrated, and verified on `main`. There is no known mathematical or analytic gap in the formalized proof chain.

Still deliberately not claimed:

- a generic arbitrary-cardinality CRT-basis theorem; only the pair/triple arities needed by Cambie's argument are formalized;
- that the earlier independent proof attempt was valid. It remains rejected because it used the false scaling identity `M(t*n,k) = t*M(n,k)` and later a wrong interval in a `Q=P/M` construction;
- that our architecture is superior to the public comparator before the controlled S1/S2 experiments are completed.

## Required restart sequence

1. Verify the exact head of `main` and the latest relevant Lean CI evidence.
2. Read this file before taking any new project action.
3. Treat #678 mathematics as archived; do not reopen D4 or E1–E4 unless a concrete regression is found.
4. Preserve the pinned PNT+ revision and all positive/negative regressions.
5. If the user has authorized scientific evaluation of #678, continue only the documented comparison/publication/AI-process roadmap.
6. **Do not select, activate, resume, research, or formalize another Erdős problem without explicit user authorization.**

## Completed benchmark outcomes — historical inventory only

Historical repository entries for other benchmarks remain inactive and are not authorization to resume them. The current permitted work scope is archived #678 scientific evaluation only.
