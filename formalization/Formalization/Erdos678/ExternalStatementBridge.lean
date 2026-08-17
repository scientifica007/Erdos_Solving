import Formalization.Erdos678.Erdos678Final

/-!
Differential-verification bridge for Erdős Problem #678.

This module connects the length-based interval API used by this repository to
public statement conventions used by the Aristotle/Alexeev formalization and
Formal Conjectures.  It also lifts the strong natural-factor Cambie endpoint to
a real factor `C ≥ 1`, matching the parameter type of the public strong theorem.

No external proof source is copied or imported here.  The bridge is proved only
from this repository's machine-checked endpoint.
-/

namespace Erdos678

open Filter

/-- A block of `k` naturals starting at `n+1` is exactly the half-open interval
`(n, n+k]` used by the public `lcmInterval` convention. -/
theorem intervalFinset_succ_eq_Ioc (n k : ℕ) :
    intervalFinset (n + 1) k = Finset.Ioc n (n + k) := by
  ext z
  constructor
  · intro hz
    rcases Finset.mem_image.mp hz with ⟨i, hi, rfl⟩
    have hik : i < k := Finset.mem_range.mp hi
    exact Finset.mem_Ioc.mpr ⟨by omega, by omega⟩
  · intro hz
    have hz' := Finset.mem_Ioc.mp hz
    refine Finset.mem_image.mpr ⟨z - (n + 1), Finset.mem_range.mpr ?_, ?_⟩
    · omega
    · omega

/-- The canonical `erdosM` definition is extensionally identical to the public
`lcmInterval n k = lcm (Ioc n (n+k))` convention. -/
theorem erdosM_eq_Ioc_lcm (n k : ℕ) :
    erdosM n k = (Finset.Ioc n (n + k)).lcm id := by
  unfold erdosM intervalLCM
  rw [intervalFinset_succ_eq_Ioc]

/-- Canonical valid-pair predicate at a fixed block length. -/
def erdos678ValidPair (k : ℕ) (p : ℕ × ℕ) : Prop :=
  p.2 + k ≤ p.1 ∧ erdosM p.1 (k + 1) < erdosM p.2 k

/-- Formal-Conjectures-style eventual nonemptiness, first stated through this
repository's canonical `erdosM` API. -/
theorem erdos678_eventually_nonempty_pairs :
    ∀ᶠ k : ℕ in atTop,
      {p : ℕ × ℕ | erdos678ValidPair k p}.Nonempty := by
  obtain ⟨K, hK⟩ :=
    cambie_lcm_ratio_eventually_with_large_start (C := 1) (by norm_num)
  refine Filter.eventually_atTop.2 ⟨K, ?_⟩
  intro k hk
  obtain ⟨x, y, _hkx, _hxy, hsep, hratio⟩ := hK k hk
  have hxpos : 0 < x := by omega
  have hypos : 0 < y := by omega
  have hxsub : x - 1 + 1 = x := by omega
  have hysub : y - 1 + 1 = y := by omega
  refine ⟨(y - 1, x - 1), ?_⟩
  change (x - 1) + k ≤ y - 1 ∧
    erdosM (y - 1) (k + 1) < erdosM (x - 1) k
  constructor
  · omega
  · simpa [erdosM, hxsub, hysub] using hratio

/-- The same eventual-nonempty statement written literally with `Finset.Ioc`,
matching the interval semantics used by the public comparator and Formal
Conjectures. -/
theorem erdos678_formalConjectures_eventual_nonempty :
    ∀ᶠ k : ℕ in atTop,
      {(m, n) : ℕ × ℕ |
        n + k ≤ m ∧
        (Finset.Ioc m (m + (k + 1))).lcm id <
          (Finset.Ioc n (n + k)).lcm id}.Nonempty := by
  simpa [erdos678ValidPair, erdosM_eq_Ioc_lcm] using
    erdos678_eventually_nonempty_pairs

/-- The explicit unbounded-witness theorem remains unbounded after forgetting
repository-specific lower-bound side conditions and retaining only the canonical
valid-pair semantics. -/
theorem erdos678_valid_pair_lengths_unbounded :
    ∀ B : ℕ, ∃ k : ℕ, B ≤ k ∧
      {p : ℕ × ℕ | erdos678ValidPair k p}.Nonempty := by
  intro B
  obtain ⟨n, m, k, hBk, _hn, _hm, _hk, hsep, hratio⟩ :=
    erdos678_unbounded_witnesses B
  refine ⟨k, hBk, (m, n), ?_⟩
  exact ⟨hsep, hratio⟩

/-- Hence the set of block lengths admitting at least one canonical valid pair is
infinite.  This statement-level bridge is useful when comparing the eventual
nonempty formulation with the explicit infinitude endpoint. -/
theorem erdos678_valid_pair_good_lengths_infinite :
    Set.Infinite
      {k : ℕ | {p : ℕ × ℕ | erdos678ValidPair k p}.Nonempty} := by
  apply erdos678_good_lengths_infinite.mono
  intro k hk
  rcases hk with ⟨n, m, _hn, _hm, _hk, hsep, hratio⟩
  exact ⟨(m, n), hsep, hratio⟩

/-- Lift the strong Cambie endpoint from a positive natural multiplicative
factor to an arbitrary real factor `C ≥ 1`.  This matches the parameter domain
of the public Aristotle/Alexeev `main_theorem_expanded` endpoint without
changing the underlying construction. -/
theorem cambie_lcm_ratio_eventually_with_large_start_real
    {C : ℝ} (hC : 1 ≤ C) :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ x y : ℕ,
        k < x ∧ x < y ∧ x + k < y ∧
        C * (intervalLCM y (k + 1) : ℝ) <
          (intervalLCM x k : ℝ) := by
  let N : ℕ := ⌈C⌉₊
  have hCN : C ≤ (N : ℝ) := by
    simpa [N] using Nat.le_ceil C
  have hCpos : 0 < C := lt_of_lt_of_le zero_lt_one hC
  have hNposR : (0 : ℝ) < (N : ℝ) := hCpos.trans_le hCN
  have hNpos : 0 < N := by
    exact_mod_cast hNposR
  obtain ⟨K, hK⟩ :=
    cambie_lcm_ratio_eventually_with_large_start (C := N) hNpos
  refine ⟨K, ?_⟩
  intro k hk
  obtain ⟨x, y, hkx, hxy, hsep, hratio⟩ := hK k hk
  refine ⟨x, y, hkx, hxy, hsep, ?_⟩
  have hratioR :
      (N : ℝ) * (intervalLCM y (k + 1) : ℝ) <
        (intervalLCM x k : ℝ) := by
    exact_mod_cast hratio
  exact
    (mul_le_mul_of_nonneg_right hCN (by positivity)).trans_lt hratioR

end Erdos678
