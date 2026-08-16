import Formalization.Erdos678.Claim4FullScaleLCM

/-!
Reachable regressions for the D4 full-scale / initial-LCM identification.
-/

namespace Erdos678

example : claim4FullScale 10 = intervalLCM 1 10 := by
  exact claim4FullScale_eq_initialLCM 10

example : claim4FullScale 10 = 2520 := by
  decide

end Erdos678
