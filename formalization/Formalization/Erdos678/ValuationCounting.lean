import Formalization.Erdos678.Intervals
import Formalization.Erdos678.ReciprocalLCMValuation

/-!
Prime-power divisibility counts for finite sets and consecutive intervals.

These counts are the bridge between the product/LCM valuation formula and the
prime-range counting arguments in Cambie's Claim 5.
-/

namespace Erdos678

/-- Number of elements of `s` divisible by `p^r`. -/
def primePowerDivisibleCount (s : Finset ℕ) (p r : ℕ) : ℕ :=
  (s.filter fun x => p ^ r ∣ x).card

/-- Number of elements in a consecutive length-based block divisible by `p^r`. -/
def intervalPrimePowerCount (start len p r : ℕ) : ℕ :=
  primePowerDivisibleCount (intervalFinset start len) p r

/-- For nonzero elements and prime `p`, divisibility by `p^r` is equivalent to
having `p`-adic valuation at least `r`, expressed at the level of the count. -/
theorem primePowerDivisibleCount_eq_card_filter_padicValNat
    {s : Finset ℕ} {p r : ℕ} (hp : Nat.Prime p)
    (hne : ∀ x ∈ s, x ≠ 0) :
    primePowerDivisibleCount s p r =
      (s.filter fun x => r ≤ padicValNat p x).card := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  unfold primePowerDivisibleCount
  congr 1
  ext x
  simp only [Finset.mem_filter]
  constructor
  · rintro ⟨hx, hdiv⟩
    exact ⟨hx, (padicValNat_dvd_iff_le (p := p) (n := r) (hne x hx)).1 hdiv⟩
  · rintro ⟨hx, hval⟩
    exact ⟨hx, (padicValNat_dvd_iff_le (p := p) (n := r) (hne x hx)).2 hval⟩

/-- Once `r` is larger than every `p`-adic valuation on `s`, no element of
`s` can be divisible by `p^r`.  This is the finite-support bound used later
when valuation sums are rewritten as prime-power divisibility counts. -/
theorem primePowerDivisibleCount_eq_zero_of_sup_lt
    {s : Finset ℕ} {p r : ℕ} (hp : Nat.Prime p)
    (hne : ∀ x ∈ s, x ≠ 0)
    (h : s.sup (fun x => padicValNat p x) < r) :
    primePowerDivisibleCount s p r = 0 := by
  letI : Fact (Nat.Prime p) := ⟨hp⟩
  unfold primePowerDivisibleCount
  rw [Finset.card_eq_zero, Finset.filter_eq_empty_iff]
  intro x hx hdiv
  have hrx : r ≤ padicValNat p x :=
    (padicValNat_dvd_iff_le (p := p) (n := r) (hne x hx)).1 hdiv
  have hxsup : padicValNat p x ≤ s.sup (fun y => padicValNat p y) :=
    Finset.le_sup hx
  exact (not_le_of_gt h) (hrx.trans hxsup)

/-- Interval-specialized finite-support bound. -/
theorem intervalPrimePowerCount_eq_zero_of_sup_lt
    {start len p r : ℕ} (hp : Nat.Prime p)
    (hne : ∀ x ∈ intervalFinset start len, x ≠ 0)
    (h : (intervalFinset start len).sup (fun x => padicValNat p x) < r) :
    intervalPrimePowerCount start len p r = 0 := by
  exact primePowerDivisibleCount_eq_zero_of_sup_lt hp hne h

end Erdos678
