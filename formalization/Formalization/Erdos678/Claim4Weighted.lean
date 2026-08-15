import Formalization.Erdos678.Claim4Modular

/-!
Weighted-combination interface for Cambie's Claim 4.

The counting and modular layers select a position whose coordinate residues
are all allowed.  This file records the remaining CRT-facing contract: the
weighted combination built from those scaled residues must represent the
selected position modulo the total modulus.
-/

namespace Erdos678

/-- The weighted sum of a finite coefficient vector. -/
def claim4WeightedCombination
    {ι : Type*} (indices : Finset ι)
    (coeff weight : ι → ℕ) : ℕ :=
  ∑ i ∈ indices, coeff i * weight i

/-- The exact representation property required from a family of CRT weights.

The later CRT-basis layer must prove this predicate; it is not assumed to
follow merely from a suggestive choice of weights. -/
def Claim4WeightedRepresentation
    {ι : Type*} (indices : Finset ι)
    (p c weight : ι → ℕ) (totalModulus : ℕ) : Prop :=
  ∀ z : ℕ,
    claim4WeightedCombination indices
        (fun i => (z * c i) % p i) weight ≡ z [MOD totalModulus]

/-- Weighted-coordinate form of Cambie's Claim 4 under an explicit CRT
representation contract. -/
theorem claim4_weighted_density_of_representation
    {ι : Type*}
    (indices : Finset ι)
    (p c weight : ι → ℕ)
    (totalModulus start len : ℕ)
    (excluded : ι → Finset ℕ)
    (hp : ∀ i ∈ indices, Nat.Prime (p i))
    (hc : ∀ i ∈ indices, ¬p i ∣ c i)
    (hlen : ∀ i ∈ indices, len ≤ p i)
    (hbudget : ∑ i ∈ indices, (excluded i).card < len)
    (hrep : Claim4WeightedRepresentation
      indices p c weight totalModulus) :
    ∃ z ∈ Finset.Ico start (start + len),
      (∀ i ∈ indices, (z * c i) % p i ∉ excluded i) ∧
        claim4WeightedCombination indices
          (fun i => (z * c i) % p i) weight ≡ z [MOD totalModulus] := by
  rcases claim4_prime_coordinate_density
      indices p c start len excluded hp hc hlen hbudget with
    ⟨z, hz, hallowed⟩
  exact ⟨z, hz, hallowed, hrep z⟩

end Erdos678
