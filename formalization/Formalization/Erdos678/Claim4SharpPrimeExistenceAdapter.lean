import Formalization.Erdos678.Claim5ProductEstimate

/-!
Phase E2 arithmetic adapter.

The analytic prime-density layer should not be required to reconstruct the
broad D4 prime-window inequalities.  It only needs to provide five primes in
the genuinely sharp strips, their within-family distinctness, and the common
slack budget.  This file proves that those narrow data automatically imply the
already frozen `Claim4CambieSharpPrimeWindowData` contract.

No prime-existence theorem is asserted here.  In particular, the structure
below is an explicit finite witness package, not an axiom or a density
hypothesis.
-/

namespace Erdos678

/-- Minimal finite data that a later analytic prime-density theorem needs to
produce.  The broad D4 windows are deliberately omitted: they follow from the
sharp closeness inequalities once the slack is small compared with `k`. -/
structure Claim4CambieNarrowPrimeData
    (C k s xp xq xr yp yq : ℕ) : Prop where
  xp_prime : Nat.Prime xp
  xq_prime : Nat.Prime xq
  xr_prime : Nat.Prime xr
  yp_prime : Nat.Prime yp
  yq_prime : Nat.Prime yq
  xp_le_k : xp ≤ k
  xq_le_k : xq ≤ k
  xr_le_k : xr ≤ k
  yp_above_half : k < 2 * yp
  yq_above_half : k < 2 * yq
  xp_close : k ≤ xp + s
  xq_close : k ≤ xq + s
  xr_close : k ≤ xr + s
  yp_close : 2 * yp ≤ k + s
  yq_close : 2 * yq ≤ k + s
  xp_ne_xq : xp ≠ xq
  xp_ne_xr : xp ≠ xr
  xq_ne_xr : xq ≠ xr
  yp_ne_yq : yp ≠ yq
  slack_budget : 40 * C * (s + 1) ≤ k

/-- Positivity of `C` turns the sharp slack budget into a `C`-independent
linear estimate.  This is the only place where the nonlinear-looking
`C*(s+1)` expression needs monotonicity rather than `omega`. -/
theorem Claim4CambieNarrowPrimeData.forty_slack_le_k
    {C k s xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (h : Claim4CambieNarrowPrimeData C k s xp xq xr yp yq) :
    40 * (s + 1) ≤ k := by
  have hC1 : 1 ≤ C := by omega
  have h40 : 40 * (s + 1) ≤ 40 * C * (s + 1) := by
    calc
      40 * (s + 1) = (40 * 1) * (s + 1) := by ring
      _ ≤ (40 * C) * (s + 1) :=
        Nat.mul_le_mul_right (s + 1) (Nat.mul_le_mul_left 40 hC1)
      _ = 40 * C * (s + 1) := by ring
  exact h40.trans h.slack_budget

/-- The narrow five-prime witness package implies the exact sharp D4 contract.
All broad-window inequalities are consequences of the much stronger slack
budget, so the future analytic theorem can target only the genuinely narrow
strips. -/
theorem Claim4CambieNarrowPrimeData.toSharpPrimeWindowData
    {C k s xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (h : Claim4CambieNarrowPrimeData C k s xp xq xr yp yq) :
    Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq := by
  have h40 : 40 * (s + 1) ≤ k := h.forty_slack_le_k hC
  have hs_le_k : s ≤ k := by omega
  have h4s : 4 * s + 1 ≤ k := by omega
  have h3s : 3 * s ≤ k := by omega
  have hyp_le_k : yp ≤ k := by
    have hclose := h.yp_close
    omega
  have hyq_le_k : yq ≤ k := by
    have hclose := h.yq_close
    omega
  have hxp_near : 3 * k + 1 ≤ 4 * xp := by
    have hclose := h.xp_close
    omega
  have hxq_near : 3 * k + 1 ≤ 4 * xq := by
    have hclose := h.xq_close
    omega
  have hxr_near : 3 * k + 1 ≤ 4 * xr := by
    have hclose := h.xr_close
    omega
  have hyp_upper : 3 * yp ≤ 2 * k := by
    have hclose := h.yp_close
    omega
  have hyq_upper : 3 * yq ≤ 2 * k := by
    have hclose := h.yq_close
    omega
  have hbase : Claim4PrimeWindowData k xp xq xr yp yq := by
    exact ⟨
      h.xp_prime, h.xq_prime, h.xr_prime, h.yp_prime, h.yq_prime,
      h.xp_le_k, h.xq_le_k, h.xr_le_k, hyp_le_k, hyq_le_k,
      hxp_near, hxq_near, hxr_near,
      h.yp_above_half, h.yq_above_half, hyp_upper, hyq_upper,
      h.xp_ne_xq, h.xp_ne_xr, h.xq_ne_xr, h.yp_ne_yq⟩
  exact ⟨hbase, h.xp_close, h.xq_close, h.xr_close,
    h.yp_close, h.yq_close, h.slack_budget⟩

/-- E2 arithmetic adapter endpoint: once the analytic layer supplies only the
narrow finite prime data, the already machine-checked D4+E1 stack yields the
strict LCM comparison. -/
theorem claim4_exists_cambie_lcm_ratio_of_narrow_primes
    {C k s xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hnarrow : Claim4CambieNarrowPrimeData C k s xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_of_sharp_windows
    hlarge (hnarrow.toSharpPrimeWindowData hlarge.C_pos)

end Erdos678
