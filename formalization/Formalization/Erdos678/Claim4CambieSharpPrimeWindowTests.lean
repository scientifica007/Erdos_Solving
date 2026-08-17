import Formalization.Erdos678.Claim4CambieSharpPrimeWindow

/-!
Reachable regressions for the final D4f sharp-prime arithmetic layer.
-/

namespace Erdos678

/-- A nonvacuous `C=1`, `k=1000` configuration lies in the sharp strips with
slack `s=23`. -/
example :
    Claim4CambieSharpPrimeWindowData 1 1000 23 977 983 991 503 509 := by
  refine ⟨?_, by norm_num, by norm_num, by norm_num,
    by norm_num, by norm_num, by norm_num⟩
  constructor <;> norm_num

/-- The same closed sharp configuration automatically satisfies the exact
D4f two-prime search budget. -/
example :
    (5 * 1 * 1000) * (claim4PairYSearchLength 1000 503 509 + 1) ≤
      503 * 509 := by
  have h :
      Claim4CambieSharpPrimeWindowData 1 1000 23 977 983 991 503 509 := by
    refine ⟨?_, by norm_num, by norm_num, by norm_num,
      by norm_num, by norm_num, by norm_num⟩
    constructor <;> norm_num
  exact h.y_search_budget

/-- The same closed sharp configuration automatically satisfies the exact
D4f three-prime search budget. -/
example :
    (5 * 1 * 1000) * (claim4TripleXSearchLength 1000 977 983 991 + 2) ≤
      977 * 983 * 991 := by
  have h :
      Claim4CambieSharpPrimeWindowData 1 1000 23 977 983 991 503 509 := by
    refine ⟨?_, by norm_num, by norm_num, by norm_num,
      by norm_num, by norm_num, by norm_num⟩
    constructor <;> norm_num
  exact h.x_search_budget (by norm_num)

/-- The final D4f endpoint is reachable using only explicit large-`k` growth
and explicit sharp prime-window data. -/
example
    {C k s xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hsharp : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      y < x + claim4CambieGap C k ∧
      claim4CambieYLower C k < y ∧ y < claim4CambieYUpper C k ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k * (intervalProd x k / intervalLCM x k) := by
  exact claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows
    hlarge hsharp

end Erdos678
