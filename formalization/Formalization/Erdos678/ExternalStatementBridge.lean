import Formalization.Erdos678.Erdos678Final

/-!
# Erdős #678 external statement bridge

Stage S1a of the scientific comparison normalizes the project's final theorem to the
interval representation used by the public `plby/lean-proofs` comparator and by the
Formal Conjectures statement.

The public representation is

`(Finset.Ioc n (n + k)).lcm id`,

i.e. the LCM of `n+1, ..., n+k`.  The project representation is `erdosM n k`, built
from the length-based `intervalFinset (n + 1) k`.  The first theorem below proves these
representations equal inside Lean; the later theorems expose the eventual-nonempty
endpoint in the external representation.

No result here claims a new mathematical proof.  This file is an interface theorem layer
for differential verification of two independently engineered formalizations.
-/

namespace Erdos678

open Filter

/-- The exact interval representation used by the public #678 comparator and by the
Formal Conjectures statement. -/
def externalLCMInterval (n k : ℕ) : ℕ :=
  (Finset.Ioc n (n + k)).lcm id

/-- Our length-based interval representation and the external half-open representation
select exactly the same natural numbers. -/
theorem intervalFinset_succ_eq_Ioc (n k : ℕ) :
    intervalFinset (n + 1) k = Finset.Ioc n (n + k) := by
  ext x
  constructor
  · intro hx
    rw [intervalFinset] at hx
    rcases Finset.mem_image.mp hx with ⟨i, hi, rfl⟩
    have hik : i < k := Finset.mem_range.mp hi
    rw [Finset.mem_Ioc]
    constructor <;> omega
  · intro hx
    rw [Finset.mem_Ioc] at hx
    rw [intervalFinset]
    let i := x - (n + 1)
    have hi : i < k := by
      dsimp [i]
      omega
    have hix : n + 1 + i = x := by
      dsimp [i]
      omega
    exact Finset.mem_image.mpr ⟨i, Finset.mem_range.mpr hi, hix⟩

/-- `erdosM` is definitionally different but extensionally identical to the public
`lcmInterval` representation. -/
theorem erdosM_eq_externalLCMInterval (n k : ℕ) :
    erdosM n k = externalLCMInterval n k := by
  unfold erdosM intervalLCM externalLCMInterval
  rw [intervalFinset_succ_eq_Ioc]

/-- Canonical eventual witness theorem in the external interval representation.
This is the `∃ K, ∀ k ≥ K, ...` form underlying the Formal Conjectures
`eventually nonempty` reading. -/
theorem erdos678_external_eventual_witnesses :
    ∃ K : ℕ, ∀ k : ℕ, K ≤ k →
      ∃ m n : ℕ,
        n + k ≤ m ∧
          externalLCMInterval m (k + 1) < externalLCMInterval n k := by
  obtain ⟨K, hK⟩ :=
    cambie_lcm_ratio_eventually_with_large_start (C := 1) (by norm_num)
  refine ⟨K, ?_⟩
  intro k hk
  obtain ⟨x, y, hkx, hxy, hsep, hratio⟩ := hK k hk
  have hxsub : x - 1 + 1 = x := by omega
  have hysub : y - 1 + 1 = y := by omega
  refine ⟨y - 1, x - 1, ?_, ?_⟩
  · omega
  · have hratio' : erdosM (y - 1) (k + 1) < erdosM (x - 1) k := by
      simpa [erdosM, hxsub, hysub] using hratio
    simpa only [erdosM_eq_externalLCMInterval] using hratio'

/-- Exact semantic shape used by the Formal Conjectures core statement: for all
sufficiently large block lengths, the valid-pair set is nonempty. -/
theorem erdos678_formalConjectures_eventually_nonempty :
    ∀ᶠ k in atTop,
      {(m, n) |
        n + k ≤ m ∧
          externalLCMInterval m (k + 1) < externalLCMInterval n k}.Nonempty := by
  obtain ⟨K, hK⟩ := erdos678_external_eventual_witnesses
  filter_upwards [Filter.eventually_ge_atTop K] with k hk
  obtain ⟨m, n, hsep, hratio⟩ := hK k hk
  refine ⟨(m, n), ?_⟩
  exact ⟨hsep, hratio⟩

end Erdos678
