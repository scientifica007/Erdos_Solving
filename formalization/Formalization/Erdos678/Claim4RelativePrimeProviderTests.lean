import Formalization.Erdos678.Claim4RelativePrimeProvider

/-!
Reachable regressions for the E2d relative-prime arithmetic adapter.
-/

namespace Erdos678

/-- Closed arithmetic regression: a multiplicative relative witness lies in the
predicted additive strip. -/
example : 91 < 97 ∧ 97 ≤ 91 + 100 / 10 := by
  apply claim4_relative_prime_witness_in_additive_strip
  · norm_num
  · norm_num
  · norm_num
  · norm_num

/-- Generic reachability of an explicit provider into an additive prime strip. -/
example
    {q k n : ℕ}
    (h : Claim4RelativePrimeProvider q)
    (hq : 0 < q)
    (hn : h.threshold ≤ n)
    (hnk : n ≤ k) :
    ∃ p : ℕ, Nat.Prime p ∧ n < p ∧ p ≤ n + k / q := by
  exact h.exists_prime_in_additive_strip hq hn hnk

end Erdos678
