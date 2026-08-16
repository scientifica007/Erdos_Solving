import Formalization.Erdos678.Claim4PrimeWindows

/-!
Reachable regressions for the D4 prime-window contract.
-/

namespace Erdos678

/-- A concrete nonvacuous window configuration.  At `k = 50`, the two
`y` primes lie just above `k/2` and the three `x` primes lie near `k`. -/
example : Claim4PrimeWindowData 50 41 43 47 29 31 := by
  constructor <;> norm_num

/-- The concrete window automatically produces all exact search-length
bounds consumed by D3. -/
example :
    claim4TripleXSearchLength 50 41 43 47 ≤ 41 ∧
      claim4TripleXSearchLength 50 41 43 47 ≤ 43 ∧
      claim4TripleXSearchLength 50 41 43 47 ≤ 47 ∧
      claim4PairYSearchLength 50 29 31 ≤ 29 ∧
      claim4PairYSearchLength 50 29 31 ≤ 31 := by
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  exact h.search_length_bounds

/-- The complete constructed-scale residue producer is reachable from the
prime-window contract alone, apart from the still-free search interval starts. -/
example :
    ∃ zx ∈ Finset.Ico 0 (claim4TripleXSearchLength 50 41 43 47),
      ∃ zy ∈ Finset.Ico 1 (1 + claim4PairYSearchLength 50 29 31),
        Claim5MediumResidues
            (1 + zx * claim4XScale 50 41 43 47)
            (zy * claim4YScale 50 29 31) 50 ∧
          Claim5SmallResidues
            (1 + zx * claim4XScale 50 41 43 47)
            (zy * claim4YScale 50 29 31) 50 := by
  have h : Claim4PrimeWindowData 50 41 43 47 29 31 := by
    constructor <;> norm_num
  exact claim4_exists_claim5_residue_interfaces_of_prime_windows
    (startx := 0) (starty := 1) h

/-- Falling to the half boundary is not admitted by the `y` window. -/
example : ¬ Claim4PrimeWindowData 10 11 13 17 5 7 := by
  intro h
  have hhalf : 10 < 2 * 5 := h.yp_above_half
  norm_num at hhalf

end Erdos678
