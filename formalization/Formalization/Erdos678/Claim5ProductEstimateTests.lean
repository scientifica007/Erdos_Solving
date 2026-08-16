import Formalization.Erdos678.Claim5ProductEstimate

/-!
Reachable regressions for the E1b quantitative product estimate.
The file is kept in the canonical graph so exact-head CI checks the E1b exit.
-/

namespace Erdos678

/-- The range-product normalization has the expected endpoint convention. -/
example : intervalProd 10 4 = intervalProd 10 3 * 13 := by
  exact intervalProd_succ 10 3

/-- Closed regression for the uniform power bound. -/
example : 21 ^ 20 < 3 * 20 ^ 20 := by
  exact succ_pow_lt_three_mul_pow (by norm_num)

/-- The product-estimate interface is reachable directly from the paper-compatible
Cambie target bounds. -/
example
    {C k x y : ℕ}
    (hC : 0 < C)
    (hk : 0 < k)
    (hx : 0 < x)
    (hy : 0 < y)
    (hylower : claim4CambieYLower C k < y)
    (hclose : y < x + claim4CambieGap C k)
    (hyupper : y < claim4CambieYUpper C k) :
    C * intervalProd y (k + 1) <
      intervalLCM 1 k * intervalProd x k := by
  exact claim4_cambie_product_lt_initialLCM
    hC hk hx hy hylower hclose hyupper

/-- Final E1 endpoint remains conditional only on the explicit D4 large-`k`
and sharp-prime-window data; prime existence itself is not introduced here. -/
example
    {C k s xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hsharp : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_of_sharp_windows hlarge hsharp

end Erdos678
