# Restart 01 — Blind continuation for Erdős Problem #214

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

## Computational exploration

We tested finite configurations consisting of overlapping axis-aligned unit squares and mixtures of rotated unit squares. No infeasible finite color system was found in the tested small configurations.

This is exploratory evidence only and is not a proof of the existence or non-existence of a finite obstruction.

## Current conclusion

No valid candidate proof has been found in Restart 01.

The current central invariants are:

1. Every unit square has one blue vertex, or two opposite blue vertices.
2. Every red unit edge forces the opposite edge of either adjacent unit square to have opposite endpoint colours.

The next search should derive nontrivial propagation cycles from these rules rather than merely enumerate isolated grids.

## Status

Blind mode: ON.
Reference solution accessed: NO.
Candidate proof: NONE.
Proof frozen: NO.
