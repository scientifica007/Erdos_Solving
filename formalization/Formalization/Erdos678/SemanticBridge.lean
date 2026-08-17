import Formalization.Erdos678.Erdos678Final

/-!
Semantic bridge for comparing the completed reconstruction with public formulations
of Erdős Problem #678.

The bridge deliberately separates the problem's pair-set semantics from the stronger
internal endpoint carrying lower bounds on `n`, `m`, and `k`.  This lets external
comparisons target the mathematical statement rather than repository-specific theorem
packaging.
-/

namespace Erdos678

open Filter

/-- Valid `(m,n)` pairs for one fixed block length `k`, using the canonical
`M(n,k) = lcm(n+1,...,n+k)` convention. -/
def validPairsAt (k : ℕ) : Set (ℕ × ℕ) :=
  {p | p.2 + k ≤ p.1 ∧ erdosM p.1 (k + 1) < erdosM p.2 k}

/-- The public eventual-nonemptiness reading of Erdős #678 follows directly from
our strong Cambie endpoint. -/
theorem validPairsAt_eventually_nonempty :
    ∀ᶠ k in atTop, (validPairsAt k).Nonempty := by
  obtain ⟨K, hK⟩ :=
    cambie_lcm_ratio_eventually_with_large_start (C := 1) (by norm_num)
  filter_upwards [eventually_ge_atTop (max 9 K)] with k hk
  have hKk : K ≤ k := (Nat.le_max_right 9 K).trans hk
  obtain ⟨x, y, hkx, hxy, hsep, hratio⟩ := hK k hKk
  have hxpos : 0 < x := by omega
  have hypos : 0 < y := by omega
  have hxsub : x - 1 + 1 = x := by omega
  have hysub : y - 1 + 1 = y := by omega
  refine ⟨(y - 1, x - 1), ?_⟩
  change x - 1 + k ≤ y - 1 ∧
    erdosM (y - 1) (k + 1) < erdosM (x - 1) k
  constructor
  · omega
  · simpa [erdosM, hxsub, hysub] using hratio

/-- Our explicit unbounded-witness endpoint implies that valid block lengths are
unbounded even after forgetting the stronger lower-bound side conditions. -/
theorem validPairsAt_unbounded_lengths :
    ∀ B : ℕ, ∃ k : ℕ, B ≤ k ∧ (validPairsAt k).Nonempty := by
  intro B
  obtain ⟨n, m, k, hBk, hn, hm, hk, hsep, hratio⟩ :=
    erdos678_unbounded_witnesses B
  refine ⟨k, hBk, (m, n), ?_⟩
  exact ⟨hsep, hratio⟩

/-- Consequently, the set of block lengths admitting a valid pair is infinite.
This is the statement-level bridge between the eventual/nonempty formulation and
our `erdos678_good_lengths_infinite` endpoint. -/
theorem validPairsAt_good_lengths_infinite :
    Set.Infinite {k : ℕ | (validPairsAt k).Nonempty} := by
  apply erdos678_good_lengths_infinite.mono
  intro k hk
  rcases hk with ⟨n, m, hn, hm, hk3, hsep, hratio⟩
  exact ⟨(m, n), hsep, hratio⟩

end Erdos678
