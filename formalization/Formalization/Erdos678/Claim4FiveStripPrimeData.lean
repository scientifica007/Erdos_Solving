import Formalization.Erdos678.Claim4SharpPrimeExistenceAdapter

/-!
Phase E2c: five disjoint prime strips.

The analytic input is easier to reuse if the five required primes are requested
from disjoint intervals of a common width `d`.  Distinctness is then a
consequence of interval separation rather than an additional analytic burden.

The three `x` primes occupy successive strips immediately below `k`:

* `xp` in `(k-d, k]`;
* `xq` in `(k-2d, k-d]`;
* `xr` in `(k-3d, k-2d]`.

The two `y` primes occupy successive strips immediately above `k/2`, expressed
without floor division by doubling endpoints:

* `yp` with `k < 2*yp ≤ k+2d`;
* `yq` with `k+2d < 2*yq ≤ k+4d`.

Choosing the D4 slack as `s = 4d` absorbs all five strips.  The single budget
`160*C*(d+1) ≤ k` implies the frozen D4 budget
`40*C*(s+1) ≤ k`.

No prime-existence theorem is asserted here.
-/

namespace Erdos678

/-- Five prime witnesses in pairwise disjoint strips of common width `d`. -/
structure Claim4CambieFiveStripPrimeData
    (C k d xp xq xr yp yq : ℕ) : Prop where
  d_pos : 0 < d
  xp_prime : Nat.Prime xp
  xq_prime : Nat.Prime xq
  xr_prime : Nat.Prime xr
  yp_prime : Nat.Prime yp
  yq_prime : Nat.Prime yq

  xp_upper : xp ≤ k
  xp_lower : k < xp + d

  xq_upper : xq + d ≤ k
  xq_lower : k < xq + 2 * d

  xr_upper : xr + 2 * d ≤ k
  xr_lower : k < xr + 3 * d

  yp_lower : k < 2 * yp
  yp_upper : 2 * yp ≤ k + 2 * d

  yq_lower : k + 2 * d < 2 * yq
  yq_upper : 2 * yq ≤ k + 4 * d

  spacing_budget : 160 * C * (d + 1) ≤ k

/-- Five disjoint strips produce the minimal narrow-prime data with the common
D4 slack `s = 4d`. -/
theorem Claim4CambieFiveStripPrimeData.toNarrowPrimeData
    {C k d xp xq xr yp yq : ℕ}
    (h : Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq) :
    Claim4CambieNarrowPrimeData C k (4 * d) xp xq xr yp yq := by
  have hxq_upper := h.xq_upper
  have hxr_upper := h.xr_upper
  have hyq_lower := h.yq_lower
  have hxq_le_k : xq ≤ k := by omega
  have hxr_le_k : xr ≤ k := by omega
  have hyq_above : k < 2 * yq := by omega

  have hxp_lower := h.xp_lower
  have hxq_lower := h.xq_lower
  have hxr_lower := h.xr_lower
  have hyp_upper := h.yp_upper
  have hyq_upper := h.yq_upper
  have hxp_close : k ≤ xp + 4 * d := by omega
  have hxq_close : k ≤ xq + 4 * d := by omega
  have hxr_close : k ≤ xr + 4 * d := by omega
  have hyp_close : 2 * yp ≤ k + 4 * d := by omega
  have hyq_close : 2 * yq ≤ k + 4 * d := hyq_upper

  have hxp_ne_xq : xp ≠ xq := by
    have hlt : xq < xp := by
      omega
    exact ne_of_gt hlt
  have hxp_ne_xr : xp ≠ xr := by
    have hlt : xr < xp := by
      omega
    exact ne_of_gt hlt
  have hxq_ne_xr : xq ≠ xr := by
    have hlt : xr < xq := by
      omega
    exact ne_of_gt hlt
  have hyp_ne_yq : yp ≠ yq := by
    have hlt : yp < yq := by
      omega
    exact ne_of_lt hlt

  have hslackLinear : 4 * d + 1 ≤ 4 * (d + 1) := by omega
  have hslack : 40 * C * (4 * d + 1) ≤ k := by
    calc
      40 * C * (4 * d + 1) ≤ 40 * C * (4 * (d + 1)) :=
        Nat.mul_le_mul_left (40 * C) hslackLinear
      _ = 160 * C * (d + 1) := by ring
      _ ≤ k := h.spacing_budget

  exact ⟨
    h.xp_prime, h.xq_prime, h.xr_prime, h.yp_prime, h.yq_prime,
    h.xp_upper, hxq_le_k, hxr_le_k,
    h.yp_lower, hyq_above,
    hxp_close, hxq_close, hxr_close, hyp_close, hyq_close,
    hxp_ne_xq, hxp_ne_xr, hxq_ne_xr, hyp_ne_yq,
    hslack⟩

/-- Five-strip witnesses produce the frozen sharp D4 contract with slack
`4d`. -/
theorem Claim4CambieFiveStripPrimeData.toSharpPrimeWindowData
    {C k d xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (h : Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq) :
    Claim4CambieSharpPrimeWindowData C k (4 * d) xp xq xr yp yq :=
  h.toNarrowPrimeData.toSharpPrimeWindowData hC

/-- E2c arithmetic endpoint: five prime witnesses in the disjoint strips feed
straight through the machine-checked D4+E1 stack to the strict LCM ratio. -/
theorem claim4_exists_cambie_lcm_ratio_of_five_strips
    {C k d xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hstrips : Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_of_narrow_primes
    hlarge hstrips.toNarrowPrimeData

end Erdos678
