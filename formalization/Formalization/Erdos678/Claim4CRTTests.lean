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

/-- For coordinates `5`, `7`, and `11`, the standard triple weights have the
concrete inverse multipliers `3`, `6`, and `6`. -/
example :
    Claim4WeightedRepresentation
      (Finset.univ : Finset (Fin 3))
      (claim4TriplePrime 5 7 11)
      (claim4TripleMultiplier 3 6 6)
      (claim4TripleWeight 5 7 11)
      385 := by
  apply claim4_triple_weightedRepresentation_of_inverses
  · norm_num
  · norm_num
  · norm_num
  · norm_num [Nat.ModEq]
  · norm_num [Nat.ModEq]
  · norm_num [Nat.ModEq]

/-- The triple producer constructs bounded, nondivisible multipliers and the
complete representation contract from pairwise-coprime primes. -/
example :
    ∃ cp cq cr : ℕ,
      cp < 5 ∧ cq < 7 ∧ cr < 11 ∧
      (∀ i : Fin 3,
        ¬claim4TriplePrime 5 7 11 i ∣
          claim4TripleMultiplier cp cq cr i) ∧
      Claim4WeightedRepresentation
        (Finset.univ : Finset (Fin 3))
        (claim4TriplePrime 5 7 11)
        (claim4TripleMultiplier cp cq cr)
        (claim4TripleWeight 5 7 11)
        385 := by
  simpa using exists_claim4_triple_crt_multipliers
    (p := 5) (q := 7) (r := 11)
    (by norm_num) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)

end Erdos678
