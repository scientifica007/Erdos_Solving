# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**Code-state basis:** `853a3486af63e86030e5b669266b6e0fe5e16ce8`  
**Canonical CI status:** GREEN  
**Verified run:** `31872525005`  
**Current phase:** Phase D — CRT combinatorial engine  
**Current target:** construct and bound the actual scales and separated representatives  
**Expansion gate:** OPEN for D4 representatives and separation only; analytic and prime-density phases remain closed

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
- the pair/triple application residue boxes, paper/canonical coefficient translation, exact exclusion cardinalities, strict budgets, and application endpoints are machine-checked;
- the scaled/affine application endpoints and their connection to both Claim 5 residue interfaces are machine-checked under explicit scale-support data;
- the general-`k` construction and quantitative control of the scales and representatives are not proved;
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

The consolidation checkpoint is historical; the present credited theorem-and-regression head is green at run `31872525005`.

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

Boundary: this theorem proves Claim 5 **conditional on the explicit residue interfaces**. The later D1d producer and D2 application boxes now select coefficient data, but D3 has not yet packaged those outputs as the two interfaces; prime-density input and Erdős #678 also remain outside this result.

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

## D2 — Application residue boxes — DONE / MACHINE-CHECKED

`Claim4ApplicationBoxes.lean` formalizes Cambie's exact coefficient boxes and instantiates the verified pair/triple CRT-density endpoints.

Completed obligations:

1. `claim4PaperCoefficient` translates canonical zero to paper coefficient `p` and preserves the residue modulo `p`;
2. `claim4XExcluded` and `claim4YExcluded` are the exact canonical complements of the paper intervals;
3. `claim4XExcluded_card` proves cardinality `k % p`, while `claim4YExcluded_card` proves `p - k % p - 1`;
4. `claim4PairYSearchLength` and `claim4TripleXSearchLength` are exactly the summed exclusion cards plus one;
5. `claim4_pair_y_box_density` and `claim4_triple_x_box_density` expose the required coefficient inequalities and weighted congruences with the strict budget internalized;
6. `Claim4ApplicationBoxesTests.lean` checks the zero-to-`p` endpoint, exact cards, concrete pair/triple instantiations, and failure at equality budget.

Exit evidence: commit `b2a05790b4ae466133e792ca6afa3eae730c0427`, run `31870476963`; `mk_all --check` reported `No update necessary`, both new modules were reached, and the full 8739-job build succeeded.

Boundary: D2 proves the normalized coefficient boxes and weighted representatives. The later D3 layer handles the essential scaling to actual `x,y`; D2 alone must not be cited as the Claim 5 connection and does not prove the D4 size/separation conditions.

### D2 implementation incident — RESOLVED

Run `31870123794` exposed four local proof-closure issues: one explicit `Nat.ModEq.refl`, one use of positivity, and two branches already closed by `simp`. Commit `b2a05790b4ae466133e792ca6afa3eae730c0427` repaired those endpoints without changing a definition, theorem statement, or assumption.

## D3 — Claim 5 interface connection — DONE / MACHINE-CHECKED UNDER EXPLICIT SCALE-SUPPORT DATA

`Claim4Claim5Interface.lean` distinguishes the normalized D2 coordinates from the actual representatives `x = 1 + z*Nx` and `y = z*Ny`, then connects those representatives to both Claim 5 residue interfaces.

Completed obligations:

1. `claim4_modEq_paperCoefficient_mod` turns the paper representative of a canonical remainder into a direct congruence witness;
2. `interval_one_add_mul_mod_injective_of_prime` proves the affine injectivity needed for `x = 1 + z*Nx`;
3. `claim4_pair_y_scaled_box_density` and `claim4_triple_x_scaled_box_density` apply the exact D2 exclusions to the actual scaled residues;
4. `Claim4SmallPrimeScaleData` records common prime-power divisibility, and `claim5SmallResidues_of_scales` derives the unchanged small-prime interface;
5. `claim5MediumResidues_of_pair_triple_boxes` combines the five special boxes with the fixed other medium coordinates;
6. `claim4_exists_claim5_residue_interfaces_of_scales` produces both interfaces from prime, unit, search-length, medium-support, and small-support data;
7. `Claim4Claim5InterfaceTests.lean` checks a nonvacuous small-prime case and a `k = 4` producer that reaches `claim5_full_identity_of_residues`, plus a malformed medium-interface regression.

Exit evidence: commit `853a3486af63e86030e5b669266b6e0fe5e16ce8`, run `31872525005`; `mk_all --check` reported `No update necessary`, both D3 modules were reached, and the full 8741-job build succeeded.

Boundary: the combined theorem assumes explicit data proving which medium primes divide `Nx,Ny`, which small prime powers divide both, that each special prime is a unit for its scale, and that the exact pair/triple search lengths fit. Constructing those scales and proving the quantitative placement of the resulting representatives belongs to D4.

### D3 implementation incident — RESOLVED

Run `31872158679` built the complete D3 theorem module and rejected only two test lines where `norm_num` continued after closing an `interval_cases` branch. Commit `853a3486af63e86030e5b669266b6e0fe5e16ce8` separated the branches without changing any definition, theorem statement, or assumption.

## D4 — Representatives and separation — CURRENT

Construct the actual scales and prime choices, discharge every premise of `claim4_exists_claim5_residue_interfaces_of_scales`, and prove the quantitative representative bounds and `y > x + k` required by Cambie's application.

Exact obligations:

1. define `Nx` and `Ny` from the fixed small-prime powers and all non-special medium primes;
2. prove their divisibility at fixed coordinates and their nondivisibility at the five special primes;
3. isolate the prime-window hypotheses for two primes near `k/2` and three near `k` and derive the exact pair/triple search-length inequalities;
4. choose the `zx,zy` search intervals so the resulting `x,y` lie in Cambie's target ranges;
5. prove positivity, `x < y`, and `y > x + k`, then feed the verified Claim 5 identity;
6. retain the prime-density dependency as an explicit later input rather than adding an axiom here.

Exit gate: a reachable theorem constructs quantitatively separated `x,y` satisfying the full Claim 5 identity from a clearly isolated prime-window hypothesis, with a green exact-head run. Do not open Phase E before this gate.

Historical theorem-code checkpoint for D1a–D1c: commit `f9f6c068fc199a6639a12befadfda126dd99764c`, run `31853105621`.

D1a–D1d gate: commit `12306b5ec393f5521ef2ebaa7ca09c7443e06867`, run `31858024749`; `mk_all --check` reported no update, all eight Claim 4 modules were reached, the 8737-job build succeeded, and GitHub `.lake` cache restore/save remained skipped to avoid the post-build disk exhaustion recorded in run `31853895481`.

D2 gate: commit `b2a05790b4ae466133e792ca6afa3eae730c0427`, run `31870476963`; `mk_all --check` reported no update, all ten Claim 4 modules were reached, the 8739-job build succeeded, and GitHub `.lake` cache restore/save remained skipped.

D3 gate: commit `853a3486af63e86030e5b669266b6e0fe5e16ce8`, run `31872525005`; `mk_all --check` reported no update, all twelve Claim 4 modules were reached, the 8741-job build succeeded, and GitHub `.lake` cache restore/save remained skipped.

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
    ├── D2: application residue boxes ............ MACHINE-CHECKED
    ├── D3: Claim 5 interface connection ......... MACHINE-CHECKED
    └── D4: representatives and separation ....... CURRENT
```

## Sole next action

Define and verify the actual scales `Nx,Ny`, discharge the combined scaled producer's divisibility/unit/search-length premises, and choose search intervals yielding Cambie's representative bounds and `y > x + k`. Do not open the analytic finish until this D4 theorem and its boundary regressions pass the canonical gate.

## Global audit gates

- state documents and CI must agree before work resumes;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
