import Formalization.Erdos678.MediumPrimeRange

/-!
Exact residue-window counts for the medium-prime range of Cambie's Claim 5.
-/

namespace Erdos678

/-- If `p` does not divide `k+1`, incrementing `k` increments its residue
modulo `p` without wraparound. -/
theorem succ_mod_eq_add_one_of_not_dvd
    {k p : ℕ} (hp : 1 < p) (hndvd : ¬ p ∣ k + 1) :
    (k + 1) % p = k % p + 1 := by
  have hp0 : 0 < p := Nat.zero_lt_one.trans hp
  have hrlt : k % p < p := Nat.mod_lt k hp0
  have hlt : k % p + 1 < p := by
    by_contra hnot
    have heq : k % p + 1 = p := by omega
    apply hndvd
    rw [Nat.dvd_iff_mod_eq_zero]
    calc
      (k + 1) % p = (k % p + 1 % p) % p := Nat.add_mod k 1 p
      _ = (k % p + 1) % p := by rw [Nat.mod_eq_of_lt hp]
      _ = 0 := by rw [heq, Nat.mod_self]
  calc
    (k + 1) % p = (k % p + 1 % p) % p := Nat.add_mod k 1 p
    _ = (k % p + 1) % p := by rw [Nat.mod_eq_of_lt hp]
    _ = k % p + 1 := Nat.mod_eq_of_lt hlt

/-- Cambie's admissible `b_p` window gives exactly `k / p + 1` multiples of
`p` in the `y` block of length `k+1`. -/
theorem cambie_y_prime_count
    {y k p b : ℕ} (hp : Nat.Prime p)
    (hbLower : p - k % p ≤ b) (hbUpper : b ≤ p)
    (hy : y ≡ b [MOD p]) :
    intervalPrimePowerCount y (k + 1) p 1 = k / p + 1 := by
  have hp0 : 0 < p := hp.pos
  have hrlt : k % p < p := Nat.mod_lt k hp0
  have hbpos : 0 < b := by omega
  have hpb_lt : p - b < p := by omega
  have hpb_le : p - b ≤ k % p := by omega
  rw [intervalPrimePowerCount_one_formula hp0 hbUpper hy]
  rw [Nat.mod_eq_of_lt hpb_lt]
  by_cases hdvd : p ∣ k + 1
  · rw [Nat.succ_div_of_dvd hdvd, Nat.mod_eq_zero_of_dvd hdvd]
    simp
  · rw [Nat.succ_div_of_not_dvd hdvd]
    have hmod : (k + 1) % p = k % p + 1 :=
      succ_mod_eq_add_one_of_not_dvd hp.one_lt hdvd
    rw [hmod]
    have hlt : p - b < k % p + 1 := by omega
    simp [hlt]

end Erdos678
