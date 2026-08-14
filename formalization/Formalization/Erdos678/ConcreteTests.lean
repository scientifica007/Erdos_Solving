import Formalization.Erdos678.Intervals

/-!
Concrete positive and negative regression tests for Erdős Problem #678.

The explicit nested LCM definitions act as an independent arithmetic oracle
for the canonical length-based `erdosM` abstraction.
-/

namespace Erdos678

/-- Independent explicit oracle for `M(36,8) = lcm(37,...,44)`. -/
def M36_8_explicit : ℕ :=
  Nat.lcm 37 (Nat.lcm 38 (Nat.lcm 39 (Nat.lcm 40
    (Nat.lcm 41 (Nat.lcm 42 (Nat.lcm 43 44))))))

/-- Independent explicit oracle for `M(47,9) = lcm(48,...,56)`. -/
def M47_9_explicit : ℕ :=
  Nat.lcm 48 (Nat.lcm 49 (Nat.lcm 50 (Nat.lcm 51
    (Nat.lcm 52 (Nat.lcm 53 (Nat.lcm 54
      (Nat.lcm 55 56)))))))

/-- Explicit oracle for the rejected candidate's left side. -/
def M495_8_explicit : ℕ :=
  Nat.lcm 496 (Nat.lcm 497 (Nat.lcm 498 (Nat.lcm 499
    (Nat.lcm 500 (Nat.lcm 501 (Nat.lcm 502 503))))))

/-- Explicit oracle for the rejected candidate's right side. -/
def M504_9_explicit : ℕ :=
  Nat.lcm 505 (Nat.lcm 506 (Nat.lcm 507 (Nat.lcm 508
    (Nat.lcm 509 (Nat.lcm 510 (Nat.lcm 511
      (Nat.lcm 512 513)))))))

example : erdosM 36 8 = M36_8_explicit := by
  decide

example : erdosM 47 9 = M47_9_explicit := by
  decide

example : erdosM 495 8 = M495_8_explicit := by
  decide

example : erdosM 504 9 = M504_9_explicit := by
  decide

/-- Positive regression: a genuine concrete solution. -/
example : erdosM 36 8 > erdosM 47 9 := by
  decide

/-- Domain conditions for the positive witness. -/
example : 8 ≥ 3 ∧ 47 ≥ 36 + 8 := by
  norm_num

/-- Negative regression: the rejected candidate remains rejected. -/
example : ¬ (erdosM 495 8 > erdosM 504 9) := by
  decide

end Erdos678
