import Formalization.Erdos678.Claim4Claim5Interface
import Mathlib.Data.Nat.Log

/-!
The quantitative scale layer for Cambie's Claim 4 construction.

For primes with `p^2 ≤ k`, both representatives must carry the maximal prime
power `p^(log_p k)`.  For the medium range `p ≤ k < p^2`, every coordinate is
fixed by divisibility except the two special `y` primes and the three special
`x` primes.  Thus the actual scales are the product of the common small-prime
powers and all non-special medium primes.

This module deliberately proves only the arithmetic support/unit contract of
the scales.  Prime-window choices and quantitative placement of the resulting
representatives belong to the next D4 layer.
-/

namespace Erdos678

/-- Primes in the small-prime range of Claim 5. -/
def claim4SmallPrimes (k : ℕ) : Finset ℕ :=
  (Finset.range (k + 1)).filter (fun p => Nat.Prime p ∧ p ^ 2 ≤ k)

/-- Primes in the medium range `p ≤ k < p^2`. -/
def claim4MediumPrimes (k : ℕ) : Finset ℕ :=
  (Finset.range (k + 1)).filter (fun p => Nat.Prime p ∧ k < p ^ 2)

/-- Cambie's common small-prime factor
`∏_{p^2 ≤ k} p^(floor(log_p k))`. -/
def claim4SmallScale (k : ℕ) : ℕ :=
  (claim4SmallPrimes k).prod (fun p => p ^ Nat.log p k)

/-- The scale obtained by retaining every medium prime except an explicit
finite set of special coordinates. -/
def claim4Scale (k : ℕ) (excluded : Finset ℕ) : ℕ :=
  claim4SmallScale k * ((claim4MediumPrimes k) \ excluded).prod id

/-- The `x = 1 + z*Nx` scale: three medium-prime coordinates stay free. -/
def claim4XScale (k xp xq xr : ℕ) : ℕ :=
  claim4Scale k {xp, xq, xr}

/-- The `y = z*Ny` scale: two medium-prime coordinates stay free. -/
def claim4YScale (k yp yq : ℕ) : ℕ :=
  claim4Scale k {yp, yq}

@[simp] theorem mem_claim4SmallPrimes {k p : ℕ} :
    p ∈ claim4SmallPrimes k ↔ p ≤ k ∧ Nat.Prime p ∧ p ^ 2 ≤ k := by
  simp [claim4SmallPrimes, Nat.lt_succ_iff, and_assoc]

@[simp] theorem mem_claim4MediumPrimes {k p : ℕ} :
    p ∈ claim4MediumPrimes k ↔ p ≤ k ∧ Nat.Prime p ∧ k < p ^ 2 := by
  simp [claim4MediumPrimes, Nat.lt_succ_iff, and_assoc]

/-- A prime does not divide a finite product when it divides none of the
individual factors. -/
theorem prime_not_dvd_finset_prod_of_not_dvd
    {α : Type*} [DecidableEq α] {p : ℕ} (hp : Nat.Prime p)
    (s : Finset α) (f : α → ℕ)
    (h : ∀ a ∈ s, ¬p ∣ f a) :
    ¬p ∣ s.prod f := by
  induction s using Finset.induction_on with
  | empty =>
      simpa using hp.not_dvd_one
  | @insert a s ha ih =>
      rw [Finset.prod_insert ha]
      apply hp.not_dvd_mul
      · exact h a (by simp)
      · apply ih
        intro b hb
        exact h b (by simp [hb])

/-- The maximal required power of every small prime is an explicit factor of
`claim4SmallScale`. -/
theorem claim4SmallScale_pow_log_dvd
    {k p : ℕ} (hp : Nat.Prime p) (hp2k : p ^ 2 ≤ k) :
    p ^ Nat.log p k ∣ claim4SmallScale k := by
  have hpk : p ≤ k := by
    nlinarith [hp.two_le]
  have hmem : p ∈ claim4SmallPrimes k := by
    simp [hpk, hp, hp2k]
  refine ⟨((claim4SmallPrimes k).erase p).prod
      (fun q => q ^ Nat.log q k), ?_⟩
  simpa [claim4SmallScale, mul_comm] using
    (Finset.prod_erase_mul (claim4SmallPrimes k)
      (fun q => q ^ Nat.log q k) hmem).symm

/-- A medium prime cannot divide the common small-prime scale. -/
theorem claim4MediumPrime_not_dvd_smallScale
    {k p : ℕ} (hp : Nat.Prime p) (hkp2 : k < p ^ 2) :
    ¬p ∣ claim4SmallScale k := by
  apply prime_not_dvd_finset_prod_of_not_dvd hp
    (claim4SmallPrimes k) (fun q => q ^ Nat.log q k)
  intro q hq
  have hqdata := (mem_claim4SmallPrimes.mp hq)
  intro hpqpow
  have hpq : p ∣ q := hp.dvd_of_dvd_pow hpqpow
  have hpqe : p = q :=
    (Nat.prime_dvd_prime_iff_eq hp hqdata.2.1).mp hpq
  subst q
  omega

/-- Every non-excluded medium prime divides the generic scale. -/
theorem claim4MediumPrime_dvd_scale
    {k p : ℕ} {excluded : Finset ℕ}
    (hp : Nat.Prime p) (hpk : p ≤ k) (hkp2 : k < p ^ 2)
    (hexcluded : p ∉ excluded) :
    p ∣ claim4Scale k excluded := by
  have hmedium : p ∈ claim4MediumPrimes k := by
    simp [hpk, hp, hkp2]
  have hmem : p ∈ claim4MediumPrimes k \ excluded := by
    simp [hmedium, hexcluded]
  have hprod : p ∣ ((claim4MediumPrimes k \ excluded).prod id) := by
    refine ⟨((claim4MediumPrimes k \ excluded).erase p).prod id, ?_⟩
    simpa [mul_comm] using
      (Finset.prod_erase_mul (claim4MediumPrimes k \ excluded) id hmem).symm
  exact dvd_mul_of_dvd_right hprod (claim4SmallScale k)

/-- An excluded medium prime is a unit for the generic scale. -/
theorem claim4MediumPrime_not_dvd_scale
    {k p : ℕ} {excluded : Finset ℕ}
    (hp : Nat.Prime p) (hkp2 : k < p ^ 2)
    (hexcluded : p ∈ excluded) :
    ¬p ∣ claim4Scale k excluded := by
  apply hp.not_dvd_mul
  · exact claim4MediumPrime_not_dvd_smallScale hp hkp2
  · apply prime_not_dvd_finset_prod_of_not_dvd hp
      (claim4MediumPrimes k \ excluded) id
    intro q hq
    have hqdata : q ∈ claim4MediumPrimes k := (Finset.mem_sdiff.mp hq).1
    have hqnot : q ∉ excluded := (Finset.mem_sdiff.mp hq).2
    intro hpq
    have hpqe : p = q :=
      (Nat.prime_dvd_prime_iff_eq hp (mem_claim4MediumPrimes.mp hqdata).2.1).mp
        (by simpa using hpq)
    subst q
    exact hqnot hexcluded

/-- The generic scale contains the common small-prime factor. -/
theorem claim4SmallScale_dvd_scale (k : ℕ) (excluded : Finset ℕ) :
    claim4SmallScale k ∣ claim4Scale k excluded := by
  exact ⟨((claim4MediumPrimes k \ excluded).prod id), rfl⟩

/-- Any two scales built from `claim4Scale` satisfy the exact small-prime
interface support expected by D3. -/
theorem claim4SmallPrimeScaleData_of_scales
    {k : ℕ} (excludedX excludedY : Finset ℕ) :
    Claim4SmallPrimeScaleData
      (claim4Scale k excludedX) (claim4Scale k excludedY) k := by
  intro p hp hp2k
  let e := Nat.log p k
  have hk0 : k ≠ 0 := by
    nlinarith [hp.two_le]
  have hlo : p ^ e ≤ k := by
    simpa [e] using Nat.pow_log_le_self p hk0
  have hhi : k < p ^ (e + 1) := by
    simpa [e, Nat.succ_eq_add_one] using Nat.lt_pow_succ_log_self hp.one_lt k
  have hpow : p ^ e ∣ claim4SmallScale k := by
    simpa [e] using claim4SmallScale_pow_log_dvd hp hp2k
  refine ⟨e, hlo, hhi, ?_, ?_⟩
  · exact hpow.trans (claim4SmallScale_dvd_scale k excludedX)
  · exact hpow.trans (claim4SmallScale_dvd_scale k excludedY)

/-- The actual `x` and `y` scales automatically provide the common
small-prime support consumed by `claim5SmallResidues_of_scales`. -/
theorem claim4XYSmallPrimeScaleData
    (k xp xq xr yp yq : ℕ) :
    Claim4SmallPrimeScaleData
      (claim4XScale k xp xq xr) (claim4YScale k yp yq) k := by
  simpa [claim4XScale, claim4YScale] using
    (claim4SmallPrimeScaleData_of_scales
      (k := k) ({xp, xq, xr} : Finset ℕ) ({yp, yq} : Finset ℕ))

/-- Every other medium prime divides the `x` scale. -/
theorem claim4XScale_dvd_of_medium_other
    {k xp xq xr p : ℕ}
    (hp : Nat.Prime p) (hpk : p ≤ k) (hkp2 : k < p ^ 2)
    (hpxp : p ≠ xp) (hpxq : p ≠ xq) (hpxr : p ≠ xr) :
    p ∣ claim4XScale k xp xq xr := by
  apply claim4MediumPrime_dvd_scale hp hpk hkp2
  simp [claim4XScale, hpxp, hpxq, hpxr]

/-- Every other medium prime divides the `y` scale. -/
theorem claim4YScale_dvd_of_medium_other
    {k yp yq p : ℕ}
    (hp : Nat.Prime p) (hpk : p ≤ k) (hkp2 : k < p ^ 2)
    (hpyp : p ≠ yp) (hpyq : p ≠ yq) :
    p ∣ claim4YScale k yp yq := by
  apply claim4MediumPrime_dvd_scale hp hpk hkp2
  simp [claim4YScale, hpyp, hpyq]

/-- Any special `x` coordinate in the medium range is a unit for `Nx`. -/
theorem claim4XScale_not_dvd_of_medium_special
    {k xp xq xr p : ℕ}
    (hp : Nat.Prime p) (hkp2 : k < p ^ 2)
    (hspecial : p ∈ ({xp, xq, xr} : Finset ℕ)) :
    ¬p ∣ claim4XScale k xp xq xr := by
  exact claim4MediumPrime_not_dvd_scale hp hkp2 hspecial

/-- Any special `y` coordinate in the medium range is a unit for `Ny`. -/
theorem claim4YScale_not_dvd_of_medium_special
    {k yp yq p : ℕ}
    (hp : Nat.Prime p) (hkp2 : k < p ^ 2)
    (hspecial : p ∈ ({yp, yq} : Finset ℕ)) :
    ¬p ∣ claim4YScale k yp yq := by
  exact claim4MediumPrime_not_dvd_scale hp hkp2 hspecial

end Erdos678
