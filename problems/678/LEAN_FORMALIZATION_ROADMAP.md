# Erdős Problem #678 — Canonical Lean Formalization Roadmap

**Status:** ACTIVE — canonical execution roadmap  
**Mode:** reconstruction and independent Lean reimplementation of Cambie (2024), not independent mathematical discovery  
**Code-state basis:** `f1dba040aeeab6a4736ab8226a186d07fe86c4ed`  
**Canonical CI status:** GREEN  
**Verified run:** `31953021835`  
**Verified build:** `mk_all --check` = `No update necessary`; canonical `lake build` = **8754 jobs**  
**Current phase:** Phase D — CRT combinatorial engine  
**Current target:** discharge Cambie's sharp dependent-placement room inequalities  
**Expansion gate:** OPEN for the final D4 room theorem only; Phase E and prime-density closure remain closed

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
- the Claim 4 finite-density, modular, weighted, concrete CRT, application-box, and D3 scaled-interface layers are machine-checked;
- the general-`k` scales `Nx,Ny`, their support/unit conditions, and exact full-scale factorizations are machine-checked;
- a fixed prime-window contract supplies all five search-length and medium-range obligations;
- generic placement and a Cambie-style dependent placement theorem are machine-checked;
- under explicit `Claim4DependentPlacementData`, the live theorem constructs the same representatives `x,y`, proves `x + k < y < x + gap`, and carries them through the complete Claim 5 identity;
- the **sharp room contract itself is not yet proved for Cambie's target ranges**;
- prime-density existence of the five special primes is not formalized;
- the quantitative LCM-ratio finish and full #678 theorem are not formalized.

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

The old consolidation checkpoint is historical; the current credited D4 theorem-and-regression head is `f1dba040...`.

---

# Phase D — Claim 4 / CRT combinatorial engine — CURRENT

## D1 — finite density, modular coordinates, weighted CRT — DONE / MACHINE-CHECKED

Machine-checked:

- strict union bound;
- modular injectivity under nondivisibility;
- prime-coordinate density;
- weighted representation consumer;
- concrete pair/triple CRT basis producers;
- representation contracts and their positive/negative regressions.

## D2 — application residue boxes — DONE / MACHINE-CHECKED

Machine-checked:

- paper coefficient convention `{1,...,p}` with `p` representing residue zero;
- exact `x` and `y` exclusion sets;
- exact excluded cardinalities;
- pair/triple search lengths equal to total exclusions plus one;
- two-prime `y` and three-prime `x` application endpoints.

## D3 — scaled Claim 4 → Claim 5 interface — DONE / MACHINE-CHECKED

Machine-checked:

- `y = z*Ny` and `x = 1 + z*Nx`;
- affine/scaled modular injectivity;
- fixed other-medium coordinate packaging;
- `Claim4SmallPrimeScaleData`;
- derivation of both Claim 5 residue interfaces;
- a reachable regression crossing into the complete Claim 5 identity.

## D4 — actual scales, representatives, and separation — CURRENT

### D4a — constructed scales — DONE / MACHINE-CHECKED

Definitions: `claim4SmallScale`, `claim4Scale`, `claim4XScale`, `claim4YScale`.

Proved:

- every required small-prime power divides both scales;
- every non-special medium prime divides the appropriate scale;
- each special prime is a unit/nondivisor for its free-coordinate scale.

Checkpoint: head `a259da8a...`, run `31947099017`, 8745 jobs.

### D4b — constructed-scale D3 wrapper — DONE / MACHINE-CHECKED

`claim4_exists_claim5_residue_interfaces_of_constructed_scales` automatically discharges D3's scale-support, fixed-coordinate divisibility, and five special-unit premises.

Checkpoint included in `a259da8a...`, run `31947099017`.

### D4c — prime-window contract — DONE / MACHINE-CHECKED

`Claim4PrimeWindowData` isolates:

- two distinct `y` primes in `(k/2, 2k/3]`;
- three pairwise-distinct `x` primes in a fixed near-`k` window.

From this contract Lean derives:

- `k < p²` for all five primes;
- all five exact pair/triple search-length bounds.

No prime-density theorem is imported; existence of such primes for all sufficiently large `k` remains a separate later dependency.

Checkpoint: head `eef7d931...`, run `31948527075`, 8747 jobs.

### D4d — factorization and quantitative placement primitives — DONE / MACHINE-CHECKED

Machine-checked:

- `claim4FullScale`;
- exact factorizations `Nx*(xp*xq*xr)=fullScale` and `Ny*(yp*yq)=fullScale`;
- positivity of the scales;
- canonical `claim4SearchStart`;
- conversion of search membership into lower/upper bounds;
- `claim4_exists_y_box_in_window` and `claim4_exists_x_box_in_window`.

Checkpoint: head `b0914c87...`, run `31949164598`, 8750 jobs.

### D4e — separated representatives and full Claim 5 consumption — DONE / MACHINE-CHECKED

Two live endpoints now exist.

1. `claim4_exists_separated_representatives_with_claim5`
   - takes explicit separated numerical windows;
   - constructs `0 < x < y`;
   - proves `x+k<y`;
   - proves both residue interfaces;
   - invokes the complete Claim 5 identity.

   Checkpoint: head `89f500f7...`, run `31951779394`, 8752 jobs.

2. `claim4_exists_close_separated_representatives_with_claim5`
   - chooses the actual `y` first;
   - then places `x` in a moving interval below that selected `y`;
   - obtains `y < x + gap` from that moving interval;
   - obtains `x+k<y` from the common-small-scale congruences `x ≡ 1`, `y ≡ 0`;
   - feeds the same representatives into both Claim 5 residue interfaces and the full Claim 5 identity.

   Checkpoint: head `72432d4b...`, run `31952559027`, 8754 jobs.  
   Cleanup checkpoint using kernel `decide`: head `f1dba040...`, run `31953021835`, 8754 jobs.

### D4f — sharp Cambie room theorem — CURRENT / LAST D4 OBLIGATION

The remaining object is not another CRT theorem. It is the finite quantitative contract

`Claim4DependentPlacementData k xp xq xr yp yq yLower yUpper gap`.

The exact remaining work is:

1. define division-safe Lean versions of Cambie's target scales:
   - an absolute `y` range compatible with the paper's `M/(5C)(1+1/k) < y < M/(4C)-k`;
   - a closeness gap compatible with `M/(5Ck)`;
2. reduce `y_room` to a bound on the two-prime search-block width using `Ny*(yp*yq)=fullScale`;
3. reduce the moving `x_room` to a bound on the three-prime search-block width using `Nx*(xp*xq*xr)=fullScale`;
4. prove the general small-scale gap `claim4SmallScale k` large enough to force `m-1>k`;
5. discharge those inequalities under explicit sufficiently-large-`k` assumptions;
6. instantiate the dependent endpoint with those sharp parameters;
7. add boundary regressions and pass exact-head CI.

### D4 exit gate

D4 is complete only when a reachable theorem supplies the **actual sharp dependent placement data** and invokes the verified close-and-separated Claim 5 endpoint, with exact-head CI green.

Do not mark D4 complete merely because the conditional endpoint exists.

---

# Phase E — Quantitative finish — PENDING / CLOSED

## E1 — LCM-ratio estimate

Formalize the transformation from Claim 5 to `LCM_x / LCM_y = M * product_x / product_y` and the lower bound driven by the verified size/closeness inequalities.

## E2 — prime-density dependency

Formalize or import the theorem producing two suitable primes near `k/2` and three suitable primes near `k` for all sufficiently large `k`.

This dependency must remain explicit; do not smuggle it into D4 as an axiom.

## E3 — strong Cambie theorem

For every fixed `C ≥ 1` and all sufficiently large `k`, construct `x,y` with `0 < x < y`, `y > x+k`, and `LCM_x > C*LCM_y`.

## E4 — Erdős #678

Take `C=1` and translate `n=x-1`, `m=y-1`.

---

# Current position

```text
Erdős #678
├── Consolidation gate ........................... PASSED
├── Arithmetic core .............................. PASSED
├── Cambie Claim 5 ............................... PASSED
└── Claim 4 / CRT engine .......................... CURRENT
    ├── D1: finite/modular/weighted CRT .......... MACHINE-CHECKED
    ├── D2: application residue boxes ............ MACHINE-CHECKED
    ├── D3: Claim 5 interface connection ......... MACHINE-CHECKED
    ├── D4a: constructed scales .................. MACHINE-CHECKED
    ├── D4b: constructed-scale wrapper ........... MACHINE-CHECKED
    ├── D4c: prime-window/search budgets ......... MACHINE-CHECKED
    ├── D4d: factorization/placement primitives .. MACHINE-CHECKED
    ├── D4e: close + separated representatives ... MACHINE-CHECKED UNDER ROOM CONTRACT
    └── D4f: sharp Cambie room theorem ............ CURRENT
```

## Sole next action

Prove `Claim4DependentPlacementData` for Cambie's actual target windows from the current scale factorization, search-length bounds, and explicit sufficiently-large-`k` inequalities. Keep special-prime **existence** as the separate prime-density dependency. Do not open Phase E until the D4f theorem and its regressions pass canonical exact-head CI.

## Global audit gates

- state documents and CI must agree before work resumes;
- exact interval lengths and endpoints before algebra;
- no guessed scaling or translation identity;
- no hidden `sorry`, new axiom, or uncredited assumption;
- a new module must be imported before a green run can validate it;
- CI success is credited only to the exact reachable statements;
- discovery, reconstruction, and formal verification remain distinct classifications.
