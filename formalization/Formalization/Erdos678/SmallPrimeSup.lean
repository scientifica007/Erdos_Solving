import Formalization.Erdos678.SmallPrimeWindows

/-!
Lower bounds for the valuation supremum in Cambie's small-prime range.
-/

namespace Erdos678

/-- A nonzero natural congruent to zero modulo `p^e` has `p`-adic valuation
at least `e`. -/
theorem exp_le_padicValNat_of_modEq_zero
    {n p e : ℕ} (hp : Nat.Prime p) (hn0 : n ≠ 0)
    (hmod : n ≡ 0 [MOD p ^ e]) :
    e ≤ padicValNat p n := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hd : p ^ e ∣ n := Nat.modEq_zero_iff_dvd.mp hmod
  exact (padicValNat_dvd_iff_le (p := p) (n := e) hn0).1 hd

/-- Consequently the valuation capped at `e` is exactly `e`. -/
theorem min_padicValNat_eq_exp_of_modEq_zero
    {n p e : ℕ} (hp : Nat.Prime p) (hn0 : n ≠ 0)
    (hmod : n ≡ 0 [MOD p ^ e]) :
    min (padicValNat p n) e = e := by
  rw [min_eq_right]
  exact exp_le_padicValNat_of_modEq_zero hp hn0 hmod

/-- If a block starts at `1` modulo `p^e` and is at least `p^e` terms long,
then it contains a multiple of `p^e`; hence its valuation supremum reaches
`e`. -/
theorem exp_le_interval_padicValNat_sup_of_modEq_one
    {start len p e : ℕ} (hp : Nat.Prime p)
    (hlen : p ^ e ≤ len)
    (hstart : start ≡ 1 [MOD p ^ e])
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0) :
    e ≤ (intervalFinset start len).sup (fun x => padicValNat p x) := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hpowe_pos : 0 < p ^ e := pow_pos hp.pos e
  let z : ℕ := start + (p ^ e - 1)
  have hzmem : z ∈ intervalFinset start len := by
    apply mem_intervalFinset_iff.mpr
    refine ⟨p ^ e - 1, ?_, rfl⟩
    omega
  have htarget : 1 + (p ^ e - 1) ≡ 0 [MOD p ^ e] := by
    have hone : 1 + (p ^ e - 1) = p ^ e := by omega
    rw [hone]
    exact (dvd_refl (p ^ e)).modEq_zero_nat
  have hzmod : z ≡ 0 [MOD p ^ e] := by
    dsimp [z]
    exact (hstart.add_right (p ^ e - 1)).trans htarget
  have hz0 : z ≠ 0 := hne z hzmem
  have hzval : e ≤ padicValNat p z :=
    exp_le_padicValNat_of_modEq_zero hp hz0 hzmod
  exact hzval.trans (Finset.le_sup hzmem)

end Erdos678
