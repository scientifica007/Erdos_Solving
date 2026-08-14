# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**Code-state basis:** `61431b8881e481a56d06e00d702eabb6b64ae471`  
**Canonical CI status:** GREEN  
**Verified run:** `31847883886`  
**Current phase:** Phase D — CRT combinatorial engine  
**Current target:** formalize Claim 4 and construct the residue interfaces consumed by Claim 5  
**Expansion gate:** OPEN for D1 only; quantitative and prime-density phases remain closed

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
- the integrated small-prime Claim 5 theorem is machine-checked with reachable boundary regressions;
- full Claim 5 is machine-checked under explicit medium- and small-prime residue hypotheses;
- Claim 4 / CRT residue construction is not proved;
- the full #678 theorem is not formalized.

A source file containing a theorem statement is not evidence that Lean accepted the theorem. Only a successful canonical build of a reachable module grants machine-checked status.

---

## 1. Small-prime integration incident — RESOLVED

Commit `ac65fb32` first made the small-prime graph live and exposed two failures. Successive canonical runs then exposed a third inference failure and two test/integration defects.

Resolved items:

- `SmallPrimeWindows.lean`: equality orientation repaired explicitly with symmetry.
- `SmallPrimeValuation.lean`: natural-subtraction positivity expressed by `Nat.sub_pos_iff_lt` instead of opaque automation.
- `SmallPrimeSup.lean`: the finset and summand supplied explicitly to `Finset.single_le_sum`.
- `Formalization.lean`: regenerated in the exact order required by `lake exe mk_all`.
- `SmallPrimeTests.lean`: tests instantiate the theorem rather than attempting non-reducible direct evaluation of `padicValNat`.

Exit evidence:

- commit `e5cbd8ea01550ae62b63d4a4c0c58a9621a8f2bf`;
- run `31845987598`;
- `mk_all --check`: no update necessary;
- `SmallPrimeClaim5.lean` and `SmallPrimeTests.lean`: reached;
- canonical build: success.

Claim 4, CRT, and quantitative estimates remain closed until B4 is complete.

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

The consolidation checkpoint was historical; the present credited code state is also green at run `31847883886`.

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

# Phase B — Cambie Claim 5 — PASSED

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

## B3 — Small-prime exponent range — DONE / MACHINE-CHECKED

Lean-facing parameterization:

```text
p^e ≤ k < p^(e+1)
x ≡ 1 (mod p^e)
y ≡ 0 (mod p^e)
```

Verified module classification:

| Module | Status |
|---|---|
| `SmallPrimeRange.lean` | reachable and machine-checked |
| `SmallPrimeInitialLCM.lean` | reachable and machine-checked |
| `SmallPrimeWindows.lean` | repaired, reachable, and machine-checked |
| `SmallPrimeValuation.lean` | repaired, reachable, and machine-checked |
| `SmallPrimeSup.lean` | repaired, reachable, and machine-checked |
| `SmallPrimeClaim5.lean` | reachable and machine-checked |
| `SmallPrimeTests.lean` | boundary theorem instantiations and a negative congruence regression checked |

Closing checkpoint: run `31845987598`, commit `e5cbd8ea01550ae62b63d4a4c0c58a9621a8f2bf`.

## B4 — Full Claim 5 assembly — DONE / MACHINE-CHECKED

Completed components:

- `Claim5MediumResidues` and `Claim5SmallResidues` expose exactly the data expected from the later CRT layer;
- `intervalProd_ne_zero_of_mem_ne_zero`, `intervalLCM_ne_zero_of_mem_ne_zero`, and `intervalProd_div_intervalLCM_ne_zero` discharge the extensionality side conditions;
- `claim5_prime_valuation_of_residues` partitions every prime into the large, medium, or small range and applies the verified theorem;
- `claim5_full_identity_of_residues` derives the natural-number identity from equality of all prime valuations;
- `Claim5AssemblyTests.lean` provides a reachable theorem-interface regression at `k = 2`.

Exit evidence: commit `61431b8881e481a56d06e00d702eabb6b64ae471`, run `31847883886`, `mk_all --check` reported no update, both new modules were reached, and the 8729-job canonical build succeeded.

Boundary: this proves Claim 5 **conditional on the explicit residue interfaces**. It does not prove Claim 4, construct CRT representatives, supply prime-density input, or finish Erdős #678.

---

# Phase D — CRT combinatorial engine — CURRENT

## D1 — Claim 4 — CURRENT

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
├── Cambie Claim 5 ............................... PASSED
│   ├── B1: p > k ................................ MACHINE-CHECKED
│   ├── B2: p ≤ k < p² .......................... MACHINE-CHECKED
│   ├── B3: small-prime exponent range ........... MACHINE-CHECKED
│   └── B4: full Claim 5 assembly ................ MACHINE-CHECKED
└── Claim 4 / CRT engine .......................... CURRENT
```

## Sole next action

State and machine-check the exact Claim 4 / CRT-density interface that constructs residues satisfying `Claim5MediumResidues` and `Claim5SmallResidues`. Do not open the quantitative-finish phase until that construction and its bounds pass the canonical gate.

## Global audit gates

- state documents and CI must agree before work resumes;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
