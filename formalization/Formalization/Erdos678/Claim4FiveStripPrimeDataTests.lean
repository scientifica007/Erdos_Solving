import Formalization.Erdos678.Claim4FiveStripPrimeData

/-!
Reachable regressions for the five-disjoint-strip E2 adapter.
This file remains in the canonical graph so exact-head CI checks E2c.
-/

namespace Erdos678

/-- A nonvacuous five-strip witness at a moderate scale. -/
example :
    Claim4CambieFiveStripPrimeData 1 2000 10 1993 1987 1973 1009 1013 := by
  constructor <;> norm_num

/-- The five-strip package automatically supplies the frozen sharp D4
contract with slack `s = 4d = 40`. -/
example :
    Claim4CambieSharpPrimeWindowData 1 2000 40 1993 1987 1973 1009 1013 := by
  apply Claim4CambieFiveStripPrimeData.toSharpPrimeWindowData (by norm_num)
  constructor <;> norm_num

/-- Generic reachability of the five-strip interface into the completed E1
endpoint. -/
example
    {C k d xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hstrips : Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_of_five_strips hlarge hstrips

end Erdos678
