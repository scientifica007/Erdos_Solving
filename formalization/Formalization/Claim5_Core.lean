import Mathlib

namespace Erdos678

/-- The LCM of a finite consecutive interval `[a, a+k]`.
The endpoint convention is deliberately explicit: both endpoints are included. -/
def intervalLCM (a k : ℕ) : ℕ :=
  (Finset.Icc a (a + k)).lcm id

/-- The product of a finite consecutive interval `[a, a+k]`. -/
def intervalProd (a k : ℕ) : ℕ :=
  (Finset.Icc a (a + k)).prod id

/-- Two positive naturals are equal once all prime `padicValNat`s agree.
This is the equality principle that will be used to prove Claim 5. -/
theorem eq_of_prime_padicValNat_eq
    {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (h : ∀ p : ℕ, Nat.Prime p → Nat.padicValNat p a = Nat.padicValNat p b) :
    a = b := by
  exact (Nat.eq_iff_prime_padicValNat_eq a b ha hb).2 h

/--
Claim 5 is intentionally not asserted here yet.
The next layer must prove the prime-by-prime valuation identity for the
specific residue conditions on `x` and `y` used by Cambie's construction.
In particular, endpoint conventions must remain explicit:
`intervalLCM y k = lcm(y, ..., y+k)`.
-/
end Erdos678
