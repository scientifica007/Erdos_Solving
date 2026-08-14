import Formalization.Erdos678.ValuationCounting
import Mathlib.Data.Nat.ModEq

/-!
The `p > k` range in Cambie's Claim 5.

This file starts with the purely interval-theoretic fact needed in that range:
a consecutive block of length at most `p` contains at most one multiple of `p`.
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

end Erdos678
