import Formalization.Erdos678.Claim4CambieRoom

/-!
A uniform lower bound for Cambie's common small-prime scale.

For `k ≥ 9`, both maximal powers of `2` and `3` belong to the small-prime
part.  Their product already dominates `k+2`, so the full small scale does as
well.  This closes the `m-1>k` separation input without any analytic prime
result.
-/

namespace Erdos678

/-- For every `k ≥ 9`, the common small-prime scale is large enough to force
the separation used by the dependent representative theorem. -/
theorem claim4SmallScale_gap_of_nine_le
    {k : ℕ} (hk : 9 ≤ k) :
    k + 2 ≤ claim4SmallScale k := by
  have h2prime : Nat.Prime 2 := by norm_num
  have h3prime : Nat.Prime 3 := by norm_num
  have h2sq : 2 ^ 2 ≤ k := by
    norm_num
    omega
  have h3sq : 3 ^ 2 ≤ k := by
    norm_num
    omega
  have h2dvd : 2 ^ Nat.log 2 k ∣ claim4SmallScale k :=
    claim4SmallScale_pow_log_dvd h2prime h2sq
  have h3dvd : 3 ^ Nat.log 3 k ∣ claim4SmallScale k :=
    claim4SmallScale_pow_log_dvd h3prime h3sq
  have hcop :
      Nat.Coprime (2 ^ Nat.log 2 k) (3 ^ Nat.log 3 k) :=
    Nat.coprime_pow_primes _ _ h2prime h3prime (by norm_num)
  have hprodDvd :
      (2 ^ Nat.log 2 k) * (3 ^ Nat.log 3 k) ∣ claim4SmallScale k :=
    hcop.mul_dvd_of_dvd_of_dvd h2dvd h3dvd
  have h2bound : k < 2 * (2 ^ Nat.log 2 k) := by
    have h := Nat.lt_pow_succ_log_self h2prime.one_lt k
    simpa [pow_succ, mul_comm] using h
  have h3bound : k < 3 * (3 ^ Nat.log 3 k) := by
    have h := Nat.lt_pow_succ_log_self h3prime.one_lt k
    simpa [pow_succ, mul_comm] using h
  have hprodLower :
      k + 2 ≤ (2 ^ Nat.log 2 k) * (3 ^ Nat.log 3 k) := by
    nlinarith
  have hprodLe :
      (2 ^ Nat.log 2 k) * (3 ^ Nat.log 3 k) ≤ claim4SmallScale k :=
    Nat.le_of_dvd (claim4SmallScale_pos k) hprodDvd
  exact hprodLower.trans hprodLe

end Erdos678
