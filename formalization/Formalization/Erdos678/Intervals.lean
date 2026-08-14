import Mathlib

/-!
Length-based interval primitives for Erdős Problem #678.

The second interval argument is always a length, never a right-endpoint offset.
This convention is intentionally chosen to prevent the off-by-one error that
invalidated an earlier construction in this project.
-/

namespace Erdos678

/-- `intervalFinset start len` contains exactly `len` consecutive naturals,
starting at `start`: `start, start+1, ..., start+len-1`. -/
def intervalFinset (start len : ℕ) : Finset ℕ :=
  (Finset.range len).image (fun i => start + i)

/-- Product of the `len` consecutive naturals starting at `start`. -/
def intervalProd (start len : ℕ) : ℕ :=
  (intervalFinset start len).prod id

/-- LCM of the `len` consecutive naturals starting at `start`. -/
def intervalLCM (start len : ℕ) : ℕ :=
  (intervalFinset start len).lcm id

/-- Canonical Erdős #678 notation:
`erdosM n k = lcm(n+1, ..., n+k)`, a block of exactly `k` terms. -/
def erdosM (n k : ℕ) : ℕ :=
  intervalLCM (n + 1) k

example : intervalFinset 10 0 = ∅ := by
  decide

example : intervalFinset 10 1 = {10} := by
  decide

example : intervalFinset 10 3 = {10, 11, 12} := by
  decide

end Erdos678
