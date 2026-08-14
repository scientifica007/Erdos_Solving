import Formalization.Erdos678.SmallPrimeRange

/-!
Valuation algebra for the small-prime range of Cambie's Claim 5.

The useful invariant is the valuation capped at an exponent `e`.  If at most
one element lies above that cap, then the entire tail above `e` is absorbed by
the LCM supremum.  Hence `sum v - sup v` depends only on the capped valuations.
-/

namespace Erdos678

/-- If the supremum of `f` reaches `e` and at most one value of `f` is above
`e`, then subtracting the supremum from the sum is the same as summing the
values capped at `e` and subtracting `e`.

This is the abstract algebraic core of Cambie's small-prime argument. -/
theorem finset_sum_sub_sup_eq_sum_min_sub
    {s : Finset ℕ} {f : ℕ → ℕ} {e : ℕ}
    (hsup : e ≤ s.sup f)
    (htail : (s.filter fun x => e < f x).card ≤ 1) :
    s.sum f - s.sup f = s.sum (fun x => min (f x) e) - e := by
  have hsum_decomp :
      s.sum f = s.sum (fun x => min (f x) e) + s.sum (fun x => f x - e) := by
    calc
      s.sum f = s.sum (fun x => min (f x) e + (f x - e)) := by
        apply Finset.sum_congr rfl
        intro x hx
        by_cases hxe : f x ≤ e
        · rw [min_eq_left hxe, Nat.sub_eq_zero_of_le hxe, Nat.add_zero]
        · have hex : e ≤ f x := by omega
          rw [min_eq_right hex]
          omega
      _ = s.sum (fun x => min (f x) e) + s.sum (fun x => f x - e) :=
        Finset.sum_add_distrib
  have hsup_decomp :
      s.sup f = e + s.sup (fun x => f x - e) := by
    apply le_antisymm
    · apply Finset.sup_le
      intro x hx
      have htail_le : f x - e ≤ s.sup (fun y => f y - e) :=
        Finset.le_sup (f := fun y => f y - e) hx
      omega
    · have htail_sup_le : s.sup (fun x => f x - e) ≤ s.sup f - e := by
        apply Finset.sup_le
        intro x hx
        exact Nat.sub_le_sub_right (Finset.le_sup (f := f) hx) e
      omega
  have htail_card :
      (s.filter fun x => 0 < f x - e).card ≤ 1 := by
    have hfilter :
        (s.filter fun x => 0 < f x - e) = (s.filter fun x => e < f x) := by
      ext x
      simp only [Finset.mem_filter]
      omega
    rw [hfilter]
    exact htail
  have htail_eq :
      s.sum (fun x => f x - e) = s.sup (fun x => f x - e) :=
    finset_sum_eq_sup_of_card_pos_le_one htail_card
  rw [hsum_decomp, hsup_decomp, htail_eq]
  omega

/-- Small-prime specialization for a consecutive interval.  If the interval
contains valuation at least `e`, and its length is at most `p^(e+1)`, then the
valuation of `product / lcm` is determined entirely by the valuations capped
at `e`. -/
theorem padicValNat_intervalProd_div_intervalLCM_eq_capped_sum_sub
    {start len p e : ℕ} (hp : Nat.Prime p)
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0)
    (hsup : e ≤ (intervalFinset start len).sup (fun x => padicValNat p x))
    (hlen : len ≤ p ^ (e + 1)) :
    padicValNat p (intervalProd start len / intervalLCM start len) =
      (intervalFinset start len).sum (fun x => min (padicValNat p x) e) - e := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  have htail :
      ((intervalFinset start len).filter fun x => e < padicValNat p x).card ≤ 1 := by
    have hfilter :
        (intervalFinset start len).filter (fun x => e < padicValNat p x) =
          (intervalFinset start len).filter (fun x => p ^ (e + 1) ∣ x) := by
      ext x
      simp only [Finset.mem_filter]
      constructor
      · rintro ⟨hx, hv⟩
        refine ⟨hx, (padicValNat_dvd_iff_le (p := p) (n := e + 1) (hne x hx)).2 ?_⟩
        omega
      · rintro ⟨hx, hdvd⟩
        have hv : e + 1 ≤ padicValNat p x :=
          (padicValNat_dvd_iff_le (p := p) (n := e + 1) (hne x hx)).1 hdvd
        exact ⟨hx, by omega⟩
    rw [hfilter]
    exact interval_multiples_card_le_one (p := p ^ (e + 1)) hlen
  rw [padicValNat_intervalProd_div_intervalLCM hp hne]
  exact finset_sum_sub_sup_eq_sum_min_sub hsup htail

end Erdos678
