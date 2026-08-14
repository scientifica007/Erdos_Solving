import Mathlib

namespace Erdos678

/-- Prime-adic valuation is additive on products. -/
lemma padicValNat_mul (p a b : ℕ) :
    padicValNat p (a * b) = padicValNat p a + padicValNat p b := by
  rw [padicValNat.mul]

end Erdos678
