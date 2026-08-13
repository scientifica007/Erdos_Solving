# Restart 01 — Blind continuation for Erdős Problem #214

Reference solution, historical paper, discussion, and formal proof have not been consulted during this restart.

## Scope

The earlier candidate `PATH-214-A` was retracted because its claimed red square contained a point of S. This restart explicitly avoids that mistake.

## Search direction

Reformulate as a 2-colouring: blue = S, red = complement. Blue has no unit-distance pair; every unit square must contain at least one blue point if no red unit square exists.

### LEMMA-214-R1-001 — Exact constraint on blue vertices of a unit square

Under the assumption that there is no red unit square, every unit square contains at least one blue vertex. Since S has no pair at distance 1, a unit square cannot contain three or four blue vertices, because among any three vertices of a square there are two adjacent vertices at distance 1. If a unit square contains two blue vertices, they must be the two opposite diagonal vertices, whose distance is sqrt(2).

Therefore every unit square contains either one blue vertex, or two blue vertices which are opposite each other.

This is a valid invariant; the previously recorded claim "exactly one blue vertex" was false because opposite vertices may both lie in S.

## Computational exploration

We tested finite configurations consisting of overlapping axis-aligned unit squares and mixtures of rotated unit squares. No infeasible finite color system was found in the tested small configurations.

This is exploratory evidence only and is not a proof of the existence or non-existence of a finite obstruction.

## Current conclusion

No valid candidate proof has been found in Restart 01.

The current central invariant is the restricted pattern of blue vertices on every unit square: one blue vertex, or two opposite blue vertices. The next search should derive propagation rules from overlapping squares rather than merely enumerate small grids.

## Status

Blind mode: ON.
Reference solution accessed: NO.
Candidate proof: NONE.
Proof frozen: NO.
