import PrimeNumberTheoremAnd.Consequences

/-!
Diagnostic only: force the exact PNT+ consequence needed by Erdős #678 into
the reachable build graph.
-/

namespace Erdos678

example {ε : ℝ} (hε : 0 < ε) :
    ∀ᶠ x : ℝ in Filter.atTop,
      ∃ p : ℕ, Nat.Prime p ∧ x < p ∧ p < (1 + ε) * x := by
  exact prime_between hε

end Erdos678
