# Lessons Learned — Erdős Problem #214

> **SUPERSEDED LESSON SNAPSHOT.** This file records lessons from the first retraction. The complete and authoritative postmortem, including the later contamination event, is `lessons-learned-v2.md`.

## Experiment classification

- Blind attempt: FAILED
- Candidate proof: RETRACTED
- Audit: FAILED
- Proof freeze: REVOKED
- Reference solution: not used to discover the failure

## L-214-001 — Geometric correctness does not imply monochromatic correctness

We correctly constructed four points forming a unit square, but one of the vertices was the distinguished point p ∈ S. Therefore the square was not contained in the complement.

Reusable rule: whenever a proof claims that a configuration is monochromatic, audit the color/state of every vertex or constituent explicitly. Checking distances or incidence relations is not enough.

## L-214-002 — Color-pattern auditing must be an explicit audit gate

The failed proof implicitly moved from “three vertices are outside S” to “the four vertices are outside S”. This is a direct color-pattern error.

Reusable rule: for every claimed monochromatic object, record a color table before acceptance:

| Constituent | Required color | Proven color |
|---|---|---|
| v1 | red | ... |
| v2 | red | ... |
| v3 | red | ... |
| v4 | red | ... |

The proof cannot pass audit until every row is justified.

## L-214-003 — Distinguish a useful geometric lemma from an invalid global inference

The fact that p, p+u, p+v, p+u+v form a unit square is correct. The inference from q outside S to a red square is false. A valid local construction can therefore coexist with an invalid global argument.

Reusable rule: audit implications separately from the construction that precedes them.

## L-214-004 — Freeze status is reversible

A proof may be frozen provisionally only under the project's process, but a later audit can revoke the freeze. The original candidate must remain in Git history, and the retraction must identify the exact logical failure.

## L-214-005 — Coloring problems require a specialized audit checklist

For Ramsey/coloring problems, audit at least:

1. the color of every constituent;
2. whether “not in S” really equals the claimed color;
3. whether a configuration has any mixed-color vertices;
4. whether the conclusion requires all vertices or only a subset;
5. whether a distinguished anchor point has been accidentally included in a monochromatic target.

## L-214-006 — Benchmark #214 exposed an audit blind spot, not a merely difficult proof

The main lesson is methodological rather than geometric: our first audit was strong on metric identities and weak on semantic state/color invariants. The audit protocol must therefore include domain/color/state invariants alongside algebraic and geometric checks.
