import Formalization.Erdos678.Erdos678Final

/-! Reachable regressions for the final Erdős #678 translation. -/

namespace Erdos678

example (B : ℕ) :
    ∃ n m k : ℕ,
      B ≤ k ∧ 3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + k ≤ m ∧
        erdosM m (k + 1) < erdosM n k := by
  exact erdos678_unbounded_witnesses B

example :
    Set.Infinite
      {k : ℕ |
        ∃ n m : ℕ,
          3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + k ≤ m ∧
            erdosM m (k + 1) < erdosM n k} := by
  exact erdos678_good_lengths_infinite

end Erdos678
