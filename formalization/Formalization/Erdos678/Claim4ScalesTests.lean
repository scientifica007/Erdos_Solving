import Formalization.Erdos678.Claim4Scales

/-!
Reachable regressions for the first D4 scale-construction boundary.
-/

namespace Erdos678

/-- The constructed `x` and `y` scales always carry the common small-prime
support required by the D3 interface. -/
example :
    Claim4SmallPrimeScaleData
      (claim4XScale 4 13 17 19) (claim4YScale 4 3 5) 4 := by
  exact claim4XYSmallPrimeScaleData 4 13 17 19 3 5

/-- At `k = 4`, the only medium prime is `3`; it is retained in the `x` scale
when the three special coordinates are elsewhere. -/
example : 3 ∣ claim4XScale 4 13 17 19 := by
  apply claim4XScale_dvd_of_medium_other
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num

/-- A special medium coordinate is removed from the corresponding scale. -/
example : ¬3 ∣ claim4YScale 4 3 5 := by
  apply claim4YScale_not_dvd_of_medium_special
  · norm_num
  · norm_num
  · simp

/-- Removing a coordinate is mathematically active: if `3` is not special,
it divides the same generic `y`-shape scale. -/
example : 3 ∣ claim4YScale 4 5 7 := by
  apply claim4YScale_dvd_of_medium_other
  · norm_num
  · norm_num
  · norm_num
  · norm_num
  · norm_num

end Erdos678
