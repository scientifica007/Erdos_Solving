# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent reimplementation of Cambie (2024), not independent mathematical discovery  
**Consolidation gate:** PASSED  
**Current phase:** Phase A — arithmetic core  
**Current target:** A1 — finite-LCM valuation  
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

# Phase C — Formalization Consolidation Gate — PASSED

Green machine-check checkpoint: GitHub Actions run `31827146122`.

## C1 — Operational memory — DONE

`PROJECT_STATE.md` now identifies #678, reconstruction mode, rejected independent paths, verified facts, and the next formalization target.

## C2 — One canonical roadmap — DONE

- this file is the sole active Lean execution roadmap;
- `CAMBIE_PROOF_ANALYSIS.md` is mathematical analysis only;
- `LEAN_TEST_PLAN.md` is explicitly `SUPERSEDED` and historical.

## C3 — Length-based interval API — DONE / MACHINE-CHECKED

Canonical semantics:

```text
intervalFinset(start,len) = {start,start+1,...,start+len-1}
```

Live definitions:

```text
intervalFinset(start,len)
intervalProd(start,len)
intervalLCM(start,len)
erdosM(n,k) = intervalLCM(n+1,k)
```

Boundary regressions for lengths `0`, `1`, and `3` are kernel-checked with `decide`.

## C4 — Canonical `M(n,k)` and abstraction tests — DONE / MACHINE-CHECKED

The canonical `erdosM` definition is checked against independent hand-expanded LCM oracles for:

```text
(36,8)
(47,9)
(495,8)
(504,9)
```

The live graph also checks:

```text
erdosM 36 8 > erdosM 47 9
¬ (erdosM 495 8 > erdosM 504 9)
```

## C5 — Clean live Lean tree — DONE

Canonical production tree:

```text
Formalization/Erdos678/
  Intervals.lean
  ConcreteTests.lean
  ValuationBasic.lean
  ProductValuation.lean
```

Superseded `Claim5_*`, `*Test*`, and version-suffixed experiment modules were removed from the live tree; their provenance remains in Git history and Markdown records.

## C6 — Canonical Lake build graph — DONE

`Formalization.lean` imports every live #678 module. GitHub Actions no longer manually enumerates `.lean` files; `lake build` is the authoritative integration check.

Invariant:

> A new Lean module is not considered live until it is reachable from the canonical build graph.

## C7 — Finite-product valuation — DONE / MACHINE-CHECKED

The live theorem proves, for prime `p` and a finite set of nonzero naturals:

```text
padicValNat p (s.prod id) = s.sum (fun x => padicValNat p x)
```

The proof uses the actual Mathlib API (`Finset.prod_ne_zero_iff`, `padicValNat.mul`) and a structured `calc` proof rather than brittle syntactic rewrites.

## C8 — Restore green CI — DONE

GitHub Actions run `31827146122` passed the canonical Lean build graph.

Repository-wide safety checks at the gate checkpoint found no occurrences of:

```text
sorry
axiom
native_decide
```

## C9 — Consolidation checkpoint — DONE

`PROJECT_STATE.md` records:

```text
consolidation_gate_status: passed
ci_status: green
current_substage: lcm-valuation
next_action: formalize finite-LCM valuation (A1)
```

Reusable consolidation lessons are recorded in `LESSONS_LEARNED_678_ADDENDUM.md`.

---

# Phase A — Arithmetic core — CURRENT

## A1 — Finite-LCM valuation — CURRENT

### Goal

Formalize the prime-adic structure of a finite LCM. The mathematical target is of the form

```text
v_p(lcm of a finite nonzero set)
  = maximum p-adic valuation among the elements.
```

### First action

Before designing a bespoke theorem, inspect current Mathlib for the strongest existing lemmas around:

```text
Finset.lcm
Nat.factorization_lcm
Nat.factorization
padicValNat
```

Prefer reducing to an existing factorization-of-LCM theorem if it gives the required result with less custom infrastructure.

### Required constraints

- exact nonzero hypotheses must be explicit;
- empty-set behavior must be specified rather than silently ignored;
- no custom maximum convention may be introduced without defining its empty-set semantics;
- no division appears yet;
- no `sorry` or new axiom.

### Exit condition

A theorem sufficient to compute/control the `p`-adic valuation of `intervalLCM start len` is reachable from the canonical Lake graph and passes CI.

## A2 — Reciprocal-LCM factor — PENDING

For a positive finite block, formalize the valuation of

```text
product(block) / lcm(block)
```

Prefer proving divisibility first or using an equivalent cross-multiplied/valuation formulation rather than relying prematurely on `Nat` division.

Any reformulation must be proved equivalent to the intended Claim 5 identity; equivalence must never be assumed.

## A3 — Interval valuation counting primitives — PENDING

Formalize the number of elements in a block divisible by `p^r` and the finite-support bound required to make valuation sums finite and explicit.

---

# Phase B — Cambie Claim 5 — PENDING

## B1 — Prime range `p > k`

Prove that such a prime can occur at most once in each relevant interval, so the product/LCM quotient contributes valuation zero.

## B2 — Prime range `sqrt(k) < p <= k`

Formalize the “at most one multiple of `p^2`” structure and connect Cambie's residue-window conditions to the exact count of multiples of `p`.

## B3 — Prime range `p <= sqrt(k)`

Formalize the small-prime capped valuation sums using the modulus `m` and the congruences on `x` and `y`.

## B4 — Claim 5 assembly

Combine all prime ranges and use equality by prime valuations to prove Cambie's exact arithmetic identity.

Exit condition: Claim 5 is machine-checked without using Claim 4, prime-density existence, or the final asymptotic estimate.

---

# Phase D — CRT combinatorial engine — PENDING

## D1 — Claim 4

Formalize Cambie's CRT-density lemma independently of the LCM application.

## D2 — Residue boxes

Formalize admissible residue sets for large primes and combine them through CRT.

## D3 — Representatives and separation

Obtain representatives `x,y` satisfying the residue restrictions, range bounds, and `y > x + k`.

---

# Phase E — Quantitative finish — PENDING

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
├── Phase C — Formalization Consolidation Gate .... PASSED
│   ├── C1 Operational memory ..................... DONE
│   ├── C2 Canonical roadmap ...................... DONE
│   ├── C3 Length-based interval API .............. DONE
│   ├── C4 Canonical M + regressions .............. DONE
│   ├── C5 Clean live Lean tree ................... DONE
│   ├── C6 Canonical Lake build graph ............. DONE
│   ├── C7 Finite-product valuation ............... DONE
│   ├── C8 Green CI ............................... DONE
│   └── C9 Consolidation checkpoint ............... DONE
└── Phase A — Arithmetic core
    ├── A1 Finite-LCM valuation ................... CURRENT
    ├── A2 Reciprocal-LCM factor .................. PENDING
    └── A3 Interval valuation counting ............ PENDING
```
