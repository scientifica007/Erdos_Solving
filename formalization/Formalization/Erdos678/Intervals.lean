import Mathlib

namespace Erdos678

/-- `intervalFinset start len` contains exactly `len` consecutive naturals,
starting at `start`: `start, start+1, ..., start+len-1`.

The second argument is a *length*, not a right-endpoint offset.  This
convention is deliberately chosen to prevent the off-by-one ambiguity that
invalidated an earlier #678 construction. -/
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

/-! Boundary regression tests for the length convention. -/

example : intervalFinset 10 0 = ∅ := by
  native_decide

example : intervalFinset 10 1 = {10} := by
  native_decide

example : intervalFinset 10 3 = {10, 11, 12} := by
  native_decide

end Erdos678
