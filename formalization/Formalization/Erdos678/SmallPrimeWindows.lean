import Formalization.Erdos678.SmallPrimeRange

/-!
Congruence transport across equal-length blocks in the small-prime range.

We first work on offsets `i < len`, then bridge the result back to the
canonical `intervalFinset` representation.
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

/-- Summing a function over the canonical length-based interval is the same as
summing it over the offsets `0,...,len-1`. -/
theorem intervalFinset_sum_eq_range_sum
    (start len : ℕ) (f : ℕ → ℕ) :
    (intervalFinset start len).sum f =
      (Finset.range len).sum (fun i => f (start + i)) := by
  classical
  unfold intervalFinset
  rw [Finset.sum_image]
  intro a ha b hb hab
  exact Nat.add_left_cancel hab

/-- Interval form of capped-valuation transport: congruent starts modulo
`p^e` give equal capped valuation sums on equal-length consecutive blocks. -/
theorem interval_sum_min_padicValNat_eq_of_modEq_prime_pow
    {start₁ start₂ len p e : ℕ} (hp : Nat.Prime p)
    (hmod : start₁ ≡ start₂ [MOD p ^ e])
    (hne₁ : ∀ x ∈ intervalFinset start₁ len, x ≠ 0)
    (hne₂ : ∀ x ∈ intervalFinset start₂ len, x ≠ 0) :
    (intervalFinset start₁ len).sum (fun x => min (padicValNat p x) e) =
      (intervalFinset start₂ len).sum (fun x => min (padicValNat p x) e) := by
  rw [intervalFinset_sum_eq_range_sum, intervalFinset_sum_eq_range_sum]
  apply sum_min_padicValNat_add_eq_of_modEq_prime_pow hp hmod
  · intro i hi
    apply hne₁ (start₁ + i)
    apply mem_intervalFinset_iff.mpr
    exact ⟨i, hi, rfl⟩
  · intro i hi
    apply hne₂ (start₂ + i)
    apply mem_intervalFinset_iff.mpr
    exact ⟨i, hi, rfl⟩

/-- A block of length `len+1` is its first element together with the tail block
of length `len` beginning one step later. -/
theorem intervalFinset_succ_len (start len : ℕ) :
    intervalFinset start (len + 1) =
      insert start (intervalFinset (start + 1) len) := by
  ext z
  simp only [Finset.mem_insert, mem_intervalFinset_iff]
  constructor
  · rintro ⟨i, hi, hiz⟩
    rcases i with _ | i
    · left
      simpa using hiz.symm
    · right
      refine ⟨i, by omega, ?_⟩
      omega
  · intro hz
    rcases hz with h | ⟨i, hi, hiz⟩
    · subst z
      exact ⟨0, by omega, by simp⟩
    · refine ⟨i + 1, by omega, ?_⟩
      omega

/-- The first element of a block is not in its one-step-later tail. -/
theorem start_not_mem_interval_tail (start len : ℕ) :
    start ∉ intervalFinset (start + 1) len := by
  intro h
  obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp h
  omega

/-- Sum decomposition matching `intervalFinset_succ_len`. -/
theorem intervalFinset_sum_succ_len
    (start len : ℕ) (f : ℕ → ℕ) :
    (intervalFinset start (len + 1)).sum f =
      f start + (intervalFinset (start + 1) len).sum f := by
  rw [intervalFinset_succ_len, Finset.sum_insert (start_not_mem_interval_tail start len)]

end Erdos678
