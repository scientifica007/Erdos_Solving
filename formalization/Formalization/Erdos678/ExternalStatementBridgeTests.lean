import Formalization.Erdos678.ExternalStatementBridge

/-!
Regression checks and axiom audits for the Erdős #678 external-statement bridge.
-/

namespace Erdos678

example : intervalFinset 37 8 = Finset.Ioc 36 44 := by
  simpa using intervalFinset_succ_eq_Ioc 36 8

example : erdosM 36 8 = (Finset.Ioc 36 44).lcm id := by
  simpa using erdosM_eq_Ioc_lcm 36 8

example :
    ∀ B : ℕ, ∃ k : ℕ, B ≤ k ∧
      {p : ℕ × ℕ | erdos678ValidPair k p}.Nonempty :=
  erdos678_valid_pair_lengths_unbounded

example :
    Set.Infinite
      {k : ℕ | {p : ℕ × ℕ | erdos678ValidPair k p}.Nonempty} :=
  erdos678_valid_pair_good_lengths_infinite

example :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ x y : ℕ,
        k < x ∧ x < y ∧ x + k < y ∧
        (3 / 2 : ℝ) * (intervalLCM y (k + 1) : ℝ) <
          (intervalLCM x k : ℝ) := by
  exact cambie_lcm_ratio_eventually_with_large_start_real (C := (3 / 2 : ℝ)) (by norm_num)

#check erdos678_formalConjectures_eventual_nonempty
#check erdos678_valid_pair_lengths_unbounded
#check erdos678_valid_pair_good_lengths_infinite
#check erdos678_good_lengths_infinite

#print axioms Erdos678.cambie_lcm_ratio_eventually_with_large_start_real
#print axioms Erdos678.erdos678_formalConjectures_eventual_nonempty
#print axioms Erdos678.erdos678_valid_pair_lengths_unbounded
#print axioms Erdos678.erdos678_valid_pair_good_lengths_infinite
#print axioms Erdos678.erdos678_unbounded_witnesses
#print axioms Erdos678.erdos678_good_lengths_infinite

end Erdos678
