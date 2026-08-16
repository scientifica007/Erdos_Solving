import Formalization.Erdos678.Claim4Placement

/-!
Reachable regressions for exact scale factorization and canonical D4 search
placement.
-/

namespace Erdos678

/-- The generic multiplicative placement arithmetic is nonvacuous. -/
example :
    10 < 3 * 7 ∧ 3 * 7 < 40 := by
  apply claim4_mul_bounds_of_mem_search
      (lower := 10) (upper := 40) (scale := 7) (len := 3) (z := 3)
  · norm_num
  · norm_num [claim4SearchStart]
  · norm_num [claim4SearchStart]

/-- The affine placement arithmetic is also nonvacuous. -/
example :
    10 < 1 + 3 * 7 ∧ 1 + 3 * 7 < 41 := by
  apply claim4_one_add_mul_bounds_of_mem_search
      (lower := 10) (upper := 41) (scale := 7) (len := 3) (z := 3)
  · norm_num
  · norm_num [claim4SearchStart]
  · norm_num [claim4SearchStart]

/-- Concrete prime-window data expose the exact `Nx` factorization. -/
example :
    claim4XScale 50 41 43 47 * (41 * 43 * 47) = claim4FullScale 50 := by
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  exact h.xScale_mul_specials_eq_full

/-- Concrete prime-window data expose the exact `Ny` factorization. -/
example :
    claim4YScale 50 29 31 * (29 * 31) = claim4FullScale 50 := by
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  exact h.yScale_mul_specials_eq_full

/-- The canonical `y` search interval reaches the scaled residue box when its
upper endpoint is chosen to contain the whole block. -/
example :
    let Ny := claim4YScale 50 29 31
    let len := claim4PairYSearchLength 50 29 31
    ∃ z ∈ Finset.Ico (claim4SearchStart 0 Ny)
        (claim4SearchStart 0 Ny + len),
      0 < z * Ny ∧
        z * Ny < (claim4SearchStart 0 Ny + len) * Ny ∧
        ∀ i : Fin 2,
          claim4PairPrime 29 31 i - 50 % claim4PairPrime 29 31 i ≤
              claim4PaperCoefficient (claim4PairPrime 29 31 i)
                ((z * Ny) % claim4PairPrime 29 31 i) ∧
            claim4PaperCoefficient (claim4PairPrime 29 31 i)
                ((z * Ny) % claim4PairPrime 29 31 i) ≤
              claim4PairPrime 29 31 i := by
  dsimp
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  apply claim4_exists_y_box_in_window h
  exact le_rfl

/-- The corresponding canonical affine `x` search interval reaches its exact
three-prime residue box. -/
example :
    let Nx := claim4XScale 50 41 43 47
    let len := claim4TripleXSearchLength 50 41 43 47
    ∃ z ∈ Finset.Ico (claim4SearchStart 0 Nx)
        (claim4SearchStart 0 Nx + len),
      0 < 1 + z * Nx ∧
        1 + z * Nx < 1 + (claim4SearchStart 0 Nx + len) * Nx ∧
        ∀ i : Fin 3,
          1 ≤ claim4PaperCoefficient (claim4TriplePrime 41 43 47 i)
                ((1 + z * Nx) % claim4TriplePrime 41 43 47 i) ∧
            claim4PaperCoefficient (claim4TriplePrime 41 43 47 i)
                ((1 + z * Nx) % claim4TriplePrime 41 43 47 i) ≤
              claim4TriplePrime 41 43 47 i -
                50 % claim4TriplePrime 41 43 47 i := by
  dsimp
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  apply claim4_exists_x_box_in_window h
  exact le_rfl

end Erdos678
