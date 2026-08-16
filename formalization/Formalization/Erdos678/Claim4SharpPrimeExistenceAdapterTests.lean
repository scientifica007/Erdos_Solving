import Formalization.Erdos678.Claim4SharpPrimeExistenceAdapter

/-!
Reachable regressions for the E2 narrow-prime arithmetic adapter.
-/

namespace Erdos678

/-- The same nonvacuous D4 witness at `C=1,k=1000` satisfies the strictly
smaller E2 analytic interface. -/
example :
    Claim4CambieNarrowPrimeData 1 1000 23 977 983 991 503 509 := by
  constructor <;> norm_num

/-- The narrow witness converts to the frozen sharp D4 contract without adding
any broad-window hypotheses. -/
example :
    Claim4CambieSharpPrimeWindowData 1 1000 23 977 983 991 503 509 := by
  apply Claim4CambieNarrowPrimeData.toSharpPrimeWindowData (by norm_num)
  constructor <;> norm_num

/-- Generic reachability of the E2 arithmetic adapter into the passed E1
endpoint. -/
example
    {C k s xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hnarrow : Claim4CambieNarrowPrimeData C k s xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_of_narrow_primes hlarge hnarrow

end Erdos678
