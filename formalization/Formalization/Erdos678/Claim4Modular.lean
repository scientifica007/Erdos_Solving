import Formalization.Erdos678.Claim4Density
import Mathlib.Data.Nat.ModEq

/-!
The modular-injectivity layer of Cambie's Claim 4.

Multiplication by a coefficient coprime to the modulus is injective on any
consecutive interval whose length does not exceed that modulus.  Combining
this with the finite counting core yields the exact coordinate-avoidance form
used in the paper's proof.
-/

namespace Erdos678

/-- Multiplication modulo `modulus` is injective on a consecutive interval of
length at most `modulus` when the multiplier is coprime to the modulus. -/
theorem interval_mul_mod_injective_of_coprime
    {modulus c start len : ℕ}
    (hc : modulus.Coprime c) (hlen : len ≤ modulus) :
    Set.InjOn (fun z => (z * c) % modulus)
      (Finset.Ico start (start + len)) := by
  intro a ha b hb hab
  have haI := Finset.mem_Ico.mp ha
  have hbI := Finset.mem_Ico.mp hb
  have hmul : a * c ≡ b * c [MOD modulus] := hab
  have hmod : a ≡ b [MOD modulus] :=
    hmul.cancel_right_of_coprime hc
  have hoff : a - start ≡ b - start [MOD modulus] := by
    apply Nat.ModEq.add_left_cancel' start
    simpa only [Nat.add_sub_of_le haI.1, Nat.add_sub_of_le hbI.1] using hmod
  have haoff : a - start < modulus := by omega
  have hboff : b - start < modulus := by omega
  have heq : a - start = b - start :=
    hoff.eq_of_lt_of_lt haoff hboff
  omega

/-- Prime specialization: a coefficient not divisible by the prime is a unit
for the modular coordinate map. -/
theorem interval_mul_mod_injective_of_prime
    {p c start len : ℕ}
    (hp : Nat.Prime p) (hc : ¬p ∣ c) (hlen : len ≤ p) :
    Set.InjOn (fun z => (z * c) % p)
      (Finset.Ico start (start + len)) := by
  exact interval_mul_mod_injective_of_coprime
    (hp.coprime_iff_not_dvd.mpr hc) hlen

/-- Modular coordinate-density form of Cambie's Claim 4.

For every active prime coordinate, `excluded i` is a set of forbidden residue
representatives.  If their total cardinality is strictly below the interval
length, a consecutive interval contains a position whose scaled residue is
allowed in every coordinate. -/
theorem claim4_prime_coordinate_density
    {ι : Type*}
    (indices : Finset ι)
    (p c : ι → ℕ)
    (start len : ℕ)
    (excluded : ι → Finset ℕ)
    (hp : ∀ i ∈ indices, Nat.Prime (p i))
    (hc : ∀ i ∈ indices, ¬p i ∣ c i)
    (hlen : ∀ i ∈ indices, len ≤ p i)
    (hbudget : ∑ i ∈ indices, (excluded i).card < len) :
    ∃ z ∈ Finset.Ico start (start + len),
      ∀ i ∈ indices, (z * c i) % p i ∉ excluded i := by
  apply claim4_exists_avoiding_coordinate_exclusions
      (indices := indices)
      (positions := Finset.Ico start (start + len))
      (value := fun i z => (z * c i) % p i)
      (excluded := excluded)
  · intro i hi
    exact interval_mul_mod_injective_of_prime
      (hp i hi) (hc i hi) (hlen i hi)
  · simpa using hbudget

end Erdos678
