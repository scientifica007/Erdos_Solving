# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**Code-state basis:** `0696e6474ebaf6deec2303f38c862842da3b28e2`  
**Canonical CI status:** GREEN at the D4 mathematical exit head  
**Verified run:** `31959479154`  
**Verified build:** `mk_all --check` = `No update necessary`; canonical `lake build` = **8766 jobs**  
**Current phase:** Phase E — quantitative finish, pending exact-head confirmation of this documentation synchronization  
**Current target:** E1 — derive the LCM-ratio estimate from Claim 5 and the sharp representative bounds  
**Expansion gate:** E1 work may begin only after exact-head CI confirms this synchronized documentation head

This file is the sole operational answer to: **what is the next Lean/formalization task for #678?**

The mathematical analysis remains in `CAMBIE_PROOF_ANALYSIS.md`. `LEAN_TEST_PLAN.md` is superseded and historical.

---

## 0. Status that must not be blurred

Externally, Erdős #678 is proved. In this repository:

- the independent proof attempt was rejected;
- `M(36,8) > M(47,9)` is machine-checked;
- `(495,504,8)` is machine-refuted and retained as a negative regression;
- the arithmetic core and all three Claim 5 prime ranges are machine-checked;
- full Claim 5 is machine-checked under explicit medium- and small-prime residue interfaces;
- the complete finite Claim 4 / CRT engine through the actual sharp Cambie dependent placement is machine-checked;
- D4 now supplies the division-safe Cambie target window, the general small-scale separation bound, an explicit sufficiently-large-`k` arithmetic contract, and a `C`-dependent sharp prime-strip contract;
- under those explicit inputs, a reachable theorem constructs the same `x,y`, proves `x+k<y<x+M/(5Ck)`, places `y` in the paper-compatible target range, and carries the representatives through the complete Claim 5 identity;
- **prime-density existence of the five special primes in the sharp strips is not formalized** and remains an explicit Phase E2 dependency;
- the quantitative LCM-ratio finish, strong Cambie theorem, and full #678 theorem are not yet formalized.

A source file is not evidence that Lean accepted it. Only a successful canonical build of a reachable module grants machine-checked status.

---

# Phase A — Arithmetic core — PASSED

Machine-checked:

- finite-product and finite-LCM valuations;
- reciprocal-LCM valuation;
- prime-power counting;
- equality from prime valuations;
- exact interval semantics and nonzero bridges.

---

# Phase B — Cambie Claim 5 — PASSED

## B1 — `p > k` — DONE / MACHINE-CHECKED

Large primes contribute zero to the reciprocal-LCM valuation.

## B2 — `p ≤ k < p²` — DONE / MACHINE-CHECKED

The medium-prime contribution is controlled by the explicit admissible residue interface.

## B3 — small-prime exponent range — DONE / MACHINE-CHECKED

The capped small-prime congruence, window, initial-LCM, supremum, and valuation chain is live with boundary regressions.

## B4 — full Claim 5 assembly — DONE / MACHINE-CHECKED

`claim5_full_identity_of_residues` converts the explicit medium/small residue interfaces into the final natural-number identity.

---

# Phase C — Formalization consolidation gate — PASSED HISTORICALLY

The repository has:

- a length-safe interval API;
- one canonical Lean import graph;
- `mk_all --check` in CI;
- GitHub Actions as the authoritative reproducible Lean gate;
- explicit positive and negative regressions;
- state/roadmap synchronization rules.

---

# Phase D — Claim 4 / CRT combinatorial engine — PASSED

## D1 — finite density, modular coordinates, weighted CRT — DONE / MACHINE-CHECKED

- strict union bound;
- modular injectivity under nondivisibility;
- prime-coordinate density;
- weighted representation consumer;
- concrete pair/triple CRT basis producers and regressions.

## D2 — application residue boxes — DONE / MACHINE-CHECKED

- paper coefficient convention `{1,...,p}` with `p` representing residue zero;
- exact `x` and `y` exclusion sets and cardinalities;
- exact pair/triple search lengths;
- two-prime `y` and three-prime `x` application endpoints.

## D3 — scaled Claim 4 → Claim 5 interface — DONE / MACHINE-CHECKED

- `y = z*Ny` and `x = 1 + z*Nx`;
- affine/scaled modular injectivity;
- fixed other-medium coordinate packaging;
- small-prime scale data;
- derivation of both Claim 5 residue interfaces;
- reachable regression crossing into complete Claim 5.

## D4 — actual scales, representatives, separation, and sharp room — DONE / MACHINE-CHECKED

### D4a/D4b — constructed scales and D3 wrapper — DONE

Definitions: `claim4SmallScale`, `claim4Scale`, `claim4XScale`, `claim4YScale`.

Machine-checked support/unit facts and `claim4_exists_claim5_residue_interfaces_of_constructed_scales`.

Checkpoint: head `a259da8a...`, run `31947099017`, 8745 jobs.

### D4c — broad prime-window/search contract — DONE

`Claim4PrimeWindowData` isolates two distinct `y` primes above `k/2` and three pairwise-distinct `x` primes near `k`, and supplies all five medium-range/search-length obligations.

Checkpoint: head `eef7d931...`, run `31948527075`, 8747 jobs.

### D4d — factorization and placement — DONE

Machine-checked:

- `claim4FullScale`;
- `Nx*(xp*xq*xr)=fullScale` and `Ny*(yp*yq)=fullScale`;
- `claim4FullScale k = intervalLCM 1 k`;
- canonical search starts and absolute-window placement endpoints.

Checkpoint: head `b0914c87...`, run `31949164598`, 8750 jobs, with the full-scale/LCM bridge added later and retained in the final graph.

### D4e — dependent close-and-separated representatives — DONE

`claim4_exists_close_separated_representatives_with_claim5`:

- chooses the actual `y` first;
- places `x` in a moving interval below that `y`;
- derives `y < x + gap` from placement;
- derives `x+k<y` from the common small-prime congruences;
- feeds the same representatives into both Claim 5 residue interfaces and the full Claim 5 identity.

Checkpoint: head `72432d4b...`, run `31952559027`, 8754 jobs.  
Cleanup checkpoint: `f1dba040...`, run `31953021835`, 8754 jobs.

### D4f — sharp Cambie room theorem — DONE / MACHINE-CHECKED

The final arithmetic room layer is now live.

Machine-checked components:

1. **Actual target parameters**
   - `claim4CambieGap C k = M/(5*C*k)`;
   - `claim4CambieYLower C k = M*(k+1)/(5*C*k)`;
   - `claim4CambieYUpper C k = M/(4*C)-k`.

2. **Width reduction**
   - sharp two-prime and three-prime search budgets are converted through the exact scale factorizations to the room consumed by the dependent placement theorem.

3. **Small-scale separation**
   - `claim4SmallScale_gap_of_nine_le : 9 ≤ k → k+2 ≤ claim4SmallScale k`.

4. **Explicit large-`k` arithmetic**
   - `Claim4CambieLargeKData C k` uses `C>0`, `9≤k`, and the elementary condition
     `20*C*k^2*(k+1) ≤ 2^k`;
   - Mathlib's Chebyshev/Lcm bound then yields the required full-scale growth and the actual `y` target-window room.

5. **Sharp `C`-dependent prime strips**
   - `Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq` refines the broad prime data by
     - `k ≤ xp+s`, `k ≤ xq+s`, `k ≤ xr+s`,
     - `2*yp ≤ k+s`, `2*yq ≤ k+s`,
     - `40*C*(s+1) ≤ k`;
   - Lean derives the exact D4f two-prime and three-prime search budgets from these strips.

6. **Final D4 endpoint**
   - `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows`
     constructs `x,y` satisfying the actual target bounds, `x+k<y<x+claim4CambieGap C k`, both Claim 5 residue interfaces, and the complete Claim 5 identity.

7. **Regressions**
   - the graph contains closed large-`k` checks and a nonvacuous sharp-window configuration at `C=1, k=1000, s=23` with `x` primes `977,983,991` and `y` primes `503,509`.

D4f checkpoints:

- room reduction / target definitions: head `0e9ff533...`, run `31956361984`, 8760 jobs;
- general small-scale gap: head `6386278d...`, run `31957062773`, 8762 jobs;
- D4 exit head: `0696e6474ebaf6deec2303f38c862842da3b28e2`, run `31959479154`, `mk_all --check = No update necessary`, **8766 jobs**.

### D4 exit gate — PASSED MATHEMATICALLY; DOCUMENTATION HEAD RECHECK PENDING

The reachable final D4 theorem supplies the actual sharp dependent-placement arithmetic from explicit sufficiently-large-`k` and sharp-prime-strip data, then invokes the verified close-and-separated Claim 5 endpoint. The exact mathematical head is green.

**Boundary:** this does not prove that the five primes exist in those strips for every sufficiently large `k`. That analytic existence statement is intentionally Phase E2, not an axiom inside D4.

---

# Phase E — Quantitative finish — NEXT AFTER DOCUMENTATION CI

## E1 — LCM-ratio estimate — SOLE NEXT ACTION

Formalize the exact natural-number algebra from Claim 5 to Cambie's LCM comparison.

Inputs already machine-checked by D4:

- `M = intervalLCM 1 k`;
- the exact Claim 5 identity;
- `0 < x < y` and `x+k<y`;
- the sharp `y` target range;
- `y < x + M/(5*C*k)`.

Required output:

- a division-safe/cancellation-safe bridge from Claim 5 to the LCM ratio comparison;
- the product-ratio lower estimate corresponding to Cambie's argument;
- ultimately, under the explicit D4 hypotheses,
  `intervalLCM x k > C * intervalLCM y (k+1)`.

Audit requirement: do not perform informal field-style cancellation in `ℕ`; isolate exact divisibility/nonzero lemmas first and add boundary regressions.

## E2 — prime-density dependency — PENDING

Formalize or import a theorem producing, for every fixed `C` and all sufficiently large `k`, two primes in the sharp strip above `k/2` and three primes in the sharp strip below `k`, with a slack `s` satisfying the D4 sharp-window budget.

This dependency must remain explicit; do not smuggle it into E1 or D4 as an axiom.

## E3 — strong Cambie theorem — PENDING

Combine E1 and E2: for every fixed `C ≥ 1` and all sufficiently large `k`, construct `x,y` with `0<x<y`, `y>x+k`, and `LCM_x > C*LCM_y`.

## E4 — Erdős #678 — PENDING

Take `C=1` and translate the interval starts to the canonical problem variables.

---

# Current position

```text
Erdős #678
├── Consolidation gate ........................... PASSED
├── Arithmetic core .............................. PASSED
├── Cambie Claim 5 ............................... PASSED
├── Claim 4 / CRT engine .......................... PASSED MATHEMATICALLY
│   ├── D1: finite/modular/weighted CRT .......... MACHINE-CHECKED
│   ├── D2: application residue boxes ............ MACHINE-CHECKED
│   ├── D3: Claim 5 interface connection ......... MACHINE-CHECKED
│   ├── D4a-d: scales/factorization/placement ..... MACHINE-CHECKED
│   ├── D4e: dependent representatives ........... MACHINE-CHECKED
│   └── D4f: sharp Cambie room .................... MACHINE-CHECKED
└── Quantitative finish ........................... NEXT AFTER DOC CI
    ├── E1: LCM-ratio estimate .................... NEXT
    ├── E2: sharp prime-density existence ......... PENDING
    ├── E3: strong Cambie theorem ................. PENDING
    └── E4: Erdős #678 ............................ PENDING
```

## Sole next action

First pass exact-head CI on this synchronized documentation head. Then begin E1: isolate the exact cancellation/divisibility lemmas needed to transform `claim5_full_identity_of_residues` into the quantitative LCM comparison, and prove the paper-compatible lower bound using the already verified sharp bounds on `x` and `y`. Keep E2 prime-density existence separate.

## Global audit gates

- state documents and CI must agree before work resumes;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
