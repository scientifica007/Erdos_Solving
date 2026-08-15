import Formalization.Erdos678.Claim4Weighted

/-!
Reachable regressions for the weighted representation interface.
-/

namespace Erdos678

/-- The one-coordinate unit weight satisfies the representation contract and
therefore yields the weighted Claim 4 conclusion. -/
example :
    ∃ z ∈ Finset.Ico 8 13,
      (∀ i ∈ ({0} : Finset ℕ),
        (z * (fun _ => 1) i) % (fun _ => 5) i ∉
          (fun _ => ({0, 1} : Finset ℕ)) i) ∧
      claim4WeightedCombination ({0} : Finset ℕ)
          (fun i => (z * (fun _ => 1) i) % (fun _ => 5) i)
          (fun _ => 1) ≡ z [MOD 5] := by
  apply claim4_weighted_density_of_representation
      (indices := ({0} : Finset ℕ))
      (p := fun _ => 5)
      (c := fun _ => 1)
      (weight := fun _ => 1)
      (totalModulus := 5)
      (start := 8)
      (len := 5)
      (excluded := fun _ => ({0, 1} : Finset ℕ))
  · intro i hi
    norm_num
  · intro i hi
    norm_num
  · intro i hi
    norm_num
  · norm_num
  · intro z
    simp [claim4WeightedCombination, Nat.ModEq]

/-- A zero weight does not represent every residue; the representation
contract is a genuine remaining obligation. -/
example :
    ¬ Claim4WeightedRepresentation
      ({0} : Finset ℕ) (fun _ => 5) (fun _ => 1) (fun _ => 0) 5 := by
  intro h
  have h1 := h 1
  norm_num [claim4WeightedCombination, Nat.ModEq] at h1

end Erdos678
