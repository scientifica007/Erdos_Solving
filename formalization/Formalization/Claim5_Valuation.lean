import Mathlib

namespace Erdos678

/-- Prime-adic valuation is additive on products for a prime `p`. -/
lemma padicValNat_mul
    {p a b : ℕ}
    (hp : Nat.Prime p)
    (ha : a ≠ 0)
    (hb : b ≠ 0) :
    padicValNat p (a * b) = padicValNat p a + padicValNat p b := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  exact padicValNat.mul ha hb

end Erdos678
