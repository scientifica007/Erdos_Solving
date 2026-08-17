import Formalization.Erdos678.ExternalStatementBridge

namespace Erdos678

example : intervalFinset 37 8 = Finset.Ioc 36 44 := by
  simpa using intervalFinset_succ_eq_Ioc 36 8

example : erdosM 36 8 = (Finset.Ioc 36 44).lcm id := by
  simpa using erdosM_eq_Ioc_lcm 36 8

example :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ x y : ℕ,
        k < x ∧ x < y ∧ x + k < y ∧
        (3 / 2 : ℝ) * (intervalLCM y (k + 1) : ℝ) <
          (intervalLCM x k : ℝ) := by
  exact cambie_lcm_ratio_eventually_with_large_start_real (C := (3 / 2 : ℝ)) (by norm_num)

#check erdos678_formalConjectures_eventual_nonempty
#check erdos678_good_lengths_infinite

#print axioms Erdos678.cambie_lcm_ratio_eventually_with_large_start_real
#print axioms Erdos678.erdos678_formalConjectures_eventual_nonempty
#print axioms Erdos678.erdos678_unbounded_witnesses
#print axioms Erdos678.erdos678_good_lengths_infinite

end Erdos678
