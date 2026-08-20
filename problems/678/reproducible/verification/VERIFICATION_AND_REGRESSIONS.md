# Erdős #678 — Verification, Statement Fidelity, and Regressions

## Verification is a layered claim

For this project, "machine checked" means more than a theorem declaration existing in a file. Credited verification requires a reachable canonical build and correct provenance for the commit being credited.

The reproducibility package therefore separates:

1. mathematical statement fidelity;
2. local concrete regressions;
3. canonical import-graph reachability;
4. full Lean build;
5. exact-head / exact-main CI provenance;
6. differential verification against the pinned public comparator.

## Statement fidelity

The internal definition `erdosM n k` represents the LCM of the `k` integers beginning at `n+1`.

`ExternalStatementBridge.lean` proves the extensional identity with the public half-open interval convention:

`erdosM n k = (Finset.Ioc n (n + k)).lcm id`.

The public-style eventual nonemptiness endpoint is then proved from the repository's own final theorem rather than copied from the comparator.

This prevents a green proof of a shifted or differently indexed statement from being mistaken for #678.

## Positive regression

`ConcreteTests.lean` retains the genuine explicit witness:

`erdosM 36 8 > erdosM 47 9`.

It also defines the two sides using explicit nested `Nat.lcm` expressions, giving a small arithmetic oracle independent of the interval abstraction.

The witness is a semantic test, not the infinitude mechanism.

## Negative regression

The rejected candidate is retained as:

`¬ (erdosM 495 8 > erdosM 504 9)`.

This preserves a falsified early trajectory as executable knowledge. Reproduction is considered incomplete if this regression disappears or flips silently.

## Final endpoint regressions

`Erdos678FinalTests.lean` reuses:

- `erdos678_unbounded_witnesses`;
- `erdos678_good_lengths_infinite`.

These tests ensure that the final theorem interface remains usable in exactly the benchmark form expected downstream.

## Bridge regressions and axiom audit

`ExternalStatementBridgeTests.lean` checks:

- concrete interval equivalence;
- public valid-pair unboundedness;
- infinite good lengths under the public predicate;
- a real-factor strong theorem instance;
- printed axioms for the selected public-facing endpoints.

## Historical canonical verification

The closed formalization roadmap records the mathematical integration and post-merge rebuild. Later S1/S2 work increased the reachable graph to the 8808-job reference build retained by the scientific evidence ledger.

The job count is historical reference metadata. The reproducibility invariant is that the exact checked-out graph is synchronized and builds successfully under its pinned dependencies.

## Machine-readable exact-main verification status

The canonical workflow publishes a commit status on the exact `main` SHA for every `push` to `main` under the context:

`erdos678/post-merge-verification`

The status is emitted only after the workflow has attempted the package validator and canonical Lean verification path. Its semantics are:

- `success` — the reproducibility-package validator, `lake exe mk_all --check`, and the full `Formalization` build all succeeded for that exact `main` SHA;
- `failure` — an earlier required verification step failed;
- absent — no post-merge verification credit should be inferred.

The status `target_url` points to the exact GitHub Actions run that produced the status. This makes exact-main verification readable from commit-status APIs even when a client cannot enumerate `push`-triggered workflow runs directly.

`REPRODUCIBILITY_MANIFEST.json` records this context, and `scripts/verify_package.py` checks that the workflow still has `statuses: write`, still publishes this exact context, and still restricts publication to `push` events on `main`.

## Differential verification

S1 compares the internal artifact with a pinned public Aristotle/Boris Alexeev artifact in a controlled common environment.

What this supports:

- both selected artifacts compile under the controlled setup;
- statement bridges make the compared endpoints semantically explicit;
- selected endpoint axiom footprints were audited;
- the internal artifact is independently structured at source level.

What this does **not** support:

- new mathematical authorship;
- first formalization priority;
- genealogical independence beyond recorded evidence;
- general proof-architecture superiority.

## Verification-credit correction lesson

The #678 record contains a correction episode where a green run supported a weaker provenance claim than initially implied. The durable rule is:

`green computation + wrong provenance attribution ≠ valid verification credit`.

Pre-merge credit is attached to the exact PR head. Integration credit is attached to the exact resulting `main` commit after merge and rebuild.
