# Erdős Problem #1125 — Historical / Modern Reconstruction

## Scope

This file records the post-blind comparison stage. The independent blind attempt has already failed audit and was explicitly revoked. The reference material is therefore now allowed.

## Primary historical source

M. Laczkovich, **On Kemperman's inequality 2f(x) ≤ f(x+h)+f(x+2h)**, *Colloquium Mathematicae* 49 (1984), no. 1, 109–115, DOI 10.4064/cm-49-1-109-115.

EuDML and IMPAN both identify this as the paper solving the monotonicity problem associated with the inequality.

## Historical context

The problem goes back to Kemperman. Kemperman's 1969 work concerns regularity of generalized convex functions and gives positive results under regularity assumptions such as measurability. The Erdős problem asks for the unrestricted real-valued case. Laczkovich's 1984 result resolves the unrestricted case.

## Modern formal reconstruction inspected

A 2026 Lean formalization in `plby/lean-proofs/src/latest/ErdosProblems/Erdos1125.lean` explicitly identifies:

- Informal author: Miklós Laczkovich
- Formal authors: Aristotle and Stefano Rocca

It states that the proof uses:

1. dyadic induction;
2. a covering lemma on `I(α) = {nα+k : n,k∈ℤ}`;
3. interpolation estimates;
4. Pell-sequence approximants for `√2`.

This file is a modern formal reconstruction, not the claim that every line is a transcription of Laczkovich's 1984 exposition.

## Reconstructed proof architecture

### Layer 1 — Finite discrete inequality

For a finite sequence `f : {0,...,n} → ℝ` satisfying

`2 f(i) ≤ f(i+h) + f(i+2h)`,

prove a quantitative endpoint estimate under a uniform bound `|f(i)| ≤ K`.

The formal proof establishes, for example,

`f(0) ≤ f(n) + 10K/n`.

The argument is first developed on powers of two, then on `2^k+1`, and finally on intermediate lengths. Backward propagation and translation are used to transfer the estimate along finite intervals.

### Layer 2 — Covering an irrational additive orbit

For an irrational `α`, define

`I(α) = {n α + k : n,k ∈ ℤ}`.

The key covering lemma constructs, for each cutoff `b` and integer `N≥2`, a finite set `H ⊂ I(α)` whose `N`-step backward closure contains all points of `I(α)` below `b`.

The construction requires controlled rational/integer approximants to `α` with denominators tending to infinity, bounded growth, small errors, and alternating signs.

### Layer 3 — Boundedness / monotonicity on the orbit

If `f` satisfies the original inequality on `I(α)`, the finite covering plus the closure principle gives boundedness above on each left ray `I(α) ∩ (-∞,b]`.

The finite discrete estimate is then interpolated between arbitrary `a<b` in `I(α)`.

The formal proof obtains an estimate of the shape

`g(a) ≤ g(b) + 10K(1/N + 1/(N+1))`,

where `g` is the restricted function and `K` bounds `|g|` on the interval.

Letting `N → ∞` forces `g(a) ≤ g(b)`.

Hence `f` is monotone on `I(α)`.

### Layer 4 — Produce the required irrational number

Take `α = √2`.

The formal proof defines Pell sequences `PellP` and `PellQ`, proves the Pell identities

`PellP(n)^2 - 2 PellQ(n)^2 = (-1)^(n+1)`,

and derives controlled approximants

`|q_j √2 - p_j| ≤ A/q_j`

with alternating signs and controlled denominator growth.

This verifies that `√2` satisfies the abstract approximation hypothesis needed by the orbit argument.

### Layer 5 — Transfer to an arbitrary real interval

For arbitrary `a≤b`, define

`g(x)=f(a+(b-a)x)`.

The inequality is preserved under this affine change of variables. Since `0,1∈I(√2)`, monotonicity on the orbit gives

`g(0) ≤ g(1)`,

hence

`f(a) ≤ f(b)`.

Therefore `f` is monotone non-decreasing on `ℝ`.

## Comparison with our blind attempt

Our blind work found only local phenomena:

- midpoint amplification from a hypothetical descent;
- a negative-increment cascade;
- failure of a fixed arithmetic-progression reduction.

These are compatible with the actual proof architecture but are insufficient because the unrestricted problem requires a mechanism that converts the local inequality into global regularity **without assuming continuity, measurability, or local boundedness**.

The decisive ingredients absent from our blind attempt were:

- quantitative finite-interval endpoint estimates with explicit `O(1/N)` error;
- an irrational additive orbit with enough arithmetic structure;
- a finite covering/closure mechanism on that orbit;
- controlled irrational approximations, concretely supplied by `√2` and Pell convergents;
- an interpolation-and-limit argument that turns bounded local errors into exact monotonicity.

## Status

- Blind phase: terminated after audit failure.
- Candidate proof freeze: **revoked**.
- Historical attribution: verified.
- Modern formal reconstruction: inspected.
- Independent proof of the full theorem: **not obtained**.
- Main lesson for `Erdos_Solving`: for irregular functional inequalities, the research record must distinguish local consequences from global regularity mechanisms.
