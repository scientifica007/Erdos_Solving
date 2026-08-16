import Formalization.Erdos678.Claim4SmallScaleGap

/-!
Explicit large-`k` arithmetic sufficient for Cambie's sharp D4 window.

The only growth hypothesis in this layer is the elementary inequality

`20 * C * k^2 * (k+1) ≤ 2^k`.

Mathlib's Chebyshev theorem

`2^k ≤ (k+1) * lcm(1,...,k)`

then yields the polynomial lower bound on the full D4 scale needed to show
that Cambie's lower `y` endpoint plus the closeness gap still lies below the
upper `y` endpoint.  No prime-density theorem is used here.
-/

namespace Erdos678

/-- An explicit sufficiently-large-`k` contract independent of the special
prime choices. -/
structure Claim4CambieLargeKData (C k : ℕ) : Prop where
  C_pos : 0 < C
  nine_le : 9 ≤ k
  pow_growth : 20 * C * k ^ 2 * (k + 1) ≤ 2 ^ k

/-- The elementary exponential threshold forces the full D4 scale to dominate
`20*C*k^2`. -/
theorem Claim4CambieLargeKData.fullScale_growth
    {C k : ℕ} (h : Claim4CambieLargeKData C k) :
    20 * C * k ^ 2 ≤ claim4FullScale k := by
  have hcheb :
      2 ^ k ≤ (k + 1) * claim4FullScale k := by
    rw [claim4FullScale_eq_lcmUpto]
    exact Chebyshev.two_pow_le_mul_lcmUpto k
  have hchain :
      20 * C * k ^ 2 * (k + 1) ≤
        (k + 1) * claim4FullScale k :=
    h.pow_growth.trans hcheb
  have hcancel :
      (k + 1) * (20 * C * k ^ 2) ≤
        (k + 1) * claim4FullScale k := by
    simpa [mul_assoc, mul_left_comm, mul_comm] using hchain
  exact Nat.le_of_mul_le_mul_left hcancel (by omega)

/-- A polynomial lower bound on the full scale is enough for Cambie's actual
natural-number target window to contain one full closeness gap. -/
theorem claim4Cambie_target_window_room_of_fullScale_growth
    {C k : ℕ}
    (hC : 0 < C)
    (hk : 9 ≤ k)
    (hM : 20 * C * k ^ 2 ≤ claim4FullScale k) :
    claim4CambieYLower C k + claim4CambieGap C k ≤
      claim4CambieYUpper C k := by
  have hkpos : 0 < k := by omega
  have hd5 : 0 < 5 * C * k := by positivity
  have hd4 : 0 < 4 * C := by positivity
  have hylmul :
      claim4CambieYLower C k * (5 * C * k) ≤
        claim4FullScale k * (k + 1) := by
    simpa [claim4CambieYLower] using
      (Nat.div_mul_le_self (claim4FullScale k * (k + 1)) (5 * C * k))
  have hgapmul :
      claim4CambieGap C k * (5 * C * k) ≤ claim4FullScale k := by
    simpa [claim4CambieGap] using
      (Nat.div_mul_le_self (claim4FullScale k) (5 * C * k))
  have hsum5 :
      (claim4CambieYLower C k + claim4CambieGap C k) * (5 * C * k) ≤
        claim4FullScale k * (k + 2) := by
    calc
      (claim4CambieYLower C k + claim4CambieGap C k) * (5 * C * k) =
          claim4CambieYLower C k * (5 * C * k) +
            claim4CambieGap C k * (5 * C * k) := by ring
      _ ≤ claim4FullScale k * (k + 1) + claim4FullScale k :=
        Nat.add_le_add hylmul hgapmul
      _ = claim4FullScale k * (k + 2) := by ring
  have hsum20 :
      (claim4CambieYLower C k + claim4CambieGap C k) * (20 * C * k) ≤
        4 * claim4FullScale k * (k + 2) := by
    calc
      (claim4CambieYLower C k + claim4CambieGap C k) * (20 * C * k) =
          4 * ((claim4CambieYLower C k + claim4CambieGap C k) *
            (5 * C * k)) := by ring
      _ ≤ 4 * (claim4FullScale k * (k + 2)) :=
        Nat.mul_le_mul_left 4 hsum5
      _ = 4 * claim4FullScale k * (k + 2) := by ring
  have hcoeff : 4 * (k + 2) + 1 ≤ 5 * k := by omega
  have hpoly :
      4 * claim4FullScale k * (k + 2) + claim4FullScale k ≤
        5 * claim4FullScale k * k := by
    calc
      4 * claim4FullScale k * (k + 2) + claim4FullScale k =
          claim4FullScale k * (4 * (k + 2) + 1) := by ring
      _ ≤ claim4FullScale k * (5 * k) :=
        Nat.mul_le_mul_left (claim4FullScale k) hcoeff
      _ = 5 * claim4FullScale k * k := by ring
  have hscaled :
      ((claim4CambieYLower C k + claim4CambieGap C k) + k) *
          (20 * C * k) ≤
        5 * claim4FullScale k * k := by
    calc
      ((claim4CambieYLower C k + claim4CambieGap C k) + k) *
          (20 * C * k) =
        (claim4CambieYLower C k + claim4CambieGap C k) * (20 * C * k) +
          20 * C * k ^ 2 := by ring
      _ ≤ 4 * claim4FullScale k * (k + 2) + 20 * C * k ^ 2 :=
        Nat.add_le_add_right hsum20 _
      _ ≤ 4 * claim4FullScale k * (k + 2) + claim4FullScale k :=
        Nat.add_le_add_left hM _
      _ ≤ 5 * claim4FullScale k * k := hpoly
  have hscaled' :
      (((claim4CambieYLower C k + claim4CambieGap C k) + k) * (4 * C)) *
          (5 * k) ≤
        claim4FullScale k * (5 * k) := by
    calc
      (((claim4CambieYLower C k + claim4CambieGap C k) + k) * (4 * C)) *
          (5 * k) =
        ((claim4CambieYLower C k + claim4CambieGap C k) + k) *
          (20 * C * k) := by ring
      _ ≤ 5 * claim4FullScale k * k := hscaled
      _ = claim4FullScale k * (5 * k) := by ring
  have hbase :
      ((claim4CambieYLower C k + claim4CambieGap C k) + k) * (4 * C) ≤
        claim4FullScale k :=
    Nat.le_of_mul_le_mul_right hscaled' (by positivity)
  have hquot :
      (claim4CambieYLower C k + claim4CambieGap C k) + k ≤
        claim4FullScale k / (4 * C) :=
    (Nat.le_div_iff_mul_le hd4).2 hbase
  unfold claim4CambieYUpper
  exact Nat.le_sub_of_add_le hquot

/-- The explicit large-`k` contract discharges the target-window and common
small-scale obligations simultaneously. -/
theorem Claim4CambieLargeKData.target_window_room
    {C k : ℕ} (h : Claim4CambieLargeKData C k) :
    claim4CambieYLower C k + claim4CambieGap C k ≤
      claim4CambieYUpper C k :=
  claim4Cambie_target_window_room_of_fullScale_growth
    h.C_pos h.nine_le h.fullScale_growth

/-- The explicit large-`k` contract also closes the separation scale. -/
theorem Claim4CambieLargeKData.small_scale_gap
    {C k : ℕ} (h : Claim4CambieLargeKData C k) :
    k + 2 ≤ claim4SmallScale k :=
  claim4SmallScale_gap_of_nine_le h.nine_le

/-- After the independent large-`k` condition is supplied, only the two sharp
prime/search budgets remain in the D4f arithmetic interface. -/
structure Claim4CambiePrimeBudgetData
    (C k xp xq xr yp yq : ℕ) : Prop where
  y_search_budget :
    (5 * C * k) * (claim4PairYSearchLength k yp yq + 1) ≤ yp * yq
  x_search_budget :
    (5 * C * k) * (claim4TripleXSearchLength k xp xq xr + 2) ≤
      xp * xq * xr

/-- Large-`k` growth plus the two prime/search budgets produce the reduced core
room contract. -/
theorem Claim4CambiePrimeBudgetData.toCoreData
    {C k xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (h : Claim4CambiePrimeBudgetData C k xp xq xr yp yq) :
    Claim4CambieRoomCoreData C k xp xq xr yp yq := by
  exact ⟨h.y_search_budget, h.x_search_budget,
    hlarge.target_window_room, hlarge.small_scale_gap⟩

/-- D4f endpoint with all non-prime room obligations discharged by the single
explicit large-`k` contract. -/
theorem claim4_exists_cambie_target_representatives_with_claim5_of_largeK
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
  exact claim4_exists_cambie_target_representatives_with_claim5_of_core
    hlarge.C_pos hprime (hbudget.toCoreData hlarge)

end Erdos678
