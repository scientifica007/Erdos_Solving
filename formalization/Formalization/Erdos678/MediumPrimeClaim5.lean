import Formalization.Erdos678.MediumPrimeValuation

/-!
Assembly of the medium-prime range of Cambie's Claim 5.

The Lean-facing range is `p <= k < p^2`, which is the exact arithmetic
property used in Cambie's `sqrt(k) < p <= k` case.  The residue-window counts,
the reciprocal-LCM valuation bridge, and the valuation of
`M = lcm(1, ..., k)` are combined here into the prime-by-prime Claim 5
identity for this range.
-/

namespace Erdos678

/-- If `p <= k < p^2`, then `p` occurs in `lcm(1,...,k)` but `p^2` does not,
so the `p`-adic valuation of that LCM is exactly one. -/
theorem padicValNat_initial_intervalLCM_eq_one
    {k p : ℕ} (hp : Nat.Prime p) (hpk : p ≤ k) (hkp2 : k < p ^ 2) :
    padicValNat p (intervalLCM 1 k) = 1 := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hne : ∀ z ∈ intervalFinset 1 k, id z ≠ 0 := by
    intro z hz
    simp only [id_eq]
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  change padicValNat p ((intervalFinset 1 k).lcm id) = 1
  rw [padicValNat_finset_lcm (f := id) hne hp]
  simp only [id_eq]
  apply le_antisymm
  · apply Finset.sup_le
    intro z hz
    have hz0 : z ≠ 0 := by
      simpa using hne z hz
    by_contra hnot
    have hv2 : 2 ≤ padicValNat p z := by omega
    have hd : p ^ 2 ∣ z :=
      (padicValNat_dvd_iff_le (p := p) (n := 2) hz0).2 hv2
    have hp2le : p ^ 2 ≤ z := Nat.le_of_dvd (Nat.pos_of_ne_zero hz0) hd
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    have hzle : z ≤ k := by omega
    omega
  · have hpmem : p ∈ intervalFinset 1 k := by
      apply mem_intervalFinset_iff.mpr
      refine ⟨p - 1, ?_, ?_⟩
      · have hp2 : 2 ≤ p := hp.two_le
        omega
      · have hp2 : 2 ≤ p := hp.two_le
        omega
    have hpval : padicValNat p p = 1 := padicValNat.self hp.one_lt
    calc
      1 = padicValNat p p := hpval.symm
      _ ≤ (intervalFinset 1 k).sup (fun z => padicValNat p z) :=
        Finset.le_sup hpmem

/-- Cambie's Claim 5 valuation identity in the medium-prime range.

The `x` block is `[x, ..., x+k-1]`, the `y` block is `[y, ..., y+k]`,
and `intervalLCM 1 k = lcm(1,...,k)`. -/
theorem claim5_medium_prime_range
    {x y k p a b : ℕ}
    (hp : Nat.Prime p)
    (hpk : p ≤ k) (hkp2 : k < p ^ 2)
    (ha1 : 1 ≤ a) (haUpper : a ≤ p - k % p)
    (hbLower : p - k % p ≤ b) (hbUpper : b ≤ p)
    (hx : x ≡ a [MOD p]) (hy : y ≡ b [MOD p])
    (hxne : ∀ z ∈ intervalFinset x k, z ≠ 0)
    (hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0) :
    padicValNat p (intervalProd y (k + 1) / intervalLCM y (k + 1)) =
      padicValNat p (intervalLCM 1 k) +
        padicValNat p (intervalProd x k / intervalLCM x k) := by
  have hxcount : intervalPrimePowerCount x k p 1 = k / p :=
    cambie_x_prime_count hp ha1 haUpper hx
  have hycount : intervalPrimePowerCount y (k + 1) p 1 = k / p + 1 :=
    cambie_y_prime_count hp hbLower hbUpper hy
  have hkdivpos : 0 < k / p := Nat.div_pos hpk hp.pos
  have hxcountpos : 0 < intervalPrimePowerCount x k p 1 := by
    rw [hxcount]
    exact hkdivpos
  have hycountpos : 0 < intervalPrimePowerCount y (k + 1) p 1 := by
    rw [hycount]
    omega
  have hxcount2 : intervalPrimePowerCount x k p 2 ≤ 1 := by
    change ((intervalFinset x k).filter fun z => p ^ 2 ∣ z).card ≤ 1
    exact interval_sq_multiples_card_le_one
      (start := x) (len := k) (p := p) (Nat.le_of_lt hkp2)
  have hycount2 : intervalPrimePowerCount y (k + 1) p 2 ≤ 1 := by
    change ((intervalFinset y (k + 1)).filter fun z => p ^ 2 ∣ z).card ≤ 1
    exact interval_sq_multiples_card_le_one
      (start := y) (len := k + 1) (p := p) (Nat.succ_le_of_lt hkp2)
  have hvx :=
    padicValNat_intervalProd_div_intervalLCM_eq_count_sub_one
      hp hxne hxcountpos hxcount2
  have hvy :=
    padicValNat_intervalProd_div_intervalLCM_eq_count_sub_one
      hp hyne hycountpos hycount2
  have hM := padicValNat_initial_intervalLCM_eq_one hp hpk hkp2
  rw [hxcount] at hvx
  rw [hycount] at hvy
  omega

end Erdos678
