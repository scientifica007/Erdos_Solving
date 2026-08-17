import Formalization.Erdos678.Claim4Placement

/-!
Cambie-style dependent placement for the D4 representatives.

The `y` representative is chosen first in an absolute numerical window.  The
`x` search block is then placed in the moving interval `(y - gap, y)`.  This
separates two logically different quantitative requirements:

* the moving `x` window gives the upper closeness bound `y < x + gap`;
* the common small-prime scale gives the lower separation bound `x + k < y`,
  because the constructed representatives satisfy `x ≡ 1` and `y ≡ 0`
  modulo that scale.

No prime-density theorem is imported here.  The room hypotheses are a finite
arithmetic contract for a later large-`k` / prime-density layer to discharge
for Cambie's concrete target ranges.
-/

namespace Erdos678

/-- Quantitative contract for choosing `y` first and then choosing `x` close
below that actual `y`. -/
structure Claim4DependentPlacementData
    (k xp xq xr yp yq yLower yUpper gap : ℕ) : Prop where
  y_room :
    (claim4SearchStart yLower (claim4YScale k yp yq) +
        claim4PairYSearchLength k yp yq) *
      claim4YScale k yp yq ≤
    yUpper
  x_room :
    ∀ y : ℕ, yLower < y → y < yUpper →
      1 +
          (claim4SearchStart (y - gap) (claim4XScale k xp xq xr) +
              claim4TripleXSearchLength k xp xq xr) *
            claim4XScale k xp xq xr ≤
        y
  small_scale_gap : k + 2 ≤ claim4SmallScale k

/-- D4 dependent-placement endpoint.  It constructs representatives with both
Cambie inequalities

`x + k < y < x + gap`

and carries the same representatives through both Claim 5 residue interfaces
and the complete Claim 5 identity. -/
theorem claim4_exists_close_separated_representatives_with_claim5
    {k xp xq xr yp yq yLower yUpper gap : ℕ}
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (hplace :
      Claim4DependentPlacementData
        k xp xq xr yp yq yLower yUpper gap) :
    ∃ x y : ℕ,
      0 < x ∧
      0 < y ∧
      x < y ∧
      x + k < y ∧
      y < x + gap ∧
      yLower < y ∧ y < yUpper ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k *
          (intervalProd x k / intervalLCM x k) := by
  rcases claim4_exists_y_box_in_window
      (k := k) (xp := xp) (xq := xq) (xr := xr)
      (yp := yp) (yq := yq)
      (lower := yLower) (upper := yUpper)
      hprime hplace.y_room with
    ⟨zy, hzy, hyLower0, hyUpper0, hybox0⟩
  let y := zy * claim4YScale k yp yq
  have hyLower : yLower < y := by
    simpa [y] using hyLower0
  have hyUpper : y < yUpper := by
    simpa [y] using hyUpper0
  rcases claim4_exists_x_box_in_window
      (k := k) (xp := xp) (xq := xq) (xr := xr)
      (yp := yp) (yq := yq)
      (lower := y - gap) (upper := y)
      hprime (hplace.x_room y hyLower hyUpper) with
    ⟨zx, hzx, hxLower0, hxy0, hxbox0⟩
  let x := 1 + zx * claim4XScale k xp xq xr
  have hxLower : y - gap < x := by
    simpa [x] using hxLower0
  have hxy : x < y := by
    simpa [x] using hxy0
  have hclose : y < x + gap := by
    omega
  have hxbox :
      ∀ i : Fin 3,
        1 ≤ claim4PaperCoefficient (claim4TriplePrime xp xq xr i)
              (x % claim4TriplePrime xp xq xr i) ∧
          claim4PaperCoefficient (claim4TriplePrime xp xq xr i)
              (x % claim4TriplePrime xp xq xr i) ≤
            claim4TriplePrime xp xq xr i -
              k % claim4TriplePrime xp xq xr i := by
    simpa [x] using hxbox0
  have hybox :
      ∀ i : Fin 2,
        claim4PairPrime yp yq i - k % claim4PairPrime yp yq i ≤
            claim4PaperCoefficient (claim4PairPrime yp yq i)
              (y % claim4PairPrime yp yq i) ∧
          claim4PaperCoefficient (claim4PairPrime yp yq i)
              (y % claim4PairPrime yp yq i) ≤
            claim4PairPrime yp yq i := by
    simpa [y] using hybox0
  have hmedium : Claim5MediumResidues x y k := by
    apply claim5MediumResidues_of_pair_triple_boxes hxbox hybox
    · intro p hp hpk hkp2 hpxp hpxq hpxr
      have hdiv : p ∣ claim4XScale k xp xq xr :=
        claim4XScale_dvd_of_medium_other hp hpk hkp2 hpxp hpxq hpxr
      have hzero :
          zx * claim4XScale k xp xq xr ≡ 0 [MOD p] :=
        Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hdiv zx)
      have hone :
          1 + zx * claim4XScale k xp xq xr ≡ 1 [MOD p] := by
        simpa using hzero.add_left 1
      simpa [x] using hone
    · intro p hp hpk hkp2 hpyp hpyq
      have hdiv : p ∣ claim4YScale k yp yq :=
        claim4YScale_dvd_of_medium_other hp hpk hkp2 hpyp hpyq
      have hzero :
          zy * claim4YScale k yp yq ≡ 0 [MOD p] :=
        Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hdiv zy)
      simpa [y] using hzero
  have hsmall0 :=
    claim5SmallResidues_of_scales
      (zx := zx) (zy := zy)
      (claim4XYSmallPrimeScaleData k xp xq xr yp yq)
  have hsmall : Claim5SmallResidues x y k := by
    simpa [x, y] using hsmall0
  have hmNx :
      claim4SmallScale k ∣ claim4XScale k xp xq xr := by
    simpa [claim4XScale] using
      (claim4SmallScale_dvd_scale k ({xp, xq, xr} : Finset ℕ))
  have hmNy :
      claim4SmallScale k ∣ claim4YScale k yp yq := by
    simpa [claim4YScale] using
      (claim4SmallScale_dvd_scale k ({yp, yq} : Finset ℕ))
  have hxzero :
      zx * claim4XScale k xp xq xr ≡ 0 [MOD claim4SmallScale k] :=
    Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hmNx zx)
  have hxmod0 :
      1 + zx * claim4XScale k xp xq xr ≡ 1
        [MOD claim4SmallScale k] := by
    simpa using hxzero.add_left 1
  have hxmod : x ≡ 1 [MOD claim4SmallScale k] := by
    simpa [x] using hxmod0
  have hymod0 :
      zy * claim4YScale k yp yq ≡ 0 [MOD claim4SmallScale k] :=
    Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hmNy zy)
  have hymod : y ≡ 0 [MOD claim4SmallScale k] := by
    simpa [y] using hymod0
  have hyone : y + 1 ≡ 1 [MOD claim4SmallScale k] := by
    simpa using hymod.add_right 1
  have hxyone : x ≡ y + 1 [MOD claim4SmallScale k] :=
    hxmod.trans hyone.symm
  have hxleyone : x ≤ y + 1 := by
    omega
  have hdivdiff : claim4SmallScale k ∣ (y + 1) - x :=
    (Nat.modEq_iff_dvd' hxleyone).mp hxyone
  have hdiffpos : 0 < (y + 1) - x := by
    omega
  have hmle : claim4SmallScale k ≤ (y + 1) - x :=
    Nat.le_of_dvd hdiffpos hdivdiff
  have hgap : x + k < y := by
    have hsmallgap : k + 2 ≤ claim4SmallScale k := hplace.small_scale_gap
    omega
  have hxpos : 0 < x := by
    dsimp [x]
    omega
  have hypos : 0 < y := by
    omega
  have hk : 0 < k :=
    lt_of_lt_of_le hprime.xp_prime.pos hprime.xp_le_k
  have hxne : ∀ z ∈ intervalFinset x k, z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hid := claim5_full_identity_of_residues
    hk hxne hyne hmedium hsmall
  exact ⟨x, y, hxpos, hypos, hxy, hgap, hclose,
    hyLower, hyUpper, hmedium, hsmall, hid⟩

end Erdos678
