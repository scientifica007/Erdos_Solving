import Formalization.Erdos678.Claim4FullScaleLCM
import Formalization.Erdos678.Claim4RoomReduction

/-!
Sharp arithmetic budgets for Cambie's D4 target windows.

The paper chooses

* `y` between approximately `M/(5C) * (1 + 1/k)` and `M/(4C) - k`;
* `x` below the selected `y`, within distance approximately `M/(5Ck)`.

Here `M = claim4FullScale k = lcm(1,...,k)`.  Natural-number floor division is
used explicitly, so the definitions are total even before positivity
hypotheses are supplied.

The main purpose of this layer is to separate two kinds of obligations:

* sharp prime/search budgets, which later prime-window density must provide;
* large-`k` scale inequalities, which are independent of the CRT construction.

No prime-existence theorem is asserted here.
-/

namespace Erdos678

/-- Natural-number version of Cambie's closeness scale `M/(5 C k)`. -/
def claim4CambieGap (C k : ℕ) : ℕ :=
  claim4FullScale k / (5 * C * k)

/-- Division-safe lower endpoint corresponding to
`M/(5C) * (1 + 1/k) = M*(k+1)/(5Ck)`. -/
def claim4CambieYLower (C k : ℕ) : ℕ :=
  (claim4FullScale k * (k + 1)) / (5 * C * k)

/-- Division-safe upper endpoint corresponding to `M/(4C) - k`. -/
def claim4CambieYUpper (C k : ℕ) : ℕ :=
  claim4FullScale k / (4 * C) - k

/-- Finite arithmetic obligations sufficient for the width-form dependent
placement contract at Cambie's target scales.

The two search-budget fields are expressed before multiplying by `Nx` or
`Ny`.  Exact scale factorization then converts them to actual search widths.
The remaining fields are pure large-`k` inequalities. -/
structure Claim4CambieRoomBudgetData
    (C k xp xq xr yp yq : ℕ) : Prop where
  y_search_budget :
    (5 * C * k) * (claim4PairYSearchLength k yp yq + 1) ≤ yp * yq
  x_search_budget :
    (5 * C * k) * (claim4TripleXSearchLength k xp xq xr + 2) ≤
      xp * xq * xr
  target_window_room :
    claim4CambieYLower C k + claim4CambieGap C k ≤
      claim4CambieYUpper C k
  gap_le_yLower : claim4CambieGap C k ≤ claim4CambieYLower C k
  small_scale_gap : k + 2 ≤ claim4SmallScale k

/-- The sharp two-prime budget bounds the actual `y` search width by Cambie's
closeness scale. -/
theorem claim4_y_search_width_le_cambieGap
    {C k xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (hbudget :
      (5 * C * k) * (claim4PairYSearchLength k yp yq + 1) ≤ yp * yq) :
    (claim4PairYSearchLength k yp yq + 1) * claim4YScale k yp yq ≤
      claim4CambieGap C k := by
  have hk : 0 < k :=
    lt_of_lt_of_le hprime.xp_prime.pos hprime.xp_le_k
  have hd : 0 < 5 * C * k := by
    positivity
  unfold claim4CambieGap
  apply (Nat.le_div_iff_mul_le hd).2
  calc
    ((claim4PairYSearchLength k yp yq + 1) * claim4YScale k yp yq) *
          (5 * C * k) =
        ((5 * C * k) * (claim4PairYSearchLength k yp yq + 1)) *
          claim4YScale k yp yq := by
      ac_rfl
    _ ≤ (yp * yq) * claim4YScale k yp yq :=
      Nat.mul_le_mul_right (claim4YScale k yp yq) hbudget
    _ = claim4FullScale k := by
      rw [mul_comm]
      exact hprime.yScale_mul_specials_eq_full

/-- The sharp three-prime budget bounds the affine `x` search width by
Cambie's closeness scale. -/
theorem claim4_x_search_width_le_cambieGap
    {C k xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (hbudget :
      (5 * C * k) * (claim4TripleXSearchLength k xp xq xr + 2) ≤
        xp * xq * xr) :
    1 +
        (claim4TripleXSearchLength k xp xq xr + 1) *
          claim4XScale k xp xq xr ≤
      claim4CambieGap C k := by
  have hk : 0 < k :=
    lt_of_lt_of_le hprime.xp_prime.pos hprime.xp_le_k
  have hd : 0 < 5 * C * k := by
    positivity
  have hNx : 1 ≤ claim4XScale k xp xq xr :=
    claim4XScale_pos k xp xq xr
  have hpre :
      1 +
          (claim4TripleXSearchLength k xp xq xr + 1) *
            claim4XScale k xp xq xr ≤
        (claim4TripleXSearchLength k xp xq xr + 2) *
          claim4XScale k xp xq xr := by
    calc
      1 +
          (claim4TripleXSearchLength k xp xq xr + 1) *
            claim4XScale k xp xq xr ≤
        claim4XScale k xp xq xr +
          (claim4TripleXSearchLength k xp xq xr + 1) *
            claim4XScale k xp xq xr :=
          Nat.add_le_add_right hNx _
      _ = (claim4TripleXSearchLength k xp xq xr + 2) *
            claim4XScale k xp xq xr := by
          ring
  apply hpre.trans
  unfold claim4CambieGap
  apply (Nat.le_div_iff_mul_le hd).2
  calc
    ((claim4TripleXSearchLength k xp xq xr + 2) *
          claim4XScale k xp xq xr) * (5 * C * k) =
        ((5 * C * k) * (claim4TripleXSearchLength k xp xq xr + 2)) *
          claim4XScale k xp xq xr := by
      ac_rfl
    _ ≤ (xp * xq * xr) * claim4XScale k xp xq xr :=
      Nat.mul_le_mul_right (claim4XScale k xp xq xr) hbudget
    _ = claim4FullScale k := by
      rw [mul_comm]
      exact hprime.xScale_mul_specials_eq_full

/-- The budget contract produces the exact width-form placement data consumed
by the already verified dependent representative theorem. -/
theorem Claim4CambieRoomBudgetData.toWidthData
    {C k xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (h : Claim4CambieRoomBudgetData C k xp xq xr yp yq) :
    Claim4DependentPlacementWidthData
      k xp xq xr yp yq
      (claim4CambieYLower C k) (claim4CambieYUpper C k)
      (claim4CambieGap C k) := by
  constructor
  · have hywidth :=
      claim4_y_search_width_le_cambieGap hC hprime h.y_search_budget
    exact Nat.add_le_add_left hywidth (claim4CambieYLower C k) |>.trans
      h.target_window_room
  · exact claim4_x_search_width_le_cambieGap hC hprime h.x_search_budget
  · exact h.gap_le_yLower
  · exact h.small_scale_gap

/-- D4f reduction endpoint: once the finite sharp arithmetic budgets are
supplied, the existing dependent-placement theorem constructs Cambie's close
and separated representatives and the complete Claim 5 identity at the actual
target scales. -/
theorem claim4_exists_cambie_target_representatives_with_claim5
    {C k xp xq xr yp yq : ℕ}
    (hC : 0 < C)
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (h : Claim4CambieRoomBudgetData C k xp xq xr yp yq) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      y < x + claim4CambieGap C k ∧
      claim4CambieYLower C k < y ∧ y < claim4CambieYUpper C k ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k * (intervalProd x k / intervalLCM x k) := by
  exact claim4_exists_close_separated_representatives_with_claim5
    hprime (h.toWidthData hC hprime).toDependentPlacementData

end Erdos678
