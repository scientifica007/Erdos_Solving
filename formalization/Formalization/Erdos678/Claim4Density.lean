import Mathlib

/-!
The finite counting core of Cambie's Claim 4.

Each coordinate excludes some values.  If the coordinate map is injective on
the candidate positions, then that coordinate can reject no more positions
than the number of values it excludes.  A strict union bound therefore leaves
at least one position accepted by every coordinate.
-/

namespace Erdos678

/-- A finite coordinate-wise avoidance lemma.

This is the combinatorial core of Cambie's Claim 4, stated independently of
primes and CRT weights.  The later arithmetic layer only has to prove that its
modular coordinate maps are injective on the chosen consecutive interval and
that the total excluded-cardinality budget is strictly smaller than the
number of candidate positions. -/
theorem claim4_exists_avoiding_coordinate_exclusions
    {ι α β : Type*}
    (indices : Finset ι)
    (positions : Finset α)
    (value : ι → α → β)
    (excluded : ι → Finset β)
    (hinj : ∀ i ∈ indices, Set.InjOn (value i) positions)
    (hbudget : ∑ i ∈ indices, (excluded i).card < positions.card) :
    ∃ z ∈ positions, ∀ i ∈ indices, value i z ∉ excluded i := by
  classical
  let bad : ι → Finset α := fun i =>
    positions.filter fun z => value i z ∈ excluded i
  have hbad_card : ∀ i ∈ indices, (bad i).card ≤ (excluded i).card := by
    intro i hi
    apply Finset.card_le_card_of_injOn (value i)
    · intro z hz
      have hz' : z ∈ positions ∧ value i z ∈ excluded i := by
        simpa [bad] using hz
      exact hz'.2
    · intro z hz z' hz' hval
      have hzmem : z ∈ positions ∧ value i z ∈ excluded i := by
        simpa [bad] using hz
      have hz'mem : z' ∈ positions ∧ value i z' ∈ excluded i := by
        simpa [bad] using hz'
      exact hinj i hi hzmem.1 hz'mem.1 hval
  have hsum :
      ∑ i ∈ indices, (bad i).card ≤
        ∑ i ∈ indices, (excluded i).card := by
    exact Finset.sum_le_sum fun i hi => hbad_card i hi
  have hunion : (indices.biUnion bad).card < positions.card :=
    lt_of_le_of_lt (Finset.card_biUnion_le.trans hsum) hbudget
  by_contra hnone
  push Not at hnone
  have hsubset : positions ⊆ indices.biUnion bad := by
    intro z hz
    obtain ⟨i, hi, hzbad⟩ := hnone z hz
    apply Finset.mem_biUnion.mpr
    refine ⟨i, hi, ?_⟩
    simp [bad, hz, hzbad]
  have hcard := Finset.card_le_card hsubset
  omega

end Erdos678
