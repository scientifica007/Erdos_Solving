import Formalization.Erdos678.Claim4FiveStripPrimeData

/-!
Phase E2d: a natural-number adapter for relative prime intervals.

PNT-style consequences are most naturally stated multiplicatively: for a fixed
positive denominator `q`, sufficiently large `n` admit a prime `p` with

`q*n < q*p < (q+1)*n`.

The D4/E2 strip interface is additive.  This file isolates the exact arithmetic
conversion.  No prime-density theorem is assumed globally and no axiom is
introduced: `Claim4RelativePrimeProvider q` is an explicit hypothesis package
for a later imported/formalized theorem.
-/

namespace Erdos678

/-- A single relative prime witness fits inside the additive strip of width
`k/q` whenever its left endpoint `n` is at most `k`. -/
theorem claim4_relative_prime_witness_in_additive_strip
    {q k n p : ℕ}
    (hq : 0 < q)
    (hnk : n ≤ k)
    (hlower : q * n < q * p)
    (hupper : q * p < (q + 1) * n) :
    n < p ∧ p ≤ n + k / q := by
  have hnp : n < p := by
    by_contra h
    have hpn : p ≤ n := Nat.le_of_not_gt h
    have hmul : q * p ≤ q * n := Nat.mul_le_mul_left q hpn
    exact (not_lt_of_ge hmul) hlower
  have hnext : k < q * (k / q + 1) := by
    exact Nat.lt_mul_div_succ k hq
  have hnnext : n < q * (k / q + 1) := hnk.trans_lt hnext
  have hpupper : p ≤ n + k / q := by
    by_contra h
    have hsucc : n + k / q + 1 ≤ p := Nat.succ_le_of_lt (Nat.lt_of_not_ge h)
    have hmul : q * (n + k / q + 1) ≤ q * p :=
      Nat.mul_le_mul_left q hsucc
    have hcross : (q + 1) * n < q * (n + k / q + 1) := by
      calc
        (q + 1) * n = q * n + n := by ring
        _ < q * n + q * (k / q + 1) := Nat.add_lt_add_left hnnext _
        _ = q * (n + k / q + 1) := by ring
    have hnot : ¬ q * p < (q + 1) * n :=
      not_lt_of_ge (Nat.le_of_lt (hcross.trans_le hmul))
    exact hnot hupper
  exact ⟨hnp, hpupper⟩

/-- Explicit eventual relative-prime input.  This is the natural-number shape
that a PNT consequence such as a `prime_between` theorem can discharge. -/
structure Claim4RelativePrimeProvider (q : ℕ) where
  threshold : ℕ
  prime_after :
    ∀ n : ℕ, threshold ≤ n →
      ∃ p : ℕ, Nat.Prime p ∧ q * n < q * p ∧ q * p < (q + 1) * n

/-- A relative-prime provider yields an actual prime in every sufficiently
large additive strip of width `k/q`, uniformly for left endpoints `n ≤ k`. -/
theorem Claim4RelativePrimeProvider.exists_prime_in_additive_strip
    {q k n : ℕ}
    (h : Claim4RelativePrimeProvider q)
    (hq : 0 < q)
    (hn : h.threshold ≤ n)
    (hnk : n ≤ k) :
    ∃ p : ℕ, Nat.Prime p ∧ n < p ∧ p ≤ n + k / q := by
  obtain ⟨p, hp, hlower, hupper⟩ := h.prime_after n hn
  obtain ⟨hnp, hpupper⟩ :=
    claim4_relative_prime_witness_in_additive_strip hq hnk hlower hupper
  exact ⟨p, hp, hnp, hpupper⟩

end Erdos678
