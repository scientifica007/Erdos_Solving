import Formalization.Erdos678.Claim4RoomReduction

/-!
Reachable regressions for the D4f width-form room reduction.
-/

namespace Erdos678

/-- A closed `k = 50` width contract reaches the Cambie-style dependent
representative endpoint end-to-end.  The constants here are intentionally
roomy; D4f will replace them by the sharp paper-compatible windows. -/
example :
    ∃ x y : ℕ,
      0 < x ∧
      0 < y ∧
      x + 50 < y ∧
      Claim5MediumResidues x y 50 ∧
      Claim5SmallResidues x y 50 ∧
      intervalProd y 51 / intervalLCM y 51 =
        intervalLCM 1 50 *
          (intervalProd x 50 / intervalLCM x 50) := by
  have hprime : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  let gap :=
    1 +
      (claim4TripleXSearchLength 50 41 43 47 + 1) *
        claim4XScale 50 41 43 47
  let yLower := gap
  let yUpper :=
    yLower +
      (claim4PairYSearchLength 50 29 31 + 1) *
        claim4YScale 50 29 31
  have hwidth :
      Claim4DependentPlacementWidthData
        50 41 43 47 29 31 yLower yUpper gap := by
    constructor
    · simp [yUpper]
    · simp [gap]
    · simp [yLower]
    · decide
  have hplace := hwidth.toDependentPlacementData
  rcases claim4_exists_close_separated_representatives_with_claim5
      hprime hplace with
    ⟨x, y, hxpos, hypos, hxy, hgap, hclose,
      hyLower, hyUpper, hmedium, hsmall, hid⟩
  exact ⟨x, y, hxpos, hypos, hgap, hmedium, hsmall, hid⟩

end Erdos678
