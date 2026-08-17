import Formalization.Erdos678.Claim4Scales

/-!
The D4 constructed-scale wrapper around the verified D3 producer.

Once the five special primes and the exact search-length inequalities are
supplied, the concrete definitions `claim4XScale` and `claim4YScale` now
discharge all scale-support premises of
`claim4_exists_claim5_residue_interfaces_of_scales` automatically.
-/

namespace Erdos678

/-- The actual D4 scales reduce the D3 producer to prime, medium-range, and
search-length data.  All small-prime support, other-medium divisibility, and
special-coordinate unit premises are discharged by `Claim4Scales`. -/
theorem claim4_exists_claim5_residue_interfaces_of_constructed_scales
    {k xp xq xr yp yq startx starty : ℕ}
    (hxp : Nat.Prime xp) (hxq : Nat.Prime xq) (hxr : Nat.Prime xr)
    (hyp : Nat.Prime yp) (hyq : Nat.Prime yq)
    (hkxp2 : k < xp ^ 2) (hkxq2 : k < xq ^ 2) (hkxr2 : k < xr ^ 2)
    (hkyp2 : k < yp ^ 2) (hkyq2 : k < yq ^ 2)
    (hlenxp : claim4TripleXSearchLength k xp xq xr ≤ xp)
    (hlenxq : claim4TripleXSearchLength k xp xq xr ≤ xq)
    (hlenxr : claim4TripleXSearchLength k xp xq xr ≤ xr)
    (hlenyp : claim4PairYSearchLength k yp yq ≤ yp)
    (hlenyq : claim4PairYSearchLength k yp yq ≤ yq) :
    ∃ zx ∈ Finset.Ico startx
        (startx + claim4TripleXSearchLength k xp xq xr),
      ∃ zy ∈ Finset.Ico starty
          (starty + claim4PairYSearchLength k yp yq),
        Claim5MediumResidues
            (1 + zx * claim4XScale k xp xq xr)
            (zy * claim4YScale k yp yq) k ∧
          Claim5SmallResidues
            (1 + zx * claim4XScale k xp xq xr)
            (zy * claim4YScale k yp yq) k := by
  apply claim4_exists_claim5_residue_interfaces_of_scales
      (k := k) (xp := xp) (xq := xq) (xr := xr)
      (yp := yp) (yq := yq)
      (Nx := claim4XScale k xp xq xr)
      (Ny := claim4YScale k yp yq)
      (startx := startx) (starty := starty)
      hxp hxq hxr hyp hyq
  · exact claim4XScale_not_dvd_of_medium_special hxp hkxp2 (by simp)
  · exact claim4XScale_not_dvd_of_medium_special hxq hkxq2 (by simp)
  · exact claim4XScale_not_dvd_of_medium_special hxr hkxr2 (by simp)
  · exact claim4YScale_not_dvd_of_medium_special hyp hkyp2 (by simp)
  · exact claim4YScale_not_dvd_of_medium_special hyq hkyq2 (by simp)
  · exact hlenxp
  · exact hlenxq
  · exact hlenxr
  · exact hlenyp
  · exact hlenyq
  · intro p hp hpk hkp2 hpxp hpxq hpxr
    exact claim4XScale_dvd_of_medium_other hp hpk hkp2 hpxp hpxq hpxr
  · intro p hp hpk hkp2 hpyp hpyq
    exact claim4YScale_dvd_of_medium_other hp hpk hkp2 hpyp hpyq
  · exact claim4XYSmallPrimeScaleData k xp xq xr yp yq

end Erdos678
