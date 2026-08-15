# Erdős Problem #678 — Cambie Proof Analysis

## Status

The independent construction attempted in our experiment was rejected. The concrete witness `M(36,8) > M(47,9)` is machine-verified, but it does not by itself yield infinitely many solutions.

This document records the mathematical structure of Cambie's 2024 proof. It is an analysis/reference document, not a task tracker and not a claim of an independent new proof.

The Claim 4 audit in this document is synchronized through the concrete pair/triple application residue boxes at code commit `b2a05790b4ae466133e792ca6afa3eae730c0427`. Canonical CI run `31870476963` passed the generated graph check and the full 8739-job build for that theorem-and-regression head.

**Canonical execution roadmap:** `LEAN_FORMALIZATION_ROADMAP.md`.

## 1. Stronger theorem actually proved

Cambie proves the stronger statement: for every constant `C >= 1`, for all sufficiently large `k`, there exist `0 < x < y` with `y > x + k` such that

`lcm{x,...,x+k-1} > C * lcm{y,...,y+k}`.

Thus Erdős #678 follows immediately by taking `C = 1` and translating

`n = x - 1`, `m = y - 1`.

Source: S. Cambie, *Resolution of an Erdős' problem on least common multiples*, arXiv:2410.09138 (2024).

## 2. Core mechanism

The proof does **not** scale one concrete witness. Instead it chooses `x` and `y` simultaneously by prescribing their residues modulo prime powers.

Set

`M = lcm(1,2,...,k)`

and decompose it as

`M = m * product_{sqrt(k) < p <= k} p`

where

`m = product_{p <= sqrt(k)} p^(floor(log_p k))`.

For primes `sqrt(k) < p <= k`, the proof defines admissible residue intervals for `x mod p` and `y mod p` so that the numbers of multiples of `p` in the two consecutive intervals differ in exactly the desired direction.

The small-prime part is controlled by requiring

`x ≡ 1 (mod m)` and `y ≡ 0 (mod m)`.

The large-prime residue constraints are then combined with the Chinese Remainder Theorem.

## 3. Claim 4 — density of CRT-generated residues

### Exact mathematical content

In the paper, Claim 4 has the following data and conclusion.

- Let `p₁ < ... < pᵣ` be primes and put `P = ∏ᵢ pᵢ`.
- Fix integer weights `wᵢ` such that the weighted combinations `∑ᵢ cᵢ wᵢ`, with `0 < cᵢ ≤ pᵢ`, cover every residue modulo `P`.
- For every coordinate choose `Bᵢ ⊆ {1,...,pᵢ}` with `|Bᵢ| ≥ (1-ε)pᵢ`.
- If `ε ∑ᵢ pᵢ < n ≤ p₁`, then every block of `n` consecutive integers contains a residue modulo `P` represented by a weighted combination whose every coefficient lies in its corresponding `Bᵢ`.

The coefficient convention `{1,...,pᵢ}` encodes residue zero by `pᵢ`. The Lean layer instead uses residues in `Finset.range (p i)`; the two conventions are equivalent but must not be mixed silently.

### Proof mechanism and hidden obligations made explicit

1. The coefficient domain has exactly `P` elements, as does the residue space modulo `P`. Therefore the assumed coverage is a surjection between finite sets of equal cardinality and hence a bijection. In particular the residue `1` has a unique coefficient vector.
2. Multiply that vector coordinatewise by each consecutive integer `z`. The representation of `1` then transports the weighted combination to the residue `z` modulo `P`.
3. In coordinate `i`, the map `z ↦ z*cᵢ mod pᵢ` must be injective on a block of length at most `pᵢ`. This needs `cᵢ` to be a unit modulo `pᵢ`; it is a real arithmetic obligation, not a consequence to leave implicit in formal code.
4. Injectivity implies that coordinate `i` rejects at most the number of excluded residues in that coordinate.
5. The union of all rejected-position sets has cardinality strictly below `n`, so at least one position is accepted in every coordinate.

For the actual CRT basis, the unit obligation follows by reducing the inverse congruence in each prime coordinate. The generic modular implementation exposes it as the explicit premise `¬ p i ∣ c i`; the verified pair/triple producers now construct the inverses and discharge that premise rather than relying on an informal inference.

### Current Lean boundary

The canonical graph now machine-checks five layers:

- `claim4_exists_avoiding_coordinate_exclusions`: the generic finite injection plus strict union-bound argument;
- `claim4_prime_coordinate_density`: the modular specialization for prime coordinates, nondivisible multipliers, and a consecutive interval no longer than each prime;
- `claim4_weighted_density_of_representation`: the weighted conclusion under the explicit producer contract `Claim4WeightedRepresentation`.
- `claim4_pair_crt_density` and `claim4_triple_crt_density`: the concrete two-/three-prime producers and density endpoints, with the representation contract and nondivisibility proofs internalized.
- `claim4_pair_y_box_density` and `claim4_triple_x_box_density`: the exact two-prime `y` and three-prime `x` application boxes, with the strict exclusion budgets internalized.

The generic formal theorem uses the sharper integer condition

`∑ᵢ |excludedᵢ| < n`

instead of introducing real-valued `ε`. The application layer now proves the exact excluded cardinalities and chooses the search length as their sum plus one, so strictness is discharged arithmetically rather than through a floating-point or real-valued estimate.

The concrete definitions now use weights `q,p` for modulus `p*q` and `q*r,p*r,p*q` for modulus `(p*q)*r`. Pairwise coprimality supplies coordinate inverses; local congruences are combined to prove `Claim4WeightedRepresentation`, and the inverse equations also prove that the multipliers are nonzero modulo their coordinate primes. This is machine-checked for exactly the two arities used in the applications.

The application layer also makes the paper's endpoint convention executable. `claim4PaperCoefficient p 0 = p`, while every nonzero canonical residue is left unchanged. For the `x` interval `1 ≤ a ≤ p - (k mod p)`, the canonical exclusion set has exactly `k mod p` elements. For the `y` interval `p - (k mod p) ≤ b ≤ p`, it has exactly `p - (k mod p) - 1` elements; the upper endpoint `p` is canonical residue zero and is therefore allowed. These exact counts feed the triple and pair density endpoints respectively.

What is **not** yet proved:

- the translation of the selected representatives into the two Claim 5 residue interfaces;
- the quantitative bounds and separation needed to realize the final `x,y` construction;
- a generic arbitrary-finite-family CRT-basis theorem.

Therefore the pair/triple producer and application-box boundary is complete, but Claim 4's role in the #678 reconstruction is still only partially formalized until D3 connects those outputs to Claim 5 and D4 supplies quantitative representatives.

## 4. Choice of x and y

Using prime-density results, Cambie chooses:

- two primes just above `k/2` to construct a suitable `y` in a controlled size range;
- three primes just below `k` to construct an `x < y` with `y-x > k` and with `x` close enough to `y`.

The exact quantitative bounds are chosen so that the final LCM ratio exceeds the arbitrary constant `C`.

Thus the infinitude mechanism is:

`large k -> prime-density window -> CRT residue system -> x,y -> exact p-adic identity -> size estimate`.

It is **not** a transformation of one fixed solution.

## 5. Claim 5 — central arithmetic identity

The key identity is

`[ y(y+1)...(y+k) / lcm(y,...,y+k) ]`

`=`

`[ M * x(x+1)...(x+k-1) / lcm(x,...,x+k-1) ]`.

Equivalently, the reciprocal-LCM factors of the two intervals differ by exactly `M = lcm(1,...,k)`.

Cambie proves this by comparing the `p`-adic valuation of both sides for every prime `p`.

### Small primes `p <= sqrt(k)`

Since an interval of length `k` or `k+1` contains at most one multiple of `p^(floor(log_p k)+1)`, the capped valuation contributed by the LCM can be controlled explicitly. The congruences

`x ≡ y+1 ≡ 1 (mod m)`

make the corresponding capped valuation sums match.

### Large primes `sqrt(k) < p <= k`

There is at most one multiple of `p^2` in the relevant intervals. Therefore it is enough to compare the number of multiples of `p` in the two interval numerators. The admissible residue intervals for `x mod p` and `y mod p` were designed precisely to force equality of the valuations after inserting the factor `M`.

### Primes `p > k`

They occur at most once in either interval, so their contribution to the reciprocal-LCM factors is zero.

The repository now machine-checks this Claim 5 architecture under two explicit residue interfaces. The Claim 4 application boxes are verified, but the interface-packaging theorem that connects their outputs to this Claim 5 architecture remains the current boundary.

## 6. Final analytic/combinatorial estimate

From Claim 5, Cambie obtains

`lcm{x,...,x+k-1} / lcm{y,...,y+k}`

`= M * x(x+1)...(x+k-1) / [y(y+1)...(y+k)]`.

The selected ranges for `x` and `y` imply a lower bound of the form

`M/(y+k) * (x/y)^k`,

which is then bounded below by a quantity exceeding arbitrary fixed `C` for sufficiently large `k`.

This is the quantitative reason that a single construction yields infinitely many triples: the construction works for every sufficiently large `k`, not because one witness can be scaled.

## 7. Prime-density dependency

The published proof uses density of primes in intervals around `k/2` and near `k` (citing Baker–Harman–Pintz). The later Lean formalization reported on ErdősProblems uses a conditional Prime Number Theorem hypothesis `pi_alt`; the site notes that the formalized theorem is therefore conditional on that hypothesis unless the relevant PNT results are imported from PNT+.

Therefore we must distinguish:

- **Mathematical proof in Cambie's paper:** unconditional, using the cited prime-density input.
- **Reported online Lean formalization:** conditional on a PNT-style axiom/hypothesis in the posted version unless the missing prime-density theorem is supplied formally.

## 8. Formalization decomposition — mathematical dependency view

This section describes dependency structure only. Operational status and next actions belong exclusively to `LEAN_FORMALIZATION_ROADMAP.md`.

The mathematical dependency order is:

1. finite consecutive blocks, products, and LCMs;
2. prime-adic valuation of products and LCMs;
3. reciprocal-LCM valuation;
4. Claim 5 split into the three prime ranges;
5. Claim 4 finite counting and modular density;
6. concrete pair/triple CRT-basis representation;
7. residue-box construction for `x` and `y`;
8. connection of the selected data to the Claim 5 residue interfaces;
9. quantitative LCM-ratio estimate;
10. exact prime-density input;
11. strong Cambie theorem;
12. deduction of Erdős #678.

## 9. Lessons from our failed attempt

The failed `Q`-ratio construction had the right high-level instinct — compare product/LCM factors prime-by-prime — but attempted to force a global identity from a single CRT parameter `t`. The fatal issue was interval indexing:

`M(t,k+1) = lcm(t+1,...,t+k+1)`,

not `lcm(t,...,t+k)`.

Cambie's proof avoids this trap by constructing **two different endpoints `x` and `y`** and proving the exact valuation identity directly.

This is a major methodological lesson: when working with interval operators, formalize interval length/endpoints first and only then derive algebraic identities.
