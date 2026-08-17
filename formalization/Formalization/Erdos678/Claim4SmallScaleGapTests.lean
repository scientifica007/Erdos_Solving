import Formalization.Erdos678.Claim4SmallScaleGap

/-!
Reachable regressions for the uniform small-scale separation theorem.
-/

namespace Erdos678

example : 11 ≤ claim4SmallScale 9 := by
  exact claim4SmallScale_gap_of_nine_le (by norm_num)

example : 52 ≤ claim4SmallScale 50 := by
  exact claim4SmallScale_gap_of_nine_le (by norm_num)

end Erdos678
