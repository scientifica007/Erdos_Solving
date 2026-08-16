import Formalization.Erdos678.Claim4CambieLargeK

/-!
Reachable regressions for the explicit large-`k` D4f layer.
-/

namespace Erdos678

/-- The elementary exponential threshold is already nonvacuous at a modest
closed value. -/
example : Claim4CambieLargeKData 1 20 := by
  constructor <;> norm_num

/-- At the same closed value, the actual natural-number Cambie target window
has room for a complete closeness gap. -/
example :
    claim4CambieYLower 1 20 + claim4CambieGap 1 20 ≤
      claim4CambieYUpper 1 20 := by
  have h : Claim4CambieLargeKData 1 20 := by
    constructor <;> norm_num
  exact h.target_window_room

/-- The large-`k` endpoint leaves only the two sharp prime/search budgets as
special-prime arithmetic input. -/
example
    {C k xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (hbudget : Claim4CambiePrimeBudgetData C k xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      y < x + claim4CambieGap C k ∧
      claim4CambieYLower C k < y ∧ y < claim4CambieYUpper C k ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k * (intervalProd x k / intervalLCM x k) := by
  exact claim4_exists_cambie_target_representatives_with_claim5_of_largeK
    hlarge hprime hbudget

end Erdos678
