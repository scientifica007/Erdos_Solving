import Formalization.Erdos678.SemanticBridge

namespace Erdos678

open Filter

example : ∀ᶠ k in atTop, (validPairsAt k).Nonempty :=
  validPairsAt_eventually_nonempty

example : ∀ B : ℕ, ∃ k : ℕ, B ≤ k ∧ (validPairsAt k).Nonempty :=
  validPairsAt_unbounded_lengths

example : Set.Infinite {k : ℕ | (validPairsAt k).Nonempty} :=
  validPairsAt_good_lengths_infinite

end Erdos678
