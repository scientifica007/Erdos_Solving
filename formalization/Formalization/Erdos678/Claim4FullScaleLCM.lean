import Formalization.Erdos678.Claim4ScaleFactorization
import Mathlib.NumberTheory.Chebyshev

/-!
Identification of the D4 full arithmetic scale with the canonical initial LCM.

Cambie's quantitative argument writes

`M = lcm(1, ..., k)`

and decomposes `M` into maximal powers of primes with `p^2 ≤ k` together with
one copy of every prime in the medium range `p ≤ k < p^2`.  The D4 scale layer
was deliberately built in exactly that form.  This module proves that the two
objects are definitionally different presentations of the same natural
number.
-/

namespace Erdos678

/-- The length-based interval `{1, ..., k}` agrees with Mathlib's closed
interval presentation. -/
theorem intervalFinset_one_eq_Icc (k : ℕ) :
    intervalFinset 1 k = Finset.Icc 1 k := by
  ext n
  simp [intervalFinset]
  omega

/-- The repository's initial interval LCM agrees with Mathlib's `lcmUpto`. -/
theorem intervalLCM_one_eq_lcmUpto (k : ℕ) :
    intervalLCM 1 k = Nat.lcmUpto k := by
  simp [intervalLCM, Nat.lcmUpto, intervalFinset_one_eq_Icc]

/-- A medium prime occurs to the first power in `lcm(1,...,k)`. -/
theorem claim4MediumPrime_log_eq_one
    {k p : ℕ} (hp : Nat.Prime p) (hpk : p ≤ k) (hkp2 : k < p ^ 2) :
    Nat.log p k = 1 := by
  rw [Nat.log_eq_one_iff]
  exact ⟨by simpa [pow_two] using hkp2, hp.one_lt, hpk⟩

/-- Splitting Mathlib's prime-power formula at `p^2 ≤ k` produces exactly the
small-scale/medium-prime product used by D4. -/
theorem claim4SmallScale_mul_medium_eq_prime_power_product (k : ℕ) :
    claim4SmallScale k * (claim4MediumPrimes k).prod id =
      ∏ p ∈ Nat.primesLE k, p ^ Nat.log p k := by
  have hsmall :
      (Nat.primesLE k).filter (fun p => p ^ 2 ≤ k) =
        claim4SmallPrimes k := by
    ext p
    simp [claim4SmallPrimes, Nat.mem_primesLE, and_assoc, and_left_comm,
      and_comm]
  have hmedium :
      (Nat.primesLE k).filter (fun p => ¬p ^ 2 ≤ k) =
        claim4MediumPrimes k := by
    ext p
    simp [claim4MediumPrimes, Nat.mem_primesLE, and_assoc, and_left_comm,
      and_comm]
  have hmediumProd :
      (claim4MediumPrimes k).prod (fun p => p ^ Nat.log p k) =
        (claim4MediumPrimes k).prod id := by
    apply Finset.prod_congr rfl
    intro p hpMem
    have hpData := mem_claim4MediumPrimes.mp hpMem
    have hlog : Nat.log p k = 1 :=
      claim4MediumPrime_log_eq_one hpData.2.1 hpData.1 hpData.2.2
    simp [hlog]
  have hsplit :=
    Finset.prod_filter_mul_prod_filter_not
      (Nat.primesLE k) (fun p => p ^ 2 ≤ k)
      (fun p => p ^ Nat.log p k)
  rw [hsmall, hmedium, hmediumProd] at hsplit
  simpa [claim4SmallScale] using hsplit

/-- The complete D4 scale is Mathlib's `lcmUpto k`. -/
theorem claim4FullScale_eq_lcmUpto (k : ℕ) :
    claim4FullScale k = Nat.lcmUpto k := by
  rw [Nat.lcmUpto_eq_prod_pow_log]
  simpa [claim4FullScale, claim4Scale] using
    claim4SmallScale_mul_medium_eq_prime_power_product k

/-- Main D4f.2 bridge: `claim4FullScale k` is exactly
`lcm(1, ..., k)` in the repository's length-based interval notation. -/
theorem claim4FullScale_eq_initialLCM (k : ℕ) :
    claim4FullScale k = intervalLCM 1 k := by
  rw [claim4FullScale_eq_lcmUpto, intervalLCM_one_eq_lcmUpto]

end Erdos678
