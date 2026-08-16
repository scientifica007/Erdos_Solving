import Formalization.Erdos678.Claim5LCMAlgebra

/-!
Reachable regressions for the E1 cancellation-safe LCM algebra.
-/

namespace Erdos678

/-- The generic LCM-divides-product theorem remains valid on an ordinary
positive interval. -/
example : intervalLCM 10 3 ∣ intervalProd 10 3 := by
  exact intervalLCM_dvd_intervalProd 10 3

/-- Cross-multiplication deliberately remains valid at a zero boundary; no
positivity is smuggled into the equality layer. -/
example :
    intervalProd 0 2 * intervalLCM 0 1 =
      intervalLCM 1 1 * intervalProd 0 1 * intervalLCM 0 2 := by
  apply claim5_cross_multiplication
  decide

/-- Positive regression for the inequality-transfer layer.  For `k=1`, the
Claim 5 quotient identity is `1 = 1`; choosing `x=3`, `y=1`, `C=1` gives the
strict product inequality `2 < 3` and hence the strict LCM inequality `2 < 3`. -/
example : 1 * intervalLCM 1 2 < intervalLCM 3 1 := by
  apply claim5_lcm_lt_of_product_lt
  · decide
  · decide
  · decide

end Erdos678
