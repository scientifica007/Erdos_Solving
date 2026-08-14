import Formalization.Erdos678.LargePrimeRange
import Formalization.Erdos678.MediumPrimeClaim5
import Formalization.Erdos678.SmallPrimeClaim5

/-!
Assembly of Cambie's Claim 5 from the three machine-checked prime ranges.

This module deliberately assumes the residue data that the later CRT layer
must construct.  It combines the range-specific valuation identities and then
uses equality of all prime valuations to obtain the natural-number identity.
-/

namespace Erdos678

/-- Residue-window data consumed by the medium-prime range `p ≤ k < p^2`. -/
def Claim5MediumResidues (x y k : ℕ) : Prop :=
  ∀ p : ℕ, Nat.Prime p → p ≤ k → k < p ^ 2 →
    ∃ a b : ℕ,
      1 ≤ a ∧ a ≤ p - k % p ∧
      p - k % p ≤ b ∧ b ≤ p ∧
      x ≡ a [MOD p] ∧ y ≡ b [MOD p]

/-- Prime-power residue data consumed by the small-prime range `p^2 ≤ k`. -/
def Claim5SmallResidues (x y k : ℕ) : Prop :=
  ∀ p : ℕ, Nat.Prime p → p ^ 2 ≤ k →
    ∃ e : ℕ,
      p ^ e ≤ k ∧ k < p ^ (e + 1) ∧
      x ≡ 1 [MOD p ^ e] ∧ y ≡ 0 [MOD p ^ e]

/-- The product of a finite nonzero interval is nonzero. -/
theorem intervalProd_ne_zero_of_mem_ne_zero
    {start len : ℕ} (hne : ∀ z ∈ intervalFinset start len, z ≠ 0) :
    intervalProd start len ≠ 0 := by
  change (intervalFinset start len).prod id ≠ 0
  rw [Finset.prod_ne_zero_iff]
  simpa only [id_eq] using hne

/-- The LCM of a finite nonzero interval is nonzero. -/
theorem intervalLCM_ne_zero_of_mem_ne_zero
    {start len : ℕ} (hne : ∀ z ∈ intervalFinset start len, z ≠ 0) :
    intervalLCM start len ≠ 0 := by
  change (intervalFinset start len).lcm id ≠ 0
  rw [Finset.lcm_ne_zero_iff]
  simpa only [id_eq] using hne

/-- The exact product/LCM quotient of a finite nonzero interval is nonzero. -/
theorem intervalProd_div_intervalLCM_ne_zero
    {start len : ℕ} (hne : ∀ z ∈ intervalFinset start len, z ≠ 0) :
    intervalProd start len / intervalLCM start len ≠ 0 := by
  have hprod : intervalProd start len ≠ 0 :=
    intervalProd_ne_zero_of_mem_ne_zero hne
  have hdiv : intervalLCM start len ∣ intervalProd start len := by
    change (intervalFinset start len).lcm id ∣ (intervalFinset start len).prod id
    exact Finset.lcm_dvd_prod (intervalFinset start len) id
  intro hzero
  have hcancel :
      (intervalProd start len / intervalLCM start len) *
          intervalLCM start len = intervalProd start len :=
    Nat.div_mul_cancel hdiv
  rw [hzero, zero_mul] at hcancel
  exact hprod hcancel.symm

/-- Prime-by-prime valuation form of Claim 5, assembled from the large,
medium, and small prime ranges. -/
theorem claim5_prime_valuation_of_residues
    {x y k p : ℕ}
    (hk : 0 < k)
    (hxne : ∀ z ∈ intervalFinset x k, z ≠ 0)
    (hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0)
    (hmedium : Claim5MediumResidues x y k)
    (hsmall : Claim5SmallResidues x y k)
    (hp : Nat.Prime p) :
    padicValNat p (intervalProd y (k + 1) / intervalLCM y (k + 1)) =
      padicValNat p (intervalLCM 1 k) +
        padicValNat p (intervalProd x k / intervalLCM x k) := by
  by_cases hpk : p ≤ k
  · by_cases hkp2 : k < p ^ 2
    · rcases hmedium p hp hpk hkp2 with
        ⟨a, b, ha1, haUpper, hbLower, hbUpper, hx, hy⟩
      exact claim5_medium_prime_range hp hpk hkp2 ha1 haUpper hbLower hbUpper
        hx hy hxne hyne
    · have hp2k : p ^ 2 ≤ k := Nat.le_of_not_gt hkp2
      rcases hsmall p hp hp2k with ⟨e, hlo, hhi, hx, hy⟩
      exact claim5_small_prime_range hp hlo hhi hx hy hxne hyne
  · have hkp : k < p := Nat.lt_of_not_ge hpk
    rcases claim5_large_prime_range hp hkp hxne hyne with ⟨hvx, hvy⟩
    have hlo : p ^ 0 ≤ k := by
      simp
      omega
    have hhi : k < p ^ (0 + 1) := by
      simpa using hkp
    have hM :=
      padicValNat_initial_intervalLCM_eq_exp (e := 0) hp hlo hhi
    omega

/-- Cambie's complete Claim 5 natural-number identity, conditional only on
the residue data that the later Claim 4 / CRT layer must construct. -/
theorem claim5_full_identity_of_residues
    {x y k : ℕ}
    (hk : 0 < k)
    (hxne : ∀ z ∈ intervalFinset x k, z ≠ 0)
    (hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0)
    (hmedium : Claim5MediumResidues x y k)
    (hsmall : Claim5SmallResidues x y k) :
    intervalProd y (k + 1) / intervalLCM y (k + 1) =
      intervalLCM 1 k *
        (intervalProd x k / intervalLCM x k) := by
  have hinitne : ∀ z ∈ intervalFinset 1 k, z ≠ 0 := by
    intro z hz
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    omega
  have hMne : intervalLCM 1 k ≠ 0 :=
    intervalLCM_ne_zero_of_mem_ne_zero hinitne
  have hxqne : intervalProd x k / intervalLCM x k ≠ 0 :=
    intervalProd_div_intervalLCM_ne_zero hxne
  have hyqne : intervalProd y (k + 1) / intervalLCM y (k + 1) ≠ 0 :=
    intervalProd_div_intervalLCM_ne_zero hyne
  have hrhsne :
      intervalLCM 1 k *
          (intervalProd x k / intervalLCM x k) ≠ 0 :=
    Nat.mul_ne_zero hMne hxqne
  apply eq_of_prime_padicValNat_eq hyqne hrhsne
  intro p hp
  rw [padicValNat_mul_of_prime hp hMne hxqne]
  exact claim5_prime_valuation_of_residues hk hxne hyne hmedium hsmall hp

end Erdos678
