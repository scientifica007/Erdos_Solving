import Formalization.Erdos678.LargePrimeRange
import Mathlib.Data.Int.CardIntervalMod

/-!
The medium-prime range in Cambie's Claim 5.

For Lean we use the arithmetic conditions actually consumed by the proof:
`k < p^2` and `p <= k`, rather than introducing square roots at this layer.
The first task is exact counting of multiples of `p` in a length-based block
from a congruence condition on its first element.
-/

namespace Erdos678

/-- If the block length is at most `p^2`, it contains at most one multiple of
`p^2`. This is the medium-prime spacing input, reused directly from B1. -/
theorem interval_sq_multiples_card_le_one
    {start len p : ℕ} (hlen : len ≤ p ^ 2) :
    ((intervalFinset start len).filter fun x => p ^ 2 ∣ x).card ≤ 1 := by
  exact interval_multiples_card_le_one (p := p ^ 2) hlen

/-- If `start ≡ a (mod p)` with `a <= p`, then an offset `i` reaches a
multiple of `p` exactly when `i ≡ p-a (mod p)`.

Using the representative `p-a` avoids introducing negative naturals. -/
theorem dvd_start_add_iff_offset_modEq
    {start p a i : ℕ} (ha : a ≤ p) (hstart : start ≡ a [MOD p]) :
    p ∣ start + i ↔ i ≡ p - a [MOD p] := by
  have htarget : a + (p - a) ≡ 0 [MOD p] := by
    have hpdiv : p ∣ a + (p - a) := by
      rw [Nat.add_sub_of_le ha]
    exact hpdiv.modEq_zero_nat
  constructor
  · intro hdiv
    have hsum : start + i ≡ a + i [MOD p] :=
      hstart.add Nat.ModEq.rfl
    have hai0 : a + i ≡ 0 [MOD p] :=
      hsum.symm.trans hdiv.modEq_zero_nat
    exact Nat.ModEq.add_left_cancel' a (hai0.trans htarget.symm)
  · intro hi
    have hsum : start + i ≡ a + (p - a) [MOD p] :=
      hstart.add hi
    have hzero : start + i ≡ 0 [MOD p] := hsum.trans htarget
    exact Nat.modEq_zero_iff_dvd.mp hzero

/-- Count multiples of `p` in a length-based block by transferring the problem
to offsets in `range len`. -/
theorem intervalPrimePowerCount_one_eq_count_modEq
    {start len p a : ℕ} (ha : a ≤ p) (hstart : start ≡ a [MOD p]) :
    intervalPrimePowerCount start len p 1 =
      len.count (fun i => i ≡ p - a [MOD p]) := by
  let e : ℕ ↪ ℕ :=
    ⟨fun i => start + i, fun _ _ h => Nat.add_left_cancel h⟩
  have hinterval : intervalFinset start len = (Finset.range len).map e := by
    ext z
    simp [intervalFinset, e]
  unfold intervalPrimePowerCount primePowerDivisibleCount
  simp only [pow_one]
  rw [hinterval, Finset.filter_map, Finset.card_map]
  rw [Nat.count_eq_card_filter_range]
  congr 1
  ext i
  simp only [Finset.mem_filter, Finset.mem_range, Function.comp_apply]
  constructor
  · rintro ⟨hi, hdiv⟩
    exact ⟨hi, (dvd_start_add_iff_offset_modEq ha hstart).1 hdiv⟩
  · rintro ⟨hi, hmod⟩
    exact ⟨hi, (dvd_start_add_iff_offset_modEq ha hstart).2 hmod⟩

/-- Closed formula for the number of multiples of `p` in a block whose start
has chosen residue representative `a`. -/
theorem intervalPrimePowerCount_one_formula
    {start len p a : ℕ} (hp0 : 0 < p) (ha : a ≤ p)
    (hstart : start ≡ a [MOD p]) :
    intervalPrimePowerCount start len p 1 =
      len / p + if (p - a) % p < len % p then 1 else 0 := by
  rw [intervalPrimePowerCount_one_eq_count_modEq ha hstart]
  exact Nat.count_modEq_card len hp0 (p - a)

end Erdos678
