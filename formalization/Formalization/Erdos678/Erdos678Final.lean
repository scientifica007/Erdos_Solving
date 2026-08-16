import Formalization.Erdos678.CambieStrongTheorem
import Formalization.Erdos678.Claim5ProductEstimate
import Formalization.Erdos678.Claim4FiveStripsFromRelativePrime
import Formalization.Erdos678.Claim4RelativePrimePNT

/-!
Phase E4: translate the strong Cambie construction to the canonical Erdős #678
indexing convention.

The E1 endpoint intentionally discarded most placement information once the LCM
comparison was proved.  For the final problem statement we need one additional
fact: the left interval start `x` must be large enough that `n = x - 1 ≥ 3`.
The existing Cambie lower-target and closeness bounds already imply the stronger
inequality `k < x`; this file preserves that fact through the E2/E3 pipeline and
then performs the off-by-one-safe translation to `erdosM`.
-/

namespace Erdos678

/-- The verified Cambie lower target and closeness bounds force the x-start to
lie beyond the block length. -/
theorem claim4_cambie_k_lt_x_of_bounds
    {C k x y : ℕ}
    (hC : 0 < C)
    (hk : 0 < k)
    (hxy : x < y)
    (hylower : claim4CambieYLower C k < y)
    (hclose : y < x + claim4CambieGap C k) :
    k < x := by
  have hgapLower := claim4CambieGap_mul_succ_le_yLower hC hk
  have hgapBelowY :
      claim4CambieGap C k * (k + 1) < y :=
    hgapLower.trans_lt hylower
  have hkgap_lt_x : k * claim4CambieGap C k < x := by
    have htmp :
        k * claim4CambieGap C k + claim4CambieGap C k <
          x + claim4CambieGap C k := by
      calc
        k * claim4CambieGap C k + claim4CambieGap C k =
            claim4CambieGap C k * (k + 1) := by ring
        _ < y := hgapBelowY
        _ < x + claim4CambieGap C k := hclose
    omega
  have hgap_pos : 0 < claim4CambieGap C k := by
    omega
  have hgap_one : 1 ≤ claim4CambieGap C k := by omega
  have hk_le_kgap : k ≤ k * claim4CambieGap C k := by
    have hmul := Nat.mul_le_mul_left k hgap_one
    simpa using hmul
  exact hk_le_kgap.trans_lt hkgap_lt_x

/-- Sharp-window E1 endpoint retaining the start-size information needed by E4. -/
theorem claim4_exists_cambie_lcm_ratio_with_large_start_of_sharp_windows
    {C k s xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hsharp : Claim4CambieSharpPrimeWindowData C k s xp xq xr yp yq) :
    ∃ x y : ℕ,
      k < x ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  have hk : 0 < k := by omega
  rcases claim4_exists_cambie_target_representatives_with_claim5_of_sharp_windows
      hlarge hsharp with
    ⟨x, y, hx, hy, hxy, hsep, hclose, hylower, hyupper,
      hmedium, hsmall, hclaim5⟩
  have hkx :=
    claim4_cambie_k_lt_x_of_bounds
      hlarge.C_pos hk hxy hylower hclose
  refine ⟨x, y, hkx, hxy, hsep, ?_⟩
  exact claim5_lcm_lt_of_cambie_bounds
    hlarge.C_pos hk hx hy hylower hclose hyupper hclaim5

/-- Five-strip form of the E4-strengthened endpoint. -/
theorem claim4_exists_cambie_lcm_ratio_with_large_start_of_five_strips
    {C k d xp xq xr yp yq : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hstrips : Claim4CambieFiveStripPrimeData C k d xp xq xr yp yq) :
    ∃ x y : ℕ,
      k < x ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  exact claim4_exists_cambie_lcm_ratio_with_large_start_of_sharp_windows
    hlarge (hstrips.toSharpPrimeWindowData hlarge.C_pos)

/-- Relative-prime-provider form retaining `k < x`. -/
theorem claim4_exists_cambie_lcm_ratio_with_large_start_of_relative_prime_provider
    {C k : ℕ}
    (hlarge : Claim4CambieLargeKData C k)
    (hprovider : Claim4RelativePrimeProvider (claim4RelativePrimeDenominator C))
    (hq_le_k : claim4RelativePrimeDenominator C ≤ k)
    (hthreshold : 2 * hprovider.threshold ≤ k) :
    ∃ x y : ℕ,
      k < x ∧ x < y ∧ x + k < y ∧
      C * intervalLCM y (k + 1) < intervalLCM x k := by
  obtain ⟨d, xp, xq, xr, yp, yq, hstrips⟩ :=
    claim4_exists_five_strips_of_relative_prime_provider
      hlarge.C_pos hprovider hq_le_k hthreshold
  exact claim4_exists_cambie_lcm_ratio_with_large_start_of_five_strips
    hlarge hstrips

/-- PNT plus the elementary E3a growth threshold gives the strong Cambie
comparison while retaining `k < x`. -/
theorem cambie_lcm_ratio_eventually_with_large_start
    {C : ℕ} (hC : 0 < C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ x y : ℕ,
        k < x ∧ x < y ∧ x + k < y ∧
        C * intervalLCM y (k + 1) < intervalLCM x k := by
  have hq : 0 < claim4RelativePrimeDenominator C := by
    dsimp [claim4RelativePrimeDenominator]
    positivity
  let hprovider :=
    claim4RelativePrimeProviderOfPNT (claim4RelativePrimeDenominator C) hq
  let Kpnt :=
    max (claim4RelativePrimeDenominator C) (2 * hprovider.threshold)
  let Kgrowth := claim4CambieLargeKThreshold C
  refine ⟨max Kpnt Kgrowth, ?_⟩
  intro k hk
  have hkPNT : Kpnt ≤ k := (Nat.le_max_left Kpnt Kgrowth).trans hk
  have hkGrowth : Kgrowth ≤ k := (Nat.le_max_right Kpnt Kgrowth).trans hk
  have hq_le_k : claim4RelativePrimeDenominator C ≤ k := by
    exact (Nat.le_max_left _ _).trans hkPNT
  have hthreshold : 2 * hprovider.threshold ≤ k := by
    exact (Nat.le_max_right _ _).trans hkPNT
  have hlarge : Claim4CambieLargeKData C k :=
    claim4CambieLargeKData_of_threshold hC hkGrowth
  exact
    claim4_exists_cambie_lcm_ratio_with_large_start_of_relative_prime_provider
      hlarge hprovider hq_le_k hthreshold

/-- Canonical Erdős #678 witness theorem in an explicitly unbounded form.
For every requested lower bound on `k`, a larger valid triple exists.  This is
stronger than merely exhibiting infinitely many isolated triples. -/
theorem erdos678_unbounded_witnesses :
    ∀ B : ℕ,
      ∃ n m k : ℕ,
        B ≤ k ∧ 3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + k ≤ m ∧
          erdosM m (k + 1) < erdosM n k := by
  intro B
  obtain ⟨K, hK⟩ :=
    cambie_lcm_ratio_eventually_with_large_start (C := 1) (by norm_num)
  let k := max 9 (max B K)
  have hBk : B ≤ k := by
    exact (Nat.le_max_left B K).trans
      ((Nat.le_max_right 9 (max B K)))
  have hKk : K ≤ k := by
    exact (Nat.le_max_right B K).trans
      ((Nat.le_max_right 9 (max B K)))
  have hk9 : 9 ≤ k := Nat.le_max_left 9 (max B K)
  obtain ⟨x, y, hkx, hxy, hsep, hratio⟩ := hK k hKk
  have hxpos : 0 < x := by omega
  have hypos : 0 < y := by omega
  have hxsub : x - 1 + 1 = x := by omega
  have hysub : y - 1 + 1 = y := by omega
  refine ⟨x - 1, y - 1, k, hBk, ?_, ?_, ?_, ?_, ?_⟩
  · omega
  · omega
  · omega
  · omega
  · simpa [erdosM, hxsub, hysub] using hratio

/-- The set of block lengths for which the canonical Erdős #678 conclusion has
witnesses is infinite. -/
theorem erdos678_good_lengths_infinite :
    Set.Infinite
      {k : ℕ |
        ∃ n m : ℕ,
          3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + k ≤ m ∧
            erdosM m (k + 1) < erdosM n k} := by
  apply Set.infinite_of_not_bddAbove
  intro hbounded
  rcases hbounded with ⟨B, hB⟩
  obtain ⟨n, m, k, hBk, hn, hm, hk, hsep, hratio⟩ :=
    erdos678_unbounded_witnesses (B + 1)
  have hmem :
      k ∈ {k : ℕ |
        ∃ n m : ℕ,
          3 ≤ n ∧ 3 ≤ m ∧ 3 ≤ k ∧ n + k ≤ m ∧
            erdosM m (k + 1) < erdosM n k} := by
    exact ⟨n, m, hn, hm, hk, hsep, hratio⟩
  have hkB : k ≤ B := hB hmem
  omega

end Erdos678
