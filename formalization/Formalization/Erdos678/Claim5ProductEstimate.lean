import Formalization.Erdos678.Claim4CambieSharpPrimeWindow
import Formalization.Erdos678.Claim5LCMAlgebra
import Mathlib.Analysis.Complex.ExponentialBounds

/-!
Phase E1b: the quantitative product estimate in Cambie's proof.

This layer stays in natural-number arithmetic except for one isolated universal
power bound.  The target-range and closeness inequalities imply that the first
`k` factors of the `y` block are within a factor `(k+1)/k` of the corresponding
`x` factors.  The standard bound `(1 + 1/k)^k < 3` then gives a factor `3` on
the prefix products.  Cambie's upper target endpoint supplies a factor `4`, so
there is enough strict room to conclude

`C * Prod_y < M * Prod_x`.

The cancellation-safe E1a theorem then transfers this product inequality to
the desired LCM inequality.  No quotient cancellation is performed here.
-/

namespace Erdos678

/-- Rewrite the interval product as the corresponding product over
`Finset.range`. -/
theorem intervalProd_eq_prod_range (start len : ℕ) :
    intervalProd start len = ∏ i ∈ Finset.range len, (start + i) := by
  unfold intervalProd intervalFinset
  rw [Finset.prod_image]
  · simp
  · intro a ha b hb hab
    omega

/-- Append the final factor of a consecutive interval product. -/
theorem intervalProd_succ (start len : ℕ) :
    intervalProd start (len + 1) = intervalProd start len * (start + len) := by
  rw [intervalProd_eq_prod_range, intervalProd_eq_prod_range]
  exact Finset.prod_range_succ (fun i => start + i) len

/-- A positive-start interval contains no zero. -/
theorem intervalFinset_mem_ne_zero_of_pos_start
    {start len : ℕ} (hstart : 0 < start) :
    ∀ z ∈ intervalFinset start len, z ≠ 0 := by
  intro z hz
  unfold intervalFinset at hz
  rcases Finset.mem_image.mp hz with ⟨i, hi, rfl⟩
  omega

/-- Uniform elementary power bound used in the product comparison.

The only real-valued step in E1b is isolated here: Mathlib proves
`(1 + 1/k)^k ≤ exp 1`, while `exp 1 < 3`. -/
theorem succ_pow_lt_three_mul_pow
    {k : ℕ} (hk : 0 < k) :
    (k + 1) ^ k < 3 * k ^ k := by
  have hkR : (0 : ℝ) < (k : ℝ) := by exact_mod_cast hk
  have hkR0 : (k : ℝ) ≠ 0 := ne_of_gt hkR
  have hbase :
      (((k + 1 : ℕ) : ℝ) / (k : ℝ)) =
        1 + (k : ℝ)⁻¹ := by
    field_simp [hkR0]
    norm_num
  have hratio :
      ((((k + 1 : ℕ) : ℝ) / (k : ℝ)) ^ k) < 3 := by
    rw [hbase]
    exact (Real.one_add_inv_pow_le_exp (n := k)).trans_lt Real.exp_one_lt_three
  have hmulR :
      (((k + 1 : ℕ) : ℝ) ^ k) < 3 * ((k : ℝ) ^ k) := by
    rw [div_pow] at hratio
    exact (div_lt_iff₀ (pow_pos hkR k)).mp hratio
  exact_mod_cast hmulR

/-- The division-safe lower endpoint dominates `(k+1)` full closeness gaps. -/
theorem claim4CambieGap_mul_succ_le_yLower
    {C k : ℕ} (hC : 0 < C) (hk : 0 < k) :
    claim4CambieGap C k * (k + 1) ≤ claim4CambieYLower C k := by
  have hd : 0 < 5 * C * k := by positivity
  unfold claim4CambieGap claim4CambieYLower
  apply (Nat.le_div_iff_mul_le hd).2
  calc
    (claim4FullScale k / (5 * C * k) * (k + 1)) * (5 * C * k) =
        (claim4FullScale k / (5 * C * k) * (5 * C * k)) * (k + 1) := by
      ring
    _ ≤ claim4FullScale k * (k + 1) :=
      Nat.mul_le_mul_right (k + 1)
        (Nat.div_mul_le_self (claim4FullScale k) (5 * C * k))

/-- Cambie's lower target bound and closeness bound force the first `k`
`y`-factors to be less than three times the corresponding `x` prefix product. -/
theorem claim4_cambie_prefix_product_lt_three
    {C k x y : ℕ}
    (hC : 0 < C)
    (hk : 0 < k)
    (hx : 0 < x)
    (hylower : claim4CambieYLower C k < y)
    (hclose : y < x + claim4CambieGap C k) :
    intervalProd y k < 3 * intervalProd x k := by
  have hgapLower := claim4CambieGap_mul_succ_le_yLower hC hk
  have hgapBelowY :
      claim4CambieGap C k * (k + 1) < y :=
    hgapLower.trans_lt hylower
  have hkgap_lt_x : k * claim4CambieGap C k < x := by
    have htmp :
        k * claim4CambieGap C k + claim4CambieGap C k <
          x + claim4CambieGap C k := by
      calc
        k * claim4CambieGap C k + claim4CambieGap C k =
            claim4CambieGap C k * (k + 1) := by ring
        _ < y := hgapBelowY
        _ < x + claim4CambieGap C k := hclose
    omega
  have hky_lt : k * y < (k + 1) * x := by
    have hmul :
        k * y < k * (x + claim4CambieGap C k) :=
      Nat.mul_lt_mul_of_pos_left hclose hk
    calc
      k * y < k * (x + claim4CambieGap C k) := hmul
      _ = k * x + k * claim4CambieGap C k := by ring
      _ ≤ k * x + x :=
        Nat.add_le_add_left (Nat.le_of_lt hkgap_lt_x) (k * x)
      _ = (k + 1) * x := by ring
  have hfactor :
      ∀ i ∈ Finset.range k,
        k * (y + i) ≤ (k + 1) * (x + i) := by
    intro i hi
    have hiki : k * i ≤ (k + 1) * i :=
      Nat.mul_le_mul_right i (Nat.le_succ k)
    calc
      k * (y + i) = k * y + k * i := by ring
      _ ≤ (k + 1) * x + k * i :=
        Nat.add_le_add_right (Nat.le_of_lt hky_lt) (k * i)
      _ ≤ (k + 1) * x + (k + 1) * i :=
        Nat.add_le_add_left hiki ((k + 1) * x)
      _ = (k + 1) * (x + i) := by ring
  have hprod :
      (∏ i ∈ Finset.range k, k * (y + i)) ≤
        ∏ i ∈ Finset.range k, (k + 1) * (x + i) :=
    Finset.prod_le_prod' hfactor
  have hscaled :
      k ^ k * intervalProd y k ≤
        (k + 1) ^ k * intervalProd x k := by
    rw [intervalProd_eq_prod_range, intervalProd_eq_prod_range]
    simpa [Finset.prod_mul_distrib] using hprod
  have hxprodpos : 0 < intervalProd x k := by
    rw [intervalProd_eq_prod_range]
    exact Finset.prod_pos (fun i hi => by omega)
  have hpow := succ_pow_lt_three_mul_pow hk
  have hpowScaled :
      (k + 1) ^ k * intervalProd x k <
        (3 * k ^ k) * intervalProd x k :=
    Nat.mul_lt_mul_of_pos_right hpow hxprodpos
  have hchain :
      k ^ k * intervalProd y k <
        k ^ k * (3 * intervalProd x k) := by
    calc
      k ^ k * intervalProd y k ≤
          (k + 1) ^ k * intervalProd x k := hscaled
      _ < (3 * k ^ k) * intervalProd x k := hpowScaled
      _ = k ^ k * (3 * intervalProd x k) := by ring
  have hkpow : 0 < k ^ k := pow_pos hk k
  exact (Nat.mul_lt_mul_left hkpow).mp hchain

/-- The actual Cambie target bounds imply the strict product inequality needed
by the E1a cancellation layer. -/
theorem claim4_cambie_product_lt_fullScale
    {C k x y : ℕ}
    (hC : 0 < C)
    (hk : 0 < k)
    (hx : 0 < x)
    (hy : 0 < y)
    (hylower : claim4CambieYLower C k < y)
    (hclose : y < x + claim4CambieGap C k)
    (hyupper : y < claim4CambieYUpper C k) :
    C * intervalProd y (k + 1) <
      claim4FullScale k * intervalProd x k := by
  have hprefix :=
    claim4_cambie_prefix_product_lt_three hC hk hx hylower hclose
  have hd4 : 0 < 4 * C := by positivity
  have hyquot : y + k < claim4FullScale k / (4 * C) := by
    unfold claim4CambieYUpper at hyupper
    omega
  have h4room :
      (4 * C) * (y + k) < claim4FullScale k := by
    have hmul :
        (4 * C) * (y + k) <
          (4 * C) * (claim4FullScale k / (4 * C)) :=
      Nat.mul_lt_mul_of_pos_left hyquot hd4
    calc
      (4 * C) * (y + k) <
          (4 * C) * (claim4FullScale k / (4 * C)) := hmul
      _ = (claim4FullScale k / (4 * C)) * (4 * C) := by ring
      _ ≤ claim4FullScale k :=
        Nat.div_mul_le_self (claim4FullScale k) (4 * C)
  have hykpos : 0 < y + k := by omega
  have hCypos : 0 < C * (y + k) := mul_pos hC hykpos
  have h3lt4 : 3 * (C * (y + k)) < 4 * (C * (y + k)) :=
    Nat.mul_lt_mul_of_pos_right (by norm_num : 3 < 4) hCypos
  have h3room : 3 * C * (y + k) < claim4FullScale k := by
    calc
      3 * C * (y + k) = 3 * (C * (y + k)) := by ring
      _ < 4 * (C * (y + k)) := h3lt4
      _ = (4 * C) * (y + k) := by ring
      _ < claim4FullScale k := h4room
  have hxprodpos : 0 < intervalProd x k := by
    rw [intervalProd_eq_prod_range]
    exact Finset.prod_pos (fun i hi => by omega)
  have h3roomScaled :
      (3 * C * (y + k)) * intervalProd x k <
        claim4FullScale k * intervalProd x k :=
    Nat.mul_lt_mul_of_pos_right h3room hxprodpos
  have hprefixScaled :
      (C * (y + k)) * intervalProd y k <
        (C * (y + k)) * (3 * intervalProd x k) :=
    Nat.mul_lt_mul_of_pos_left hprefix hCypos
  calc
    C * intervalProd y (k + 1) =
        C * (intervalProd y k * (y + k)) := by
      rw [intervalProd_succ]
    _ = (C * (y + k)) * intervalProd y k := by ring
    _ < (C * (y + k)) * (3 * intervalProd x k) := hprefixScaled
    _ = (3 * C * (y + k)) * intervalProd x k := by ring
    _ < claim4FullScale k * intervalProd x k := h3roomScaled

/-- Initial-LCM form of the E1b product estimate. -/
theorem claim4_cambie_product_lt_initialLCM
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
  have h := claim4_cambie_product_lt_fullScale
    hC hk hx hy hylower hclose hyupper
  rw [claim4FullScale_eq_initialLCM] at h
  exact h

/-- E1 conclusion for representatives that already satisfy Claim 5 and the
machine-checked Cambie target bounds. -/
theorem claim5_lcm_lt_of_cambie_bounds
    {C k x y : ℕ}
    (hC : 0 < C)
    (hk : 0 < k)
    (hx : 0 < x)
    (hy : 0 < y)
    (hylower : claim4CambieYLower C k < y)
    (hclose : y < x + claim4CambieGap C k)
    (hyupper : y < claim4CambieYUpper C k)
    (hclaim5 :
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k *
          (intervalProd x k / intervalLCM x k)) :
    C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim5_lcm_lt_of_product_lt
    (intervalFinset_mem_ne_zero_of_pos_start hy)
    hclaim5
    (claim4_cambie_product_lt_initialLCM
      hC hk hx hy hylower hclose hyupper)

/-- Phase E1 endpoint: the already verified D4 sharp-window construction
produces representatives with the desired strict LCM ratio.  Prime existence
is still deliberately absent and remains the separate Phase E2 dependency. -/
theorem claim4_exists_cambie_lcm_ratio_of_sharp_windows
    {C k s xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hsharp : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  have hk : 0 < k := lt_of_lt_of_le (by norm_num : 0 < 9) hlarge.nine_le
  rcases claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows
      hlarge hsharp with
    ⟨x, y, hx, hy, hxy, hsep, hclose, hylower, hyupper,
      hmedium, hsmall, hclaim5⟩
  refine ⟨x, y, hx, hy, hxy, hsep, ?_⟩
  exact claim5_lcm_lt_of_cambie_bounds
    hlarge.C_pos hk hx hy hylower hclose hyupper hclaim5

end Erdos678
