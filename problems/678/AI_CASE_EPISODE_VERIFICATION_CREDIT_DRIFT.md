# Erdős #678 — AI Case Episode: Verification-Credit Drift

## Classification

- scope: archived Erdős #678 scientific evaluation
- episode type: AI-assisted scientific-production / verification methodology
- mathematical content changed: no
- proof theorem invalidated: no
- externally observable evidence only: yes
- hidden chain-of-thought required: no
- current status: correction implemented; final persistent-artifact PR gate awaiting runnable GitHub Actions

## Research significance

A theorem-proving workflow can produce a green CI result while the scientific claim attached to that result is still too strong.

The relevant distinction is:

> **What commit does the CI metadata describe?**

versus

> **What repository tree did the verification process actually execute?**

During the #678 post-archive comparison work, these were found not to be interchangeable for historical pull-request runs.

This episode is useful for AI-for-science research because it demonstrates a failure mode above the tactic/proof level: the formal proof can be correct and the CI can be green, yet the workflow can still overstate the provenance of the verification credit.

## Observable sequence

### E1 — prior project rule

The project had adopted a policy described informally as “exact-head CI before merge.” This was intended to prevent stale verification after a later edit.

The historical GitHub Actions workflow, however, used default pull-request checkout behavior:

```yaml
- uses: actions/checkout@v4
```

No explicit PR-head `ref` was supplied.

### E2 — differential-verification work creates an audit opportunity

During S1 scientific comparison, a new semantic bridge was built and checked. Lean Verification run `32033822601` was associated by GitHub metadata with PR head

`610d525145a8129d345a1d3ce6a6b41809e3d1f8`.

The build succeeded.

### E3 — execution log contradicts the stronger provenance interpretation

Inspection of the checkout log showed the actual checked-out commit was

`5983f901358d8f82d85a425369d429cfa9475f96`,

a synthetic integration-tree merge commit, not literal PR head `610d525...`.

The scientific correction is subtle but important:

- **valid claim:** the PR integration tree built successfully;
- **unsupported stronger claim:** that run literally built PR head `610d525...` by itself.

The green result was not retracted. Its provenance label was narrowed to what the execution evidence actually established.

### E4 — workflow repair

The active S1 branch changes canonical pull-request checkout to:

```yaml
- uses: actions/checkout@v4
  with:
    ref: ${{ github.event.pull_request.head.sha || github.sha }}
```

and records:

```bash
git rev-parse HEAD
```

before the canonical build.

Thus the intended scientific property—verification of the credited PR head—is made executable and observable rather than assumed from metadata.

### E5 — infrastructure failure appears after the repair

When new verification was attempted, GitHub Actions did not start the jobs because the account had a payment/spending-limit condition.

Observed runs:

- `32036454657` — canonical gate attempt;
- `32036454660` — comparison-workflow attempt.

GitHub annotations state that the jobs were not started because of account payment/spending settings. No Lean step executed.

This created a second classification test:

- **CI infrastructure failure:** yes;
- **Lean proof failure:** no;
- **evidence against the successful S1 scientific experiment:** no.

The branch remains unmerged rather than weakening the verification gate.

## Why the mathematical #678 result remains verified

The correction affects the interpretation of some historical **pull-request-event** evidence, not the archived mathematical result itself.

The mathematical merge commit on `main`, `8fd1b20541ac7782f52429db3a2cc4c887547372`, received successful push-triggered post-merge verification in run `32011189766`, with `No update necessary` and 8806 jobs.

The S1 common-environment scientific experiment is also unaffected: run `32028006457` was push-triggered on exact experiment head

`b1e3fc60f6dc4f125a125121a2abbcf3610ed749`,

and its checkout log explicitly matches that head.

## Failure taxonomy extension

### New label: `verification-credit-drift`

Definition:

> The system assigns a stronger statement about *which artifact was verified* than the execution evidence supports, even though the underlying verification process may itself be successful.

This differs from:

- proof failure — Lean rejects the theorem;
- build-graph failure — the theorem is not reachable from the credited target;
- stale-CI failure — a green run predates a later edit;
- documentation drift — prose lags repository state;
- infrastructure failure — verification does not start or complete for external operational reasons.

## Control derived from the episode

A robust verification-credit protocol should record at least:

1. intended commit SHA;
2. actual checked-out SHA from inside the job;
3. canonical target built;
4. import-graph audit result;
5. workflow/run identifier;
6. conclusion;
7. classification of any failure as proof, repository, dependency, or infrastructure failure.

For pull requests, run metadata and badge state are supporting signals; they do not replace execution-level commit provenance.

## AI-assisted-production interpretation

This episode is relevant to AI-assisted science for three reasons.

First, the AI workflow did not merely generate proof code; it audited the epistemic status of its own verification evidence.

Second, the corrective behavior was externally observable and falsifiable: a specific metadata interpretation was compared with a specific checkout log, the discrepancy was recorded, and the workflow was changed.

Third, the system did not respond to a blocked corrected run by weakening the gate or relabeling an infrastructure failure as success. The artifact remains pending integration until the intended check can actually execute.

This supports a broader process hypothesis for later controlled testing:

> AI-assisted formal science needs verification of **provenance claims** as well as verification of mathematical propositions.

That hypothesis is motivated by this episode but is not yet established causally.

## Reusable experimental questions

Future controlled work can ask:

- How often do agents infer exact-artifact verification from CI metadata without checking execution provenance?
- Does an explicit `verified_commit` log field reduce false commit-credit claims?
- Can agents reliably distinguish proof failures from dependency, CI, or account-infrastructure failures?
- Does a provenance audit change downstream decisions such as merge/no-merge?
- Are these effects preserved across GitHub Actions, other CI systems, and local formalization pipelines?

## Evidence links inside this repository

- `CI_VERIFICATION_PROVENANCE_CORRECTION_2026-08-17.md`
- `S1_DIFFERENTIAL_VERIFICATION_RESULT.md`
- `DIFFERENTIAL_VERIFICATION_EVIDENCE.yaml`
- `SCIENTIFIC_EVIDENCE_LEDGER.yaml`
- `.github/workflows/lean.yml` on the active S1 branch

## Claim boundary

This episode supports a documented process failure/correction and motivates future AI-for-science experiments.

It does **not** by itself prove that the project's process controls are superior to alternatives, that AI caused the correction, or that the correction improves outcomes in general. Those claims require prospective controls in Stage S4.

## Scope gate

This episode concerns scientific evaluation of archived #678 only. It does not authorize selection, research, or formalization of another Erdős problem; `DEC-012` remains in force.
