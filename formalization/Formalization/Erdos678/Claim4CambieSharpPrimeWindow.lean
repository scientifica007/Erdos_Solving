import Formalization.Erdos678.Claim4CambieLargeK

/-!
C-dependent sharp prime windows for the final D4 arithmetic budgets.

The broad `Claim4PrimeWindowData` contract is sufficient for the CRT search
lengths to fit inside each coordinate, but Cambie's quantitative target needs
those searches to be much shorter: of order `k/C` after normalization by the
freed special-prime factors.

This module adds only a finite arithmetic refinement.  For a slack `s`:

* the two `y` primes lie just above `k/2`, with `2p ≤ k+s`;
* the three `x` primes lie just below `k`, with `k ≤ p+s`;
* `40*C*(s+1) ≤ k` makes the strip narrow enough.

Existence of primes in these strips is deliberately NOT proved here.  That
remains the separate prime-density dependency.  The theorem below proves that
any five primes satisfying this explicit contract automatically discharge both
remaining D4f search-budget inequalities.
-/

namespace Erdos678

/-- Sharp `C`-dependent refinement of the broad D4 prime-window contract. -/
structure Claim4CambieSharpPrimeWindowData
    (C k s xp xq xr yp yq : ℕ) : Prop where
  base : Claim4PrimeWindowData k xp xq xr yp yq
  xp_close : k ≤ xp + s
  xq_close : k ≤ xq + s
  xr_close : k ≤ xr + s
  yp_close : 2 * yp ≤ k + s
  yq_close : 2 * yq ≤ k + s
  slack_budget : 40 * C * (s + 1) ≤ k

/-- The sharp half-window bounds make the exact two-prime `y` search length at
most `2s`. -/
theorem Claim4CambieSharpPrimeWindowData.y_search_length_le_two_slack
    {C k s xp xq xr yp yq : ℕ}
    (h : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    claim4PairYSearchLength k yp yq + 1 ≤ 2 * s := by
  have hypmod : k % yp = k - yp :=
    mod_eq_sub_of_le_of_lt_two_mul h.base.yp_le_k h.base.yp_above_half
  have hyqmod : k % yq = k - yq :=
    mod_eq_sub_of_le_of_lt_two_mul h.base.yq_le_k h.base.yq_above_half
  have hyple := h.base.yp_le_k
  have hyqle := h.base.yq_le_k
  have hypabove := h.base.yp_above_half
  have hyqabove := h.base.yq_above_half
  have hypclose := h.yp_close
  have hyqclose := h.yq_close
  rw [claim4PairYSearchLength, hypmod, hyqmod]
  omega

/-- The sharp near-`k` bounds make the exact three-prime `x` search length,
including the affine reserve used by D4f, at most `3(s+1)`. -/
theorem Claim4CambieSharpPrimeWindowData.x_search_length_le_three_slack
    {C k s xp xq xr yp yq : ℕ}
    (h : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    claim4TripleXSearchLength k xp xq xr + 2 ≤ 3 * (s + 1) := by
  have hxpmod : k % xp = k - xp :=
    mod_eq_sub_of_le_of_lt_two_mul h.base.xp_le_k h.base.xp_above_half
  have hxqmod : k % xq = k - xq :=
    mod_eq_sub_of_le_of_lt_two_mul h.base.xq_le_k h.base.xq_above_half
  have hxrmod : k % xr = k - xr :=
    mod_eq_sub_of_le_of_lt_two_mul h.base.xr_le_k h.base.xr_above_half
  have hxpclose := h.xp_close
  have hxqclose := h.xq_close
  have hxrclose := h.xr_close
  rw [claim4TripleXSearchLength, hxpmod, hxqmod, hxrmod]
  omega

/-- The sharp `y` strip automatically supplies the D4f two-prime search
budget. -/
theorem Claim4CambieSharpPrimeWindowData.y_search_budget
    {C k s xp xq xr yp yq : ℕ}
    (h : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    (5 * C * k) * (claim4PairYSearchLength k yp yq + 1) ≤ yp * yq := by
  have hs : s ≤ s + 1 := Nat.le_succ s
  have h40s : 40 * C * s ≤ k := by
    calc
      40 * C * s ≤ 40 * C * (s + 1) :=
        Nat.mul_le_mul_left (40 * C) hs
      _ ≤ k := h.slack_budget
  have h40sk : (40 * C * s) * k ≤ k * k :=
    Nat.mul_le_mul_right k h40s
  have hkyp : k ≤ 2 * yp := Nat.le_of_lt h.base.yp_above_half
  have hkyq : k ≤ 2 * yq := Nat.le_of_lt h.base.yq_above_half
  have hsq : k * k ≤ (2 * yp) * (2 * yq) :=
    Nat.mul_le_mul hkyp hkyq
  have hfour : 4 * (10 * C * k * s) ≤ 4 * (yp * yq) := by
    calc
      4 * (10 * C * k * s) = (40 * C * s) * k := by ring
      _ ≤ k * k := h40sk
      _ ≤ (2 * yp) * (2 * yq) := hsq
      _ = 4 * (yp * yq) := by ring
  have hten : 10 * C * k * s ≤ yp * yq :=
    Nat.le_of_mul_le_mul_left hfour (by norm_num)
  calc
    (5 * C * k) * (claim4PairYSearchLength k yp yq + 1) ≤
        (5 * C * k) * (2 * s) :=
      Nat.mul_le_mul_left (5 * C * k) h.y_search_length_le_two_slack
    _ = 10 * C * k * s := by ring
    _ ≤ yp * yq := hten

/-- The sharp `x` strip automatically supplies the D4f three-prime search
budget once `k ≥ 9`; the latter is already part of `Claim4CambieLargeKData`. -/
theorem Claim4CambieSharpPrimeWindowData.x_search_budget
    {C k s xp xq xr yp yq : ℕ}
    (hk : 9 ≤ k)
    (h : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    (5 * C * k) * (claim4TripleXSearchLength k xp xq xr + 2) ≤
      xp * xq * xr := by
  have h15C : 15 * C ≤ 40 * C :=
    Nat.mul_le_mul_right C (by norm_num)
  have h15 : 15 * C * (s + 1) ≤ 40 * C * (s + 1) :=
    Nat.mul_le_mul_right (s + 1) h15C
  have h15k : 15 * C * (s + 1) ≤ k :=
    h15.trans h.slack_budget
  have h15kk : (15 * C * (s + 1)) * k ≤ k * k :=
    Nat.mul_le_mul_right k h15k
  have hkxp : k ≤ 2 * xp := Nat.le_of_lt h.base.xp_above_half
  have hkxq : k ≤ 2 * xq := Nat.le_of_lt h.base.xq_above_half
  have hsq : k * k ≤ (2 * xp) * (2 * xq) :=
    Nat.mul_le_mul hkxp hkxq
  have hxr4 : 4 ≤ xr := by
    have habove := h.base.xr_above_half
    omega
  have hfour_le : 4 * (xp * xq) ≤ xp * xq * xr := by
    calc
      4 * (xp * xq) = (xp * xq) * 4 := by ring
      _ ≤ (xp * xq) * xr := Nat.mul_le_mul_left (xp * xq) hxr4
      _ = xp * xq * xr := by ring
  have hmain : 15 * C * k * (s + 1) ≤ xp * xq * xr := by
    calc
      15 * C * k * (s + 1) = (15 * C * (s + 1)) * k := by ring
      _ ≤ k * k := h15kk
      _ ≤ (2 * xp) * (2 * xq) := hsq
      _ = 4 * (xp * xq) := by ring
      _ ≤ xp * xq * xr := hfour_le
  calc
    (5 * C * k) * (claim4TripleXSearchLength k xp xq xr + 2) ≤
        (5 * C * k) * (3 * (s + 1)) :=
      Nat.mul_le_mul_left (5 * C * k) h.x_search_length_le_three_slack
    _ = 15 * C * k * (s + 1) := by ring
    _ ≤ xp * xq * xr := hmain

/-- The sharp prime-window contract produces exactly the two remaining D4f
prime/search budgets. -/
theorem Claim4CambieSharpPrimeWindowData.toPrimeBudgetData
    {C k s xp xq xr yp yq : ℕ}
    (hk : 9 ≤ k)
    (h : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    Claim4CambiePrimeBudgetData C k xp xq xr yp yq := by
  exact ⟨h.y_search_budget, h.x_search_budget hk⟩

/-- Final D4f arithmetic endpoint: explicit large-`k` growth and explicit
C-dependent prime strips imply the actual Cambie target representatives and
full Claim 5 identity.  Prime existence itself remains outside this theorem. -/
theorem claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows
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
  exact claim4_exists_cambie_target_representatives_with_claim5_of_largeK
    hlarge hsharp.base (hsharp.toPrimeBudgetData hlarge.nine_le)

end Erdos678
