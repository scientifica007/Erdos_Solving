# Restart 01 — Blind continuation for Erdős Problem #214

> **HISTORICAL SNAPSHOT — DO NOT RESUME FROM THIS FILE.** Blind mode was on during this restart, but later external-context contamination terminated the experiment. The authoritative final outcome is `lessons-learned-v2.md`.

Reference solution, historical paper, discussion, and formal proof have not been consulted during this restart.

## Scope

The earlier candidate `PATH-214-A` was retracted because its claimed red square contained a point of S. This restart explicitly avoids that mistake.

## Search direction

Reformulate as a 2-colouring: blue = S, red = complement. Blue has no unit-distance pair; every unit square must contain at least one blue point if no red unit square exists.

### LEMMA-214-R1-001 — Correct constraint on blue vertices of a unit square

Under the assumption that there is no red unit square, every unit square contains at least one blue vertex. Since S has no pair at distance 1, a unit square cannot contain three or four blue vertices, because among any three vertices of a square there are two adjacent vertices at distance 1. If a unit square contains two blue vertices, they must be the two opposite diagonal vertices, whose distance is sqrt(2).

Therefore every unit square contains either one blue vertex, or two blue vertices which are opposite each other.

This is a valid invariant. The previously recorded claim "exactly one blue vertex" was false because opposite vertices may both lie in S; that error has been corrected in this file.

### LEMMA-214-R1-002 — Red edge forces opposite-edge colour alternation

Assume x and y are red and |x-y|=1. Let u be either of the two unit vectors perpendicular to y-x. Then x+u and y+u are the other two vertices of a unit square on the red edge xy. They are themselves at distance 1, so they cannot both be blue. Since x and y are red and we are assuming there is no red unit square, at least one of x+u and y+u must be blue. Hence exactly one of x+u and y+u is blue.

Thus every red unit edge induces an opposite edge whose two endpoints have opposite colours. This is a genuine propagation rule and may be iterated through overlapping unit squares.

### LEMMA-214-R1-003 — Blue point forces its unit circle to be red

If p is blue, then every point x with |x-p|=1 is red, directly from the defining condition that S contains no two points at distance 1.

Attempts to push this immediately to a larger concentric circle do not work: for q with |q-p|=sqrt(3), the obvious square-completion constructions do not force a unique colour for q. No radius-sqrt(3) colouring conclusion is recorded.

## Computational exploration

We generated finite point configurations from unit steps in the eight directions at multiples of 45 degrees, and encoded the constraints: no unit-distance pair may both be blue, and every unit square must contain a blue vertex. Configurations with 41 points / 8 square constraints and 129 points / 56 square constraints were both satisfiable. We then tested unions of several small square lattices with rotations (including 30, 45, 60, and 90 degrees) and translations; the resulting finite systems were also feasible under the same constraints. In an additional randomized check, 50 unions of two 5x5 square grids with varied rotation angles and translations were all finitely feasible under the same constraints.

These are finite satisfiability results only; they do not imply global colourability or non-colourability.

The experiments show that simple regular or nearly regular local grids do not immediately expose the required obstruction. Any eventual finite obstruction is likely to require a richer configuration or a different structural argument.

## Current conclusion

No valid candidate proof has been found in Restart 01.

The current central invariants are:

1. Every unit square has one blue vertex, or two opposite blue vertices.
2. Every red unit edge forces the opposite edge of either adjacent unit square to have opposite endpoint colours.
3. Every blue point has a full red unit circle around it.

The next search should derive nontrivial propagation cycles from these rules rather than merely enumerate isolated grids.

## Historical status at the time of Restart 01

Blind mode at this checkpoint: ON.
Reference solution accessed at this checkpoint: NO.
Candidate proof: NONE.
Proof frozen: NO.

Final repository status after later events: **INCONCLUSIVE / CONTAMINATED; blind mode terminated.**
