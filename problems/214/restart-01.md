# Restart 01 — Blind continuation for Erdős Problem #214

Reference solution, historical paper, discussion, and formal proof have not been consulted during this restart.

## Scope

The earlier candidate `PATH-214-A` was retracted because its claimed red square contained a point of S. This restart explicitly avoids that mistake.

## Search direction

Reformulate as a 2-colouring: blue = S, red = complement. Blue has no unit-distance pair; every unit square must contain at least one blue point if no red unit square exists.

A stronger consequence is now established:

### LEMMA-214-R1-001 — Exact one-blue-per-unit-square

Under the assumption that there is no red unit square, every unit square contains exactly one blue vertex.

Proof: it contains at least one blue vertex. It cannot contain two blue vertices, because any two distinct vertices of a unit square that are adjacent are distance 1, while the two diagonal vertices are distance sqrt(2); hence the only possible pair of blue vertices in a unit square would have to be adjacent, contradicting the defining property of S. Therefore exactly one vertex is blue. 

## Computational exploration

We tested finite configurations consisting of overlapping axis-aligned unit squares and mixtures of rotated unit squares. No infeasible finite color system was found in the tested small configurations.

This is exploratory evidence only and is not a proof of the existence or non-existence of a finite obstruction.

## Current conclusion

No valid candidate proof has been found in Restart 01.

The exact-one-blue-per-unit-square reformulation is the current central invariant. The next search should derive propagation rules from overlapping squares rather than merely enumerate small grids.

## Status

Blind mode: ON.
Reference solution accessed: NO.
Candidate proof: NONE.
Proof frozen: NO.
