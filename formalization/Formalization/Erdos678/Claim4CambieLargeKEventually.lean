import Formalization.Erdos678.Claim4CambieLargeK
import Mathlib.Data.Nat.Choose.Bounds

/-!
Phase E3a: discharge the elementary large-`k` growth package.

Rather than moving through real exponential asymptotics, we use the fourth
binomial coefficient.  Mathlib supplies both a polynomial lower bound for
`k.choose 4` and `k.choose 4 ≤ 2^k`.  A deliberately coarse linear threshold
in `C` is enough to dominate the cubic expression required by D4.
-/

namespace Erdos678

/-- The explicit linear threshold used for the elementary large-`k` package. -/
def claim4CambieLargeKThreshold (C : ℕ) : ℕ :=
  max 9 (3840 * C + 3)

/-- Above the explicit threshold, the D4 exponential-growth contract holds.
The constant is intentionally coarse; only eventual existence matters. -/
theorem claim4CambieLargeKData_of_threshold
    {C k : ℕ}
    (hC : 0 < C)
    (hk : claim4CambieLargeKThreshold C ≤ k) :
    Claim4CambieLargeKData C k := by
  have hnine : 9 ≤ k := by
    exact (Nat.le_max_left 9 (3840 * C + 3)).trans hk
  have hlinear : 3840 * C + 3 ≤ k := by
    exact (Nat.le_max_right 9 (3840 * C + 3)).trans hk
  let t := k - 3
  have hkt : k ≤ 2 * t := by
    dsimp [t]
    omega
  have hk1t : k + 1 ≤ 2 * t := by
    dsimp [t]
    omega
  have hcoeff : 3840 * C ≤ t := by
    dsimp [t]
    omega
  have hksq : k ^ 2 ≤ (2 * t) ^ 2 := by
    simpa [pow_two] using Nat.mul_le_mul hkt hkt
  have hcubic : k ^ 2 * (k + 1) ≤ 8 * t ^ 3 := by
    calc
      k ^ 2 * (k + 1) ≤ (2 * t) ^ 2 * (2 * t) :=
        Nat.mul_le_mul hksq hk1t
      _ = 8 * t ^ 3 := by ring
  have hquartic : 3840 * C * t ^ 3 ≤ t ^ 4 := by
    calc
      3840 * C * t ^ 3 = (3840 * C) * t ^ 3 := by ring
      _ ≤ t * t ^ 3 := Nat.mul_le_mul_right (t ^ 3) hcoeff
      _ = t ^ 4 := by ring
  have htarget24 :
      24 * (20 * C * k ^ 2 * (k + 1)) ≤ t ^ 4 := by
    calc
      24 * (20 * C * k ^ 2 * (k + 1)) =
          480 * C * (k ^ 2 * (k + 1)) := by ring
      _ ≤ 480 * C * (8 * t ^ 3) := Nat.mul_le_mul_left (480 * C) hcubic
      _ = 3840 * C * t ^ 3 := by ring
      _ ≤ t ^ 4 := hquartic
  have hchooseQ := Nat.pow_le_choose (α := ℚ) 4 k
  have hchoose24Q :
      (((k + 1 - 4) ^ 4 : ℕ) : ℚ) ≤
        ((24 * k.choose 4 : ℕ) : ℚ) := by
    norm_num [Nat.factorial] at hchooseQ ⊢
    nlinarith
  have hchoose24 :
      (k + 1 - 4) ^ 4 ≤ 24 * k.choose 4 := by
    exact_mod_cast hchoose24Q
  have hsub : k + 1 - 4 = t := by
    dsimp [t]
    omega
  have ht_choose : t ^ 4 ≤ 24 * k.choose 4 := by
    simpa [hsub] using hchoose24
  have htarget24' :
      24 * (20 * C * k ^ 2 * (k + 1)) ≤ 24 * k.choose 4 :=
    htarget24.trans ht_choose
  have htarget_choose :
      20 * C * k ^ 2 * (k + 1) ≤ k.choose 4 :=
    Nat.le_of_mul_le_mul_left htarget24' (by norm_num)
  have hpow : 20 * C * k ^ 2 * (k + 1) ≤ 2 ^ k :=
    htarget_choose.trans (Nat.choose_le_two_pow k 4)
  exact ⟨hC, hnine, hpow⟩

/-- For each positive `C`, the complete D4 large-`k` package is eventually
available with an explicit threshold. -/
theorem claim4CambieLargeKData_eventually
    {C : ℕ} (hC : 0 < C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k → Claim4CambieLargeKData C k := by
  exact ⟨claim4CambieLargeKThreshold C,
    fun _ hk ↦ claim4CambieLargeKData_of_threshold hC hk⟩

end Erdos678
