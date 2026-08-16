import Formalization.Erdos678.Claim4ConstructedInterface

/-!
Reachable regressions for the D4 constructed-scale wrapper.
-/

namespace Erdos678

/-- The former hand-written `Nx = 12`, `Ny = 4` D3 boundary can now be
reached through the canonical scale constructors themselves. -/
example :
    ∃ zx ∈ Finset.Ico 0 (claim4TripleXSearchLength 4 13 17 19),
      ∃ zy ∈ Finset.Ico 1 (1 + claim4PairYSearchLength 4 3 5),
        Claim5MediumResidues
            (1 + zx * claim4XScale 4 13 17 19)
            (zy * claim4YScale 4 3 5) 4 ∧
          Claim5SmallResidues
            (1 + zx * claim4XScale 4 13 17 19)
            (zy * claim4YScale 4 3 5) 4 := by
  apply claim4_exists_claim5_residue_interfaces_of_constructed_scales
      (k := 4)
      (xp := 13) (xq := 17) (xr := 19)
      (yp := 3) (yq := 5)
      (startx := 0) (starty := 1)
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num [claim4TripleXSearchLength]
  · norm_num [claim4TripleXSearchLength]
  · norm_num [claim4TripleXSearchLength]
  · norm_num [claim4PairYSearchLength]
  · norm_num [claim4PairYSearchLength]

end Erdos678
