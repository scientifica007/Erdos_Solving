# S2a Closure Note — 2026-08-17

S2a (dependency-surface baseline) is scientifically complete and machine-verified.

Evidence chain:

- experiment commit: `4685fca552ae4a0270dfa3823d46fde48efa5ade`;
- experiment run/job: `32047324807` / `95438118197` — SUCCESS;
- evidence artifact digest: `sha256:9723b6e2f9a37757c535bdcd16c424869560a3f1d80d55ad0b1e22053f9812fd`;
- integration PR: #28;
- exact PR head: `3d4e35c15eb07938dfcb3fb5de29e8d51f1e767e`;
- exact-head canonical run: `32047808010` — SUCCESS;
- merge commit: `37deb850f894d32863970aca6b07e876f89e813d`;
- post-merge canonical run: `32048513043` — SUCCESS;
- post-merge provenance: `verified_commit=37deb850f894d32863970aca6b07e876f89e813d`;
- import graph check: `No update necessary`;
- canonical build: `8808 jobs`.

Scientific conclusion retained from S2a: dependency-surface counts are boundary-sensitive. The internal artifact consumes PNT+ as an external Lake dependency, while the comparator carries reachable PNT+ source inside its repository. Raw module/file/frontier counts therefore conflate proof decomposition, dependency packaging, and ownership and are not proof-complexity or architecture-superiority measures.

This note does not alter the mathematics or Lean theorem source. Its purpose is to make the transition to S2b auditable under DEC-008/DEC-011. S2b may start only after this documentation-only closure branch itself passes canonical exact-head CI, merges, and `main` verifies.

`DEC-012` remains in force: no other Erdős problem is authorized.
