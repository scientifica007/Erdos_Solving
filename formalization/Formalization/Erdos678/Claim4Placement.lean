import Formalization.Erdos678.Claim4ScaleFactorization

/-!
Canonical search-interval placement for D4.

For a positive scale, `lower / scale + 1` is the first canonical search
parameter whose scaled value is strictly above `lower`.  Once the complete
search block still fits below an upper endpoint, every representative selected
by the verified Claim 4 density theorem lies inside the requested numerical
window.

This module supplies separate `x` and `y` placement endpoints.  D4e may first
choose `y` in an absolute Cambie window and then choose `x` in a window that
depends on that particular `y`.
-/

namespace Erdos678

/-- Canonical beginning of a scaled search block strictly above `lower`. -/
def claim4SearchStart (lower scale : ℕ) : ℕ :=
  lower / scale + 1

/-- Every multiplicatively scaled search point lies strictly above `lower` and
below `upper` when the whole canonical search block fits below `upper`. -/
theorem claim4_mul_bounds_of_mem_search
    {lower upper scale len z : ℕ}
    (hscale : 0 < scale)
    (hz : z ∈ Finset.Ico (claim4SearchStart lower scale)
      (claim4SearchStart lower scale + len))
    (hroom : (claim4SearchStart lower scale + len) * scale ≤ upper) :
    lower < z * scale ∧ z * scale < upper := by
  have hzIco := Finset.mem_Ico.mp hz
  have hbase : lower < claim4SearchStart lower scale * scale := by
    unfold claim4SearchStart
    exact (Nat.div_lt_iff_lt_mul hscale).mp (Nat.lt_succ_self _)
  have hlowerMul :
      claim4SearchStart lower scale * scale ≤ z * scale :=
    Nat.mul_le_mul_right scale hzIco.1
  have hupperMul :
      z * scale < (claim4SearchStart lower scale + len) * scale :=
    Nat.mul_lt_mul_of_pos_right hzIco.2 hscale
  exact ⟨lt_of_lt_of_le hbase hlowerMul, lt_of_lt_of_le hupperMul hroom⟩

/-- Affine representatives `1 + z*scale` satisfy the analogous bounds. -/
theorem claim4_one_add_mul_bounds_of_mem_search
    {lower upper scale len z : ℕ}
    (hscale : 0 < scale)
    (hz : z ∈ Finset.Ico (claim4SearchStart lower scale)
      (claim4SearchStart lower scale + len))
    (hroom : 1 + (claim4SearchStart lower scale + len) * scale ≤ upper) :
    lower < 1 + z * scale ∧ 1 + z * scale < upper := by
  have hzIco := Finset.mem_Ico.mp hz
  have hbase : lower < claim4SearchStart lower scale * scale := by
    unfold claim4SearchStart
    exact (Nat.div_lt_iff_lt_mul hscale).mp (Nat.lt_succ_self _)
  have hlowerMul :
      claim4SearchStart lower scale * scale ≤ z * scale :=
    Nat.mul_le_mul_right scale hzIco.1
  have hupperMul :
      z * scale < (claim4SearchStart lower scale + len) * scale :=
    Nat.mul_lt_mul_of_pos_right hzIco.2 hscale
  constructor
  · omega
  · have hadd :
        1 + z * scale <
          1 + (claim4SearchStart lower scale + len) * scale := by
      exact Nat.add_lt_add_left hupperMul 1
    exact lt_of_lt_of_le hadd hroom

/-- Place a `y = z*Ny` representative in any numerical window whose canonical
Claim 4 search block fits.  The output retains the exact two-prime residue box
for later joint packaging with the `x` box. -/
theorem claim4_exists_y_box_in_window
    {k xp xq xr yp yq lower upper : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq)
    (hroom :
      (claim4SearchStart lower (claim4YScale k yp yq) +
          claim4PairYSearchLength k yp yq) * claim4YScale k yp yq ≤ upper) :
    ∃ z ∈ Finset.Ico
        (claim4SearchStart lower (claim4YScale k yp yq))
        (claim4SearchStart lower (claim4YScale k yp yq) +
          claim4PairYSearchLength k yp yq),
      lower < z * claim4YScale k yp yq ∧
        z * claim4YScale k yp yq < upper ∧
        ∀ i : Fin 2,
          claim4PairPrime yp yq i - k % claim4PairPrime yp yq i ≤
              claim4PaperCoefficient (claim4PairPrime yp yq i)
                ((z * claim4YScale k yp yq) % claim4PairPrime yp yq i) ∧
            claim4PaperCoefficient (claim4PairPrime yp yq i)
                ((z * claim4YScale k yp yq) % claim4PairPrime yp yq i) ≤
              claim4PairPrime yp yq i := by
  rcases h.medium_square_bounds with
    ⟨hkxp2, hkxq2, hkxr2, hkyp2, hkyq2⟩
  rcases h.search_length_bounds with
    ⟨hlenxp, hlenxq, hlenxr, hlenyp, hlenyq⟩
  have hNyp : ¬yp ∣ claim4YScale k yp yq :=
    claim4YScale_not_dvd_of_medium_special h.yp_prime hkyp2 (by simp)
  have hNyq : ¬yq ∣ claim4YScale k yp yq :=
    claim4YScale_not_dvd_of_medium_special h.yq_prime hkyq2 (by simp)
  rcases claim4_pair_y_scaled_box_density
      (k := k) (p := yp) (q := yq)
      (scale := claim4YScale k yp yq)
      (start := claim4SearchStart lower (claim4YScale k yp yq))
      h.yp_prime h.yq_prime hNyp hNyq hlenyp hlenyq with
    ⟨z, hz, hbox⟩
  have hbounds := claim4_mul_bounds_of_mem_search
    (lower := lower) (upper := upper)
    (scale := claim4YScale k yp yq)
    (len := claim4PairYSearchLength k yp yq)
    (z := z) (claim4YScale_pos k yp yq) hz hroom
  exact ⟨z, hz, hbounds.1, hbounds.2, hbox⟩

/-- Place an `x = 1 + z*Nx` representative in any numerical window whose
canonical Claim 4 search block fits.  The output retains the exact three-prime
residue box. -/
theorem claim4_exists_x_box_in_window
    {k xp xq xr yp yq lower upper : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq)
    (hroom :
      1 + (claim4SearchStart lower (claim4XScale k xp xq xr) +
          claim4TripleXSearchLength k xp xq xr) *
            claim4XScale k xp xq xr ≤ upper) :
    ∃ z ∈ Finset.Ico
        (claim4SearchStart lower (claim4XScale k xp xq xr))
        (claim4SearchStart lower (claim4XScale k xp xq xr) +
          claim4TripleXSearchLength k xp xq xr),
      lower < 1 + z * claim4XScale k xp xq xr ∧
        1 + z * claim4XScale k xp xq xr < upper ∧
        ∀ i : Fin 3,
          1 ≤ claim4PaperCoefficient (claim4TriplePrime xp xq xr i)
                ((1 + z * claim4XScale k xp xq xr) %
                  claim4TriplePrime xp xq xr i) ∧
            claim4PaperCoefficient (claim4TriplePrime xp xq xr i)
                ((1 + z * claim4XScale k xp xq xr) %
                  claim4TriplePrime xp xq xr i) ≤
              claim4TriplePrime xp xq xr i -
                k % claim4TriplePrime xp xq xr i := by
  rcases h.medium_square_bounds with
    ⟨hkxp2, hkxq2, hkxr2, hkyp2, hkyq2⟩
  rcases h.search_length_bounds with
    ⟨hlenxp, hlenxq, hlenxr, hlenyp, hlenyq⟩
  have hNxp : ¬xp ∣ claim4XScale k xp xq xr :=
    claim4XScale_not_dvd_of_medium_special h.xp_prime hkxp2 (by simp)
  have hNxq : ¬xq ∣ claim4XScale k xp xq xr :=
    claim4XScale_not_dvd_of_medium_special h.xq_prime hkxq2 (by simp)
  have hNxr : ¬xr ∣ claim4XScale k xp xq xr :=
    claim4XScale_not_dvd_of_medium_special h.xr_prime hkxr2 (by simp)
  rcases claim4_triple_x_scaled_box_density
      (k := k) (p := xp) (q := xq) (r := xr)
      (scale := claim4XScale k xp xq xr)
      (start := claim4SearchStart lower (claim4XScale k xp xq xr))
      h.xp_prime h.xq_prime h.xr_prime hNxp hNxq hNxr
      hlenxp hlenxq hlenxr with
    ⟨z, hz, hbox⟩
  have hbounds := claim4_one_add_mul_bounds_of_mem_search
    (lower := lower) (upper := upper)
    (scale := claim4XScale k xp xq xr)
    (len := claim4TripleXSearchLength k xp xq xr)
    (z := z) (claim4XScale_pos k xp xq xr) hz hroom
  exact ⟨z, hz, hbounds.1, hbounds.2, hbox⟩

end Erdos678
