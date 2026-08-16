import Formalization.Erdos678.Claim4CambieLargeKEventually

/-! Reachable regressions for the explicit eventual large-`k` package. -/

namespace Erdos678

example {k : ℕ} (hk : 3843 ≤ k) : Claim4CambieLargeKData 1 k := by
  apply claim4CambieLargeKData_of_threshold (C := 1)
  · norm_num
  · simpa [claim4CambieLargeKThreshold] using hk

example {C : ℕ} (hC : 0 < C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k → Claim4CambieLargeKData C k := by
  exact claim4CambieLargeKData_eventually hC

end Erdos678
