import Formalization.Erdos678.Claim4FiveStripsFromRelativePrime
import PrimeNumberTheoremAnd.Consequences

/-!
Phase E2e: discharge the relative-prime provider from the formal prime number theorem.

The external analytic input is PNT+'s `prime_between`: for every fixed positive
real `ε`, every sufficiently large real `x` has a prime in
`(x, (1 + ε) * x)`.  Taking `ε = 1/q`, extracting one eventual lower bound,
and rounding it up produces the natural-number provider used by E2d.
-/

namespace Erdos678

open Filter

/-- PNT+ supplies the natural-number relative-prime provider for every positive
integer denominator.  The chosen threshold is noncomputable, but all properties
consumed downstream are propositions and are kernel checked. -/
noncomputable def claim4RelativePrimeProviderOfPNT (q : ℕ) (hq : 0 < q) :
    Claim4RelativePrimeProvider q := by
  have hqR : (0 : ℝ) < (q : ℝ) := by
    exact_mod_cast hq
  have hε : 0 < (1 : ℝ) / (q : ℝ) := div_pos zero_lt_one hqR
  have hevent :
      ∀ᶠ x : ℝ in atTop,
        ∃ p : ℕ, Nat.Prime p ∧ x < p ∧ p < (1 + (1 : ℝ) / (q : ℝ)) * x :=
    prime_between hε
  have hex :
      ∃ a : ℝ, ∀ b : ℝ, a ≤ b →
        ∃ p : ℕ, Nat.Prime p ∧ b < p ∧
          p < (1 + (1 : ℝ) / (q : ℝ)) * b :=
    Filter.eventually_atTop.mp hevent
  let a : ℝ := Classical.choose hex
  have ha :
      ∀ b : ℝ, a ≤ b →
        ∃ p : ℕ, Nat.Prime p ∧ b < p ∧
          p < (1 + (1 : ℝ) / (q : ℝ)) * b := by
    simpa [a] using Classical.choose_spec hex
  refine ⟨⌈a⌉₊, ?_⟩
  intro n hn
  have han : a ≤ (n : ℝ) := by
    have haceil : a ≤ (⌈a⌉₊ : ℝ) := Nat.le_ceil a
    have hceiln : (⌈a⌉₊ : ℝ) ≤ (n : ℝ) := by
      exact_mod_cast hn
    exact haceil.trans hceiln
  obtain ⟨p, hp, hnp, hpupper⟩ := ha (n : ℝ) han
  refine ⟨p, hp, ?_, ?_⟩
  · have hscaled : (q : ℝ) * (n : ℝ) < (q : ℝ) * (p : ℝ) :=
      (mul_lt_mul_left hqR).2 hnp
    exact_mod_cast hscaled
  · have hscaled :
        (q : ℝ) * (p : ℝ) <
          (q : ℝ) * ((1 + (1 : ℝ) / (q : ℝ)) * (n : ℝ)) :=
      (mul_lt_mul_left hqR).2 hpupper
    have hright :
        (q : ℝ) * ((1 + (1 : ℝ) / (q : ℝ)) * (n : ℝ)) =
          ((q : ℝ) + 1) * (n : ℝ) := by
      field_simp [ne_of_gt hqR]
      <;> ring
    rw [hright] at hscaled
    exact_mod_cast hscaled

/-- For each positive `C`, PNT eliminates the prime-density input entirely:
there is a threshold after which the already completed D4 large-`k` hypotheses
imply the strict LCM ratio.  E3 only has to package the remaining large-`k`
growth conditions. -/
theorem claim4_exists_cambie_lcm_ratio_eventually_of_pnt
    {C : ℕ} (hC : 0 < C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k → Claim4CambieLargeKData C k →
      ∃ x y : ℕ,
        0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
        C * intervalLCM y (k + 1) < intervalLCM x k := by
  have hq : 0 < claim4RelativePrimeDenominator C := by
    dsimp [claim4RelativePrimeDenominator]
    positivity
  let hprovider :=
    claim4RelativePrimeProviderOfPNT (claim4RelativePrimeDenominator C) hq
  refine ⟨max (claim4RelativePrimeDenominator C) (2 * hprovider.threshold), ?_⟩
  intro k hk hlarge
  have hq_le_k : claim4RelativePrimeDenominator C ≤ k :=
    (Nat.le_max_left _ _).trans hk
  have hthreshold : 2 * hprovider.threshold ≤ k :=
    (Nat.le_max_right _ _).trans hk
  exact
    claim4_exists_cambie_lcm_ratio_of_relative_prime_provider
      hlarge hprovider hq_le_k hthreshold

end Erdos678
