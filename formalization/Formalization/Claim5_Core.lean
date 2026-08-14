import Mathlib

namespace Erdos678

/-- LCM of the inclusive interval `[a, a+k]`. -/
def intervalLCM (a k : ℕ) : ℕ :=
  (Finset.Icc a (a + k)).lcm id

/-- Product of the inclusive interval `[a, a+k]`. -/
def intervalProd (a k : ℕ) : ℕ :=
  (Finset.Icc a (a + k)).prod id

/-- Prime-by-prime equality principle for positive naturals. -/
lemma eq_of_prime_padicValNat_eq
    {a b : ℕ}
    (ha : a ≠ 0)
    (hb : b ≠ 0)
    (h : ∀ p : ℕ, Nat.Prime p → padicValNat p a = padicValNat p b) :
    a = b := by
  apply (Nat.eq_iff_prime_padicValNat_eq a b ha hb).2
  intro p hp
  exact h p hp

/--
Claim 5 is not asserted yet. The next layer will prove its
prime-by-prime valuation identity under Cambie's residue conditions.
The endpoint convention is explicit: `intervalLCM y k` means
`lcm(y, ..., y+k)`.
-/

end Erdos678
