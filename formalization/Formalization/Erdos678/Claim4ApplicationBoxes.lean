import Formalization.Erdos678.Claim4CRT

/-!
Application residue boxes for Cambie's Claim 4.

The paper writes coordinate coefficients in `{1, ..., p}`, with `p`
representing residue zero.  Lean's modular layer uses canonical residues in
`{0, ..., p - 1}`.  This file makes that translation explicit, defines the
exact excluded sets for the `x` and `y` boxes, computes their cardinalities,
and instantiates the verified pair/triple CRT density endpoints.
-/

namespace Erdos678

/-- Translate a canonical residue to Cambie's coefficient convention
`{1, ..., p}`, in which `p` represents residue zero. -/
def claim4PaperCoefficient (p a : ℕ) : ℕ :=
  if a = 0 then p else a

/-- The paper coefficient represents the same residue as its canonical input. -/
theorem claim4PaperCoefficient_modEq (p a : ℕ) :
    claim4PaperCoefficient p a ≡ a [MOD p] := by
  by_cases ha : a = 0
  · subst a
    simp [claim4PaperCoefficient, Nat.ModEq]
  · simp only [claim4PaperCoefficient, if_neg ha]
    exact Nat.ModEq.refl a

/-- A canonical residue modulo a positive modulus translates into the closed
coefficient interval `{1, ..., p}`. -/
theorem claim4PaperCoefficient_bounds
    {p a : ℕ} (hp : 0 < p) (ha : a < p) :
    1 ≤ claim4PaperCoefficient p a ∧ claim4PaperCoefficient p a ≤ p := by
  by_cases ha0 : a = 0
  · subst a
    simp [claim4PaperCoefficient]
    omega
  · simp [claim4PaperCoefficient, ha0]
    omega

/-- Canonical residues excluded from Cambie's `x` box
`1 ≤ a ≤ p - (k mod p)`.

When `k mod p = 0`, the paper endpoint `p` represents residue zero, so the
canonical box contains every residue and the exclusion set is empty. -/
def claim4XExcluded (k p : ℕ) : Finset ℕ :=
  if k % p = 0 then ∅
  else insert 0 (Finset.Ico (p - k % p + 1) p)

/-- Canonical residues excluded from Cambie's `y` box
`p - (k mod p) ≤ b ≤ p`; the endpoint `p` is residue zero. -/
def claim4YExcluded (k p : ℕ) : Finset ℕ :=
  Finset.Ico 1 (p - k % p)

/-- Avoiding the canonical `x` exclusion set is exactly membership in the
paper's coefficient interval. -/
theorem claim4_not_mem_xExcluded_iff
    {k p a : ℕ} (hp : 0 < p) (ha : a < p) :
    a ∉ claim4XExcluded k p ↔
      1 ≤ claim4PaperCoefficient p a ∧
        claim4PaperCoefficient p a ≤ p - k % p := by
  have hrlt : k % p < p := Nat.mod_lt k hp
  by_cases hr0 : k % p = 0
  · by_cases ha0 : a = 0
    · simp [claim4XExcluded, claim4PaperCoefficient, hr0, ha0]
      omega
    · simp [claim4XExcluded, claim4PaperCoefficient, hr0, ha0]
      omega
  · by_cases ha0 : a = 0
    · simp [claim4XExcluded, claim4PaperCoefficient, hr0, ha0]
      omega
    · simp [claim4XExcluded, claim4PaperCoefficient, hr0, ha0, ha]
      omega

/-- Avoiding the canonical `y` exclusion set is exactly membership in the
paper's coefficient interval. -/
theorem claim4_not_mem_yExcluded_iff
    {k p a : ℕ} (hp : 0 < p) (ha : a < p) :
    a ∉ claim4YExcluded k p ↔
      p - k % p ≤ claim4PaperCoefficient p a ∧
        claim4PaperCoefficient p a ≤ p := by
  have hrlt : k % p < p := Nat.mod_lt k hp
  by_cases ha0 : a = 0
  · simp [claim4YExcluded, claim4PaperCoefficient, ha0]
  · simp [claim4YExcluded, claim4PaperCoefficient, ha0]
    omega

/-- The `x` box excludes exactly `k mod p` canonical residues. -/
theorem claim4XExcluded_card
    {k p : ℕ} (hp : 0 < p) :
    (claim4XExcluded k p).card = k % p := by
  have hrlt : k % p < p := Nat.mod_lt k hp
  by_cases hr0 : k % p = 0
  · simp [claim4XExcluded, hr0]
  · have hzero : 0 ∉ Finset.Ico (p - k % p + 1) p := by
      simp
    simp [claim4XExcluded, hr0, hzero, Nat.card_Ico]
    omega

/-- The `y` box excludes exactly `p - (k mod p) - 1` canonical residues. -/
theorem claim4YExcluded_card
    {k p : ℕ} (_hp : 0 < p) :
    (claim4YExcluded k p).card = p - k % p - 1 := by
  simp [claim4YExcluded, Nat.card_Ico]

/-- Coordinate exclusions for the two-prime `y` application. -/
def claim4PairYExcluded (k p q : ℕ) : Fin 2 → Finset ℕ :=
  ![claim4YExcluded k p, claim4YExcluded k q]

/-- The smallest search length obtained directly from the strict union bound
for the two-prime `y` box. -/
def claim4PairYSearchLength (k p q : ℕ) : ℕ :=
  (p - k % p - 1) + (q - k % q - 1) + 1

/-- Coordinate exclusions for the three-prime `x` application. -/
def claim4TripleXExcluded (k p q r : ℕ) : Fin 3 → Finset ℕ :=
  ![claim4XExcluded k p, claim4XExcluded k q, claim4XExcluded k r]

/-- The smallest search length obtained directly from the strict union bound
for the three-prime `x` box. -/
def claim4TripleXSearchLength (k p q r : ℕ) : ℕ :=
  k % p + k % q + k % r + 1

/-- Cambie's two-prime `y` box instantiated through the concrete pair CRT
producer.  No representation or exclusion-budget assumption remains: the
caller supplies only the prime/coprimality data and verifies that the exact
search length fits inside each prime coordinate. -/
theorem claim4_pair_y_box_density
    {k p q start : ℕ}
    (hp : Nat.Prime p) (hq : Nat.Prime q)
    (hpq : p.Coprime q)
    (hlenp : claim4PairYSearchLength k p q ≤ p)
    (hlenq : claim4PairYSearchLength k p q ≤ q) :
    ∃ c : Fin 2 → ℕ,
      (∀ i : Fin 2, ¬claim4PairPrime p q i ∣ c i) ∧
      ∃ z ∈ Finset.Ico start (start + claim4PairYSearchLength k p q),
        (∀ i : Fin 2,
          claim4PairPrime p q i - k % claim4PairPrime p q i ≤
              claim4PaperCoefficient (claim4PairPrime p q i)
                ((z * c i) % claim4PairPrime p q i) ∧
            claim4PaperCoefficient (claim4PairPrime p q i)
                ((z * c i) % claim4PairPrime p q i) ≤
              claim4PairPrime p q i) ∧
        claim4WeightedCombination (Finset.univ : Finset (Fin 2))
          (fun i => (z * c i) % claim4PairPrime p q i)
          (claim4PairWeight p q) ≡ z [MOD p * q] := by
  have hbudget :
      ∑ i : Fin 2, (claim4PairYExcluded k p q i).card <
        claim4PairYSearchLength k p q := by
    simp [claim4PairYExcluded, Fin.sum_univ_two,
      claim4YExcluded_card (k := k) (p := p) hp.pos,
      claim4YExcluded_card (k := k) (p := q) hq.pos,
      claim4PairYSearchLength]
  rcases claim4_pair_crt_density
      (p := p) (q := q) (start := start)
      (len := claim4PairYSearchLength k p q)
      (excluded := claim4PairYExcluded k p q)
      hp hq hpq hlenp hlenq hbudget with
    ⟨c, hc, z, hz, hallowed, hrep⟩
  refine ⟨c, hc, z, hz, ?_, hrep⟩
  intro i
  have hi := hallowed i (Finset.mem_univ i)
  fin_cases i
  · have hlt : (z * c 0) % p < p := Nat.mod_lt _ hp.pos
    have hnot : (z * c 0) % p ∉ claim4YExcluded k p := by
      simpa [claim4PairYExcluded, claim4PairPrime] using hi
    simpa [claim4PairPrime] using
      (claim4_not_mem_yExcluded_iff
        (k := k) (p := p) (a := (z * c 0) % p) hp.pos hlt).mp hnot
  · have hlt : (z * c 1) % q < q := Nat.mod_lt _ hq.pos
    have hnot : (z * c 1) % q ∉ claim4YExcluded k q := by
      simpa [claim4PairYExcluded, claim4PairPrime] using hi
    simpa [claim4PairPrime] using
      (claim4_not_mem_yExcluded_iff
        (k := k) (p := q) (a := (z * c 1) % q) hq.pos hlt).mp hnot

/-- Cambie's three-prime `x` box instantiated through the concrete triple CRT
producer, with the exact exclusion budget internalized. -/
theorem claim4_triple_x_box_density
    {k p q r start : ℕ}
    (hp : Nat.Prime p) (hq : Nat.Prime q) (hr : Nat.Prime r)
    (hpq : p.Coprime q) (hpr : p.Coprime r) (hqr : q.Coprime r)
    (hlenp : claim4TripleXSearchLength k p q r ≤ p)
    (hlenq : claim4TripleXSearchLength k p q r ≤ q)
    (hlenr : claim4TripleXSearchLength k p q r ≤ r) :
    ∃ c : Fin 3 → ℕ,
      (∀ i : Fin 3, ¬claim4TriplePrime p q r i ∣ c i) ∧
      ∃ z ∈ Finset.Ico start (start + claim4TripleXSearchLength k p q r),
        (∀ i : Fin 3,
          1 ≤ claim4PaperCoefficient (claim4TriplePrime p q r i)
                ((z * c i) % claim4TriplePrime p q r i) ∧
            claim4PaperCoefficient (claim4TriplePrime p q r i)
                ((z * c i) % claim4TriplePrime p q r i) ≤
              claim4TriplePrime p q r i -
                k % claim4TriplePrime p q r i) ∧
        claim4WeightedCombination (Finset.univ : Finset (Fin 3))
          (fun i => (z * c i) % claim4TriplePrime p q r i)
          (claim4TripleWeight p q r) ≡ z [MOD (p * q) * r] := by
  have hbudget :
      ∑ i : Fin 3, (claim4TripleXExcluded k p q r i).card <
        claim4TripleXSearchLength k p q r := by
    simp [claim4TripleXExcluded, Fin.sum_univ_three,
      claim4XExcluded_card (k := k) (p := p) hp.pos,
      claim4XExcluded_card (k := k) (p := q) hq.pos,
      claim4XExcluded_card (k := k) (p := r) hr.pos,
      claim4TripleXSearchLength]
  rcases claim4_triple_crt_density
      (p := p) (q := q) (r := r) (start := start)
      (len := claim4TripleXSearchLength k p q r)
      (excluded := claim4TripleXExcluded k p q r)
      hp hq hr hpq hpr hqr hlenp hlenq hlenr hbudget with
    ⟨c, hc, z, hz, hallowed, hrep⟩
  refine ⟨c, hc, z, hz, ?_, hrep⟩
  intro i
  have hi := hallowed i (Finset.mem_univ i)
  fin_cases i
  · have hlt : (z * c 0) % p < p := Nat.mod_lt _ hp.pos
    have hnot : (z * c 0) % p ∉ claim4XExcluded k p := by
      simpa [claim4TripleXExcluded, claim4TriplePrime] using hi
    simpa [claim4TriplePrime] using
      (claim4_not_mem_xExcluded_iff
        (k := k) (p := p) (a := (z * c 0) % p) hp.pos hlt).mp hnot
  · have hlt : (z * c 1) % q < q := Nat.mod_lt _ hq.pos
    have hnot : (z * c 1) % q ∉ claim4XExcluded k q := by
      simpa [claim4TripleXExcluded, claim4TriplePrime] using hi
    simpa [claim4TriplePrime] using
      (claim4_not_mem_xExcluded_iff
        (k := k) (p := q) (a := (z * c 1) % q) hq.pos hlt).mp hnot
  · have hlt : (z * c 2) % r < r := Nat.mod_lt _ hr.pos
    have hnot : (z * c 2) % r ∉ claim4XExcluded k r := by
      simpa [claim4TripleXExcluded, claim4TriplePrime] using hi
    simpa [claim4TriplePrime] using
      (claim4_not_mem_xExcluded_iff
        (k := k) (p := r) (a := (z * c 2) % r) hr.pos hlt).mp hnot

end Erdos678
