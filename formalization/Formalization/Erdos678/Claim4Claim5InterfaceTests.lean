import Formalization.Erdos678.Claim4Claim5Interface

/-!
Reachable regressions for the scaled Claim 4 / Claim 5 interface boundary.
-/

namespace Erdos678

/-- Paper representatives can be used directly as congruence witnesses. -/
example : 22 ≡ claim4PaperCoefficient 7 (22 % 7) [MOD 7] := by
  exact claim4_modEq_paperCoefficient_mod 22 7

/-- Common divisibility by the maximal small prime power produces the small
residue interface in a nonvacuous case. -/
example : Claim5SmallResidues (1 + 3 * 12) (5 * 4) 4 := by
  apply claim5SmallResidues_of_scales
  intro p hp hp2k
  have hp2 : 2 ≤ p := hp.two_le
  have hple : p ≤ 2 := by nlinarith
  have hpeq : p = 2 := by omega
  subst p
  refine ⟨2, ?_, ?_, ?_, ?_⟩ <;> norm_num

/-- Concrete scaled pair/triple producers jointly feed both Claim 5 residue
interfaces and hence the already verified full Claim 5 identity. -/
example :
    ∃ x y : ℕ,
      Claim5MediumResidues x y 4 ∧
      Claim5SmallResidues x y 4 ∧
      intervalProd y 5 / intervalLCM y 5 =
        intervalLCM 1 4 * (intervalProd x 4 / intervalLCM x 4) := by
  have hxother :
      ∀ p : ℕ, Nat.Prime p → p ≤ 4 → 4 < p ^ 2 →
        p ≠ 13 → p ≠ 17 → p ≠ 19 → p ∣ 12 := by
    intro p hp hpk hkp2 hp13 hp17 hp19
    have hp2 : 2 ≤ p := hp.two_le
    interval_cases p
    · norm_num at hkp2
    · norm_num
    · norm_num at hp
  have hyother :
      ∀ p : ℕ, Nat.Prime p → p ≤ 4 → 4 < p ^ 2 →
        p ≠ 3 → p ≠ 5 → p ∣ 4 := by
    intro p hp hpk hkp2 hp3 hp5
    have hp2 : 2 ≤ p := hp.two_le
    interval_cases p
    · norm_num at hkp2
    · norm_num at hp3
    · norm_num at hp
  have hsmall : Claim4SmallPrimeScaleData 12 4 4 := by
    intro p hp hp2k
    have hp2 : 2 ≤ p := hp.two_le
    have hple : p ≤ 2 := by nlinarith
    have hpeq : p = 2 := by omega
    subst p
    refine ⟨2, ?_, ?_, ?_, ?_⟩ <;> norm_num
  rcases claim4_exists_claim5_residue_interfaces_of_scales
      (k := 4)
      (xp := 13) (xq := 17) (xr := 19)
      (yp := 3) (yq := 5)
      (Nx := 12) (Ny := 4)
      (startx := 0) (starty := 1)
      (by norm_num) (by norm_num) (by norm_num)
      (by norm_num) (by norm_num)
      (by norm_num) (by norm_num) (by norm_num)
      (by norm_num) (by norm_num)
      (by norm_num [claim4TripleXSearchLength])
      (by norm_num [claim4TripleXSearchLength])
      (by norm_num [claim4TripleXSearchLength])
      (by norm_num [claim4PairYSearchLength])
      (by norm_num [claim4PairYSearchLength])
      hxother hyother hsmall with
    ⟨zx, hzx, zy, hzy, hmedium, hsmall'⟩
  let x := 1 + zx * 12
  let y := zy * 4
  have hxpos : 0 < x := by
    simp [x]
  have hypos : 0 < y := by
    have hzy' := Finset.mem_Ico.mp hzy
    dsimp [y]
    omega
  have hxne : ∀ z ∈ intervalFinset x 4, z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hyne : ∀ z ∈ intervalFinset y 5, z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  refine ⟨x, y, ?_, ?_, ?_⟩
  · simpa [x, y] using hmedium
  · simpa [x, y] using hsmall'
  · apply claim5_full_identity_of_residues
      (x := x) (y := y) (k := 4)
    · norm_num
    · exact hxne
    · exact hyne
    · simpa [x, y] using hmedium
    · simpa [x, y] using hsmall'

/-- The medium-prime interface is not cosmetic: the wrong `y` residue at
`k = 2`, `p = 2` makes the interface impossible. -/
example : ¬ Claim5MediumResidues 1 1 2 := by
  intro h
  rcases h 2 (by norm_num) (by norm_num) (by norm_num) with
    ⟨a, b, ha1, haUpper, hbLower, hbUpper, hxa, hyb⟩
  have hb : b = 2 := by norm_num at hbLower hbUpper ⊢; omega
  subst b
  norm_num [Nat.ModEq] at hyb

end Erdos678
