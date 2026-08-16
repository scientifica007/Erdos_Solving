# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**D4 mathematical basis:** `0696e6474ebaf6deec2303f38c862842da3b28e2`  
**D4 mathematical run:** `31959479154` — SUCCESS  
**D4 documentation gate:** `c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893`, run `31960707971` — SUCCESS  
**Verified build at both gates:** `mk_all --check` = `No update necessary`; canonical `lake build` = **8766 jobs**  
**Current phase:** Phase E — quantitative finish  
**Current target:** **E1 — LCM-ratio estimate**  
**Expansion gate:** OPEN for E1; E2 prime-density existence remains a separate dependency

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
- D4 supplies actual scales, full-scale factorization, the exact Cambie target window, a general small-scale separation bound, an explicit large-`k` arithmetic contract, and a `C`-dependent sharp prime-strip contract;
- under those explicit inputs, the final D4 theorem constructs `x,y`, proves `x+k<y<x+M/(5Ck)`, places `y` in the paper-compatible target range, and carries the same representatives through the complete Claim 5 identity;
- **existence of the five sharp-window primes for every sufficiently large `k` is not formalized** and remains E2;
- the LCM-ratio estimate, strong Cambie theorem, and full #678 theorem remain open in the repository.

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

## D1 — finite density, modular coordinates, weighted CRT — DONE

Machine-checked strict union bound, modular injectivity, coordinate density, weighted representation, and concrete pair/triple CRT basis producers.

## D2 — application residue boxes — DONE

Machine-checked paper coefficient convention, exact `x`/`y` exclusion sets and cardinalities, exact pair/triple search lengths, and application endpoints.

## D3 — scaled Claim 4 → Claim 5 interface — DONE

Machine-checked scaled/affine representatives, fixed other-medium coordinates, small-prime scale data, both Claim 5 residue interfaces, and a reachable bridge into full Claim 5.

## D4 — actual scales, placement, separation, and sharp room — DONE

### D4a/D4b — constructed scales and wrapper

`claim4SmallScale`, `claim4Scale`, `claim4XScale`, `claim4YScale` and all support/unit obligations are machine-checked.

Checkpoint: `a259da8a...`, run `31947099017`, 8745 jobs.

### D4c — broad prime-window contract

`Claim4PrimeWindowData` supplies the broad five-prime medium/search obligations.

Checkpoint: `eef7d931...`, run `31948527075`, 8747 jobs.

### D4d — factorization and placement

Machine-checked:

- `claim4FullScale`;
- `Nx*(xp*xq*xr)=fullScale` and `Ny*(yp*yq)=fullScale`;
- `claim4FullScale k = intervalLCM 1 k`;
- canonical search starts and quantitative placement.

Checkpoint: `b0914c87...`, run `31949164598`, 8750 jobs; the LCM bridge is retained in the final graph.

### D4e — dependent close-and-separated representatives

`claim4_exists_close_separated_representatives_with_claim5` chooses `y`, then places `x` in a moving interval, derives `x+k<y<x+gap`, obtains both residue interfaces, and invokes full Claim 5.

Checkpoint: `72432d4b...`, run `31952559027`, 8754 jobs. Cleanup: `f1dba040...`, run `31953021835`.

### D4f — sharp Cambie room theorem

Machine-checked:

1. actual division-safe parameters
   - `gap = M/(5*C*k)`,
   - `yLower = M*(k+1)/(5*C*k)`,
   - `yUpper = M/(4*C)-k`;
2. width-form reduction through exact scale factorization;
3. `claim4SmallScale_gap_of_nine_le : 9 ≤ k → k+2 ≤ claim4SmallScale k`;
4. `Claim4CambieLargeKData`, using `C>0`, `9≤k`, and `20*C*k^2*(k+1) ≤ 2^k` to derive full-scale growth and target-window room;
5. `Claim4CambieSharpPrimeWindowData`, refining the broad prime data by a slack `s` with
   - `k ≤ xp+s`, `k ≤ xq+s`, `k ≤ xr+s`,
   - `2*yp ≤ k+s`, `2*yq ≤ k+s`,
   - `40*C*(s+1) ≤ k`;
6. exact derivation of both D4f search budgets from those strips;
7. `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows`;
8. closed regressions including `C=1, k=1000, s=23`, x-primes `977,983,991`, y-primes `503,509`.

Checkpoints:

- room reduction: `0e9ff533...`, run `31956361984`, 8760 jobs;
- small-scale gap: `6386278d...`, run `31957062773`, 8762 jobs;
- mathematical exit: `0696e6474ebaf6deec2303f38c862842da3b28e2`, run `31959479154`, 8766 jobs;
- documentation gate: `c1bbe17bc0cac263850b0a7f0fdb6076eaf9d893`, run `31960707971`, 8766 jobs.

### D4 exit gate — PASSED

The final reachable D4 theorem supplies the sharp dependent-placement arithmetic from explicit large-`k` and sharp-prime-strip data and invokes the verified Claim 5 endpoint. Both mathematical and state-document gates are green.

**Boundary:** D4 does not prove that the five special primes exist in those strips for all sufficiently large `k`. That analytic existence theorem is E2 and must not be smuggled into E1 or D4.

---

# Phase E — Quantitative finish — CURRENT

## E1 — LCM-ratio estimate — CURRENT / SOLE NEXT ACTION

The target is to prove the paper-compatible comparison

`intervalLCM x k > C * intervalLCM y (k+1)`

from the already machine-checked Claim 5 identity and sharp bounds.

### E1a — cancellation-safe algebra — CURRENT FIRST CHECKPOINT

Do **not** treat natural-number quotients as field fractions. First prove:

1. a reusable theorem
   `intervalLCM start len ∣ intervalProd start len`;
2. a cross-multiplication lemma consuming exact divisibility and the Claim 5 quotient identity to obtain
   `Prod_y * LCM_x = M * Prod_x * LCM_y`;
3. an inequality-transfer lemma: under explicit positivity,
   `C * Prod_y < M * Prod_x`
   implies
   `C * LCM_y < LCM_x`;
4. positive and zero-boundary regressions for these cancellation lemmas.

Only after E1a is green may the proof use quantitative product estimates.

### E1b — product-ratio estimate — PENDING

Use the verified D4 bounds:

- `0 < x < y`;
- `x+k < y`;
- `y < x + M/(5*C*k)`;
- `M*(k+1)/(5*C*k) < y`;
- `y < M/(4*C)-k`;

to prove `C * Prod_y < M * Prod_x` in a division-safe form.

The proof should isolate pointwise/product monotonicity and any integer approximations as separate lemmas with regressions.

### E1c — D4 representative endpoint → LCM comparison — PENDING

Compose E1a/E1b with `claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows` to produce the LCM comparison under explicit large-`k` and sharp-prime-window data.

## E2 — sharp prime-density existence — PENDING

Formalize or import a theorem producing, for every fixed `C` and all sufficiently large `k`, two primes in the sharp strip above `k/2` and three primes in the sharp strip below `k`, with a slack `s` satisfying the D4 budget.

E2 remains independent of E1.

## E3 — strong Cambie theorem — PENDING

Combine E1 and E2 for every fixed positive `C` and all sufficiently large `k`.

## E4 — Erdős #678 — PENDING

Take `C=1` and translate interval starts to the canonical problem variables.

---

# Current position

```text
Erdős #678
├── Arithmetic core .............................. PASSED
├── Cambie Claim 5 ............................... PASSED
├── Claim 4 / CRT engine .......................... PASSED
│   ├── D1–D3 ..................................... MACHINE-CHECKED
│   └── D4 sharp Cambie placement ................. MACHINE-CHECKED
└── Quantitative finish ........................... CURRENT
    ├── E1a cancellation-safe LCM algebra ......... CURRENT
    ├── E1b product-ratio estimate ................ PENDING
    ├── E1c representative-to-LCM endpoint ........ PENDING
    ├── E2 sharp prime-density existence .......... PENDING
    ├── E3 strong Cambie theorem .................. PENDING
    └── E4 Erdős #678 ............................. PENDING
```

## Sole next action

Implement E1a in a dedicated Phase-E work branch after the D4 PR is review-ready/integrated according to repository governance. The first source theorem must be the exact divisibility/cross-multiplication layer; do not start with asymptotic estimates or prime density.

## Global audit gates

- state documents and CI must agree before merge/integration;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
