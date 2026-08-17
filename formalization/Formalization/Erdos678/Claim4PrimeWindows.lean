import Formalization.Erdos678.Claim4ConstructedInterface

/-!
Prime-window contract for the quantitative D4 construction.

The analytic prime-density theorem is deliberately not imported here.  This
module states a purely arithmetic contract that a later prime-density layer can
produce:

* two distinct `y` primes lie in `(k/2, 2k/3]`;
* three pairwise-distinct `x` primes lie in `[(3k+1)/4, k]`.

These fixed windows are stronger than the qualitative requirements of the D3
producer and are wide enough for standard prime-density inputs at sufficiently
large `k`.  Their purpose here is only to discharge the exact modular
search-length inequalities and the medium-range `k < p^2` obligations.
-/

namespace Erdos678

/-- Purely arithmetic prime-window data consumed by D4.  No existence theorem
for these primes is asserted in this module. -/
structure Claim4PrimeWindowData
    (k xp xq xr yp yq : ℕ) : Prop where
  xp_prime : Nat.Prime xp
  xq_prime : Nat.Prime xq
  xr_prime : Nat.Prime xr
  yp_prime : Nat.Prime yp
  yq_prime : Nat.Prime yq
  xp_le_k : xp ≤ k
  xq_le_k : xq ≤ k
  xr_le_k : xr ≤ k
  yp_le_k : yp ≤ k
  yq_le_k : yq ≤ k
  xp_near_k : 3 * k + 1 ≤ 4 * xp
  xq_near_k : 3 * k + 1 ≤ 4 * xq
  xr_near_k : 3 * k + 1 ≤ 4 * xr
  yp_above_half : k < 2 * yp
  yq_above_half : k < 2 * yq
  yp_below_two_thirds : 3 * yp ≤ 2 * k
  yq_below_two_thirds : 3 * yq ≤ 2 * k
  xp_ne_xq : xp ≠ xq
  xp_ne_xr : xp ≠ xr
  xq_ne_xr : xq ≠ xr
  yp_ne_yq : yp ≠ yq

/-- In the interval `p ≤ k < 2p`, the remainder `k mod p` is exactly
`k - p`. -/
theorem mod_eq_sub_of_le_of_lt_two_mul
    {k p : ℕ} (hpk : p ≤ k) (hk2p : k < 2 * p) :
    k % p = k - p := by
  rw [Nat.mod_eq_sub_mod hpk]
  exact Nat.mod_eq_of_lt (by omega)

/-- Any prime strictly above `k/2` belongs to the medium range `k < p^2`. -/
theorem lt_prime_sq_of_lt_two_mul
    {k p : ℕ} (hp : Nat.Prime p) (hk2p : k < 2 * p) :
    k < p ^ 2 := by
  have hp2 : 2 ≤ p := hp.two_le
  nlinarith

/-- The two-prime `y` search length fits in its left coordinate throughout the
window `(k/2, 2k/3]`. -/
theorem claim4PairYSearchLength_le_left_of_window
    {k p q : ℕ}
    (hpk : p ≤ k) (hqk : q ≤ k)
    (hk2p : k < 2 * p) (hk2q : k < 2 * q)
    (hpupper : 3 * p ≤ 2 * k) (hqupper : 3 * q ≤ 2 * k) :
    claim4PairYSearchLength k p q ≤ p := by
  have hpmod : k % p = k - p :=
    mod_eq_sub_of_le_of_lt_two_mul hpk hk2p
  have hqmod : k % q = k - q :=
    mod_eq_sub_of_le_of_lt_two_mul hqk hk2q
  rw [claim4PairYSearchLength, hpmod, hqmod]
  omega

/-- Symmetric right-coordinate bound for the `y` search. -/
theorem claim4PairYSearchLength_le_right_of_window
    {k p q : ℕ}
    (hpk : p ≤ k) (hqk : q ≤ k)
    (hk2p : k < 2 * p) (hk2q : k < 2 * q)
    (hpupper : 3 * p ≤ 2 * k) (hqupper : 3 * q ≤ 2 * k) :
    claim4PairYSearchLength k p q ≤ q := by
  have hpmod : k % p = k - p :=
    mod_eq_sub_of_le_of_lt_two_mul hpk hk2p
  have hqmod : k % q = k - q :=
    mod_eq_sub_of_le_of_lt_two_mul hqk hk2q
  rw [claim4PairYSearchLength, hpmod, hqmod]
  omega

/-- The three-prime `x` search length fits in the first coordinate when all
three primes lie in the fixed near-`k` window. -/
theorem claim4TripleXSearchLength_le_first_of_window
    {k p q r : ℕ}
    (hpk : p ≤ k) (hqk : q ≤ k) (hrk : r ≤ k)
    (hpnear : 3 * k + 1 ≤ 4 * p)
    (hqnear : 3 * k + 1 ≤ 4 * q)
    (hrnear : 3 * k + 1 ≤ 4 * r) :
    claim4TripleXSearchLength k p q r ≤ p := by
  have hk2p : k < 2 * p := by omega
  have hk2q : k < 2 * q := by omega
  have hk2r : k < 2 * r := by omega
  have hpmod : k % p = k - p :=
    mod_eq_sub_of_le_of_lt_two_mul hpk hk2p
  have hqmod : k % q = k - q :=
    mod_eq_sub_of_le_of_lt_two_mul hqk hk2q
  have hrmod : k % r = k - r :=
    mod_eq_sub_of_le_of_lt_two_mul hrk hk2r
  rw [claim4TripleXSearchLength, hpmod, hqmod, hrmod]
  omega

/-- Second-coordinate version of the near-`k` triple bound. -/
theorem claim4TripleXSearchLength_le_second_of_window
    {k p q r : ℕ}
    (hpk : p ≤ k) (hqk : q ≤ k) (hrk : r ≤ k)
    (hpnear : 3 * k + 1 ≤ 4 * p)
    (hqnear : 3 * k + 1 ≤ 4 * q)
    (hrnear : 3 * k + 1 ≤ 4 * r) :
    claim4TripleXSearchLength k p q r ≤ q := by
  have hk2p : k < 2 * p := by omega
  have hk2q : k < 2 * q := by omega
  have hk2r : k < 2 * r := by omega
  have hpmod : k % p = k - p :=
    mod_eq_sub_of_le_of_lt_two_mul hpk hk2p
  have hqmod : k % q = k - q :=
    mod_eq_sub_of_le_of_lt_two_mul hqk hk2q
  have hrmod : k % r = k - r :=
    mod_eq_sub_of_le_of_lt_two_mul hrk hk2r
  rw [claim4TripleXSearchLength, hpmod, hqmod, hrmod]
  omega

/-- Third-coordinate version of the near-`k` triple bound. -/
theorem claim4TripleXSearchLength_le_third_of_window
    {k p q r : ℕ}
    (hpk : p ≤ k) (hqk : q ≤ k) (hrk : r ≤ k)
    (hpnear : 3 * k + 1 ≤ 4 * p)
    (hqnear : 3 * k + 1 ≤ 4 * q)
    (hrnear : 3 * k + 1 ≤ 4 * r) :
    claim4TripleXSearchLength k p q r ≤ r := by
  have hk2p : k < 2 * p := by omega
  have hk2q : k < 2 * q := by omega
  have hk2r : k < 2 * r := by omega
  have hpmod : k % p = k - p :=
    mod_eq_sub_of_le_of_lt_two_mul hpk hk2p
  have hqmod : k % q = k - q :=
    mod_eq_sub_of_le_of_lt_two_mul hqk hk2q
  have hrmod : k % r = k - r :=
    mod_eq_sub_of_le_of_lt_two_mul hrk hk2r
  rw [claim4TripleXSearchLength, hpmod, hqmod, hrmod]
  omega

/-- The fixed near-`k` window is also above `k/2`. -/
theorem Claim4PrimeWindowData.xp_above_half
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    k < 2 * xp := by
  have hnear := h.xp_near_k
  omega

theorem Claim4PrimeWindowData.xq_above_half
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    k < 2 * xq := by
  have hnear := h.xq_near_k
  omega

theorem Claim4PrimeWindowData.xr_above_half
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    k < 2 * xr := by
  have hnear := h.xr_near_k
  omega

/-- All five primes selected by the window contract are automatically in the
medium range needed by the constructed-scale wrapper. -/
theorem Claim4PrimeWindowData.medium_square_bounds
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    k < xp ^ 2 ∧ k < xq ^ 2 ∧ k < xr ^ 2 ∧
      k < yp ^ 2 ∧ k < yq ^ 2 := by
  refine ⟨lt_prime_sq_of_lt_two_mul h.xp_prime h.xp_above_half,
    lt_prime_sq_of_lt_two_mul h.xq_prime h.xq_above_half,
    lt_prime_sq_of_lt_two_mul h.xr_prime h.xr_above_half,
    lt_prime_sq_of_lt_two_mul h.yp_prime h.yp_above_half,
    lt_prime_sq_of_lt_two_mul h.yq_prime h.yq_above_half⟩

/-- The prime-window contract discharges all five exact search-length
inequalities consumed by D3. -/
theorem Claim4PrimeWindowData.search_length_bounds
    {k xp xq xr yp yq : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    claim4TripleXSearchLength k xp xq xr ≤ xp ∧
      claim4TripleXSearchLength k xp xq xr ≤ xq ∧
      claim4TripleXSearchLength k xp xq xr ≤ xr ∧
      claim4PairYSearchLength k yp yq ≤ yp ∧
      claim4PairYSearchLength k yp yq ≤ yq := by
  refine ⟨
    claim4TripleXSearchLength_le_first_of_window
      h.xp_le_k h.xq_le_k h.xr_le_k h.xp_near_k h.xq_near_k h.xr_near_k,
    claim4TripleXSearchLength_le_second_of_window
      h.xp_le_k h.xq_le_k h.xr_le_k h.xp_near_k h.xq_near_k h.xr_near_k,
    claim4TripleXSearchLength_le_third_of_window
      h.xp_le_k h.xq_le_k h.xr_le_k h.xp_near_k h.xq_near_k h.xr_near_k,
    claim4PairYSearchLength_le_left_of_window
      h.yp_le_k h.yq_le_k h.yp_above_half h.yq_above_half
        h.yp_below_two_thirds h.yq_below_two_thirds,
    claim4PairYSearchLength_le_right_of_window
      h.yp_le_k h.yq_le_k h.yp_above_half h.yq_above_half
        h.yp_below_two_thirds h.yq_below_two_thirds⟩

/-- D4c endpoint: once a caller supplies primes in the fixed windows, the
constructed scales feed D3 with no remaining support or search-length
premises.  The later D4 placement layer chooses `startx,starty`. -/
theorem claim4_exists_claim5_residue_interfaces_of_prime_windows
    {k xp xq xr yp yq startx starty : ℕ}
    (h : Claim4PrimeWindowData k xp xq xr yp yq) :
    ∃ zx ∈ Finset.Ico startx
        (startx + claim4TripleXSearchLength k xp xq xr),
      ∃ zy ∈ Finset.Ico starty
          (starty + claim4PairYSearchLength k yp yq),
        Claim5MediumResidues
            (1 + zx * claim4XScale k xp xq xr)
            (zy * claim4YScale k yp yq) k ∧
          Claim5SmallResidues
            (1 + zx * claim4XScale k xp xq xr)
            (zy * claim4YScale k yp yq) k := by
  rcases h.medium_square_bounds with
    ⟨hkxp2, hkxq2, hkxr2, hkyp2, hkyq2⟩
  rcases h.search_length_bounds with
    ⟨hlenxp, hlenxq, hlenxr, hlenyp, hlenyq⟩
  exact claim4_exists_claim5_residue_interfaces_of_constructed_scales
    h.xp_prime h.xq_prime h.xr_prime h.yp_prime h.yq_prime
    hkxp2 hkxq2 hkxr2 hkyp2 hkyq2
    hlenxp hlenxq hlenxr hlenyp hlenyq

end Erdos678
