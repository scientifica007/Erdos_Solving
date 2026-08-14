import Mathlib

open scoped BigOperators

namespace Erdos678

lemma padicValNat_finset_prod
    {p : ℕ} (hp : Nat.Prime p) {s : Finset ℕ}
    (hne : ∀ x ∈ s, x ≠ 0) :
    padicValNat p (∏ x in s, x) = ∑ x in s, padicValNat p x := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  classical
  revert hne
  induction s using Finset.induction_on with
  | empty =>
      intro
      simp
  | @insert a s ha ih =>
      intro hne
      have ha0 : a ≠ 0 := hne a (by simp)
      have hs0 : ∀ x ∈ s, x ≠ 0 := by
        intro x hx
        exact hne x (by simp [hx])
      have hprod0 : (∏ x in s, x) ≠ 0 := by
        apply Finset.prod_ne_zero
        intro x hx
        exact hs0 x hx
      rw [Finset.prod_insert ha, Finset.sum_insert ha]
      rw [padicValNat.mul ha0 hprod0]
      rw [ih hs0]

end Erdos678
