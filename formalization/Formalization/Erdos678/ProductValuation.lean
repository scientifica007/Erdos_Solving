import Formalization.Erdos678.ValuationBasic

/-!
Finite-product `p`-adic valuation lemmas for the Erdős #678 formalization.
-/

namespace Erdos678

/-- For a prime `p`, the `p`-adic valuation of a finite product of nonzero
naturals is the sum of the individual valuations. -/
lemma padicValNat_finset_prod
    {p : ℕ} (hp : Nat.Prime p) {s : Finset ℕ}
    (hne : ∀ x ∈ s, x ≠ 0) :
    padicValNat p (s.prod id) = s.sum (fun x => padicValNat p x) := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  classical
  revert hne
  induction s using Finset.induction_on with
  | empty =>
      intro hne
      simp
  | @insert a s ha ih =>
      intro hne
      have ha0 : a ≠ 0 := hne a (by simp)
      have hs0 : ∀ x ∈ s, x ≠ 0 := by
        intro x hx
        exact hne x (by simp [hx])
      have hprod0 : s.prod id ≠ 0 := by
        rw [Finset.prod_ne_zero_iff]
        exact hs0
      calc
        padicValNat p ((insert a s).prod id)
            = padicValNat p (a * s.prod id) := by
                simp [Finset.prod_insert, ha]
        _ = padicValNat p a + padicValNat p (s.prod id) :=
              padicValNat.mul ha0 hprod0
        _ = padicValNat p a + s.sum (fun x => padicValNat p x) := by
              rw [ih hs0]
        _ = (insert a s).sum (fun x => padicValNat p x) := by
              rw [Finset.sum_insert ha]

end Erdos678
