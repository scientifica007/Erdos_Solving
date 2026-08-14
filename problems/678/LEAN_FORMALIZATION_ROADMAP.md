# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**Code-state basis:** `ac65fb32a90abf5183b52f117248793517262e65`  
**Canonical CI status:** RED  
**Diagnostic run:** `31839041104`  
**Current phase:** Phase B — Cambie Claim 5  
**Current target:** restore the small-prime graph and machine-check `SmallPrimeClaim5.lean`  
**Expansion gate:** CLOSED until CI is green

This file is the sole operational answer to: **what is the next Lean/formalization task for #678?**

The mathematical analysis remains in `CAMBIE_PROOF_ANALYSIS.md`. The old `LEAN_TEST_PLAN.md` is `SUPERSEDED` and historical.

---

## 0. Status that must not be blurred

Externally, Erdős #678 is proved. In this repository:

- the independent proof attempt was rejected;
- `M(36,8) > M(47,9)` is machine-checked;
- `(495,504,8)` is machine-refuted and retained as a negative regression;
- the arithmetic core is machine-checked;
- the Claim 5 ranges `p > k` and `p ≤ k < p²` are machine-checked;
- the capped small-prime congruence core is machine-checked;
- the integrated small-prime Claim 5 theorem is **not** machine-checked;
- full Claim 5 is not assembled;
- the full #678 theorem is not formalized.

A source file containing a theorem statement is not evidence that Lean accepted the theorem. Only a successful canonical build of a reachable module grants machine-checked status.

---

## 1. Current integration incident — BLOCKING

Commit `ac65fb32` imported `Formalization.Erdos678.SmallPrimeClaim5` into `Formalization.lean`. This correctly made the dependency graph live, but canonical run `31839041104` failed.

### Failure SP-I1 — equality orientation

- File: `SmallPrimeWindows.lean`
- Location: line 71 in the diagnostic run
- Symptom: `hiz` simplifies to `start = z`, while the goal is `z = start`.
- Required action: repair the orientation explicitly; do not alter interval semantics.

### Failure SP-I2 — natural subtraction/supremum proof

- File: `SmallPrimeValuation.lean`
- Location: line 55 in the diagnostic run
- Symptom: `omega` cannot prove the required step.
- Required action: replace the opaque automation step with an explicit order/subtraction argument and verify all natural-number truncation conditions.

### Exit condition for the incident

- both failures repaired;
- `lake build` succeeds through `Formalization.lean`;
- `SmallPrimeClaim5.lean` appears in the successful reachable graph;
- `PROJECT_STATE.md` and this roadmap record the successful commit and run.

No work on Claim 4, CRT, or the quantitative estimate is allowed before this exit condition.

---

# Phase C — Formalization Consolidation Gate — PASSED HISTORICALLY

Consolidation established:

- a length-based interval API;
- canonical `erdosM` semantics;
- explicit positive and negative arithmetic regressions;
- a concept-oriented Lean tree;
- one canonical import graph;
- finite-product valuation;
- a green checkpoint at run `31827146122`.

The phrase `PASSED HISTORICALLY` does not mean that the present head is green. It records that the consolidation requirements were met at their checkpoint.

---

# Phase A — Arithmetic core — PASSED

## A1 — Finite-product and finite-LCM valuations — DONE / MACHINE-CHECKED

For prime `p` and nonzero finite inputs, the graph proves:

```text
v_p(product) = sum of v_p
v_p(lcm) = supremum of v_p
```

## A2 — Reciprocal-LCM factor — DONE / MACHINE-CHECKED

```text
v_p(product / lcm) = sum of valuations - supremum of valuations
```

The natural quotient is justified by divisibility before valuation rules are applied.

## A3 — Prime-power counting — DONE / MACHINE-CHECKED

The graph defines prime-power divisibility counts, connects them to `padicValNat`, and proves finite-support vanishing above the valuation supremum.

---

# Phase B — Cambie Claim 5 — IN PROGRESS

## B1 — Prime range `p > k` — DONE / MACHINE-CHECKED

A block of length at most `p` contains at most one multiple of `p`; hence the product/LCM quotient has zero `p`-adic valuation. The combined theorem for the `x` and `y` blocks passed in run `31832061313`.

## B2 — Prime range `p ≤ k < p²` — DONE / MACHINE-CHECKED

Completed components:

- exact residue-class counts for the `x` block;
- exact residue-class counts for the `y` block;
- uniqueness of a multiple of `p²` in the relevant blocks;
- reciprocal-LCM valuation as the number of multiples of `p` minus one;
- `v_p(lcm(1,...,k)) = 1`;
- assembled medium-prime Claim 5 identity.

Integrated closing checkpoint: run `31836288385`, commit `25987ea7`.

## B3 — Small-prime exponent range — CURRENT / INTEGRATION FAILED

Lean-facing parameterization:

```text
p^e ≤ k < p^(e+1)
x ≡ 1 (mod p^e)
y ≡ 0 (mod p^e)
```

Current module classification:

| Module | Status |
|---|---|
| `SmallPrimeRange.lean` | imported and machine-checked |
| `SmallPrimeInitialLCM.lean` | source compiles in the diagnostic run, but the total graph is red |
| `SmallPrimeWindows.lean` | live and failing |
| `SmallPrimeValuation.lean` | live and failing |
| `SmallPrimeSup.lean` | present; dependent graph not fully validated |
| `SmallPrimeClaim5.lean` | imported but not reached successfully |

B3 is not `DONE` until the full dependency graph passes.

## B4 — Full Claim 5 assembly — PENDING

After B3 is green:

1. state the complete residue hypotheses required for every prime range;
2. split an arbitrary prime into large, medium, or small cases;
3. apply the range-specific valuation identities;
4. prove both sides of the proposed identity are nonzero;
5. use equality of all prime `padicValNat` values to prove the natural-number identity.

Exit condition: Cambie's exact Claim 5 identity is machine-checked without Claim 4, prime-density existence, or the final asymptotic estimate.

---

# Phase D — CRT combinatorial engine — PENDING

## D1 — Claim 4

Formalize Cambie's CRT-density lemma independently of the LCM application.

## D2 — Residue boxes

Formalize admissible residue sets for the relevant primes and combine them by CRT.

## D3 — Representatives and separation

Construct `x,y` with the residue restrictions, quantitative bounds, and `y > x + k`.

---

# Phase E — Quantitative finish — PENDING

## E1 — LCM-ratio estimate

Derive the final ratio bound from Claim 5 with every inequality direction checked.

## E2 — Prime-density dependency

Identify and isolate the exact theorem used. An explicit unproved hypothesis must remain visibly conditional.

## E3 — Strong Cambie theorem

Formalize the sufficiently-large-`k` result for arbitrary fixed `C ≥ 1`.

## E4 — Deduce Erdős #678

Set `C = 1`, translate `n=x-1`, `m=y-1`, and prove all domain and infinitude conditions.

---

# Current position

```text
Erdős #678
├── Consolidation gate ........................... PASSED AT CHECKPOINT
├── Arithmetic core .............................. PASSED
└── Cambie Claim 5 ............................... IN PROGRESS
    ├── B1: p > k ................................ MACHINE-CHECKED
    ├── B2: p ≤ k < p² .......................... MACHINE-CHECKED
    ├── B3: small-prime exponent range ........... LIVE / CI FAILURE
    └── B4: full Claim 5 assembly ................ PENDING
```

## Sole next action

Restore a green canonical build for the currently imported small-prime graph. Do not start a new mathematical phase.

## Global audit gates

- state documents and CI must agree before work resumes;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
