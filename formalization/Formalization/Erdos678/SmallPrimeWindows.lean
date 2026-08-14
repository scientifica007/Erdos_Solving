import Formalization.Erdos678.SmallPrimeRange

/-!
Congruence transport across equal-length blocks in the small-prime range.

We first work on offsets `i < len`.  This keeps the core statement independent
of the representation of `intervalFinset`; a separate bridge can later rewrite
the offset sum as an interval sum.
-/

namespace Erdos678

/-- Equal-length blocks whose starts are congruent modulo `p^e` have equal
sums of `p`-adic valuations capped at `e`, when written over their common
offset set. -/
theorem sum_min_padicValNat_add_eq_of_modEq_prime_pow
    {start₁ start₂ len p e : ℕ} (hp : Nat.Prime p)
    (hmod : start₁ ≡ start₂ [MOD p ^ e])
    (hne₁ : ∀ i < len, start₁ + i ≠ 0)
    (hne₂ : ∀ i < len, start₂ + i ≠ 0) :
    (Finset.range len).sum (fun i => min (padicValNat p (start₁ + i)) e) =
      (Finset.range len).sum (fun i => min (padicValNat p (start₂ + i)) e) := by
  apply Finset.sum_congr rfl
  intro i hi
  have hil : i < len := Finset.mem_range.mp hi
  exact min_padicValNat_eq_of_modEq_prime_pow
    hp (hne₁ i hil) (hne₂ i hil) (hmod.add_right i)

end Erdos678
