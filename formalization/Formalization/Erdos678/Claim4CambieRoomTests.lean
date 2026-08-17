import Formalization.Erdos678.Claim4CambieRoom

/-!
Reachable regressions for the sharp Cambie room reduction.
-/

namespace Erdos678

/-- A concrete sufficiently larger scale exhibits a nonvacuous five-prime
configuration satisfying both sharp search budgets for `C = 1`.  The remaining
large-`k` scale inequalities are intentionally tested separately from prime
existence. -/
example : Claim4PrimeWindowData 1000 971 977 983 503 509 := by
  constructor <;> norm_num

example :
    (5 * 1 * 1000) *
        (claim4PairYSearchLength 1000 503 509 + 1) ≤ 503 * 509 := by
  norm_num [claim4PairYSearchLength]

example :
    (5 * 1 * 1000) *
        (claim4TripleXSearchLength 1000 971 977 983 + 2) ≤
      971 * 977 * 983 := by
  norm_num [claim4TripleXSearchLength]

/-- The reduction endpoint is reachable without adding any hidden analytical
or prime-existence assumption. -/
example
    {C k xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (hroom : Claim4CambieRoomBudgetData C k xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      y < x + claim4CambieGap C k ∧
      claim4CambieYLower C k < y ∧ y < claim4CambieYUpper C k ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k * (intervalProd x k / intervalLCM x k) := by
  exact claim4_exists_cambie_target_representatives_with_claim5
    hC hprime hroom

end Erdos678
