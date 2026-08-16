import Formalization.Erdos678.Claim4DependentPlacement

/-!
Width-form reduction of the D4 dependent-placement room contract.

The canonical search start `lower / scale + 1` is useful for constructing
representatives, but it is inconvenient for the quantitative estimates that
must discharge Cambie's sharp windows.  This module isolates a stronger but
simpler sufficient contract expressed only through window widths.

The reduction is purely arithmetic: no prime-density theorem and no new
asymptotic assumption is introduced here.
-/

namespace Erdos678

/-- The first canonical scaled search point is at most one scale above the
requested lower endpoint. -/
theorem claim4SearchStart_mul_le_add_scale (lower scale : ℕ) :
    claim4SearchStart lower scale * scale ≤ lower + scale := by
  calc
    claim4SearchStart lower scale * scale =
        (lower / scale) * scale + scale := by
      simp [claim4SearchStart, Nat.add_mul]
    _ ≤ lower + scale :=
      Nat.add_le_add_right (Nat.div_mul_le_self lower scale) scale

/-- A width bound of `(len+1)*scale` is sufficient for a multiplicatively
scaled canonical search block. -/
theorem claim4_mul_room_of_width
    {lower upper scale len : ℕ}
    (hwidth : lower + (len + 1) * scale ≤ upper) :
    (claim4SearchStart lower scale + len) * scale ≤ upper := by
  have hstart := claim4SearchStart_mul_le_add_scale lower scale
  calc
    (claim4SearchStart lower scale + len) * scale =
        claim4SearchStart lower scale * scale + len * scale := by
      rw [Nat.add_mul]
    _ ≤ (lower + scale) + len * scale :=
      Nat.add_le_add_right hstart (len * scale)
    _ = lower + (len + 1) * scale := by
      simp only [Nat.add_mul, one_mul]
      ac_rfl
    _ ≤ upper := hwidth

/-- The affine `x = 1 + z*scale` search has the analogous sufficient width
bound, with the visible affine `+1` retained. -/
theorem claim4_one_add_mul_room_of_width
    {lower upper scale len : ℕ}
    (hwidth : 1 + lower + (len + 1) * scale ≤ upper) :
    1 + (claim4SearchStart lower scale + len) * scale ≤ upper := by
  have hbase :
      (claim4SearchStart lower scale + len) * scale ≤
        lower + (len + 1) * scale :=
    claim4_mul_room_of_width (le_refl _)
  calc
    1 + (claim4SearchStart lower scale + len) * scale ≤
        1 + (lower + (len + 1) * scale) :=
      Nat.add_le_add_left hbase 1
    _ = 1 + lower + (len + 1) * scale := by
      simp [Nat.add_assoc]
    _ ≤ upper := hwidth

/-- A division-free sufficient contract for `Claim4DependentPlacementData`.

The `y` block only needs its absolute window width.  The moving `x` block only
needs a uniform width bounded by `gap`; `gap ≤ yLower` then guarantees that the
moving lower endpoint `y-gap` is genuine for every selected `y`. -/
structure Claim4DependentPlacementWidthData
    (k xp xq xr yp yq yLower yUpper gap : ℕ) : Prop where
  y_width :
    yLower +
        (claim4PairYSearchLength k yp yq + 1) *
          claim4YScale k yp yq ≤
      yUpper
  x_width :
    1 +
        (claim4TripleXSearchLength k xp xq xr + 1) *
          claim4XScale k xp xq xr ≤
      gap
  gap_le_yLower : gap ≤ yLower
  small_scale_gap : k + 2 ≤ claim4SmallScale k

/-- The width-form contract discharges the exact canonical-search room
obligations consumed by the dependent placement theorem. -/
theorem Claim4DependentPlacementWidthData.toDependentPlacementData
    {k xp xq xr yp yq yLower yUpper gap : ℕ}
    (h :
      Claim4DependentPlacementWidthData
        k xp xq xr yp yq yLower yUpper gap) :
    Claim4DependentPlacementData
      k xp xq xr yp yq yLower yUpper gap := by
  constructor
  · exact claim4_mul_room_of_width h.y_width
  · intro y hyLower hyUpper
    have hgaple : gap ≤ y :=
      h.gap_le_yLower.trans (Nat.le_of_lt hyLower)
    apply claim4_one_add_mul_room_of_width
    have hxwidth := h.x_width
    omega
  · exact h.small_scale_gap

end Erdos678
