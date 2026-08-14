import Formalization.Erdos678.MediumPrimeClaim5
import Mathlib.Data.Nat.ModEq

/-!
The small-prime range in Cambie's Claim 5.

The central invariant is not equality of full `p`-adic valuations.  Cambie's
congruences only force equality up to the exponent `e` occurring in
`lcm(1,...,k)`.  We therefore first formalize the exact capped information:
congruence modulo `p^e` preserves every divisibility level `p^r` for `r <= e`.
-/

namespace Erdos678

/-- Congruence modulo `p^e` descends to congruence modulo every lower power
`p^r`, `r <= e`. -/
theorem modEq_prime_pow_of_le
    {a b p e r : ℕ} (hre : r ≤ e) (hmod : a ≡ b [MOD p ^ e]) :
    a ≡ b [MOD p ^ r] := by
  exact hmod.of_dvd (pow_dvd_pow p hre)

/-- For nonzero naturals, congruence modulo `p^e` makes the `p`-adic
valuations indistinguishable at every level up to `e`.

This is the formal capped-valuation principle used in Cambie's small-prime
range. -/
theorem padicValNat_level_iff_of_modEq_prime_pow
    {a b p e r : ℕ} (hp : Nat.Prime p)
    (ha0 : a ≠ 0) (hb0 : b ≠ 0)
    (hre : r ≤ e) (hmod : a ≡ b [MOD p ^ e]) :
    r ≤ padicValNat p a ↔ r ≤ padicValNat p b := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have hmodr : a ≡ b [MOD p ^ r] := modEq_prime_pow_of_le hre hmod
  constructor
  · intro hva
    have hda : p ^ r ∣ a :=
      (padicValNat_dvd_iff_le (p := p) (n := r) ha0).2 hva
    have haMod0 : a ≡ 0 [MOD p ^ r] := hda.modEq_zero_nat
    have hbMod0 : b ≡ 0 [MOD p ^ r] := hmodr.symm.trans haMod0
    have hdb : p ^ r ∣ b := Nat.modEq_zero_iff_dvd.mp hbMod0
    exact (padicValNat_dvd_iff_le (p := p) (n := r) hb0).1 hdb
  · intro hvb
    have hdb : p ^ r ∣ b :=
      (padicValNat_dvd_iff_le (p := p) (n := r) hb0).2 hvb
    have hbMod0 : b ≡ 0 [MOD p ^ r] := hdb.modEq_zero_nat
    have haMod0 : a ≡ 0 [MOD p ^ r] := hmodr.trans hbMod0
    have hda : p ^ r ∣ a := Nat.modEq_zero_iff_dvd.mp haMod0
    exact (padicValNat_dvd_iff_le (p := p) (n := r) ha0).1 hda

/-- Congruence modulo `p^e` forces equality of the `p`-adic valuations after
capping both at `e`. -/
theorem min_padicValNat_eq_of_modEq_prime_pow
    {a b p e : ℕ} (hp : Nat.Prime p)
    (ha0 : a ≠ 0) (hb0 : b ≠ 0)
    (hmod : a ≡ b [MOD p ^ e]) :
    min (padicValNat p a) e = min (padicValNat p b) e := by
  apply le_antisymm
  · apply le_min
    · have hre : min (padicValNat p a) e ≤ e := min_le_right _ _
      have hva : min (padicValNat p a) e ≤ padicValNat p a := min_le_left _ _
      exact (padicValNat_level_iff_of_modEq_prime_pow hp ha0 hb0 hre hmod).1 hva
    · exact min_le_right _ _
  · apply le_min
    · have hre : min (padicValNat p b) e ≤ e := min_le_right _ _
      have hvb : min (padicValNat p b) e ≤ padicValNat p b := min_le_left _ _
      exact (padicValNat_level_iff_of_modEq_prime_pow hp ha0 hb0 hre hmod).2 hvb
    · exact min_le_right _ _

end Erdos678
