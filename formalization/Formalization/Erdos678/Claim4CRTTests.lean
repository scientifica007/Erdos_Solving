import Formalization.Erdos678.Claim4CRT

/-!
Reachable regressions for the concrete pair and triple CRT producers.
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

/-- A multiplier divisible by its coordinate prime does not merely fail the
local inverse equation: it falsifies the complete pair representation
contract. -/
example :
    ¬Claim4WeightedRepresentation
      (Finset.univ : Finset (Fin 2))
      (claim4PairPrime 5 7)
      (claim4PairMultiplier 5 3)
      (claim4PairWeight 5 7)
      35 := by
  intro h
  have h1 := h 1
  norm_num [Claim4WeightedRepresentation, claim4WeightedCombination,
    claim4PairPrime, claim4PairMultiplier, claim4PairWeight,
    Fin.sum_univ_two, Nat.ModEq] at h1

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

/-- The pair density endpoint is directly reachable without asking the
caller for a representation assumption. -/
example : True := by
  rcases claim4_pair_crt_density
      (p := 5) (q := 7) (start := 8) (len := 5)
      (excluded := fun _ : Fin 2 => ∅)
      (hp := by norm_num) (hq := by norm_num) (hpq := by norm_num)
      (hlenp := by norm_num) (hlenq := by norm_num)
      (hbudget := by norm_num [Fin.sum_univ_two]) with
    ⟨c, hc, z, hz, hallowed, hrep⟩
  trivial

/-- The triple density endpoint is likewise reachable from concrete
pairwise-coprime primes and an exclusion budget alone. -/
example : True := by
  rcases claim4_triple_crt_density
      (p := 5) (q := 7) (r := 11) (start := 8) (len := 5)
      (excluded := fun _ : Fin 3 => ∅)
      (hp := by norm_num) (hq := by norm_num) (hr := by norm_num)
      (hpq := by norm_num) (hpr := by norm_num) (hqr := by norm_num)
      (hlenp := by norm_num) (hlenq := by norm_num)
      (hlenr := by norm_num)
      (hbudget := by norm_num [Fin.sum_univ_three]) with
    ⟨c, hc, z, hz, hallowed, hrep⟩
  trivial

end Erdos678
