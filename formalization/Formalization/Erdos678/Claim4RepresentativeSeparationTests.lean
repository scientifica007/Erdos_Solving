import Formalization.Erdos678.Claim4RepresentativeSeparation

/-!
Reachable regression for the D4e separated-representative endpoint.
-/

namespace Erdos678

/-- The D4e endpoint is nonvacuously reachable from the concrete `k = 50`
prime-window regression once the two canonical search blocks are given explicit
separated numerical windows. -/
example :
    ∃ x y : ℕ,
      0 < x ∧
      x + 50 < y ∧
      Claim5MediumResidues x y 50 ∧
      Claim5SmallResidues x y 50 ∧
      intervalProd y 51 / intervalLCM y 51 =
        intervalLCM 1 50 *
          (intervalProd x 50 / intervalLCM x 50) := by
  have hprime : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  let xUpper :=
    1 +
      (claim4SearchStart 0 (claim4XScale 50 41 43 47) +
          claim4TripleXSearchLength 50 41 43 47) *
        claim4XScale 50 41 43 47
  let yLower := xUpper + 50
  let yUpper :=
    (claim4SearchStart yLower (claim4YScale 50 29 31) +
        claim4PairYSearchLength 50 29 31) *
      claim4YScale 50 29 31
  have hwindow :
      Claim4SeparatedWindowData
        50 41 43 47 29 31 0 xUpper yLower yUpper := by
    constructor
    · simpa [xUpper]
    · simpa [yUpper]
    · simpa [yLower]
  rcases claim4_exists_separated_representatives_with_claim5
      hprime hwindow with
    ⟨x, y, hxpos, hxy, hgap, hxLower, hxUpper,
      hyLower, hyUpper, hmedium, hsmall, hid⟩
  exact ⟨x, y, hxpos, hgap, hmedium, hsmall, hid⟩

end Erdos678
