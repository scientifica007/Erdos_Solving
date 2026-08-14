import Formalization.Erdos678.Intervals
import Formalization.Erdos678.ProductValuation
import Formalization.Erdos678.LCMValuation
import Mathlib.Algebra.GCDMonoid.FinsetLemmas

/-!
Valuation of the product/LCM factor used in Cambie's Claim 5.

The quotient is taken only after using Mathlib's `Finset.lcm_dvd_prod`, so the
`Nat` division is an exact quotient.  This keeps the formal statement aligned
with the mathematical reciprocal-LCM factor rather than relying on unchecked
integer-division manipulations.
-/

namespace Erdos678

/-- For a finite set of nonzero naturals, the `p`-adic valuation of
`product / lcm` is the sum of the individual valuations minus their maximum. -/
theorem padicValNat_prod_div_lcm
    {p : ℕ} (hp : Nat.Prime p) {s : Finset ℕ}
    (hne : ∀ x ∈ s, x ≠ 0) :
    padicValNat p ((s.prod id) / (s.lcm id)) =
      s.sum (fun x => padicValNat p x) -
        s.sup (fun x => padicValNat p x) := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  rw [padicValNat.div_of_dvd (Finset.lcm_dvd_prod s id)]
  rw [padicValNat_finset_prod hp hne]
  rw [padicValNat_finset_lcm (f := id) hne hp]
  simp only [id_eq]

/-- The same valuation formula specialized to a consecutive length-based block. -/
theorem padicValNat_intervalProd_div_intervalLCM
    {start len p : ℕ} (hp : Nat.Prime p)
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0) :
    padicValNat p (intervalProd start len / intervalLCM start len) =
      (intervalFinset start len).sum (fun x => padicValNat p x) -
        (intervalFinset start len).sup (fun x => padicValNat p x) := by
  exact padicValNat_prod_div_lcm hp hne

end Erdos678
