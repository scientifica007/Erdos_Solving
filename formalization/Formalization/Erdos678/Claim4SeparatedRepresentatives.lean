import Formalization.Erdos678.Claim4Placement

/-!
Separated quantitative representatives for D4e.

The preceding layers construct the actual scales, isolate the five-prime
window contract, and place the verified CRT search blocks inside arbitrary
numerical windows.  This module packages those ingredients into two actual
representatives `x` and `y`.

The separation hypothesis is stated only at the level of the enclosing
numerical windows: `xUpper + k ≤ yLower`.  The produced representatives then
satisfy `x + k < y` automatically.  No separation property is assumed of the
CRT witnesses themselves.
-/

namespace Erdos678

/-- D4e endpoint: separated representatives satisfying both Claim 5 residue
interfaces and hence Cambie's complete Claim 5 identity.

The only quantitative obligations left to the caller are that the canonical
`x` and `y` search blocks fit in their chosen numerical windows and that those
windows are separated by at least `k`. -/
theorem claim4_exists_separated_claim5_representatives
    {k xp xq xr yp yq xLower xUpper yLower yUpper : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq)
    (hk : 0 < k)
    (hxroom :
      1 + (claim4SearchStart xLower (claim4XScale k xp xq xr) +
          claim4TripleXSearchLength k xp xq xr) *
            claim4XScale k xp xq xr ≤ xUpper)
    (hyroom :
      (claim4SearchStart yLower (claim4YScale k yp yq) +
          claim4PairYSearchLength k yp yq) *
            claim4YScale k yp yq ≤ yUpper)
    (hsep : xUpper + k ≤ yLower) :
    ∃ x y : ℕ,
      0 < x ∧ x < y ∧ x + k < y ∧
      xLower < x ∧ x < xUpper ∧
      yLower < y ∧ y < yUpper ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k * (intervalProd x k / intervalLCM x k) := by
  let Nx := claim4XScale k xp xq xr
  let Ny := claim4YScale k yp yq
  let lenx := claim4TripleXSearchLength k xp xq xr
  let leny := claim4PairYSearchLength k yp yq
  let startx := claim4SearchStart xLower Nx
  let starty := claim4SearchStart yLower Ny
  rcases claim4_exists_claim5_residue_interfaces_of_prime_windows
      (startx := startx) (starty := starty) h with
    ⟨zx, hzx, zy, hzy, hmedium, hsmall⟩
  let x := 1 + zx * Nx
  let y := zy * Ny
  have hxbounds : xLower < x ∧ x < xUpper := by
    dsimp [x]
    exact claim4_one_add_mul_bounds_of_mem_search
      (lower := xLower) (upper := xUpper)
      (scale := Nx) (len := lenx) (z := zx)
      (by simpa [Nx] using claim4XScale_pos k xp xq xr)
      (by simpa [startx, lenx] using hzx)
      (by simpa [startx, lenx, Nx] using hxroom)
  have hybounds : yLower < y ∧ y < yUpper := by
    dsimp [y]
    exact claim4_mul_bounds_of_mem_search
      (lower := yLower) (upper := yUpper)
      (scale := Ny) (len := leny) (z := zy)
      (by simpa [Ny] using claim4YScale_pos k yp yq)
      (by simpa [starty, leny] using hzy)
      (by simpa [starty, leny, Ny] using hyroom)
  have hxpos : 0 < x := by
    dsimp [x]
    omega
  have hypos : 0 < y := by
    omega
  have hxy : x < y := by
    omega
  have hgap : x + k < y := by
    omega
  have hxne : ∀ z ∈ intervalFinset x k, z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, rfl⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, rfl⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hmedium' : Claim5MediumResidues x y k := by
    simpa [x, y, Nx, Ny] using hmedium
  have hsmall' : Claim5SmallResidues x y k := by
    simpa [x, y, Nx, Ny] using hsmall
  have hidentity :=
    claim5_full_identity_of_residues hk hxne hyne hmedium' hsmall'
  exact ⟨x, y, hxpos, hxy, hgap,
    hxbounds.1, hxbounds.2, hybounds.1, hybounds.2,
    hmedium', hsmall', hidentity⟩

end Erdos678
