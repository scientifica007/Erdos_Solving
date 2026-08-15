# problems/

> **Current index synchronized on 2026-08-15.**

This directory contains local research records for nine selected Erdős problems. It is not a mirror of the full upstream database and does not claim that every folder is an active benchmark.

## Current inventory

| Problem | Repository-level research status | Authoritative outcome file |
|---|---|---|
| 18 | known sub-result reconstructed; parent problem not solved | `18/research-log.md` |
| 214 | retracted proof, incomplete restart, then contamination | `214/lessons-learned-v2.md` |
| 225 | inactive; no candidate proof; blind boundary intact | `225/research-log.md` |
| 246 | paused because the copied statement is defective | `246/research-log.md` |
| 275 | completed successful blind cycle and historical comparison | `275/comparison.md` |
| 303 | blind attempt incomplete; reference comparison completed | `303/comparison.md` |
| 447 | contaminated benchmark; not an active blind challenge | `447/README.md` |
| 678 | active Cambie reconstruction in Lean; Claim 5 checked under explicit residue hypotheses; Claim 4 checked through the concrete pair/triple application boxes; connection to the Claim 5 residue interfaces is current; CI green | `678/LEAN_FORMALIZATION_ROADMAP.md` |
| 1125 | blind attempt failed; historical reconstruction completed | `1125/comparison/historical-reconstruction.md` |

## Reading rule

A problem folder may contain stage snapshots whose embedded text was correct at the time, such as `blind mode: ON`, `candidate under audit`, or `restart possible`. Such a file must carry a `HISTORICAL SNAPSHOT` notice once superseded. Use the outcome file listed above for current classification.

## Source principle

Local records are not replacements for the original problem page, primary literature, OEIS, upstream structured data, or external formalization repositories. Any external status should be reverified when a benchmark is resumed.

## Intended structured form

The long-term target remains a structured problem package:

```text
problems/<number>/
  problem.yaml
  statement.md
  literature.md
  research-log.md
  attempts/
  computations/
  formal/
  evidence/
```

This schema is not yet implemented. The current Markdown files are the working record and should not be described as structured source-of-truth data.
