import Formalization.Erdos678.Claim4ApplicationBoxes
import Formalization.Erdos678.Claim5Assembly

/-!
Scaled application-box connection from Cambie's Claim 4 layer to Claim 5.

The normalized pair/triple CRT endpoints are not yet the actual interval
endpoints used in Claim 5.  Once all non-special coordinates are fixed, the
actual representatives have the forms `x = 1 + z * Nx` and `y = z * Ny`.
This file applies the verified exclusion boxes to those scaled residues,
packages the remaining medium-prime coordinates by divisibility of the
scales, and derives the small-prime interface from common prime-power
divisibility of the two scales.

The quantitative construction of `Nx`, `Ny`, the prime choices, and the
separation bounds remains outside this interface layer.
-/

namespace Erdos678

/-- Every natural number is congruent to the paper representative of its
canonical residue. -/
theorem claim4_modEq_paperCoefficient_mod (x p : ℕ) :
    x ≡ claim4PaperCoefficient p (x % p) [MOD p] := by
  have hx : x ≡ x % p [MOD p] := by
    simp [Nat.ModEq]
  exact hx.trans (claim4PaperCoefficient_modEq p (x % p)).symm

/-- Adding one to a unit-scaled modular coordinate preserves injectivity on a
short consecutive interval. -/
theorem interval_one_add_mul_mod_injective_of_prime
    {p c start len : ℕ}
    (hp : Nat.Prime p) (hc : ¬p ∣ c) (hlen : len ≤ p) :
    Set.InjOn (fun z => (1 + z * c) % p)
      (Finset.Ico start (start + len)) := by
  intro a ha b hb hab
  have hadd : 1 + a * c ≡ 1 + b * c [MOD p] := hab
  have hmul : a * c ≡ b * c [MOD p] := by
    apply Nat.ModEq.add_left_cancel' 1
    simpa using hadd
  exact interval_mul_mod_injective_of_prime hp hc hlen ha hb hmul

/-- The two-prime `y` box applied to an actual scaled representative
`y = z * scale`. -/
theorem claim4_pair_y_scaled_box_density
    {k p q scale start : ℕ}
    (hp : Nat.Prime p) (hq : Nat.Prime q)
    (hscalep : ¬p ∣ scale) (hscaleq : ¬q ∣ scale)
    (hlenp : claim4PairYSearchLength k p q ≤ p)
    (hlenq : claim4PairYSearchLength k p q ≤ q) :
    ∃ z ∈ Finset.Ico start (start + claim4PairYSearchLength k p q),
      ∀ i : Fin 2,
        claim4PairPrime p q i - k % claim4PairPrime p q i ≤
            claim4PaperCoefficient (claim4PairPrime p q i)
              ((z * scale) % claim4PairPrime p q i) ∧
          claim4PaperCoefficient (claim4PairPrime p q i)
              ((z * scale) % claim4PairPrime p q i) ≤
            claim4PairPrime p q i := by
  have hbudget :
      ∑ i : Fin 2, (claim4PairYExcluded k p q i).card <
        claim4PairYSearchLength k p q := by
    simp [claim4PairYExcluded, Fin.sum_univ_two,
      claim4YExcluded_card (k := k) (p := p) hp.pos,
      claim4YExcluded_card (k := k) (p := q) hq.pos,
      claim4PairYSearchLength]
  rcases claim4_prime_coordinate_density
      (indices := (Finset.univ : Finset (Fin 2)))
      (p := claim4PairPrime p q)
      (c := fun _ => scale)
      (start := start)
      (len := claim4PairYSearchLength k p q)
      (excluded := claim4PairYExcluded k p q)
      (by
        intro i hi
        fin_cases i
        · simpa [claim4PairPrime] using hp
        · simpa [claim4PairPrime] using hq)
      (by
        intro i hi
        fin_cases i
        · simpa [claim4PairPrime] using hscalep
        · simpa [claim4PairPrime] using hscaleq)
      (by
        intro i hi
        fin_cases i
        · simpa [claim4PairPrime] using hlenp
        · simpa [claim4PairPrime] using hlenq)
      (by simpa using hbudget) with
    ⟨z, hz, hallowed⟩
  refine ⟨z, hz, ?_⟩
  intro i
  have hi := hallowed i (Finset.mem_univ i)
  fin_cases i
  · have hlt : (z * scale) % p < p := Nat.mod_lt _ hp.pos
    have hnot : (z * scale) % p ∉ claim4YExcluded k p := by
      simpa [claim4PairYExcluded, claim4PairPrime] using hi
    simpa [claim4PairPrime] using
      (claim4_not_mem_yExcluded_iff
        (k := k) (p := p) (a := (z * scale) % p) hp.pos hlt).mp hnot
  · have hlt : (z * scale) % q < q := Nat.mod_lt _ hq.pos
    have hnot : (z * scale) % q ∉ claim4YExcluded k q := by
      simpa [claim4PairYExcluded, claim4PairPrime] using hi
    simpa [claim4PairPrime] using
      (claim4_not_mem_yExcluded_iff
        (k := k) (p := q) (a := (z * scale) % q) hq.pos hlt).mp hnot

/-- The three-prime `x` box applied to an actual affine representative
`x = 1 + z * scale`. -/
theorem claim4_triple_x_scaled_box_density
    {k p q r scale start : ℕ}
    (hp : Nat.Prime p) (hq : Nat.Prime q) (hr : Nat.Prime r)
    (hscalep : ¬p ∣ scale) (hscaleq : ¬q ∣ scale)
    (hscaler : ¬r ∣ scale)
    (hlenp : claim4TripleXSearchLength k p q r ≤ p)
    (hlenq : claim4TripleXSearchLength k p q r ≤ q)
    (hlenr : claim4TripleXSearchLength k p q r ≤ r) :
    ∃ z ∈ Finset.Ico start (start + claim4TripleXSearchLength k p q r),
      ∀ i : Fin 3,
        1 ≤ claim4PaperCoefficient (claim4TriplePrime p q r i)
              ((1 + z * scale) % claim4TriplePrime p q r i) ∧
          claim4PaperCoefficient (claim4TriplePrime p q r i)
              ((1 + z * scale) % claim4TriplePrime p q r i) ≤
            claim4TriplePrime p q r i -
              k % claim4TriplePrime p q r i := by
  have hbudget :
      ∑ i : Fin 3, (claim4TripleXExcluded k p q r i).card <
        claim4TripleXSearchLength k p q r := by
    simp [claim4TripleXExcluded, Fin.sum_univ_three,
      claim4XExcluded_card (k := k) (p := p) hp.pos,
      claim4XExcluded_card (k := k) (p := q) hq.pos,
      claim4XExcluded_card (k := k) (p := r) hr.pos,
      claim4TripleXSearchLength]
  rcases claim4_exists_avoiding_coordinate_exclusions
      (indices := (Finset.univ : Finset (Fin 3)))
      (positions := Finset.Ico start
        (start + claim4TripleXSearchLength k p q r))
      (value := fun i z =>
        (1 + z * scale) % claim4TriplePrime p q r i)
      (excluded := claim4TripleXExcluded k p q r)
      (by
        intro i hi
        fin_cases i
        · simpa [claim4TriplePrime] using
            interval_one_add_mul_mod_injective_of_prime hp hscalep hlenp
        · simpa [claim4TriplePrime] using
            interval_one_add_mul_mod_injective_of_prime hq hscaleq hlenq
        · simpa [claim4TriplePrime] using
            interval_one_add_mul_mod_injective_of_prime hr hscaler hlenr)
      (by simpa using hbudget) with
    ⟨z, hz, hallowed⟩
  refine ⟨z, hz, ?_⟩
  intro i
  have hi := hallowed i (Finset.mem_univ i)
  fin_cases i
  · have hlt : (1 + z * scale) % p < p := Nat.mod_lt _ hp.pos
    have hnot : (1 + z * scale) % p ∉ claim4XExcluded k p := by
      simpa [claim4TripleXExcluded, claim4TriplePrime] using hi
    simpa [claim4TriplePrime] using
      (claim4_not_mem_xExcluded_iff
        (k := k) (p := p) (a := (1 + z * scale) % p) hp.pos hlt).mp hnot
  · have hlt : (1 + z * scale) % q < q := Nat.mod_lt _ hq.pos
    have hnot : (1 + z * scale) % q ∉ claim4XExcluded k q := by
      simpa [claim4TripleXExcluded, claim4TriplePrime] using hi
    simpa [claim4TriplePrime] using
      (claim4_not_mem_xExcluded_iff
        (k := k) (p := q) (a := (1 + z * scale) % q) hq.pos hlt).mp hnot
  · have hlt : (1 + z * scale) % r < r := Nat.mod_lt _ hr.pos
    have hnot : (1 + z * scale) % r ∉ claim4XExcluded k r := by
      simpa [claim4TripleXExcluded, claim4TriplePrime] using hi
    simpa [claim4TriplePrime] using
      (claim4_not_mem_xExcluded_iff
        (k := k) (p := r) (a := (1 + z * scale) % r) hr.pos hlt).mp hnot

/-- Common small-prime power divisibility carried by the two scales. -/
def Claim4SmallPrimeScaleData (Nx Ny k : ℕ) : Prop :=
  ∀ p : ℕ, Nat.Prime p → p ^ 2 ≤ k →
    ∃ e : ℕ,
      p ^ e ≤ k ∧ k < p ^ (e + 1) ∧
      p ^ e ∣ Nx ∧ p ^ e ∣ Ny

/-- Divisibility of both scales by every required small prime power produces
the exact small-prime Claim 5 residue interface. -/
theorem claim5SmallResidues_of_scales
    {Nx Ny zx zy k : ℕ}
    (hscale : Claim4SmallPrimeScaleData Nx Ny k) :
    Claim5SmallResidues (1 + zx * Nx) (zy * Ny) k := by
  intro p hp hp2k
  rcases hscale p hp hp2k with ⟨e, hlo, hhi, hNx, hNy⟩
  refine ⟨e, hlo, hhi, ?_, ?_⟩
  · have hzero : zx * Nx ≡ 0 [MOD p ^ e] :=
      Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hNx zx)
    simpa using hzero.add_left 1
  · exact Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hNy zy)

/-- Package three special `x` boxes, two special `y` boxes, and fixed
congruences at every other medium prime into `Claim5MediumResidues`. -/
theorem claim5MediumResidues_of_pair_triple_boxes
    {x y k xp xq xr yp yq : ℕ}
    (hxbox : ∀ i : Fin 3,
      1 ≤ claim4PaperCoefficient (claim4TriplePrime xp xq xr i)
            (x % claim4TriplePrime xp xq xr i) ∧
        claim4PaperCoefficient (claim4TriplePrime xp xq xr i)
            (x % claim4TriplePrime xp xq xr i) ≤
          claim4TriplePrime xp xq xr i -
            k % claim4TriplePrime xp xq xr i)
    (hybox : ∀ i : Fin 2,
      claim4PairPrime yp yq i - k % claim4PairPrime yp yq i ≤
          claim4PaperCoefficient (claim4PairPrime yp yq i)
            (y % claim4PairPrime yp yq i) ∧
        claim4PaperCoefficient (claim4PairPrime yp yq i)
            (y % claim4PairPrime yp yq i) ≤
          claim4PairPrime yp yq i)
    (hxother : ∀ p : ℕ, Nat.Prime p → p ≤ k → k < p ^ 2 →
      p ≠ xp → p ≠ xq → p ≠ xr → x ≡ 1 [MOD p])
    (hyother : ∀ p : ℕ, Nat.Prime p → p ≤ k → k < p ^ 2 →
      p ≠ yp → p ≠ yq → y ≡ 0 [MOD p]) :
    Claim5MediumResidues x y k := by
  intro p hp hpk hkp2
  have hrlt : k % p < p := Nat.mod_lt k hp.pos
  have ha :
      ∃ a : ℕ, 1 ≤ a ∧ a ≤ p - k % p ∧ x ≡ a [MOD p] := by
    by_cases hxp : p = xp
    · subst p
      have hbox := hxbox (0 : Fin 3)
      refine ⟨claim4PaperCoefficient xp (x % xp), ?_, ?_,
        claim4_modEq_paperCoefficient_mod x xp⟩
      · simpa [claim4TriplePrime] using hbox.1
      · simpa [claim4TriplePrime] using hbox.2
    · by_cases hxq : p = xq
      · subst p
        have hbox := hxbox (1 : Fin 3)
        refine ⟨claim4PaperCoefficient xq (x % xq), ?_, ?_,
          claim4_modEq_paperCoefficient_mod x xq⟩
        · simpa [claim4TriplePrime] using hbox.1
        · simpa [claim4TriplePrime] using hbox.2
      · by_cases hxr : p = xr
        · subst p
          have hbox := hxbox (2 : Fin 3)
          refine ⟨claim4PaperCoefficient xr (x % xr), ?_, ?_,
            claim4_modEq_paperCoefficient_mod x xr⟩
          · simpa [claim4TriplePrime] using hbox.1
          · simpa [claim4TriplePrime] using hbox.2
        · refine ⟨1, by simp, ?_, hxother p hp hpk hkp2 hxp hxq hxr⟩
          omega
  have hb :
      ∃ b : ℕ, p - k % p ≤ b ∧ b ≤ p ∧ y ≡ b [MOD p] := by
    by_cases hyp : p = yp
    · subst p
      have hbox := hybox (0 : Fin 2)
      refine ⟨claim4PaperCoefficient yp (y % yp), ?_, ?_,
        claim4_modEq_paperCoefficient_mod y yp⟩
      · simpa [claim4PairPrime] using hbox.1
      · simpa [claim4PairPrime] using hbox.2
    · by_cases hyq : p = yq
      · subst p
        have hbox := hybox (1 : Fin 2)
        refine ⟨claim4PaperCoefficient yq (y % yq), ?_, ?_,
          claim4_modEq_paperCoefficient_mod y yq⟩
        · simpa [claim4PairPrime] using hbox.1
        · simpa [claim4PairPrime] using hbox.2
      · have hy0 : y ≡ 0 [MOD p] := hyother p hp hpk hkp2 hyp hyq
        have hzero : 0 ≡ p [MOD p] := by
          simp [Nat.ModEq]
        refine ⟨p, by omega, le_rfl, hy0.trans hzero⟩
  rcases ha with ⟨a, ha1, haUpper, hxa⟩
  rcases hb with ⟨b, hbLower, hbUpper, hyb⟩
  exact ⟨a, b, ha1, haUpper, hbLower, hbUpper, hxa, hyb⟩

/-- Scaled pair/triple boxes, divisibility at all other medium coordinates,
and common small-prime scale data jointly produce both residue interfaces
consumed by the full Claim 5 theorem. -/
theorem claim4_exists_claim5_residue_interfaces_of_scales
    {k xp xq xr yp yq Nx Ny startx starty : ℕ}
    (hxp : Nat.Prime xp) (hxq : Nat.Prime xq) (hxr : Nat.Prime xr)
    (hyp : Nat.Prime yp) (hyq : Nat.Prime yq)
    (hNxp : ¬xp ∣ Nx) (hNxq : ¬xq ∣ Nx) (hNxr : ¬xr ∣ Nx)
    (hNyp : ¬yp ∣ Ny) (hNyq : ¬yq ∣ Ny)
    (hlenxp : claim4TripleXSearchLength k xp xq xr ≤ xp)
    (hlenxq : claim4TripleXSearchLength k xp xq xr ≤ xq)
    (hlenxr : claim4TripleXSearchLength k xp xq xr ≤ xr)
    (hlenyp : claim4PairYSearchLength k yp yq ≤ yp)
    (hlenyq : claim4PairYSearchLength k yp yq ≤ yq)
    (hxother : ∀ p : ℕ, Nat.Prime p → p ≤ k → k < p ^ 2 →
      p ≠ xp → p ≠ xq → p ≠ xr → p ∣ Nx)
    (hyother : ∀ p : ℕ, Nat.Prime p → p ≤ k → k < p ^ 2 →
      p ≠ yp → p ≠ yq → p ∣ Ny)
    (hsmall : Claim4SmallPrimeScaleData Nx Ny k) :
    ∃ zx ∈ Finset.Ico startx
        (startx + claim4TripleXSearchLength k xp xq xr),
      ∃ zy ∈ Finset.Ico starty
          (starty + claim4PairYSearchLength k yp yq),
        Claim5MediumResidues (1 + zx * Nx) (zy * Ny) k ∧
          Claim5SmallResidues (1 + zx * Nx) (zy * Ny) k := by
  rcases claim4_triple_x_scaled_box_density
      (k := k) (p := xp) (q := xq) (r := xr)
      (scale := Nx) (start := startx)
      hxp hxq hxr hNxp hNxq hNxr hlenxp hlenxq hlenxr with
    ⟨zx, hzx, hxbox⟩
  rcases claim4_pair_y_scaled_box_density
      (k := k) (p := yp) (q := yq)
      (scale := Ny) (start := starty)
      hyp hyq hNyp hNyq hlenyp hlenyq with
    ⟨zy, hzy, hybox⟩
  refine ⟨zx, hzx, zy, hzy, ?_, ?_⟩
  · apply claim5MediumResidues_of_pair_triple_boxes hxbox hybox
    · intro p hp hpk hkp2 hpxp hpxq hpxr
      have hdiv : p ∣ Nx := hxother p hp hpk hkp2 hpxp hpxq hpxr
      have hzero : zx * Nx ≡ 0 [MOD p] :=
        Nat.modEq_zero_iff_dvd.mpr (dvd_mul_of_dvd_right hdiv zx)
      simpa using hzero.add_left 1
    · intro p hp hpk hkp2 hpyp hpyq
      have hdiv : p ∣ Ny := hyother p hp hpk hkp2 hpyp hpyq
      exact Nat.modEq_zero_iff_dvd.mpr
        (dvd_mul_of_dvd_right hdiv zy)
  · exact claim5SmallResidues_of_scales hsmall

end Erdos678
