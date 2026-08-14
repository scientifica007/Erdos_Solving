import Mathlib

namespace Erdos678

/-- Two nonzero naturals are equal once all prime `padicValNat` values agree. -/
lemma eq_of_prime_padicValNat_eq
    {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (h : ∀ p : ℕ, Nat.Prime p → padicValNat p a = padicValNat p b) :
    a = b := by
  exact (Nat.eq_iff_prime_padicValNat_eq a b ha hb).2 h

/-- `padicValNat` is additive on a nonzero product for a prime base. -/
lemma padicValNat_mul_of_prime
    {p a b : ℕ}
    (hp : Nat.Prime p)
    (ha : a ≠ 0)
    (hb : b ≠ 0) :
    padicValNat p (a * b) = padicValNat p a + padicValNat p b := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  exact padicValNat.mul ha hb

end Erdos678
