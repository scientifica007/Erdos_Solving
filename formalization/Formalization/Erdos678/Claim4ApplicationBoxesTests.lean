import Formalization.Erdos678.Claim4ApplicationBoxes

/-!
Reachable regressions for Cambie's concrete `x` and `y` residue boxes.
-/

namespace Erdos678

/-- The paper endpoint `p` is the canonical zero residue. -/
example : claim4PaperCoefficient 11 0 = 11 := by
  rfl

/-- Translating zero to `p` preserves its residue. -/
example : claim4PaperCoefficient 11 0 ≡ 0 [MOD 11] := by
  exact claim4PaperCoefficient_modEq 11 0

/-- For `k = 20` and `p = 11`, the `x` box excludes exactly nine
canonical residues. -/
example : (claim4XExcluded 20 11).card = 9 := by
  simpa using claim4XExcluded_card (k := 20) (p := 11) (by norm_num)

/-- For the same parameters, the `y` box excludes exactly one residue. -/
example : (claim4YExcluded 20 11).card = 1 := by
  simpa using claim4YExcluded_card (k := 20) (p := 11) (by norm_num)

/-- Residue zero belongs to the paper's `y` box because it is encoded by the
upper endpoint `p`. -/
example :
    11 - 20 % 11 ≤ claim4PaperCoefficient 11 0 ∧
      claim4PaperCoefficient 11 0 ≤ 11 := by
  norm_num [claim4PaperCoefficient]

/-- The exact two-prime `y` search length is reachable for concrete primes. -/
example : True := by
  rcases claim4_pair_y_box_density
      (k := 20) (p := 11) (q := 13) (start := 5)
      (by norm_num) (by norm_num) (by norm_num)
      (by norm_num [claim4PairYSearchLength])
      (by norm_num [claim4PairYSearchLength]) with
    ⟨c, hc, z, hz, hbox, hrep⟩
  trivial

/-- The exact three-prime `x` search length is reachable for concrete primes
near `k`. -/
example : True := by
  rcases claim4_triple_x_box_density
      (k := 40) (p := 29) (q := 31) (r := 37) (start := 7)
      (by norm_num) (by norm_num) (by norm_num)
      (by norm_num) (by norm_num) (by norm_num)
      (by norm_num [claim4TripleXSearchLength])
      (by norm_num [claim4TripleXSearchLength])
      (by norm_num [claim4TripleXSearchLength]) with
    ⟨c, hc, z, hz, hbox, hrep⟩
  trivial

/-- Strictness is active: the six positions excluded by the concrete pair
cannot satisfy a budget of only six. -/
example :
    ¬((claim4YExcluded 20 11).card +
        (claim4YExcluded 20 13).card < 6) := by
  have hp := claim4YExcluded_card (k := 20) (p := 11) (by norm_num)
  have hq := claim4YExcluded_card (k := 20) (p := 13) (by norm_num)
  norm_num at hp hq ⊢
  omega

end Erdos678
