import Mathlib

namespace Erdos678

/-- Explicit LCM for M(36,8) = lcm(37,...,44). -/
def M36_8 : Nat :=
  Nat.lcm 37 (Nat.lcm 38 (Nat.lcm 39 (Nat.lcm 40
    (Nat.lcm 41 (Nat.lcm 42 (Nat.lcm 43 44))))))

/-- Explicit LCM for M(47,9) = lcm(48,...,56). -/
def M47_9 : Nat :=
  Nat.lcm 48 (Nat.lcm 49 (Nat.lcm 50 (Nat.lcm 51
    (Nat.lcm 52 (Nat.lcm 53 (Nat.lcm 54
      (Nat.lcm 55 56)))))))

/-- A genuine concrete solution to Erdős #678. -/
example : M36_8 > M47_9 := by
  norm_num [M36_8, M47_9]

/-- The corresponding domain condition m >= n + k. -/
example : 47 >= 36 + 8 := by
  norm_num

/-- The previously proposed (495,504,8) instance is NOT a solution. -/
def M495_8 : Nat :=
  Nat.lcm 496 (Nat.lcm 497 (Nat.lcm 498 (Nat.lcm 499
    (Nat.lcm 500 (Nat.lcm 501 (Nat.lcm 502 503))))))

def M504_9 : Nat :=
  Nat.lcm 505 (Nat.lcm 506 (Nat.lcm 507 (Nat.lcm 508
    (Nat.lcm 509 (Nat.lcm 510 (Nat.lcm 511
      (Nat.lcm 512 513)))))))

example : ¬ (M495_8 > M504_9) := by
  norm_num [M495_8, M504_9]

end Erdos678
