#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"

printf '%s\n' '== Erdős #678 reproducibility package =='
printf 'repository=%s\n' "$REPO_ROOT"
printf '%s\n' '-- validating package metadata and source references'
python3 "$SCRIPT_DIR/verify_package.py"

printf '%s\n' '-- checking canonical Lean import graph'
cd "$REPO_ROOT/formalization"
lake exe mk_all --check

printf '%s\n' '-- building canonical Lean graph'
lake build Formalization

printf '%s\n' 'ERDOS678 REPRODUCTION SUCCESS'
