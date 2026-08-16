import Formalization.Erdos678.Claim4FiveStripsFromRelativePrime

/-!
Reachable E2d regressions for the provider-to-five-strips composition.
-/

namespace Erdos678

/-- The finite five-strip package is reachable from the explicit relative-prime
provider under only the two stated large-`k` inequalities. -/
example
    {C k : ℕ}
    (hC : 0 < C)
    (hprovider : Claim4RelativePrimeProvider (claim4RelativePrimeDenominator C))
    (hq_le_k : claim4RelativePrimeDenominator C ≤ k)
    (hthreshold : 2 * hprovider.threshold ≤ k) :
    ∃ d xp xq xr yp yq : ℕ,
      Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq := by
  exact claim4_exists_five_strips_of_relative_prime_provider
    hC hprovider hq_le_k hthreshold

/-- The same provider reaches the final strict LCM ratio once the already
machine-checked large-`k` condition is supplied. -/
example
    {C k : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hprovider : Claim4RelativePrimeProvider (claim4RelativePrimeDenominator C))
    (hq_le_k : claim4RelativePrimeDenominator C ≤ k)
    (hthreshold : 2 * hprovider.threshold ≤ k) :
    ∃ x y : ℕ,
      0 < x ∧ 0 < y ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_of_relative_prime_provider
    hlarge hprovider hq_le_k hthreshold

end Erdos678
