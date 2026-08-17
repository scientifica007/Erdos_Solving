# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** COMPLETE / MACHINE-CHECKED on the E4 branch  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**D4 final reachable gate:** `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495` — SUCCESS, **8766 jobs**  
**E1 mathematical exit:** `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909` — SUCCESS, **8770 jobs**  
**E2 prime-density exit:** `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856` — SUCCESS, **8800 jobs**  
**E3 strong Cambie exit:** `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891` — SUCCESS, **8804 jobs**  
**E4 / full #678 mathematical exit:** `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757` — SUCCESS, `No update necessary`, **8806 jobs**  
**Current task:** documentation synchronization and stacked-PR review only; no mathematical phase remains open.

This file is the sole operational answer to: **what is the next Lean/formalization task for #678?**

The mathematical analysis remains in `CAMBIE_PROOF_ANALYSIS.md`. `LEAN_TEST_PLAN.md` is superseded and historical.

---

## 0. Status that must not be blurred

Externally, Erdős #678 is proved. In this repository:

- the earlier independent proof attempt remains rejected;
- `M(36,8) > M(47,9)` is machine-checked;
- `(495,504,8)` is machine-refuted and retained as a negative regression;
- the arithmetic core, Claim 5, Claim 4 / CRT engine, quantitative LCM estimate, prime-density bridge, strong Cambie theorem, final canonical index translation, and infinite-family theorem are all machine-checked on the E4 branch;
- the analytic input is the pinned `AxiomMath/PrimeNumberTheoremAnd` revision `2667e414c38e5a5dc9aa1946f16f13001e5cd3ed`, used through its kernel-checked `prime_between` consequence;
- no custom prime-density axiom and no `sorry` is introduced.

A source file is not evidence that Lean accepted it. The credited status above comes from canonical reachable builds.

---

# Phase A — Arithmetic core — PASSED

Machine-checked finite-product/LCM valuations, reciprocal-LCM valuation, prime-power counting, equality from prime valuations, and interval/nonzero bridges.

# Phase B — Cambie Claim 5 — PASSED

All large-, medium-, and small-prime ranges are machine-checked, together with the assembled natural-number Claim 5 identity under the explicit residue interfaces produced downstream by Claim 4.

# Phase C — Consolidation gate — PASSED

Length-safe interval API, canonical import graph, `mk_all --check`, and positive/negative regressions are live.

# Phase D — Claim 4 / CRT combinatorial engine — PASSED

Machine-checked components include finite density, weighted CRT, pair/triple CRT producers, exact residue boxes/search lengths, constructed scales, full-scale factorization, dependent placement, Cambie target window, sharp prime-window budgets, and the final sharp representative endpoint with full Claim 5.

Final reachable D4 checkpoint: `eb5ffebffcb199cc76c83a941da955f4ecfebde5`, run `31963803495`, **8766 jobs**.

---

# Phase E — Quantitative finish — PASSED

## E1 — cancellation-safe LCM-ratio estimate — PASSED

Machine-checked:

- exact interval-LCM divisibility into the interval product;
- cancellation-safe Claim 5 cross multiplication;
- strict product-to-LCM inequality transfer;
- interval-product recursion;
- `(k+1)^k < 3*k^k`;
- product comparison from Cambie's lower target, closeness, and upper target;
- `claim4_exists_cambie_lcm_ratio_of_sharp_windows`.

Exit: `3fa8f4416ae976dbfa6be6ddbe7726dd74c0c42a`, run `31968714909`, **8770 jobs**.

## E2 — sharp prime-density existence — PASSED

E2 was resolved without changing D4/E1 constants:

1. `Claim4CambieFiveStripPrimeData` packages three disjoint near-`k` strips and two disjoint just-above-`k/2` strips.
2. `Claim4RelativePrimeProvider q` isolates the exact eventual multiplicative prime interval needed.
3. The provider is converted to the five additive strips with denominator `q = 320*C`.
4. `claim4RelativePrimeProviderOfPNT` derives the provider from the imported `prime_between` theorem in pinned PNT+.
5. `claim4_exists_cambie_lcm_ratio_eventually_of_pnt` removes the explicit prime-density hypothesis from the LCM endpoint.

Key checkpoints:

- E2c five-strip arithmetic: `81cf4b2303a4a93bf30d2fcb322b810c754530f3`, run `31972724132`, **8774 jobs**;
- provider→five-strips: `14c9e5e8df00de4e129d142e472b3c9d91fd1c00`, run `31975082883`, **8778 jobs**;
- E2 exit: `6d06401bd2ee3aca116fd4ac592bf14d5e43694c`, run `31975809856`, **8800 jobs**.

## E3 — strong Cambie theorem — PASSED

`claim4CambieLargeKData_of_threshold` discharges the remaining elementary growth condition above

`claim4CambieLargeKThreshold C = max 9 (3840*C + 3)`

using the fourth binomial coefficient and `Nat.choose_le_two_pow`.

`cambie_lcm_ratio_eventually` combines this threshold with E2's PNT threshold, proving the strong eventual LCM comparison for every fixed positive `C`.

- E3a growth checkpoint: `58b870511588e6f9100443d2250024031bfaa3fd`, run `31974295910`, **8776 jobs**;
- E3 exit: `d13cf16a1a1a0a42d8d5bd4afc4ae0a50e9bda94`, run `31975821891`, **8804 jobs**.

## E4 — canonical Erdős #678 theorem — PASSED

`Erdos678Final.lean` performs the off-by-one-safe translation from interval starts to the canonical variables:

- `claim4_cambie_k_lt_x_of_bounds` recovers `k < x` from existing verified bounds, ensuring `n = x-1 ≥ 3`;
- the large-start fact is preserved through sharp-window, five-strip, provider, and PNT endpoints;
- `cambie_lcm_ratio_eventually_with_large_start` specializes the strong construction with enough start information;
- `erdos678_unbounded_witnesses` proves that for every lower bound `B`, there exist `n,m,k` with
  `B ≤ k`, `3 ≤ n,m,k`, `n+k ≤ m`, and
  `erdosM m (k+1) < erdosM n k`;
- `erdos678_good_lengths_infinite` proves the set of such valid block lengths is infinite.

E4 mathematical exit: `54fe163f8a70b736255bea7ffc1a4cf8d4fcb941`, run `31976903757`, `No update necessary`, **8806 jobs**.

---

# Current position

```text
Erdős #678
├── Arithmetic core .............................. PASSED
├── Cambie Claim 5 ............................... PASSED
├── Claim 4 / CRT engine ......................... PASSED
└── Quantitative finish .......................... PASSED
    ├── E1 LCM-ratio estimate .................... PASSED
    ├── E2 sharp prime-density existence ......... PASSED
    ├── E3 strong Cambie theorem ................. PASSED
    └── E4 canonical #678 + infinitude ........... PASSED
```

## Sole next action

Synchronize all status documentation on the E4 PR, obtain one final green canonical CI for that documentation head, then perform stacked-PR review/integration. Do not reopen the mathematical proof unless a concrete regression is found.

## Global audit gates

- state documents and CI must agree before merge/integration;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
