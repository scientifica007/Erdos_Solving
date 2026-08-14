import Formalization.Erdos678.ValuationBasic
import Mathlib.Algebra.GCDMonoid.FinsetLemmas

/-!
Finite-LCM valuation lemmas for Erdős Problem #678.

The generic theorem in this file deliberately delegates the LCM/factorization
step to Mathlib's `Finset.factorization_lcm`, rather than rebuilding it by
induction.  For a prime base, `Nat.factorization_def` then identifies the
factorization exponent with `padicValNat`.
-/

namespace Erdos678

/-- For a prime `p`, the `p`-adic valuation of the LCM of finitely many nonzero
naturals is the supremum (maximum) of their individual `p`-adic valuations. -/
theorem padicValNat_finset_lcm {ι : Type*} {f : ι → ℕ} {s : Finset ι}
    (hf : ∀ a ∈ s, f a ≠ 0) {p : ℕ} (hp : Nat.Prime p) :
    padicValNat p (s.lcm f) = s.sup (fun a => padicValNat p (f a)) := by
  simpa only [Nat.factorization_def _ hp] using
    (Finset.factorization_lcm (s := s) (f := f) hf p)

end Erdos678
