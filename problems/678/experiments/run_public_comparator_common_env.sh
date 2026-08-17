#!/usr/bin/env bash
set -euo pipefail

# Compile the public Aristotle/Alexeev Erdős #678 source in this repository's
# pinned Lean/Mathlib/PNT+ environment without copying that source into the
# repository.  The blob SHA makes the external input immutable and auditable.

COMPARATOR_REPO="${COMPARATOR_REPO:-https://github.com/plby/lean-proofs.git}"
COMPARATOR_COMMIT="${COMPARATOR_COMMIT:-6f906fef432892db5c910c48ad1a3728dd42cdac}"
COMPARATOR_BLOB="${COMPARATOR_BLOB:-f2331e8bcc71bc36cce7724a0c54fafd8d64d480}"
COMPARATOR_PATH="src/latest/ErdosProblems/Erdos678.lean"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
WORK="${RUNNER_TEMP:-${TMPDIR:-/tmp}}/erdos678-public-comparator"
GITDIR="$WORK/git"
SOURCE="$WORK/Erdos678Comparator.lean"

rm -rf "$WORK"
mkdir -p "$GITDIR"

git -C "$GITDIR" init -q
git -C "$GITDIR" remote add origin "$COMPARATOR_REPO"
git -C "$GITDIR" fetch --depth=1 --filter=blob:none origin "$COMPARATOR_COMMIT"

actual_commit="$(git -C "$GITDIR" rev-parse FETCH_HEAD)"
actual_blob="$(git -C "$GITDIR" rev-parse "FETCH_HEAD:$COMPARATOR_PATH")"

echo "Comparator commit: $actual_commit"
echo "Comparator blob:   $actual_blob"
echo "Expected commit:   $COMPARATOR_COMMIT"
echo "Expected blob:     $COMPARATOR_BLOB"

test "$actual_commit" = "$COMPARATOR_COMMIT"
test "$actual_blob" = "$COMPARATOR_BLOB"

git -C "$GITDIR" show "FETCH_HEAD:$COMPARATOR_PATH" > "$SOURCE"

cd "$ROOT/formalization"
echo "Compiling public comparator in Erdos_Solving pinned Lake environment..."
lake env lean "$SOURCE"
