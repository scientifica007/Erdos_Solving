import Mathlib

namespace Erdos678

def intervalLCM (a k : ℕ) : ℕ :=
  (Finset.Icc a (a + k)).lcm id

def intervalProd (a k : ℕ) : ℕ :=
  (Finset.Icc a (a + k)).prod id

lemma eq_of_prime_padicValNat_eq {a b : ℕ} (ha : a ≠ 0) (hb : b ≠ 0)
    (h : ∀ p, Nat.Prime p → padicValNat p a = padicValNat p b) : a = b :=
  (Nat.eq_iff_prime_padicValNat_eq a b ha hb).2 h

end Erdos678
