import Formalization.Erdos678.SmallPrimeRange

/-!
The `p`-adic valuation of the initial LCM in exponent form.

Instead of introducing `floor(log_p k)`, we parameterize by the exact exponent
`e` characterized by `p^e <= k < p^(e+1)`.  This is the property consumed by
Cambie's Claim 5 and is easier to compose with the capped-valuation layer.
-/

namespace Erdos678

/-- If `p^e <= k < p^(e+1)`, then the `p`-adic valuation of
`lcm(1,...,k)` is exactly `e`. -/
theorem padicValNat_initial_intervalLCM_eq_exp
    {k p e : ℕ} (hp : Nat.Prime p)
    (hlo : p ^ e ≤ k) (hhi : k < p ^ (e + 1)) :
    padicValNat p (intervalLCM 1 k) = e := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hne : ∀ z ∈ intervalFinset 1 k, id z ≠ 0 := by
    intro z hz
    simp only [id_eq]
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  change padicValNat p ((intervalFinset 1 k).lcm id) = e
  rw [padicValNat_finset_lcm (f := id) hne hp]
  simp only [id_eq]
  apply le_antisymm
  · apply Finset.sup_le
    intro z hz
    have hz0 : z ≠ 0 := by simpa using hne z hz
    by_contra hnot
    have hv : e + 1 ≤ padicValNat p z := by omega
    have hd : p ^ (e + 1) ∣ z :=
      (padicValNat_dvd_iff_le (p := p) (n := e + 1) hz0).2 hv
    have hpowle : p ^ (e + 1) ≤ z := Nat.le_of_dvd (Nat.pos_of_ne_zero hz0) hd
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    have hzle : z ≤ k := by omega
    omega
  · have hpowe_pos : 0 < p ^ e := pow_pos hp.pos e
    have hmem : p ^ e ∈ intervalFinset 1 k := by
      apply mem_intervalFinset_iff.mpr
      refine ⟨p ^ e - 1, ?_, ?_⟩
      · omega
      · omega
    have hval : padicValNat p (p ^ e) = e := padicValNat.prime_pow e
    calc
      e = padicValNat p (p ^ e) := hval.symm
      _ ≤ (intervalFinset 1 k).sup (fun z => padicValNat p z) := Finset.le_sup hmem

end Erdos678
