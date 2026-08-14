# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent reimplementation of Cambie (2024), not independent mathematical discovery  
**Current gate:** Formalization Consolidation Gate  
**Canonical mathematical analysis:** `CAMBIE_PROOF_ANALYSIS.md`

This file is the single operational answer to: **what is the next Lean/formalization task for #678?**

Historical plans may remain in the repository for provenance, but they must not compete with this roadmap.

---

## 0. Mathematical status that must not be blurred

Externally, Erdős #678 is proved. In this repository:

- the independent proof attempt was rejected;
- the valid concrete witness `M(36,8) > M(47,9)` is machine-checked;
- the proposed `(495,504,8)` witness is machine-refuted and retained as a negative regression;
- the current work is a reconstruction/formalization of Cambie's proof architecture;
- the full Claim 5 theorem is not yet proved in this repository;
- the full #678 theorem is not yet formalized in this repository.

No CI success may be described as proof of more than the exact statements checked by Lean.

---

# Phase C — Formalization Consolidation Gate

No new Claim 5 mathematics is added before this gate passes.

## C1 — Operational memory

**Goal:** make `PROJECT_STATE.md` reflect #678 and the actual reconstruction state.

**Exit condition:** a new agent can read `PROJECT_STATE.md` alone and correctly identify the current problem, mode, verified facts, rejected paths, CI status, and next action.

**Status:** DONE.

## C2 — One canonical roadmap

**Goal:** eliminate competing execution plans.

Actions:

1. Use this file as the sole active Lean execution roadmap.
2. Keep `CAMBIE_PROOF_ANALYSIS.md` as mathematical analysis, not a task tracker.
3. Mark `LEAN_TEST_PLAN.md` as `SUPERSEDED` while retaining it for provenance.

**Exit condition:** only this file answers “what is the next formalization step?”.

**Status:** IN PROGRESS.

## C3 — Length-based interval API

**Goal:** make interval length explicit so the type-level/formal interface resists the off-by-one failure that invalidated the earlier construction.

Preferred canonical semantics:

```text
intervalFinset(start, len) = {start, start+1, ..., start+len-1}
```

Implementation should prefer a construction based on `Finset.range len` mapped/embedded by `i ↦ start + i`, rather than an endpoint formula whose meaning changes at `len = 0`.

Required definitions:

```text
intervalFinset(start, len)
intervalProd(start, len)
intervalLCM(start, len)
erdosM(n,k) = intervalLCM(n+1,k)
```

Required boundary regression tests:

```text
intervalFinset 10 0 = ∅
intervalFinset 10 1 = {10}
intervalFinset 10 3 = {10,11,12}
```

**Exit condition:** all live interval APIs use length semantics; no live theorem relies on the ambiguous former endpoint-offset interpretation.

## C4 — Canonical `M(n,k)` and abstraction tests

**Goal:** connect the general abstraction to an independent explicit arithmetic oracle.

Keep explicit hand-expanded LCMs for the known positive and rejected negative examples. Then prove that the canonical general definition agrees with them:

```text
erdosM 36 8 = M36_8_explicit
erdosM 47 9 = M47_9_explicit
erdosM 495 8 = M495_8_explicit
erdosM 504 9 = M504_9_explicit
```

Then machine-check:

```text
erdosM 36 8 > erdosM 47 9
¬ (erdosM 495 8 > erdosM 504 9)
```

**Exit condition:** the general definition passes positive and negative regression tests against independent explicit definitions.

## C5 — Clean the live Lean tree

**Goal:** distinguish production formalization from failed experiments.

Target shape (exact filenames may vary if Lean module naming suggests a better form):

```text
Formalization/Erdos678/
  Intervals.lean
  ConcreteTests.lean
  ValuationBasic.lean
  ProductValuation.lean
  LCMValuation.lean        # created later
  Claim5.lean              # created later
```

Rules:

- no `v2`, `fixed`, `final`, or similar suffixes in the live tree;
- failed experiments are preserved by Git history and explanatory Markdown, not by ambiguous production modules;
- every live file has one clear responsibility.

**Exit condition:** one canonical live module per concept.

## C6 — Canonical Lake build graph

**Goal:** `lake build` must check all live formalization modules without manually listing them in GitHub Actions.

Actions:

1. Create/maintain a canonical import root for #678.
2. Import every live #678 module from that root or through its dependency graph.
3. Ensure the Lake target includes that root.
4. Reduce the workflow to the canonical build plus only genuinely independent smoke/regression checks if needed.

**Invariant:** a new live `.lean` module that is not reachable from the canonical build graph is not considered integrated.

**Exit condition:** `lake build` failing is sufficient to detect a broken live module.

## C7 — Finite-product valuation

**Goal:** prove the generic theorem

```text
padicValNat p (product over s) = sum over s of padicValNat p
```

under the exact Mathlib hypotheses:

- `Nat.Prime p`;
- each factor is nonzero.

Implementation policy:

- prefer explicit APIs such as `s.prod id` and `s.sum ...` if notation causes parser/elaboration fragility;
- use `Finset.induction`;
- use `padicValNat.mul` only with its required hypotheses;
- no `sorry` and no new axiom.

**Exit condition:** theorem machine-checks through the canonical Lake build.

## C8 — Restore green CI

**Goal:** make `main` green with the consolidated architecture.

The green run must cover at least:

- canonical interval API;
- canonical `erdosM`;
- positive witness regression;
- negative witness regression;
- equality-by-prime-valuations core;
- multiplicative `padicValNat` wrapper;
- finite-product valuation theorem.

**Exit condition:** GitHub Actions PASS on `main` with no `sorry` introduced by this consolidation.

## C9 — Consolidation checkpoint

Update `PROJECT_STATE.md`:

```text
consolidation_gate_status: passed
ci_status: green
current_substage: lcm-valuation
next_action: formalize finite-LCM valuation
```

Record reusable lessons:

1. interval APIs must encode length explicitly when endpoint ambiguity has already caused proof failure;
2. a Lean module is live only if reachable from the canonical build graph and checked in CI.

**Exit condition:** restart instructions are unambiguous.

---

# Phase A — Arithmetic core after consolidation

This phase starts only after C9.

## A1 — Finite-LCM valuation

Target mathematical content:

```text
v_p(lcm of a finite nonzero set) = maximum p-adic valuation among the elements
```

The exact Lean statement may use `Nat.factorization`, `Finset.lcm`, divisibility lemmas, or a maximum formulation dictated by Mathlib's strongest existing API.

Do not force a bespoke theorem if Mathlib already provides the required factorization-of-LCM result.

## A2 — Reciprocal-LCM factor

For a positive finite block, formalize the valuation of

```text
product(block) / lcm(block)
```

Prefer proving divisibility first or using an equivalent cross-multiplied/valuation formulation rather than relying prematurely on `Nat` division.

Any reformulation must be proved equivalent to the intended Claim 5 identity; equivalence must never be assumed.

## A3 — Interval valuation counting primitives

Formalize the number of elements in a block divisible by `p^r` and the finite-support bound required to make valuation sums finite and explicit.

---

# Phase B — Cambie Claim 5

## B1 — Prime range `p > k`

Prove that such a prime can occur at most once in each relevant interval, so the product/LCM quotient contributes valuation zero.

## B2 — Prime range `sqrt(k) < p <= k`

Formalize the “at most one multiple of `p^2`” structure and connect Cambie's residue-window conditions to the exact count of multiples of `p`.

## B3 — Prime range `p <= sqrt(k)`

Formalize the small-prime capped valuation sums using the modulus `m` and the congruences on `x` and `y`.

## B4 — Claim 5 assembly

Combine all prime ranges and use equality by prime valuations to prove Cambie's exact arithmetic identity.

**Exit condition:** Claim 5 is machine-checked without using Claim 4, prime-density existence, or the final asymptotic estimate.

---

# Phase D — CRT combinatorial engine

## D1 — Claim 4

Formalize Cambie's CRT-density lemma independently of the LCM application.

## D2 — Residue boxes

Formalize admissible residue sets for large primes and combine them through CRT.

## D3 — Representatives and separation

Obtain representatives `x,y` satisfying the residue restrictions, range bounds, and `y > x + k`.

---

# Phase E — Quantitative finish

## E1 — LCM-ratio estimate

From Claim 5, derive the lower bound used by Cambie. Every inequality direction must be Lean-checked.

## E2 — Prime-density dependency

Identify the exact prime-density theorem needed.

Policy:

- if imported from a trusted formal library, name the dependency;
- if temporarily assumed, isolate and visibly label the hypothesis/axiom;
- never describe a theorem depending on an explicit unproved prime-density assumption as unconditional formalization.

## E3 — Strong Cambie theorem

Formalize the sufficiently-large-`k` theorem with arbitrary fixed `C >= 1`.

## E4 — Deduce Erdős #678

Set `C = 1` and translate

```text
n = x - 1
m = y - 1
```

while proving all domain conditions and infinitude/distinctness requirements.

---

# Global audit gates

These apply to every phase:

- exact statement before proof search;
- interval length/endpoints expanded before algebra;
- concrete candidate witnesses checked numerically before positive formalization;
- positive and negative regressions retained;
- no guessed scaling or translation identity;
- no inequality-direction change without proof;
- no hidden use of `sorry` or new axioms in arithmetic core;
- distinguish mathematical discovery, proof reconstruction, and formal verification;
- CI success is interpreted only as validation of the exact reachable Lean statements.

---

# Current position

```text
Erdős #678
└── Formalization Consolidation Gate
    ├── C1 Operational memory ............... DONE
    ├── C2 Canonical roadmap ................ IN PROGRESS
    ├── C3 Length-based interval API ........ PENDING
    ├── C4 Canonical M + regressions ......... PENDING
    ├── C5 Clean live Lean tree .............. PENDING
    ├── C6 Canonical Lake build graph ........ PENDING
    ├── C7 Finite-product valuation .......... PENDING
    ├── C8 Green CI .......................... PENDING
    └── C9 Consolidation checkpoint .......... PENDING
```
