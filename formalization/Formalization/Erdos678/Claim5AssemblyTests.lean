import Formalization.Erdos678.Claim5Assembly

/-!
Reachable interface regression for the assembled Claim 5 identity.

At `k = 2`, the only prime not in the large range is `p = 2`, and it lies in
the medium range.  The small-prime premise is therefore vacuous.
-/

namespace Erdos678

example :
    intervalProd 2 3 / intervalLCM 2 3 =
      intervalLCM 1 2 * (intervalProd 1 2 / intervalLCM 1 2) := by
  apply claim5_full_identity_of_residues (x := 1) (y := 2) (k := 2)
  · norm_num
  · intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  · intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  · intro p hp hpk hkp2
    have hp2 : 2 ≤ p := hp.two_le
    have hpeq : p = 2 := by omega
    subst p
    refine ⟨1, 2, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> norm_num [Nat.ModEq]
  · intro p hp hp2k
    have hp2 : 2 ≤ p := hp.two_le
    have hp4 : 4 ≤ p ^ 2 := by nlinarith
    omega

end Erdos678
