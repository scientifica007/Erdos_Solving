import Formalization.Erdos678.Claim4Modular

/-!
Reachable regressions for the modular layer of Cambie's Claim 4.
-/

namespace Erdos678

/-- Multiplication by two modulo five leaves an allowed position in any full
five-position interval when only two residues are forbidden. -/
example :
    ∃ z ∈ Finset.Ico 7 12,
      (z * 2) % 5 ∉ ({0, 1} : Finset ℕ) := by
  have h := claim4_prime_coordinate_density
      (indices := ({0} : Finset ℕ))
      (p := fun _ => 5)
      (c := fun _ => 2)
      (start := 7)
      (len := 5)
      (excluded := fun _ => ({0, 1} : Finset ℕ))
      (by intro i hi; norm_num)
      (by intro i hi; norm_num)
      (by intro i hi; norm_num)
      (by norm_num)
  simpa using h

/-- The nondivisibility condition is active: multiplication by five modulo
five is not injective even on two consecutive positions. -/
example :
    ¬ Set.InjOn (fun z : ℕ => (z * 5) % 5) (Finset.Ico 0 2) := by
  intro h
  have h01 : (0 : ℕ) = 1 := h (by simp) (by simp) (by norm_num)
  norm_num at h01

end Erdos678
