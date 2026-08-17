# Erdős #678 — CI verification provenance correction (2026-08-17)

## Purpose

This note records a verification-credit correction discovered during the post-archive scientific-comparison work on Erdős #678.

It does **not** change the mathematical theorem or invalidate the successful post-merge verification of the archived result. It tightens how pull-request CI evidence is classified.

## What was discovered

The historical `Lean Verification` workflow used the default

```yaml
- uses: actions/checkout@v4
```

for both `push` and `pull_request` events.

During a later S1 comparison run, GitHub run metadata identified the pull-request head, but the checkout log showed that the job actually built GitHub's synthetic pull-request merge ref rather than the literal PR head commit.

Concrete example:

- pull-request head metadata: `610d525145a8129d345a1d3ce6a6b41809e3d1f8`;
- Lean Verification run: `32033822601`;
- actual checked-out commit in the job log: `5983f901358d8f82d85a425369d429cfa9475f96`;
- base at that experiment: `0d8287bc5fcc41ed4dc7ea68e5d27cd0091b8d5e`.

The build itself succeeded, including `No update necessary`, 8808 jobs, and the S1 semantic-bridge axiom audits. The correction concerns **which tree received verification credit**, not whether that integration tree built.

## Correct classification

A successful PR-event run using the default checkout should be described as:

> successful verification of the PR integration tree / synthetic merge ref

unless its checkout log explicitly proves that the literal PR head was checked out.

A run's `head_sha` metadata alone is insufficient evidence for literal exact-head checkout.

## Workflow repair

The canonical workflow on the active S1 branch now uses:

```yaml
- uses: actions/checkout@v4
  with:
    ref: ${{ github.event.pull_request.head.sha || github.sha }}
```

and records:

```text
git rev-parse HEAD
```

before the canonical build.

Future PR exact-head credit therefore requires the execution log to identify the same commit that is being credited.

## Effect on previous #678 claims

The mathematical #678 artifact remains machine-checked and integrated because the merged `main` commits received successful push-triggered post-merge verification, including the mathematical integration run `32011189766`. On a `push` event to `main`, the checked-out tree is the pushed commit itself.

However, older prose that called every historical PR-event run “exact-head” should be read cautiously unless the corresponding checkout log was audited. The project will not retroactively infer literal head checkout merely from GitHub metadata.

## Relation to the S1 differential experiment

The strongest S1 external-comparison experiment is **not affected** by this correction.

Run `32028006457` was a `push`-triggered temporary experiment on exact experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`.

Its log explicitly checked out that commit, then:

- built the internal canonical graph (`No update necessary`, 8808 jobs);
- compiled the pinned public comparator source unchanged in the same pinned Lake environment;
- produced matching selected-endpoint axiom footprints consisting only of `propext`, `Classical.choice`, and `Quot.sound`.

Thus the scientific S1 result remains valid while the final PR integration gate is made stricter.

## Current infrastructure blocker

After the workflow correction was prepared, new GitHub Actions jobs could not start because GitHub reported an account billing/spending-limit condition. Two attempted S1 verification runs were stopped before any Lean step:

- canonical run `32036454657`;
- differential-run attempt `32036454660`.

GitHub's check annotation states that the jobs were not started because recent account payments failed or the spending limit needs to be increased.

These runs are classified as **CI infrastructure failures**, not Lean failures and not evidence against either formalization.

The active S1 PR must remain unmerged until the billing/spending condition is resolved and the commit-explicit canonical PR gate can run successfully.

## AI-assisted scientific-production lesson

This episode adds a distinct failure class to the #678 process record:

**verification-credit drift** — the system had stronger language about what a CI run verified than the execution evidence justified.

The corrective pattern is:

1. inspect execution logs, not only run metadata;
2. identify the commit actually checked out;
3. reclassify historical evidence without hiding the discrepancy;
4. repair the workflow so the intended property is executable;
5. distinguish infrastructure failure from proof failure.

Reusable rule:

> Verification credit belongs to the commit/tree actually executed. Metadata labels, PR head fields, and a green badge are supporting evidence, not substitutes for explicit checkout provenance.

## Scope

This correction concerns the archived #678 artifact and its scientific evaluation only. It does not authorize work on another Erdős problem; `DEC-012` remains in force.
