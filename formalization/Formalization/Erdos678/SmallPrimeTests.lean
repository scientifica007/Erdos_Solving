import Formalization.Erdos678.SmallPrimeClaim5

/-!
Concrete boundary regressions for the small-prime range of Cambie's Claim 5.

These examples independently evaluate the arithmetic identity.  The negative
case deliberately violates the required congruence for the y-block, recording
that the small-prime hypotheses are mathematically active.
-/

namespace Erdos678

/-- Positive regression at p = 2, e = 1, and the lower boundary k = p^e. -/
example :
    padicValNat 2 (intervalProd 6 3 / intervalLCM 6 3) =
      padicValNat 2 (intervalLCM 1 2) +
        padicValNat 2 (intervalProd 3 2 / intervalLCM 3 2) := by
  decide

/-- Boundary regression at exponent e = 0. -/
example :
    padicValNat 2 (intervalProd 4 2 / intervalLCM 4 2) =
      padicValNat 2 (intervalLCM 1 1) +
        padicValNat 2 (intervalProd 3 1 / intervalLCM 3 1) := by
  decide

/-- Negative regression: y = 5 violates y ≡ 0 (mod 2), and the identity fails. -/
example :
    padicValNat 2 (intervalProd 5 3 / intervalLCM 5 3) ≠
      padicValNat 2 (intervalLCM 1 2) +
        padicValNat 2 (intervalProd 3 2 / intervalLCM 3 2) := by
  decide

end Erdos678
