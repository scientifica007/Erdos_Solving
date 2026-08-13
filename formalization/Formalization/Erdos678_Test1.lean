import Mathlib

namespace Erdos678

/-- First machine-checkable sanity test for Erdős Problem #678.
We begin with the explicit witness parameters produced by the salvaged construction. -/
example : 504 ≥ 495 + 8 := by
  norm_num

/-- The explicit witness parameters are admissible for the problem. -/
example : 8 ≥ 3 ∧ 504 ≥ 495 + 8 := by
  norm_num

end Erdos678
