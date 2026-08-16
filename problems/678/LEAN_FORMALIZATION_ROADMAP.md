# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**D4 final reachable gate:** `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495` — SUCCESS, **8766 jobs**  
**E1a gate:** `36b91df00a7a25d20a635256a8533a7d9030714d`, run `31963812320` — SUCCESS, **8768 jobs**  
**E1 mathematical exit:** `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909` — SUCCESS  
**Verified E1 exit:** `mk_all --check` = `No update necessary`; canonical `lake build` = **8770 jobs**  
**Current phase:** Phase E — quantitative finish  
**Current target:** **E2 — sharp prime-density existence**  
**Expansion gate:** OPEN for E2; E3/E4 remain closed until the prime-existence dependency is formalized

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
- the complete finite Claim 4 / CRT engine through sharp Cambie dependent placement is machine-checked;
- the complete E1 cancellation-safe LCM algebra and quantitative product estimate are machine-checked;
- under explicit large-`k` and sharp-prime-window data, the repository now constructs `x,y` with `x+k<y` and proves
  `C * intervalLCM y (k+1) < intervalLCM x k`;
- **existence of the five sharp-window primes for every sufficiently large `k` is not formalized** and is the sole current E2 obligation;
- the strong Cambie theorem and full #678 theorem remain open in the repository.

A source file is not evidence that Lean accepted it. Only a successful canonical build of a reachable module grants machine-checked status.

---

# Phase A — Arithmetic core — PASSED

Machine-checked finite-product/LCM valuations, reciprocal-LCM valuation, prime-power counting, equality from prime valuations, and exact interval/nonzero bridges.

---

# Phase B — Cambie Claim 5 — PASSED

## B1 — `p > k` — DONE / MACHINE-CHECKED

Large primes contribute zero to the reciprocal-LCM valuation.

## B2 — `p ≤ k < p²` — DONE / MACHINE-CHECKED

The medium-prime contribution is controlled by the explicit admissible residue interface.

## B3 — `p² ≤ k` — DONE / MACHINE-CHECKED

The capped small-prime congruence/window/initial-LCM/supremum/valuation chain is live with boundary regressions.

## B4 — full Claim 5 assembly — DONE / MACHINE-CHECKED

`claim5_full_identity_of_residues` converts explicit medium/small residue interfaces into the final natural-number identity.

---

# Phase C — Formalization consolidation gate — PASSED HISTORICALLY

The repository has a length-safe interval API, one canonical import graph, `mk_all --check` in CI, explicit positive/negative regressions, and synchronized operational state rules.

---

# Phase D — Claim 4 / CRT combinatorial engine — PASSED

## D1–D3 — finite density, application boxes, scaled Claim 4 → Claim 5 — DONE

Machine-checked strict union bound, modular injectivity, weighted CRT, concrete pair/triple producers, exact residue boxes/search lengths, scaled/affine representatives, and both Claim 5 residue interfaces.

## D4 — actual scales, placement, separation, and sharp room — DONE

Machine-checked:

- `claim4SmallScale`, `claim4Scale`, `claim4XScale`, `claim4YScale` with support/unit obligations;
- `Claim4PrimeWindowData`;
- `claim4FullScale k = intervalLCM 1 k` and exact x/y factorizations;
- canonical and dependent placement, including `x+k<y<x+gap`;
- division-safe Cambie values
  - `gap = M/(5*C*k)`,
  - `yLower = M*(k+1)/(5*C*k)`,
  - `yUpper = M/(4*C)-k`;
- `claim4SmallScale_gap_of_nine_le : 9 ≤ k → k+2 ≤ claim4SmallScale k`;
- `Claim4CambieLargeKData`, using `C>0`, `9≤k`, and `20*C*k^2*(k+1) ≤ 2^k`;
- `Claim4CambieSharpPrimeWindowData`, with a slack `s`, two y-primes just above `k/2`, three x-primes just below `k`, and `40*C*(s+1) ≤ k`;
- exact derivation of both sharp search budgets;
- `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows`;
- closed regressions including `C=1, k=1000, s=23`, x-primes `977,983,991`, y-primes `503,509`.

Key checkpoints:

- D4a/b: `a259da8a...`, run `31947099017`, 8745 jobs;
- D4c: `eef7d931...`, run `31948527075`, 8747 jobs;
- D4d: `b0914c87...`, run `31949164598`, 8750 jobs;
- D4e dependent endpoint: `72432d4b...`, run `31952559027`, 8754 jobs;
- D4f room reduction: `0e9ff533...`, run `31956361984`, 8760 jobs;
- D4f small-scale gap: `6386278d...`, run `31957062773`, 8762 jobs;
- D4 mathematical exit: `0696e647...`, run `31959479154`, 8766 jobs;
- D4 final reachable repair: `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495`, 8766 jobs.

### D4 exit gate — PASSED

The final reachable D4 theorem supplies sharp dependent-placement arithmetic from explicit large-`k` and sharp-prime-strip data and invokes the verified Claim 5 endpoint.

**Boundary:** D4 does not prove that the five special primes exist in those strips for all sufficiently large `k`. That analytic existence theorem is E2.

---

# Phase E — Quantitative finish — CURRENT

## E1 — LCM-ratio estimate — PASSED / MACHINE-CHECKED

### E1a — cancellation-safe algebra — DONE

Machine-checked:

1. `intervalLCM_dvd_intervalProd`;
2. `claim5_cross_multiplication`, using exact divisibility and `Nat.div_mul_cancel` rather than field-style cancellation;
3. `claim5_lcm_lt_of_product_lt` reducing the LCM comparison to
   `C * Prod_y < M * Prod_x` under explicit nonzero hypotheses;
4. positive and zero-boundary regressions.

Checkpoint: `36b91df00a7a25d20a635256a8533a7d9030714d`, run `31963812320`, `No update necessary`, **8768 jobs**.

### E1b — product-ratio estimate — DONE

Machine-checked:

- `intervalProd_eq_prod_range` and `intervalProd_succ`;
- positive-start nonzero interval bridge;
- `succ_pow_lt_three_mul_pow : 0 < k → (k+1)^k < 3*k^k`;
- `claim4CambieGap_mul_succ_le_yLower`;
- from `yLower<y<x+gap`, the prefix comparison
  `intervalProd y k < 3 * intervalProd x k`;
- from `y<yUpper`, the remaining factor-4 room;
- `claim4_cambie_product_lt_fullScale` and `claim4_cambie_product_lt_initialLCM`.

### E1c — D4 representative endpoint → LCM comparison — DONE

`claim5_lcm_lt_of_cambie_bounds` combines the E1a transfer with the E1b product estimate.

Final E1 endpoint:

`claim4_exists_cambie_lcm_ratio_of_sharp_windows`

Under explicit `Claim4CambieLargeKData` and `Claim4CambieSharpPrimeWindowData`, it produces `x,y` satisfying positivity, order, separation, and

`C * intervalLCM y (k+1) < intervalLCM x k`.

E1 mathematical exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909` — SUCCESS, `No update necessary`, **8770 jobs**.

## E2 — sharp prime-density existence — CURRENT / SOLE NEXT ACTION

Formalize or import a theorem producing, for every fixed positive `C` and all sufficiently large `k`, data satisfying `Claim4CambieSharpPrimeWindowData`.

The exact already-frozen D4 contract requires a single slack `s` and five distinct primes such that:

- each x-prime lies in the broad D4 range and satisfies `k ≤ p+s`;
- each y-prime lies in the broad D4 half-window and satisfies `2*p ≤ k+s`;
- all five primes are pairwise distinct as required by `Claim4PrimeWindowData`;
- `40*C*(s+1) ≤ k`.

### E2a — library audit — CURRENT FIRST CHECKPOINT

Inspect the pinned Mathlib revision for formal PNT / prime-counting / short-interval results. Identify the smallest existing theorem that can produce arbitrarily many primes in relative neighborhoods of `k` and `k/2`, or document precisely which analytic theorem must be added/imported.

No new axiom or opaque “prime density hypothesis” may be introduced merely to advance the status.

### E2b — arithmetic adapter — PENDING

Convert the selected analytic theorem into the exact natural-number strip inequalities and a common slack `s` satisfying `40*C*(s+1) ≤ k`.

### E2c — five-prime constructor — PENDING

Package two y-primes and three x-primes into `Claim4CambieSharpPrimeWindowData`, with distinctness and all broad-window obligations discharged.

### E2 exit gate

A reachable theorem must have the shape: for fixed positive `C`, there exists a threshold such that every larger `k` admits `s,xp,xq,xr,yp,yq` satisfying `Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq`.

## E3 — strong Cambie theorem — PENDING

Combine the E2 constructor with `Claim4CambieLargeKData` and the passed E1 endpoint for every fixed positive `C` and all sufficiently large `k`.

## E4 — Erdős #678 — PENDING

Take `C=1` and translate interval starts to the canonical problem variables.

---

# Current position

```text
Erdős #678
├── Arithmetic core .............................. PASSED
├── Cambie Claim 5 ............................... PASSED
├── Claim 4 / CRT engine .......................... PASSED
│   └── D4 sharp Cambie placement ................. MACHINE-CHECKED
└── Quantitative finish ........................... CURRENT
    ├── E1 cancellation-safe LCM ratio ............ PASSED / MACHINE-CHECKED
    ├── E2 sharp prime-density existence .......... CURRENT
    │   ├── E2a library audit ...................... CURRENT
    │   ├── E2b arithmetic adapter ................ PENDING
    │   └── E2c five-prime constructor ............ PENDING
    ├── E3 strong Cambie theorem .................. PENDING
    └── E4 Erdős #678 ............................. PENDING
```

## Sole next action

Audit the pinned formal library for a prime-density/PNT theorem sufficient to produce the exact five-prime sharp-window contract. Do not alter the already machine-checked D4/E1 constants to fit a weaker theorem, and do not introduce an uncredited analytic axiom.

## Global audit gates

- state documents and CI must agree before merge/integration;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
