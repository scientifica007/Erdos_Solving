import Formalization.Erdos678.Claim4Weighted
import Mathlib.Data.Int.GCD
import Mathlib.Data.Nat.ChineseRemainder

/-!
Concrete CRT-basis producers for Cambie's Claim 4.

The weighted consumer introduced earlier deliberately required an explicit
`Claim4WeightedRepresentation` contract.  This file begins discharging that
contract for the actual CRT basis.  For two coprime coordinates `p` and `q`,
the weights are `q` and `p`; inverse multipliers are constructed from
coprimality and the resulting weighted combination represents every residue
modulo `p * q`.
-/

namespace Erdos678

/-- The two coordinate moduli. -/
def claim4PairPrime (p q : ℕ) : Fin 2 → ℕ := ![p, q]

/-- The standard two-coordinate CRT weights for modulus `p * q`. -/
def claim4PairWeight (p q : ℕ) : Fin 2 → ℕ := ![q, p]

/-- The inverse multipliers attached to the two CRT weights. -/
def claim4PairMultiplier (cp cq : ℕ) : Fin 2 → ℕ := ![cp, cq]

/-- Scaling an inverse coordinate by `z` still contributes `z` modulo that
coordinate modulus, even after replacing the coefficient by its canonical
remainder. -/
theorem claim4_scaled_coordinate_modEq
    {p c weight z : ℕ} (hinverse : c * weight ≡ 1 [MOD p]) :
    ((z * c) % p) * weight ≡ z [MOD p] := by
  calc
    ((z * c) % p) * weight ≡ (z * c) * weight [MOD p] :=
      (Nat.mod_modEq (z * c) p).mul_right weight
    _ = z * (c * weight) := by ac_rfl
    _ ≡ z * 1 [MOD p] := hinverse.mul_left z
    _ = z := by simp

/-- A weighted coordinate vanishes modulo `p` whenever its weight contains
`p` as a factor. -/
theorem claim4_weighted_coordinate_modEq_zero
    {p value weight : ℕ} (hweight : p ∣ weight) :
    value * weight ≡ 0 [MOD p] :=
  Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hweight value)

/-- The explicit two-coordinate CRT sum represents `z` modulo `p * q`. -/
theorem claim4_pair_weighted_modEq
    {p q cp cq z : ℕ}
    (hpq : p.Coprime q)
    (hcp : cp * q ≡ 1 [MOD p])
    (hcq : cq * p ≡ 1 [MOD q]) :
    ((z * cp) % p) * q + ((z * cq) % q) * p ≡ z [MOD p * q] := by
  apply (Nat.modEq_and_modEq_iff_modEq_mul hpq).mpr
  constructor
  · calc
      ((z * cp) % p) * q + ((z * cq) % q) * p ≡ z + 0 [MOD p] :=
        (claim4_scaled_coordinate_modEq hcp).add
          (claim4_weighted_coordinate_modEq_zero (dvd_refl p))
      _ = z := by simp
  · calc
      ((z * cp) % p) * q + ((z * cq) % q) * p ≡ 0 + z [MOD q] :=
        (claim4_weighted_coordinate_modEq_zero (dvd_refl q)).add
          (claim4_scaled_coordinate_modEq hcq)
      _ = z := by simp

/-- The standard pair weights satisfy the weighted representation contract
once their coordinate multipliers are inverses. -/
theorem claim4_pair_weightedRepresentation_of_inverses
    {p q cp cq : ℕ}
    (hpq : p.Coprime q)
    (hcp : cp * q ≡ 1 [MOD p])
    (hcq : cq * p ≡ 1 [MOD q]) :
    Claim4WeightedRepresentation
      (Finset.univ : Finset (Fin 2))
      (claim4PairPrime p q)
      (claim4PairMultiplier cp cq)
      (claim4PairWeight p q)
      (p * q) := by
  intro z
  simpa [claim4WeightedCombination, claim4PairPrime, claim4PairMultiplier,
    claim4PairWeight, Fin.sum_univ_two] using
    (claim4_pair_weighted_modEq hpq hcp hcq (z := z))

/-- An inverse multiplier cannot be divisible by its prime coordinate. -/
theorem claim4_not_dvd_multiplier_of_inverse
    {p c weight : ℕ} (hp : Nat.Prime p)
    (hinverse : c * weight ≡ 1 [MOD p]) :
    ¬p ∣ c := by
  apply hp.coprime_iff_not_dvd.mp
  exact (Nat.coprime_of_mul_modEq_one weight hinverse).symm

/-- Prime and coprimality data produce actual pair CRT multipliers, including
the nondivisibility facts needed by the density theorem. -/
theorem exists_claim4_pair_crt_multipliers
    {p q : ℕ} (hp : Nat.Prime p) (hq : Nat.Prime q)
    (hpq : p.Coprime q) :
    ∃ cp cq : ℕ,
      cp < p ∧ cq < q ∧
      (∀ i : Fin 2,
        ¬claim4PairPrime p q i ∣ claim4PairMultiplier cp cq i) ∧
      Claim4WeightedRepresentation
        (Finset.univ : Finset (Fin 2))
        (claim4PairPrime p q)
        (claim4PairMultiplier cp cq)
        (claim4PairWeight p q)
        (p * q) := by
  obtain ⟨cp, hcp_lt, hcp_mod⟩ :=
    Nat.exists_mul_mod_eq_one_of_coprime hpq.symm hp.one_lt
  obtain ⟨cq, hcq_lt, hcq_mod⟩ :=
    Nat.exists_mul_mod_eq_one_of_coprime hpq hq.one_lt
  have hcp : cp * q ≡ 1 [MOD p] := by
    simpa [Nat.ModEq, Nat.mul_comm, Nat.mod_eq_of_lt hp.one_lt] using hcp_mod
  have hcq : cq * p ≡ 1 [MOD q] := by
    simpa [Nat.ModEq, Nat.mul_comm, Nat.mod_eq_of_lt hq.one_lt] using hcq_mod
  refine ⟨cp, cq, hcp_lt, hcq_lt, ?_,
    claim4_pair_weightedRepresentation_of_inverses hpq hcp hcq⟩
  intro i
  fin_cases i
  · simpa [claim4PairPrime, claim4PairMultiplier] using
      (claim4_not_dvd_multiplier_of_inverse hp hcp)
  · simpa [claim4PairPrime, claim4PairMultiplier] using
      (claim4_not_dvd_multiplier_of_inverse hq hcq)

/-- Pair-coordinate density with the concrete CRT producer internalized: the
caller supplies primes, coprimality, interval bounds, and exclusions, but no
weighted-representation assumption. -/
theorem claim4_pair_crt_density
    {p q start len : ℕ}
    (excluded : Fin 2 → Finset ℕ)
    (hp : Nat.Prime p) (hq : Nat.Prime q)
    (hpq : p.Coprime q)
    (hlenp : len ≤ p) (hlenq : len ≤ q)
    (hbudget : ∑ i : Fin 2, (excluded i).card < len) :
    ∃ c : Fin 2 → ℕ,
      (∀ i : Fin 2, ¬claim4PairPrime p q i ∣ c i) ∧
      ∃ z ∈ Finset.Ico start (start + len),
        (∀ i ∈ (Finset.univ : Finset (Fin 2)),
          (z * c i) % claim4PairPrime p q i ∉ excluded i) ∧
        claim4WeightedCombination (Finset.univ : Finset (Fin 2))
          (fun i => (z * c i) % claim4PairPrime p q i)
          (claim4PairWeight p q) ≡ z [MOD p * q] := by
  obtain ⟨cp, cq, hcp_lt, hcq_lt, hc, hrep⟩ :=
    exists_claim4_pair_crt_multipliers hp hq hpq
  let c := claim4PairMultiplier cp cq
  refine ⟨c, ?_, ?_⟩
  · simpa [c] using hc
  · apply claim4_weighted_density_of_representation
      (indices := (Finset.univ : Finset (Fin 2)))
      (p := claim4PairPrime p q)
      (c := c)
      (weight := claim4PairWeight p q)
      (totalModulus := p * q)
      (start := start)
      (len := len)
      (excluded := excluded)
    · intro i hi
      fin_cases i
      · simpa [claim4PairPrime] using hp
      · simpa [claim4PairPrime] using hq
    · intro i hi
      exact (by simpa [c] using hc i)
    · intro i hi
      fin_cases i
      · simpa [claim4PairPrime] using hlenp
      · simpa [claim4PairPrime] using hlenq
    · simpa using hbudget
    · simpa [c] using hrep

end Erdos678
