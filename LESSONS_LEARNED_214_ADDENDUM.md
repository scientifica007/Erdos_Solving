# Project Lessons Addendum — Erdős Problem #214

These lessons supplement `LESSONS_LEARNED.md` and are derived from the complete #214 experiment.

## New protocol rules

### P-214-01 — Color-pattern audit is mandatory
Every Ramsey/coloring candidate must include an explicit constituent-by-constituent color audit. A geometrically correct configuration is not enough.

### P-214-02 — Minimal-counterconfiguration test for every invariant
Before promoting a new invariant to “established”, search for the smallest configuration that could falsify it. The false “exactly one blue vertex per square” claim would have failed immediately on opposite diagonal vertices.

### P-214-03 — Separate proof levels
Every research statement must be tagged as one of:
`local lemma`, `propagation rule`, `finite CSP observation`, `finite obstruction`, `global theorem`.
No upward promotion is allowed without a proof of the missing implication.

### P-214-04 — Diminishing-return boundary
When repeated finite searches over a configuration family remain satisfiable, record the boundary and change representation instead of merely increasing the same family.

### P-214-05 — Blind isolation is a hard constraint
During blind mode, no external web search, historical paper, target discussion, or target-specific theorem lookup may be used if it can reveal the solution architecture. A “general theorem search” is not automatically safe.

### P-214-06 — Contamination is terminal
If target-specific information is exposed before freeze, set:
`blind_mode = TERMINATED`
`final_classification = INCONCLUSIVE / CONTAMINATED`
Do not retroactively call later work independent.

### P-214-07 — Restart chronology is immutable
A restart must be recorded separately from the original failed attempt. Failed material remains available for provenance.

### P-214-08 — Freeze is conditional on adversarial audit
A proof is not frozen merely because a file says “FROZEN”. Freeze requires a successful adversarial audit, including semantic/color/domain checks.

## Benchmark interpretation

#214 should be retained as a canonical process-failure benchmark:

`invalid candidate → inadequate audit → retraction → corrected restart → finite-search saturation → contamination → blind termination`.
