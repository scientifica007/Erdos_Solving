import Formalization.Erdos678.ValuationCounting
import Mathlib.Data.Nat.ModEq

/-!
The `p > k` range in Cambie's Claim 5.

The core mechanism is elementary and deliberately separated from the CRT
construction: a consecutive block of length at most `p` contains at most one
multiple of `p`. Hence at most one factor has positive `p`-adic valuation, so
the sum of valuations equals their supremum and the product/LCM quotient has
valuation zero.
-/

namespace Erdos678

/-- Membership in the length-based interval, exposed through its offset. -/
theorem mem_intervalFinset_iff {start len x : ℕ} :
    x ∈ intervalFinset start len ↔ ∃ i < len, start + i = x := by
  simp [intervalFinset]

/-- A consecutive block of length at most `p` contains at most one multiple of `p`. -/
theorem interval_multiple_unique
    {start len p x y : ℕ} (hlen : len ≤ p)
    (hx : x ∈ intervalFinset start len) (hy : y ∈ intervalFinset start len)
    (hpx : p ∣ x) (hpy : p ∣ y) : x = y := by
  obtain ⟨i, hi, hix⟩ := mem_intervalFinset_iff.mp hx
  obtain ⟨j, hj, hjy⟩ := mem_intervalFinset_iff.mp hy
  have hip : i < p := lt_of_lt_of_le hi hlen
  have hjp : j < p := lt_of_lt_of_le hj hlen
  have hxmod : start + i ≡ 0 [MOD p] := by
    rw [hix]
    exact hpx.modEq_zero_nat
  have hymod : start + j ≡ 0 [MOD p] := by
    rw [hjy]
    exact hpy.modEq_zero_nat
  have hijmod : i ≡ j [MOD p] :=
    Nat.ModEq.add_left_cancel' start (hxmod.trans hymod.symm)
  have hij : i = j := by
    unfold Nat.ModEq at hijmod
    simpa [Nat.mod_eq_of_lt hip, Nat.mod_eq_of_lt hjp] using hijmod
  calc
    x = start + i := hix.symm
    _ = start + j := by rw [hij]
    _ = y := hjy

/-- Cardinal form of `interval_multiple_unique`: the filtered set of multiples
of `p` in a block of length at most `p` has cardinality at most one. -/
theorem interval_multiples_card_le_one {start len p : ℕ} (hlen : len ≤ p) :
    ((intervalFinset start len).filter fun x => p ∣ x).card ≤ 1 := by
  rw [Finset.card_le_one]
  intro a ha b hb
  rcases Finset.mem_filter.mp ha with ⟨haI, hpa⟩
  rcases Finset.mem_filter.mp hb with ⟨hbI, hpb⟩
  exact interval_multiple_unique hlen haI hbI hpa hpb

/-- If a natural-valued function is positive at at most one point of a finite
set, then its sum equals its supremum. -/
theorem finset_sum_eq_sup_of_card_pos_le_one
    {s : Finset ℕ} {f : ℕ → ℕ}
    (hcard : (s.filter fun x => 0 < f x).card ≤ 1) :
    s.sum f = s.sup f := by
  classical
  by_cases hnon : (s.filter fun x => 0 < f x).Nonempty
  · obtain ⟨a, haF⟩ := hnon
    have haS : a ∈ s := (Finset.mem_filter.mp haF).1
    have hzero : ∀ b ∈ s, b ≠ a → f b = 0 := by
      intro b hb hba
      by_contra hfb
      have hfbpos : 0 < f b := Nat.pos_of_ne_zero hfb
      have hbF : b ∈ s.filter fun x => 0 < f x :=
        Finset.mem_filter.mpr ⟨hb, hfbpos⟩
      have hab : a = b := (Finset.card_le_one.mp hcard) a haF b hbF
      exact hba hab.symm
    have hsum : s.sum f = f a :=
      Finset.sum_eq_single_of_mem a haS hzero
    have hsup_le : s.sup f ≤ f a := by
      apply Finset.sup_le
      intro b hb
      by_cases hba : b = a
      · simpa [hba]
      · rw [hzero b hb hba]
        exact Nat.zero_le _
    have ha_le_sup : f a ≤ s.sup f := Finset.le_sup haS
    have hsup : s.sup f = f a := le_antisymm hsup_le ha_le_sup
    exact hsum.trans hsup.symm
  · have hzero : ∀ b ∈ s, f b = 0 := by
      intro b hb
      by_contra hfb
      have hfbpos : 0 < f b := Nat.pos_of_ne_zero hfb
      exact hnon ⟨b, Finset.mem_filter.mpr ⟨hb, hfbpos⟩⟩
    have hsum : s.sum f = 0 := Finset.sum_eq_zero hzero
    have hsup_le : s.sup f ≤ 0 := Finset.sup_le fun b hb => by
      rw [hzero b hb]
    have hsup : s.sup f = 0 := le_antisymm hsup_le (Nat.zero_le _)
    exact hsum.trans hsup.symm

/-- For a nonzero natural and prime `p`, positive `p`-adic valuation is
exactly divisibility by `p`. -/
theorem padicValNat_pos_iff_dvd
    {p x : ℕ} (hp : Nat.Prime p) (hx0 : x ≠ 0) :
    0 < padicValNat p x ↔ p ∣ x := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  constructor
  · intro hpos
    have hpow : p ^ 1 ∣ x :=
      (padicValNat_dvd_iff_le (p := p) (n := 1) hx0).2 hpos
    simpa using hpow
  · intro hdiv
    have hpow : p ^ 1 ∣ x := by simpa using hdiv
    exact (padicValNat_dvd_iff_le (p := p) (n := 1) hx0).1 hpow

/-- In a nonzero consecutive block of length at most `p`, the sum of all
`p`-adic valuations equals their supremum. -/
theorem interval_padicValNat_sum_eq_sup
    {start len p : ℕ} (hp : Nat.Prime p) (hlen : len ≤ p)
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0) :
    (intervalFinset start len).sum (fun x => padicValNat p x) =
      (intervalFinset start len).sup (fun x => padicValNat p x) := by
  classical
  have hfilter :
      (intervalFinset start len).filter (fun x => 0 < padicValNat p x) =
        (intervalFinset start len).filter (fun x => p ∣ x) := by
    ext x
    simp only [Finset.mem_filter]
    constructor
    · rintro ⟨hx, hpos⟩
      exact ⟨hx, (padicValNat_pos_iff_dvd hp (hne x hx)).1 hpos⟩
    · rintro ⟨hx, hdiv⟩
      exact ⟨hx, (padicValNat_pos_iff_dvd hp (hne x hx)).2 hdiv⟩
  apply finset_sum_eq_sup_of_card_pos_le_one
  rw [hfilter]
  exact interval_multiples_card_le_one hlen

/-- A prime whose size is at least the block length contributes zero to the
valuation of the block's product/LCM quotient. -/
theorem padicValNat_intervalProd_div_intervalLCM_eq_zero
    {start len p : ℕ} (hp : Nat.Prime p) (hlen : len ≤ p)
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0) :
    padicValNat p (intervalProd start len / intervalLCM start len) = 0 := by
  rw [padicValNat_intervalProd_div_intervalLCM hp hne]
  rw [interval_padicValNat_sum_eq_sup hp hlen hne]
  exact Nat.sub_self _

/-- Cambie's `p > k` case for both consecutive blocks in Claim 5.
The `x` block has length `k`, while the `y` block has length `k + 1`. -/
theorem claim5_large_prime_range
    {x y k p : ℕ} (hp : Nat.Prime p) (hpk : k < p)
    (hxne : ∀ z ∈ intervalFinset x k, z ≠ 0)
    (hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0) :
    padicValNat p (intervalProd x k / intervalLCM x k) = 0 ∧
      padicValNat p (intervalProd y (k + 1) / intervalLCM y (k + 1)) = 0 := by
  constructor
  · exact padicValNat_intervalProd_div_intervalLCM_eq_zero hp (Nat.le_of_lt hpk) hxne
  · exact padicValNat_intervalProd_div_intervalLCM_eq_zero hp (Nat.succ_le_of_lt hpk) hyne

end Erdos678
