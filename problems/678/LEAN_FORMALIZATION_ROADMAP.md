# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**Code-state basis:** `12306b5ec393f5521ef2ebaa7ca09c7443e06867`  
**Canonical CI status:** GREEN  
**Verified run:** `31858024749`  
**Current phase:** Phase D — CRT combinatorial engine  
**Current target:** formalize Cambie's pair/triple application residue boxes and their exclusion budgets  
**Expansion gate:** OPEN for D2 application boxes only; Claim 5 connection, quantitative, and prime-density phases remain closed

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
- the Claim 4 finite union-bound core, modular injectivity layer, prime-coordinate density theorem, and conditional weighted consumer are machine-checked;
- the concrete two- and three-prime CRT basis weights, inverse multipliers, weighted representation contracts, and density endpoints are machine-checked;
- the application residue boxes, exclusion-cardinality estimates, and full Claim 4 application are not proved;
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

The consolidation checkpoint is historical; the present credited theorem-and-regression head is green at run `31858024749`.

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

Boundary: this theorem proves Claim 5 **conditional on the explicit residue interfaces**. The later D1d producer now constructs the pair/triple CRT basis, but the application boxes still do not supply those interfaces; prime-density input and Erdős #678 also remain outside this result.

---

# Phase D — CRT combinatorial engine — CURRENT

## D1 — Claim 4 density theorem and concrete CRT producer — DONE / MACHINE-CHECKED FOR THE TWO-/THREE-PRIME APPLICATIONS

### D1a — Finite strict union bound — DONE / MACHINE-CHECKED

`Claim4Density.lean` proves `claim4_exists_avoiding_coordinate_exclusions`: injectivity bounds the rejected positions for each coordinate, `Finset.card_biUnion_le` bounds their union, and a strict total exclusion budget leaves an accepted position.

`Claim4DensityTests.lean` checks:

- a positive case where two singleton exclusions cannot cover five positions;
- a negative equality-budget case where two exclusions do cover two positions.

### D1b — Modular coordinate injectivity — DONE / MACHINE-CHECKED

`Claim4Modular.lean` proves:

- `interval_mul_mod_injective_of_coprime`;
- `interval_mul_mod_injective_of_prime`;
- `claim4_prime_coordinate_density`.

The formal statement uses the exact integer budget

```text
sum_i |excluded_i| < interval length
```

instead of introducing a real-valued `epsilon`. This is the proof-consumer form of the paper's inequality `epsilon * sum_i p_i < n`.

`Claim4ModularTests.lean` checks a unit multiplier modulo five and records failure of injectivity for a multiplier divisible by five.

### D1c — Weighted consumer interface — DONE / MACHINE-CHECKED

`Claim4Weighted.lean` defines:

- `claim4WeightedCombination`;
- `Claim4WeightedRepresentation`;
- `claim4_weighted_density_of_representation`.

The last theorem combines the verified coordinate-density theorem with a supplied representation contract. Its positive and zero-weight negative regressions are live in `Claim4WeightedTests.lean`.

This is a **consumer theorem**, not a proof that any particular CRT weights satisfy the contract.

### D1d — Actual pair/triple CRT-basis producer — DONE / MACHINE-CHECKED

`Claim4CRT.lean` now discharges the producer contract for the two concrete arities used by Cambie:

- pair coordinates `p,q`, modulus `p*q`, and weights `q,p`;
- triple coordinates `p,q,r`, modulus `(p*q)*r`, and weights `q*r,p*r,p*q`;
- coordinate inverses constructed from the exact coprimality hypotheses;
- local scaled-coordinate congruences and zero-off-coordinate congruences;
- pair and triple CRT composition through `Nat.modEq_and_modEq_iff_modEq_mul`;
- nondivisibility of every constructed multiplier in its own prime coordinate;
- `Claim4WeightedRepresentation` for both bases;
- `claim4_pair_crt_density` and `claim4_triple_crt_density`, which internalize the producer and leave no representation assumption for the caller.

`Claim4CRTTests.lean` checks concrete pair and triple representations, existence of bounded nondivisible multipliers, failure of the **full** pair representation contract for a divisible multiplier, and direct reachability of both density endpoints.

The generic arbitrary-finite-family CRT basis is not formalized. This is not credited as a generic proof of the paper's Claim 4 statement; it is the verified producer for the two- and three-prime applications required by the current reconstruction.

Exit evidence:

- pair producer: commit `5ab1ec7ab23ee2ce1be437432e713d6dbd2662a3`, run `31856857400`;
- pair/triple theorem graph: commit `ee42cef70d1cf7108b68546bf851f19eaf96c2f5`, run `31857628246`;
- strengthened producer/consumer regressions: commit `12306b5ec393f5521ef2ebaa7ca09c7443e06867`, run `31858024749`.

### D1 implementation incidents — RESOLVED

- run `31856460100` rejected the wrong direction `.mpr`; the local-to-global CRT theorem is used with `.mp`;
- run `31857253699` exposed a nested proof-block indentation error in the triple composition;
- neither repair weakened a theorem statement or introduced a new assumption.

## D2 — Application residue boxes — CURRENT

Formalize Cambie's admissible coordinate sets for the relevant primes and instantiate the verified pair/triple density endpoints for the future `y` and `x` representatives.

Exact obligations:

1. fix the paper-to-Lean convention translating coefficients in `{1,...,p}` to residues in `Finset.range p`;
2. define the two-prime admissible coordinate sets used for `y` and the three-prime sets used for `x`;
3. define their complements/excluded finsets and prove exact or sufficient cardinality bounds;
4. prove the strict summed exclusion budgets and interval-length bounds required by `claim4_pair_crt_density` and `claim4_triple_crt_density`;
5. add reachable boundary tests, including a failed equality-budget or malformed-box case.

Exit gate: both application-box instantiations reach the concrete density endpoints in the canonical graph, with a green exact-head run. Do not yet credit the Claim 5 residue interfaces until D3.

## D3 — Claim 5 interface connection — PENDING

Translate the selected coordinate coefficients and weighted representatives into `Claim5MediumResidues` and `Claim5SmallResidues`.

## D4 — Representatives and separation — PENDING

Prove the quantitative representative bounds and `y > x + k` required by the application.

Historical theorem-code checkpoint for D1a–D1c: commit `f9f6c068fc199a6639a12befadfda126dd99764c`, run `31853105621`.

D1a–D1d gate: commit `12306b5ec393f5521ef2ebaa7ca09c7443e06867`, run `31858024749`; `mk_all --check` reported no update, all eight Claim 4 modules were reached, the 8737-job build succeeded, and GitHub `.lake` cache restore/save remained skipped to avoid the post-build disk exhaustion recorded in run `31853895481`.

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
    ├── D1a: finite union bound ................... MACHINE-CHECKED
    ├── D1b: modular coordinate density .......... MACHINE-CHECKED
    ├── D1c: weighted consumer interface ......... MACHINE-CHECKED
    ├── D1d: pair/triple CRT-basis producer ...... MACHINE-CHECKED
    └── D2: application residue boxes ............ CURRENT
```

## Sole next action

Define and verify Cambie's pair/triple admissible residue boxes, prove the strict exclusion budgets, and instantiate `claim4_pair_crt_density` and `claim4_triple_crt_density`. Do not credit the Claim 5 interface connection or open the quantitative phase until these application endpoints and their regressions pass the canonical gate.

## Global audit gates

- state documents and CI must agree before work resumes;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
