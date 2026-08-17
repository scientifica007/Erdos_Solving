import Formalization.Erdos678.Claim4PrimeWindows
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
Exact factorization and positivity facts for the D4 scales.

`claim4FullScale k` contains every small-prime maximal power and every medium
prime.  The `x` and `y` scales are obtained by deleting exactly the designated
special medium coordinates.  This module records the resulting exact product
identities; it does not yet identify `claim4FullScale k` with the interval LCM.
-/

namespace Erdos678

/-- The complete arithmetic scale before freeing special medium coordinates. -/
def claim4FullScale (k : ℕ) : ℕ :=
  claim4Scale k ∅

/-- The common small-prime factor is positive. -/
theorem claim4SmallScale_pos (k : ℕ) :
    0 < claim4SmallScale k := by
  apply Finset.prod_pos
  intro p hp
  have hpprime : Nat.Prime p := (mem_claim4SmallPrimes.mp hp).2.1
  exact pow_pos hpprime.pos _

/-- Every scale obtained by deleting medium coordinates remains positive. -/
theorem claim4Scale_pos (k : ℕ) (excluded : Finset ℕ) :
    0 < claim4Scale k excluded := by
  apply Nat.mul_pos
  · exact claim4SmallScale_pos k
  · apply Finset.prod_pos
    intro p hp
    have hpmedium : p ∈ claim4MediumPrimes k := (Finset.mem_sdiff.mp hp).1
    exact (mem_claim4MediumPrimes.mp hpmedium).2.1.pos

 theorem claim4FullScale_pos (k : ℕ) :
    0 < claim4FullScale k := by
  exact claim4Scale_pos k ∅

 theorem claim4XScale_pos (k xp xq xr : ℕ) :
    0 < claim4XScale k xp xq xr := by
  exact claim4Scale_pos k {xp, xq, xr}

 theorem claim4YScale_pos (k yp yq : ℕ) :
    0 < claim4YScale k yp yq := by
  exact claim4Scale_pos k {yp, yq}

/-- Restoring a deleted subset of medium coordinates recovers the full scale
exactly. -/
theorem claim4Scale_mul_excluded_prod_eq_full
    {k : ℕ} {excluded : Finset ℕ}
    (hsub : excluded ⊆ claim4MediumPrimes k) :
    claim4Scale k excluded * excluded.prod id = claim4FullScale k := by
  have hprod :
      ((claim4MediumPrimes k \ excluded).prod id) * excluded.prod id =
        (claim4MediumPrimes k).prod id := by
    simpa using (Finset.prod_sdiff (f := id) hsub)
  change
    (claim4SmallScale k * ((claim4MediumPrimes k \ excluded).prod id)) *
        excluded.prod id =
      claim4SmallScale k * (claim4MediumPrimes k).prod id
  simpa [mul_assoc] using congrArg (fun n => claim4SmallScale k * n) hprod

/-- The three special `x` primes all belong to the medium-coordinate set. -/
theorem Claim4PrimeWindowData.x_special_subset_medium
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    ({xp, xq, xr} : Finset ℕ) ⊆ claim4MediumPrimes k := by
  rcases h.medium_square_bounds with
    ⟨hkxp2, hkxq2, hkxr2, hkyp2, hkyq2⟩
  intro p hp
  simp only [Finset.mem_insert, Finset.mem_singleton] at hp
  rcases hp with rfl | rfl | rfl
  · exact mem_claim4MediumPrimes.mpr ⟨h.xp_le_k, h.xp_prime, hkxp2⟩
  · exact mem_claim4MediumPrimes.mpr ⟨h.xq_le_k, h.xq_prime, hkxq2⟩
  · exact mem_claim4MediumPrimes.mpr ⟨h.xr_le_k, h.xr_prime, hkxr2⟩

/-- The two special `y` primes all belong to the medium-coordinate set. -/
theorem Claim4PrimeWindowData.y_special_subset_medium
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    ({yp, yq} : Finset ℕ) ⊆ claim4MediumPrimes k := by
  rcases h.medium_square_bounds with
    ⟨hkxp2, hkxq2, hkxr2, hkyp2, hkyq2⟩
  intro p hp
  simp only [Finset.mem_insert, Finset.mem_singleton] at hp
  rcases hp with rfl | rfl
  · exact mem_claim4MediumPrimes.mpr ⟨h.yp_le_k, h.yp_prime, hkyp2⟩
  · exact mem_claim4MediumPrimes.mpr ⟨h.yq_le_k, h.yq_prime, hkyq2⟩

/-- Exact factorization of the full scale through the `x` scale and its three
free prime coordinates. -/
theorem Claim4PrimeWindowData.xScale_mul_specials_eq_full
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    claim4XScale k xp xq xr * (xp * xq * xr) = claim4FullScale k := by
  have hfactor := claim4Scale_mul_excluded_prod_eq_full
    (k := k) (excluded := ({xp, xq, xr} : Finset ℕ)) h.x_special_subset_medium
  have hprod :
      ({xp, xq, xr} : Finset ℕ).prod id = xp * xq * xr := by
    simp [h.xp_ne_xq, h.xp_ne_xr, h.xq_ne_xr, mul_assoc]
  change claim4XScale k xp xq xr *
      ({xp, xq, xr} : Finset ℕ).prod id = claim4FullScale k at hfactor
  rw [hprod] at hfactor
  exact hfactor

/-- Exact factorization of the full scale through the `y` scale and its two
free prime coordinates. -/
theorem Claim4PrimeWindowData.yScale_mul_specials_eq_full
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    claim4YScale k yp yq * (yp * yq) = claim4FullScale k := by
  have hfactor := claim4Scale_mul_excluded_prod_eq_full
    (k := k) (excluded := ({yp, yq} : Finset ℕ)) h.y_special_subset_medium
  have hprod :
      ({yp, yq} : Finset ℕ).prod id = yp * yq := by
    simp [h.yp_ne_yq]
  change claim4YScale k yp yq *
      ({yp, yq} : Finset ℕ).prod id = claim4FullScale k at hfactor
  rw [hprod] at hfactor
  exact hfactor

end Erdos678
