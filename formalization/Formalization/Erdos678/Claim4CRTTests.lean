import Formalization.Erdos678.Claim4CRT

/-!
Reachable regressions for the concrete pair CRT producer.
-/

namespace Erdos678

/-- For coordinates `5` and `7`, both CRT weights have inverse multiplier
`3`, so the producer contract is concrete and reachable. -/
example :
    Claim4WeightedRepresentation
      (Finset.univ : Finset (Fin 2))
      (claim4PairPrime 5 7)
      (claim4PairMultiplier 3 3)
      (claim4PairWeight 5 7)
      35 := by
  apply claim4_pair_weightedRepresentation_of_inverses
  · norm_num
  · norm_num [Nat.ModEq]
  · norm_num [Nat.ModEq]

/-- The existence theorem supplies nondivisible multipliers and the complete
pair representation contract for two distinct concrete primes. -/
example :
    ∃ cp cq : ℕ,
      cp < 5 ∧ cq < 7 ∧
      (∀ i : Fin 2,
        ¬claim4PairPrime 5 7 i ∣ claim4PairMultiplier cp cq i) ∧
      Claim4WeightedRepresentation
        (Finset.univ : Finset (Fin 2))
        (claim4PairPrime 5 7)
        (claim4PairMultiplier cp cq)
        (claim4PairWeight 5 7)
        35 := by
  simpa using exists_claim4_pair_crt_multipliers
    (p := 5) (q := 7) (by norm_num) (by norm_num) (by norm_num)

/-- A multiplier divisible by its coordinate prime cannot serve as the
inverse for the standard pair basis. -/
example : ¬(5 * 7 ≡ 1 [MOD 5]) := by
  norm_num [Nat.ModEq]

end Erdos678
