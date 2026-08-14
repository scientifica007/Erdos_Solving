import Formalization.Erdos678.Claim4Density

/-!
Reachable positive and negative regressions for the finite Claim 4 core.
-/

namespace Erdos678

/-- Two singleton exclusions cannot cover five candidate positions. -/
example :
    ∃ z ∈ Finset.range 5,
      ∀ i ∈ ({0, 1} : Finset ℕ), z ∉ ({i} : Finset ℕ) := by
  apply claim4_exists_avoiding_coordinate_exclusions
      (indices := ({0, 1} : Finset ℕ))
      (positions := Finset.range 5)
      (value := fun _ z => z)
      (excluded := fun i => {i})
  · intro i hi a ha b hb hab
    exact hab
  · norm_num

/-- Strictness is necessary: two singleton exclusions can cover two positions. -/
example :
    ¬ (∃ z ∈ Finset.range 2,
      ∀ i ∈ ({0, 1} : Finset ℕ), z ∉ ({i} : Finset ℕ)) := by
  simp
  omega

end Erdos678
