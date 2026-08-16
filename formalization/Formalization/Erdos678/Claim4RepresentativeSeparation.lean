import Formalization.Erdos678.Claim4Placement

/-!
Quantitative representative separation for D4.

This layer consumes two independent inputs:

* `Claim4PrimeWindowData`, which supplies the five special primes and all exact
  Claim 4 search-length bounds;
* `Claim4SeparatedWindowData`, which records only the numerical room needed to
  place the two canonical search blocks in separated target windows.

The second input is deliberately a finite arithmetic contract.  A later
large-`k` / prime-density layer may discharge it for Cambie's concrete target
ranges without changing the CRT construction below.

Crucially, the theorem in this module does not assume `x < y` or
`x + k < y` for the representatives.  Those inequalities are derived from
membership in the two verified search blocks and the separation of their
numerical windows.
-/

namespace Erdos678

/-- Quantitative room for the canonical `x` and `y` Claim 4 search blocks.
The windows are separated by at least `k` before representatives are chosen. -/
structure Claim4SeparatedWindowData
    (k xp xq xr yp yq xLower xUpper yLower yUpper : ℕ) : Prop where
  x_room :
    1 +
        (claim4SearchStart xLower (claim4XScale k xp xq xr) +
            claim4TripleXSearchLength k xp xq xr) *
          claim4XScale k xp xq xr ≤
      xUpper
  y_room :
    (claim4SearchStart yLower (claim4YScale k yp yq) +
        claim4PairYSearchLength k yp yq) *
      claim4YScale k yp yq ≤
    yUpper
  separated_windows : xUpper + k ≤ yLower

/-- D4e endpoint: separated representatives with both Claim 5 residue
interfaces and the complete Claim 5 identity.

No representative-order or representative-separation hypothesis is assumed.
The inequalities `x < y` and `x + k < y` are consequences of the verified
search membership together with `Claim4SeparatedWindowData`. -/
theorem claim4_exists_separated_representatives_with_claim5
    {k xp xq xr yp yq xLower xUpper yLower yUpper : ℕ}
    (hprime : Claim4PrimeWindowData k xp xq xr yp yq)
    (hwindow :
      Claim4SeparatedWindowData
        k xp xq xr yp yq xLower xUpper yLower yUpper) :
    ∃ x y : ℕ,
      0 < x ∧
      x < y ∧
      x + k < y ∧
      xLower < x ∧ x < xUpper ∧
      yLower < y ∧ y < yUpper ∧
      Claim5MediumResidues x y k ∧
      Claim5SmallResidues x y k ∧
      intervalProd y (k + 1) / intervalLCM y (k + 1) =
        intervalLCM 1 k *
          (intervalProd x k / intervalLCM x k) := by
  rcases claim4_exists_claim5_residue_interfaces_of_prime_windows
      (startx := claim4SearchStart xLower (claim4XScale k xp xq xr))
      (starty := claim4SearchStart yLower (claim4YScale k yp yq))
      hprime with
    ⟨zx, hzx, zy, hzy, hmedium0, hsmall0⟩
  let x := 1 + zx * claim4XScale k xp xq xr
  let y := zy * claim4YScale k yp yq
  have hxbounds0 := claim4_one_add_mul_bounds_of_mem_search
    (lower := xLower) (upper := xUpper)
    (scale := claim4XScale k xp xq xr)
    (len := claim4TripleXSearchLength k xp xq xr)
    (z := zx)
    (claim4XScale_pos k xp xq xr) hzx hwindow.x_room
  have hybounds0 := claim4_mul_bounds_of_mem_search
    (lower := yLower) (upper := yUpper)
    (scale := claim4YScale k yp yq)
    (len := claim4PairYSearchLength k yp yq)
    (z := zy)
    (claim4YScale_pos k yp yq) hzy hwindow.y_room
  have hxbounds : xLower < x ∧ x < xUpper := by
    simpa [x] using hxbounds0
  have hybounds : yLower < y ∧ y < yUpper := by
    simpa [y] using hybounds0
  have hsep : xUpper + k ≤ yLower := hwindow.separated_windows
  have hxpos : 0 < x := by
    dsimp [x]
    omega
  have hxy : x < y := by
    omega
  have hgap : x + k < y := by
    omega
  have hk : 0 < k :=
    lt_of_lt_of_le hprime.xp_prime.pos hprime.xp_le_k
  have hmedium : Claim5MediumResidues x y k := by
    simpa [x, y] using hmedium0
  have hsmall : Claim5SmallResidues x y k := by
    simpa [x, y] using hsmall0
  have hxne : ∀ z ∈ intervalFinset x k, z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hid := claim5_full_identity_of_residues
    hk hxne hyne hmedium hsmall
  exact ⟨x, y, hxpos, hxy, hgap,
    hxbounds.1, hxbounds.2, hybounds.1, hybounds.2,
    hmedium, hsmall, hid⟩

end Erdos678
