import Formalization.Erdos678.Claim4RelativePrimeProvider

/-!
Phase E2d: from one fixed relative-prime theorem to the five Cambie strips.

For fixed `C`, use denominator `q = 320*C` and strip width `d = k/q`.
If the relative-prime provider is available beyond a threshold and `k` is large
enough that both `q ≤ k` and `2*threshold ≤ k`, then all five strip starts are
past the threshold.  Applying the provider at those five starts produces the
finite package consumed by E2c.

The analytic existence of the provider remains a separate explicit input.
-/

namespace Erdos678

/-- Fixed denominator used to turn a relative prime gap into Cambie's narrow
additive strips. -/
def claim4RelativePrimeDenominator (C : ℕ) : ℕ := 320 * C

/-- Common additive strip width induced by the relative denominator. -/
def claim4RelativeStripWidth (C k : ℕ) : ℕ :=
  k / claim4RelativePrimeDenominator C

/-- A relative-prime provider at denominator `320*C` yields the five disjoint
prime strips once `k` is beyond the provider threshold and the denominator
itself. -/
theorem claim4_exists_five_strips_of_relative_prime_provider
    {C k : ℕ}
    (hC : 0 < C)
    (hprovider : Claim4RelativePrimeProvider (claim4RelativePrimeDenominator C))
    (hq_le_k : claim4RelativePrimeDenominator C ≤ k)
    (hthreshold : 2 * hprovider.threshold ≤ k) :
    ∃ d xp xq xr yp yq : ℕ,
      Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq := by
  let q := claim4RelativePrimeDenominator C
  let d := k / q
  have hq : 0 < q := by
    dsimp [q, claim4RelativePrimeDenominator]
    positivity
  have hqk : q ≤ k := by
    simpa [q] using hq_le_k
  have hq_ge_six : 6 ≤ q := by
    dsimp [q, claim4RelativePrimeDenominator]
    omega
  have hqd : q * d ≤ k := by
    dsimp [d]
    simpa [mul_comm] using Nat.div_mul_le_self k q
  have hdpos : 0 < d := by
    dsimp [d]
    exact Nat.div_pos hqk hq
  have h6d : 6 * d ≤ k := by
    calc
      6 * d ≤ q * d := Nat.mul_le_mul_right d hq_ge_six
      _ ≤ k := hqd
  have hd_le_k : d ≤ k := by omega
  have hhalf_threshold : hprovider.threshold ≤ k / 2 := by
    apply (Nat.le_div_iff_mul_le (by norm_num : 0 < 2)).2
    simpa [mul_comm] using hthreshold
  have hT_xp : hprovider.threshold ≤ k - d := by omega
  have hT_xq : hprovider.threshold ≤ k - 2 * d := by omega
  have hT_xr : hprovider.threshold ≤ k - 3 * d := by omega
  have hT_yp : hprovider.threshold ≤ k / 2 := hhalf_threshold
  have hT_yq : hprovider.threshold ≤ k / 2 + d := by omega
  have hnxp : k - d ≤ k := Nat.sub_le _ _
  have hnxq : k - 2 * d ≤ k := Nat.sub_le _ _
  have hnxr : k - 3 * d ≤ k := Nat.sub_le _ _
  have hnyp : k / 2 ≤ k := Nat.div_le_self _ _
  have hnyq : k / 2 + d ≤ k := by omega

  obtain ⟨xp, hxpPrime, hxpLower, hxpUpper0⟩ :=
    hprovider.exists_prime_in_additive_strip hq hT_xp hnxp
  obtain ⟨xq, hxqPrime, hxqLower, hxqUpper0⟩ :=
    hprovider.exists_prime_in_additive_strip hq hT_xq hnxq
  obtain ⟨xr, hxrPrime, hxrLower, hxrUpper0⟩ :=
    hprovider.exists_prime_in_additive_strip hq hT_xr hnxr
  obtain ⟨yp, hypPrime, hypLower, hypUpper0⟩ :=
    hprovider.exists_prime_in_additive_strip hq hT_yp hnyp
  obtain ⟨yq, hyqPrime, hyqLower, hyqUpper0⟩ :=
    hprovider.exists_prime_in_additive_strip hq hT_yq hnyq

  have hxpUpper : xp ≤ (k - d) + d := by
    simpa [d] using hxpUpper0
  have hxqUpper : xq ≤ (k - 2 * d) + d := by
    simpa [d] using hxqUpper0
  have hxrUpper : xr ≤ (k - 3 * d) + d := by
    simpa [d] using hxrUpper0
  have hypUpper : yp ≤ k / 2 + d := by
    simpa [d] using hypUpper0
  have hyqUpper : yq ≤ (k / 2 + d) + d := by
    simpa [d] using hyqUpper0

  have hxp_upper : xp ≤ k := by omega
  have hxp_lower : k < xp + d := by omega
  have hxq_upper : xq + d ≤ k := by omega
  have hxq_lower : k < xq + 2 * d := by omega
  have hxr_upper : xr + 2 * d ≤ k := by omega
  have hxr_lower : k < xr + 3 * d := by omega
  have hyp_lower : k < 2 * yp := by omega
  have hyp_upper : 2 * yp ≤ k + 2 * d := by omega
  have hyq_lower : k + 2 * d < 2 * yq := by omega
  have hyq_upper : 2 * yq ≤ k + 4 * d := by omega

  have hsum : q * d + q ≤ k + k := Nat.add_le_add hqd hqk
  have htwice : 2 * (160 * C * (d + 1)) ≤ 2 * k := by
    calc
      2 * (160 * C * (d + 1)) = q * d + q := by
        dsimp [q, claim4RelativePrimeDenominator]
        ring
      _ ≤ k + k := hsum
      _ = 2 * k := by ring
  have hspacing : 160 * C * (d + 1) ≤ k :=
    Nat.le_of_mul_le_mul_left htwice (by norm_num)

  exact ⟨d, xp, xq, xr, yp, yq, ⟨
    hdpos,
    hxpPrime, hxqPrime, hxrPrime, hypPrime, hyqPrime,
    hxp_upper, hxp_lower,
    hxq_upper, hxq_lower,
    hxr_upper, hxr_lower,
    hyp_lower, hyp_upper,
    hyq_lower, hyq_upper,
    hspacing⟩⟩

/-- Relative-prime provider endpoint through the completed E2c+D4+E1 stack. -/
theorem claim4_exists_cambie_lcm_ratio_of_relative_prime_provider
    {C k : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hprovider : Claim4RelativePrimeProvider (claim4RelativePrimeDenominator C))
    (hq_le_k : claim4RelativePrimeDenominator C ≤ k)
    (hthreshold : 2 * hprovider.threshold ≤ k) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  obtain ⟨d, xp, xq, xr, yp, yq, hstrips⟩ :=
    claim4_exists_five_strips_of_relative_prime_provider
      hlarge.C_pos hprovider hq_le_k hthreshold
  exact claim4_exists_cambie_lcm_ratio_of_five_strips hlarge hstrips

end Erdos678
