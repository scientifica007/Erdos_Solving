import Formalization.Erdos678.Claim5Assembly

/-!
Cancellation-safe natural-number algebra for Phase E1.

The verified Claim 5 identity is stated with exact natural-number quotients.
This module converts that quotient identity into a cross-multiplied equality
using only proved divisibility, and then transfers a product inequality to the
corresponding LCM inequality under explicit nonzero hypotheses.

No field-style cancellation is used.
-/

namespace Erdos678

/-- The LCM of a finite interval divides its product.  This is valid even on
zero-containing intervals and is the reusable cancellation primitive for E1. -/
theorem intervalLCM_dvd_intervalProd (start len : ℕ) :
    intervalLCM start len ∣ intervalProd start len := by
  change (intervalFinset start len).lcm id ∣ (intervalFinset start len).prod id
  exact Finset.lcm_dvd_prod (intervalFinset start len) id

/-- Cross-multiplied form of the complete Claim 5 quotient identity.

The theorem needs no positivity assumption: exact divisibility is sufficient
to replace each quotient times its divisor by the original product. -/
theorem claim5_cross_multiplication
    {x y k : ℕ}
    (hclaim5 :
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k *
          (intervalProd x k / intervalLCM x k)) :
    intervalProd y (k + 1) * intervalLCM x k =
      intervalLCM 1 k * intervalProd x k * intervalLCM y (k + 1) := by
  have hxdiv : intervalLCM x k ∣ intervalProd x k :=
    intervalLCM_dvd_intervalProd x k
  have hydiv : intervalLCM y (k + 1) ∣ intervalProd y (k + 1) :=
    intervalLCM_dvd_intervalProd y (k + 1)
  calc
    intervalProd y (k + 1) * intervalLCM x k =
        ((intervalProd y (k + 1) / intervalLCM y (k + 1)) *
            intervalLCM y (k + 1)) * intervalLCM x k := by
      rw [Nat.div_mul_cancel hydiv]
    _ =
        ((intervalLCM 1 k *
            (intervalProd x k / intervalLCM x k)) *
              intervalLCM y (k + 1)) * intervalLCM x k := by
      rw [hclaim5]
    _ =
        intervalLCM 1 k *
          ((intervalProd x k / intervalLCM x k) * intervalLCM x k) *
            intervalLCM y (k + 1) := by
      ac_rfl
    _ = intervalLCM 1 k * intervalProd x k * intervalLCM y (k + 1) := by
      rw [Nat.div_mul_cancel hxdiv]

/-- Inequality transfer for E1.

If the `y` interval contains no zero, then its product and LCM are positive.
Under Claim 5, the strict product inequality

`C * Prod_y < M * Prod_x`

therefore implies the desired strict LCM inequality

`C * LCM_y < LCM_x`.
-/
theorem claim5_lcm_lt_of_product_lt
    {C x y k : ℕ}
    (hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0)
    (hclaim5 :
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k *
          (intervalProd x k / intervalLCM x k))
    (hprod :
      C * intervalProd y (k + 1) <
        intervalLCM 1 k * intervalProd x k) :
    C * intervalLCM y (k + 1) < intervalLCM x k := by
  have hcross := claim5_cross_multiplication hclaim5
  have hPypos : 0 < intervalProd y (k + 1) :=
    Nat.pos_of_ne_zero (intervalProd_ne_zero_of_mem_ne_zero hyne)
  have hLypos : 0 < intervalLCM y (k + 1) :=
    Nat.pos_of_ne_zero (intervalLCM_ne_zero_of_mem_ne_zero hyne)
  have hscaled :
      (C * intervalProd y (k + 1)) * intervalLCM y (k + 1) <
        (intervalLCM 1 k * intervalProd x k) * intervalLCM y (k + 1) :=
    Nat.mul_lt_mul_of_pos_right hprod hLypos
  have hcancel :
      intervalProd y (k + 1) * (C * intervalLCM y (k + 1)) <
        intervalProd y (k + 1) * intervalLCM x k := by
    calc
      intervalProd y (k + 1) * (C * intervalLCM y (k + 1)) =
          (C * intervalProd y (k + 1)) * intervalLCM y (k + 1) := by
        ac_rfl
      _ < (intervalLCM 1 k * intervalProd x k) * intervalLCM y (k + 1) :=
        hscaled
      _ = intervalProd y (k + 1) * intervalLCM x k := hcross.symm
  exact (Nat.mul_lt_mul_left hPypos).mp hcancel

end Erdos678
