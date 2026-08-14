# Lessons Learned — Erdős Problem #214

> **HISTORICAL APPENDIX — SUPERSEDED FOR FINAL BENCHMARK STATUS.** These retraction lessons remain valid; the later contamination and terminal classification are recorded in `problems/214/lessons-learned-v2.md` and `LESSONS_LEARNED_214_ADDENDUM.md`.

- Blind attempt: FAILED.
- Candidate proof: RETRACTED.
- Audit: FAILED.
- Proof freeze: REVOKED.

## Core lesson

Geometric correctness does not imply monochromatic correctness. The constructed unit square had a vertex p ∈ S, so it was not contained in the complement.

## Protocol changes

1. Every coloring/Ramsey proof must audit the color/state of every constituent of every claimed monochromatic configuration.
2. Structural correctness and color correctness are separate proof obligations.
3. A valid local construction does not validate the global implication that follows from it.
4. When a freeze is revoked, preserve the failed artifact and record the exact logical fault.
5. Domain-sensitive audit is mandatory: coloring problems need a color-pattern audit in addition to algebraic/geometric checks.
