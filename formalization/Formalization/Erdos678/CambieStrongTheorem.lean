import Formalization.Erdos678.Claim4CambieLargeKEventually
import Formalization.Erdos678.Claim4RelativePrimePNT

/-!
Phase E3: strong eventual Cambie LCM comparison.

E2 supplies the relative-prime witnesses from PNT once `k` is above an
analytic threshold, conditional only on the already isolated D4 large-`k`
package.  E3a supplies that package above an explicit elementary threshold.
Taking the maximum of the two thresholds removes every remaining auxiliary
hypothesis from the strict LCM comparison.
-/

namespace Erdos678

/-- Strong Cambie endpoint: for each positive factor `C`, every sufficiently
large block length admits separated interval starts whose LCMs differ by more
than that factor. -/
theorem cambie_lcm_ratio_eventually
    {C : ℕ} (hC : 0 < C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ x y : ℕ,
        0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
        C * intervalLCM y (k + 1) < intervalLCM x k := by
  obtain ⟨Kpnt, hpnt⟩ := claim4_exists_cambie_lcm_ratio_eventually_of_pnt hC
  let Kgrowth := claim4CambieLargeKThreshold C
  refine ⟨max Kpnt Kgrowth, ?_⟩
  intro k hk
  have hkPNT : Kpnt ≤ k := (Nat.le_max_left Kpnt Kgrowth).trans hk
  have hkGrowth : Kgrowth ≤ k := (Nat.le_max_right Kpnt Kgrowth).trans hk
  exact hpnt k hkPNT (claim4CambieLargeKData_of_threshold hC hkGrowth)

end Erdos678
