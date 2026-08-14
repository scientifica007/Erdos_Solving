import Formalization.Erdos678.MediumPrimeWindows
import Mathlib.Algebra.BigOperators.Ring.Finset

/-!
Valuation algebra for the medium-prime range of Cambie's Claim 5.

The key decomposition is `v = [v > 0] + (v - 1)`.  When the tail
`v - 1` is positive at at most one point, its sum equals its supremum by the
B1 lemma.  This converts `sum v - sup v` into the number of positive
valuations minus one.
-/

namespace Erdos678

/-- If `f` is positive somewhere and `f - 1` is positive at at most one point,
then `sum f - sup f` is the size of the positive support minus one. -/
theorem finset_sum_sub_sup_eq_card_pos_sub_one
    {s : Finset ℕ} {f : ℕ → ℕ}
    (hpos : (s.filter fun x => 0 < f x).Nonempty)
    (htail : (s.filter fun x => 0 < f x - 1).card ≤ 1) :
    s.sum f - s.sup f = (s.filter fun x => 0 < f x).card - 1 := by
  have hsum_decomp :
      s.sum f = (s.filter fun x => 0 < f x).card +
        s.sum (fun x => f x - 1) := by
    calc
      s.sum f = s.sum (fun x => (if 0 < f x then 1 else 0) + (f x - 1)) := by
        apply Finset.sum_congr rfl
        intro x hx
        by_cases hfx : 0 < f x
        · simp only [if_pos hfx]
          omega
        · have hz : f x = 0 := Nat.eq_zero_of_not_pos hfx
          simp [hz]
      _ = s.sum (fun x => if 0 < f x then 1 else 0) +
          s.sum (fun x => f x - 1) := Finset.sum_add_distrib
      _ = (s.filter fun x => 0 < f x).card +
          s.sum (fun x => f x - 1) := by
        simpa using
          (Finset.sum_boole (R := ℕ) (fun x => 0 < f x) s)
  have hsup_pos : 0 < s.sup f := by
    obtain ⟨a, ha⟩ := hpos
    have haS : a ∈ s := (Finset.mem_filter.mp ha).1
    have hfa : 0 < f a := (Finset.mem_filter.mp ha).2
    exact lt_of_lt_of_le hfa (Finset.le_sup haS)
  have hsup_decomp :
      s.sup f = 1 + s.sup (fun x => f x - 1) := by
    apply le_antisymm
    · apply Finset.sup_le
      intro x hx
      have hle : f x - 1 ≤ s.sup (fun y => f y - 1) :=
        Finset.le_sup (f := fun y => f y - 1) hx
      omega
    · have htail_le : s.sup (fun x => f x - 1) ≤ s.sup f - 1 := by
        apply Finset.sup_le
        intro x hx
        exact Nat.sub_le_sub_right (Finset.le_sup (f := f) hx) 1
      omega
  have htail_eq :
      s.sum (fun x => f x - 1) = s.sup (fun x => f x - 1) :=
    finset_sum_eq_sup_of_card_pos_le_one htail
  rw [hsum_decomp, hsup_decomp, htail_eq]
  omega

/-- If a nonzero finite set contains at least one multiple of the prime `p`
and at most one multiple of `p^2`, then the reciprocal-LCM factor has
`p`-adic valuation equal to the number of multiples of `p` minus one. -/
theorem padicValNat_prod_div_lcm_eq_primePowerCount_sub_one
    {p : ℕ} (hp : Nat.Prime p) {s : Finset ℕ}
    (hne : ∀ x ∈ s, x ≠ 0)
    (hcount1 : 0 < primePowerDivisibleCount s p 1)
    (hcount2 : primePowerDivisibleCount s p 2 ≤ 1) :
    padicValNat p ((s.prod id) / (s.lcm id)) =
      primePowerDivisibleCount s p 1 - 1 := by
  have hcount1_filter :
      primePowerDivisibleCount s p 1 =
        (s.filter fun x => 0 < padicValNat p x).card := by
    calc
      primePowerDivisibleCount s p 1 =
          (s.filter fun x => 1 ≤ padicValNat p x).card :=
        primePowerDivisibleCount_eq_card_filter_padicValNat hp hne
      _ = (s.filter fun x => 0 < padicValNat p x).card := by
        have hfilter :
            (s.filter fun x => 1 ≤ padicValNat p x) =
              (s.filter fun x => 0 < padicValNat p x) := by
          ext x
          simp only [Finset.mem_filter]
          constructor
          · rintro ⟨hx, hv⟩
            exact ⟨hx, by omega⟩
          · rintro ⟨hx, hv⟩
            exact ⟨hx, by omega⟩
        exact congrArg Finset.card hfilter
  have hcount2_filter :
      primePowerDivisibleCount s p 2 =
        (s.filter fun x => 0 < padicValNat p x - 1).card := by
    calc
      primePowerDivisibleCount s p 2 =
          (s.filter fun x => 2 ≤ padicValNat p x).card :=
        primePowerDivisibleCount_eq_card_filter_padicValNat hp hne
      _ = (s.filter fun x => 0 < padicValNat p x - 1).card := by
        have hfilter :
            (s.filter fun x => 2 ≤ padicValNat p x) =
              (s.filter fun x => 0 < padicValNat p x - 1) := by
          ext x
          simp only [Finset.mem_filter]
          constructor
          · rintro ⟨hx, hv⟩
            exact ⟨hx, by omega⟩
          · rintro ⟨hx, hv⟩
            exact ⟨hx, by omega⟩
        exact congrArg Finset.card hfilter
  have hpos : (s.filter fun x => 0 < padicValNat p x).Nonempty := by
    rw [← Finset.card_pos, ← hcount1_filter]
    exact hcount1
  have htail : (s.filter fun x => 0 < padicValNat p x - 1).card ≤ 1 := by
    rw [← hcount2_filter]
    exact hcount2
  rw [padicValNat_prod_div_lcm hp hne]
  rw [finset_sum_sub_sup_eq_card_pos_sub_one hpos htail]
  rw [← hcount1_filter]

/-- Interval specialization of the medium-prime valuation bridge. -/
theorem padicValNat_intervalProd_div_intervalLCM_eq_count_sub_one
    {start len p : ℕ} (hp : Nat.Prime p)
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0)
    (hcount1 : 0 < intervalPrimePowerCount start len p 1)
    (hcount2 : intervalPrimePowerCount start len p 2 ≤ 1) :
    padicValNat p (intervalProd start len / intervalLCM start len) =
      intervalPrimePowerCount start len p 1 - 1 := by
  simpa [intervalPrimePowerCount, intervalProd, intervalLCM] using
    (padicValNat_prod_div_lcm_eq_primePowerCount_sub_one
      (s := intervalFinset start len) hp hne hcount1 hcount2)

end Erdos678
