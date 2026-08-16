import Formalization.Erdos678.Claim4DependentPlacement

/-!
Reachable regression for the Cambie-style dependent D4 placement endpoint.
-/

namespace Erdos678

/-- At the concrete `k = 50` prime-window configuration, a deliberately roomy
moving-window contract reaches the dependent placement theorem end-to-end.
The regression checks theorem liveness; the later quantitative layer is still
responsible for Cambie's sharp asymptotic window constants. -/
example :
    ∃ x y : ℕ,
      0 < x ∧
      0 < y ∧
      x + 50 < y ∧
      y < x +
        ((claim4SearchStart
              (1 +
                (claim4SearchStart 0 (claim4XScale 50 41 43 47) +
                    claim4TripleXSearchLength 50 41 43 47) *
                  claim4XScale 50 41 43 47)
              (claim4YScale 50 29 31) +
            claim4PairYSearchLength 50 29 31) *
          claim4YScale 50 29 31) ∧
      Claim5MediumResidues x y 50 ∧
      Claim5SmallResidues x y 50 ∧
      intervalProd y 51 / intervalLCM y 51 =
        intervalLCM 1 50 *
          (intervalProd x 50 / intervalLCM x 50) := by
  have hprime : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  let xBaseUpper :=
    1 +
      (claim4SearchStart 0 (claim4XScale 50 41 43 47) +
          claim4TripleXSearchLength 50 41 43 47) *
        claim4XScale 50 41 43 47
  let yLower := xBaseUpper
  let yUpper :=
    (claim4SearchStart yLower (claim4YScale 50 29 31) +
        claim4PairYSearchLength 50 29 31) *
      claim4YScale 50 29 31
  let gap := yUpper
  have hplace :
      Claim4DependentPlacementData
        50 41 43 47 29 31 yLower yUpper gap := by
    constructor
    · simpa [yUpper]
    · intro y hyLower hyUpper
      have hylegap : y ≤ gap := by
        dsimp [gap]
        exact Nat.le_of_lt hyUpper
      have hsub : y - gap = 0 := Nat.sub_eq_zero_of_le hylegap
      rw [hsub]
      have hbasele : xBaseUpper ≤ y := by
        exact Nat.le_of_lt (by simpa [yLower] using hyLower)
      simpa [xBaseUpper] using hbasele
    · native_decide
  rcases claim4_exists_close_separated_representatives_with_claim5
      hprime hplace with
    ⟨x, y, hxpos, hypos, hxy, hgap, hclose,
      hyLower, hyUpper, hmedium, hsmall, hid⟩
  exact ⟨x, y, hxpos, hypos, hgap, by simpa [gap, yUpper, yLower, xBaseUpper] using hclose,
    hmedium, hsmall, hid⟩

end Erdos678
