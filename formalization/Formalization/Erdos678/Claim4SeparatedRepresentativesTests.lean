import Formalization.Erdos678.Claim4SeparatedRepresentatives

/-!
Reachable regressions for the D4e separated-representative endpoint.
-/

namespace Erdos678

/-- A concrete prime-window configuration can be given canonical separated
numerical windows without guessing CRT witnesses. -/
example :
    let Nx := claim4XScale 50 41 43 47
    let Ny := claim4YScale 50 29 31
    let lenx := claim4TripleXSearchLength 50 41 43 47
    let leny := claim4PairYSearchLength 50 29 31
    let xUpper :=
      1 + (claim4SearchStart 0 Nx + lenx) * Nx
    let yLower := xUpper + 50
    let yUpper :=
      (claim4SearchStart yLower Ny + leny) * Ny
    ∃ x y : ℕ,
      0 < x ∧ x < y ∧ x + 50 < y ∧
      0 < x ∧ x < xUpper ∧
      yLower < y ∧ y < yUpper ∧
      Claim5MediumResidues x y 50 ∧
      Claim5SmallResidues x y 50 ∧
      intervalProd y 51 / intervalLCM y 51 =
        intervalLCM 1 50 * (intervalProd x 50 / intervalLCM x 50) := by
  dsimp only
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  apply claim4_exists_separated_claim5_representatives
      (h := h) (hk := by norm_num)
  · exact le_rfl
  · exact le_rfl
  · exact le_rfl

end Erdos678
