import Formalization.Erdos678.SmallPrimeClaim5

/-!
Concrete boundary regressions for the small-prime range of Cambie's Claim 5.

The positive examples instantiate the general theorem at the lower exponent
boundary and at exponent zero.  The negative example records that the required
congruence for the y-block is not vacuous.
-/

namespace Erdos678

/-- Positive regression at p = 2, e = 1, and the lower boundary k = p^e. -/
example :
    padicValNat 2 (intervalProd 6 3 / intervalLCM 6 3) =
      padicValNat 2 (intervalLCM 1 2) +
        padicValNat 2 (intervalProd 3 2 / intervalLCM 3 2) := by
  apply claim5_small_prime_range (x := 3) (y := 6) (k := 2) (p := 2) (e := 1)
  · norm_num
  · norm_num
  · norm_num
  · norm_num [Nat.ModEq]
  · norm_num [Nat.ModEq]
  · intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  · intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega

/-- Boundary regression at exponent e = 0. -/
example :
    padicValNat 2 (intervalProd 4 2 / intervalLCM 4 2) =
      padicValNat 2 (intervalLCM 1 1) +
        padicValNat 2 (intervalProd 3 1 / intervalLCM 3 1) := by
  apply claim5_small_prime_range (x := 3) (y := 4) (k := 1) (p := 2) (e := 0)
  · norm_num
  · norm_num
  · norm_num
  · norm_num [Nat.ModEq]
  · norm_num [Nat.ModEq]
  · intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  · intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega

/-- Negative congruence regression for the deliberately invalid y = 5 case. -/
example : ¬ (5 ≡ 0 [MOD 2]) := by
  norm_num [Nat.ModEq]

end Erdos678
