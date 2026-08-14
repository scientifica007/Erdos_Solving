import Formalization.Erdos678.SmallPrimeValuation
import Formalization.Erdos678.SmallPrimeWindows
import Formalization.Erdos678.SmallPrimeInitialLCM
import Formalization.Erdos678.SmallPrimeSup

/-!
Assembly of the exponent-parameterized small-prime range of Cambie's Claim 5.

The range is expressed by `p^e <= k < p^(e+1)` rather than by a logarithm.
Cambie's small-prime congruences are represented by `x ≡ 1 (mod p^e)` and
`y ≡ 0 (mod p^e)`.
-/

namespace Erdos678

/-- Cambie's Claim 5 valuation identity in the small-prime exponent range.

The `x` block is `[x,...,x+k-1]`, the `y` block is `[y,...,y+k]`, and
`intervalLCM 1 k = lcm(1,...,k)`.
-/
theorem claim5_small_prime_range
    {x y k p e : ℕ}
    (hp : Nat.Prime p)
    (hlo : p ^ e ≤ k) (hhi : k < p ^ (e + 1))
    (hx : x ≡ 1 [MOD p ^ e])
    (hy : y ≡ 0 [MOD p ^ e])
    (hxne : ∀ z ∈ intervalFinset x k, z ≠ 0)
    (hyne : ∀ z ∈ intervalFinset y (k + 1), z ≠ 0) :
    padicValNat p (intervalProd y (k + 1) / intervalLCM y (k + 1)) =
      padicValNat p (intervalLCM 1 k) +
        padicValNat p (intervalProd x k / intervalLCM x k) := by
  have htailne : ∀ z ∈ intervalFinset (y + 1) k, z ≠ 0 := by
    intro z hz
    apply hyne z
    obtain ⟨i, hi, hiz⟩ := mem_intervalFinset_iff.mp hz
    apply mem_intervalFinset_iff.mpr
    refine ⟨i + 1, by omega, ?_⟩
    omega
  have hymem : y ∈ intervalFinset y (k + 1) := by
    apply mem_intervalFinset_iff.mpr
    exact ⟨0, by omega, by simp⟩
  have hy0 : y ≠ 0 := hyne y hymem
  have hsupx :
      e ≤ (intervalFinset x k).sup (fun z => padicValNat p z) :=
    exp_le_interval_padicValNat_sup_of_modEq_one hp hlo hx hxne
  have hsupy :
      e ≤ (intervalFinset y (k + 1)).sup (fun z => padicValNat p z) := by
    have hyval : e ≤ padicValNat p y :=
      exp_le_padicValNat_of_modEq_zero hp hy0 hy
    exact hyval.trans (Finset.le_sup hymem)
  have hklen : k ≤ p ^ (e + 1) := Nat.le_of_lt hhi
  have hylen : k + 1 ≤ p ^ (e + 1) := Nat.succ_le_of_lt hhi
  have hvx :=
    padicValNat_intervalProd_div_intervalLCM_eq_capped_sum_sub
      hp hxne hsupx hklen
  have hvy :=
    padicValNat_intervalProd_div_intervalLCM_eq_capped_sum_sub
      hp hyne hsupy hylen
  have hy1 : y + 1 ≡ 1 [MOD p ^ e] := by
    simpa using hy.add_right 1
  have hxy : x ≡ y + 1 [MOD p ^ e] := hx.trans hy1.symm
  have hsumtail :
      (intervalFinset x k).sum (fun z => min (padicValNat p z) e) =
        (intervalFinset (y + 1) k).sum (fun z => min (padicValNat p z) e) :=
    interval_sum_min_padicValNat_eq_of_modEq_prime_pow
      hp hxy hxne htailne
  have hycap : min (padicValNat p y) e = e :=
    min_padicValNat_eq_exp_of_modEq_zero hp hy0 hy
  have hsumy :
      (intervalFinset y (k + 1)).sum (fun z => min (padicValNat p z) e) =
        e + (intervalFinset x k).sum (fun z => min (padicValNat p z) e) := by
    calc
      (intervalFinset y (k + 1)).sum (fun z => min (padicValNat p z) e) =
          min (padicValNat p y) e +
            (intervalFinset (y + 1) k).sum (fun z => min (padicValNat p z) e) :=
        intervalFinset_sum_succ_len y k (fun z => min (padicValNat p z) e)
      _ = e + (intervalFinset (y + 1) k).sum (fun z => min (padicValNat p z) e) := by
        rw [hycap]
      _ = e + (intervalFinset x k).sum (fun z => min (padicValNat p z) e) := by
        rw [← hsumtail]
  have hsx :
      e ≤ (intervalFinset x k).sum (fun z => min (padicValNat p z) e) :=
    exp_le_interval_sum_min_padicValNat_of_modEq_one hp hlo hx hxne
  have hM := padicValNat_initial_intervalLCM_eq_exp hp hlo hhi
  omega

end Erdos678
