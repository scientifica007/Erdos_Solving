import Formalization.Erdos678.Claim4RelativePrimePNT

/-!
Reachable E2e regressions: the imported PNT consequence must construct the
relative-prime provider and eliminate the analytic input from the LCM endpoint.
These checks also keep the corrected five-strip bridge reachable under the
canonical full build.
-/

namespace Erdos678

example : Nonempty (Claim4RelativePrimeProvider 2) := by
  exact ⟨claim4RelativePrimeProviderOfPNT 2 (by norm_num)⟩

example {C : ℕ} (hC : 0 < C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k → Claim4CambieLargeKData C k →
      ∃ x y : ℕ,
        0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
        C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_eventually_of_pnt hC

end Erdos678
