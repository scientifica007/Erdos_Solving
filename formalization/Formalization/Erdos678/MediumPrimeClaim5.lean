import Formalization.Erdos678.MediumPrimeValuation

/-!
Assembly of the medium-prime range of Cambie's Claim 5.

This file first proves the missing valuation of
`M = lcm(1, ..., k)`: when `p <= k < p^2`, its `p`-adic valuation is exactly
one.  The final medium-prime Claim 5 relation is assembled only after this
input is machine-checked.
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

end Erdos678
