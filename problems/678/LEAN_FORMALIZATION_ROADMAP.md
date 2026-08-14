# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent reimplementation of Cambie (2024), not independent mathematical discovery  
**Consolidation gate:** PASSED  
**Arithmetic core:** PASSED  
**Current phase:** Phase B — Cambie Claim 5  
**Current target:** B1 — prime range `p > k`  
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

`PROJECT_STATE.md` identifies #678, reconstruction mode, rejected independent paths, verified facts, and the current formalization target.

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

The canonical `erdosM` definition is checked against independent hand-expanded LCM oracles for `(36,8)`, `(47,9)`, `(495,8)`, and `(504,9)`. The live graph also checks the positive and negative witness regressions.

## C5 — Clean live Lean tree — DONE

The production tree is concept-oriented; version-suffixed and superseded experiment modules were removed from the live tree while their provenance remains in Git history and Markdown records.

## C6 — Canonical Lake build graph — DONE

`Formalization.lean` imports every live #678 module. GitHub Actions no longer manually enumerates `.lean` files; `lake build` is the authoritative integration check.

Invariant:

> A new Lean module is not considered live until it is reachable from the canonical build graph.

## C7 — Finite-product valuation — DONE / MACHINE-CHECKED

For prime `p` and a finite set of nonzero naturals:

```text
padicValNat p (s.prod id) = s.sum (fun x => padicValNat p x)
```

## C8 — Restore green CI — DONE

GitHub Actions run `31827146122` passed the consolidated canonical graph. Repository safety checks found no `sorry`, `axiom`, or `native_decide` at that checkpoint.

## C9 — Consolidation checkpoint — DONE

The project advanced to the arithmetic core.

---

# Phase A — Arithmetic core — PASSED

## A1 — Finite-LCM valuation — DONE / MACHINE-CHECKED

Mathlib inspection found the existing structural theorem `Finset.factorization_lcm`; together with `Nat.factorization_def` it yields the live theorem

```text
padicValNat p (s.lcm f)
  = s.sup (fun a => padicValNat p (f a))
```

under explicit nonzero hypotheses.

Important integration lesson: the file-creation run passed before the new module was imported by the canonical root, so it did **not** validate the new theorem. The true integration run after root import was GitHub Actions `31828058986`, which passed.

## A2 — Reciprocal-LCM factor — DONE / MACHINE-CHECKED

Using `Finset.lcm_dvd_prod` and `padicValNat.div_of_dvd`, the live theorem proves

```text
padicValNat p (product / lcm)
  = sum of valuations - supremum of valuations.
```

An initial elaboration mismatch caused by `id` inside `Finset.sup` was repaired explicitly with `simp only [id_eq]`. Corrected GitHub Actions run `31829283998` passed.

The interval-specialized theorem is also live:

```text
padicValNat p (intervalProd start len / intervalLCM start len)
  = sum_{x in interval} padicValNat p x
    - sup_{x in interval} padicValNat p x.
```

## A3 — Interval valuation counting primitives — DONE / MACHINE-CHECKED

Live definitions:

```text
primePowerDivisibleCount s p r
intervalPrimePowerCount start len p r
```

The formalization connects `p^r ∣ x` with `r ≤ padicValNat p x` through Mathlib's `padicValNat_dvd_iff_le`, and proves the finite-support theorem:

```text
if sup_{x in s} padicValNat p x < r,
then primePowerDivisibleCount s p r = 0.
```

GitHub Actions run `31829795250` passed the canonical graph.

Arithmetic-core exit condition: PASSED.

---

# Phase B — Cambie Claim 5 — CURRENT

## B1 — Prime range `p > k` — CURRENT

### Mathematical target

For each of the two Claim 5 blocks, prove that if the prime `p` is larger than `k`, then at most one block element is divisible by `p`. Consequently all `p`-adic valuation occurring in the product is concentrated in at most one factor, the LCM captures exactly that valuation, and therefore

```text
padicValNat p (intervalProd / intervalLCM) = 0.
```

For the block of length `k+1`, the integer condition `p > k` gives `k+1 ≤ p`, so the same one-multiple argument applies.

### Implementation policy

1. First formalize a reusable interval-spacing lemma: two distinct multiples of `p` inside a consecutive block of length at most `p` are impossible.
2. Keep the statement independent of Cambie's CRT residue hypotheses; none are needed in this prime range.
3. Derive the zero valuation through the existing A2 formula rather than reproving product/LCM arithmetic.
4. No Claim 4, prime-density, or asymptotic input is permitted here.

### Exit condition

A machine-checked theorem sufficient to discharge the `p > k` case for both Claim 5 intervals is reachable from the canonical Lake graph.

## B2 — Prime range `sqrt(k) < p <= k` — PENDING

Formalize the “at most one multiple of `p^2`” structure and connect Cambie's residue-window conditions to the exact count of multiples of `p`.

## B3 — Prime range `p <= sqrt(k)` — PENDING

Formalize the small-prime capped valuation sums using the modulus `m` and the congruences on `x` and `y`.

## B4 — Claim 5 assembly — PENDING

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
├── Phase A — Arithmetic core ..................... PASSED
│   ├── A1 Finite-LCM valuation ................... DONE
│   ├── A2 Reciprocal-LCM factor .................. DONE
│   └── A3 Interval valuation counting ............ DONE
└── Phase B — Cambie Claim 5 ...................... CURRENT
    ├── B1 Prime range p > k ...................... CURRENT
    ├── B2 sqrt(k) < p <= k ....................... PENDING
    ├── B3 p <= sqrt(k) ........................... PENDING
    └── B4 Claim 5 assembly ....................... PENDING
```
