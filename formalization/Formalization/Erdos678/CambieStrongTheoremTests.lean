import Formalization.Erdos678.CambieStrongTheorem

/-! Reachable regression for the strong eventual Cambie endpoint. -/

namespace Erdos678

example :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ x y : ℕ,
        0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
        intervalLCM y (k + 1) < intervalLCM x k := by
  simpa using cambie_lcm_ratio_eventually (C := 1) (by norm_num)

end Erdos678
