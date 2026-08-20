#!/usr/bin/env python3
"""Fail-closed consistency checks for the Erdős #678 reproducibility package."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

PACKAGE_ROOT = Path(__file__).resolve().parents[1]
REPO_ROOT = PACKAGE_ROOT.parents[2]

errors: list[str] = []


def fail(message: str) -> None:
    errors.append(message)


def load_json(path: Path):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:  # fail closed with a useful diagnostic
        fail(f"cannot parse JSON {path.relative_to(REPO_ROOT)}: {exc}")
        return None


manifest = load_json(PACKAGE_ROOT / "REPRODUCIBILITY_MANIFEST.json")
claims_doc = load_json(PACKAGE_ROOT / "CLAIM_EVIDENCE_MATRIX.json")
evidence_doc = load_json(PACKAGE_ROOT / "evidence" / "EVIDENCE_INDEX.json")
paper1 = load_json(PACKAGE_ROOT / "papers" / "PAPER_1_CLAIMS.json")
paper2 = load_json(PACKAGE_ROOT / "papers" / "PAPER_2_CLAIMS.json")

required_package_paths = [
    "README.md",
    "REPRODUCIBILITY_WORKPLAN.md",
    "REPRODUCIBILITY_MANIFEST.json",
    "CLAIM_EVIDENCE_MATRIX.json",
    "REPRODUCE.md",
    "mathematics/PROBLEM_AND_PROOF_MAP.md",
    "formalization/FORMALIZATION_AND_DEPENDENCIES.md",
    "verification/VERIFICATION_AND_REGRESSIONS.md",
    "evaluation/SCIENTIFIC_EVALUATION_SUMMARY.md",
    "evidence/EVIDENCE_INDEX.json",
    "papers/SHARED_FACT_BASE.md",
    "papers/PAPER_1_CLAIMS.json",
    "papers/PAPER_2_CLAIMS.json",
    "scripts/verify_package.py",
    "scripts/reproduce.sh",
]
for rel in required_package_paths:
    if not (PACKAGE_ROOT / rel).is_file():
        fail(f"missing package path: {rel}")

# The package is a curated view, not a second Lean source tree.
lean_copies = [p.relative_to(PACKAGE_ROOT).as_posix() for p in PACKAGE_ROOT.rglob("*.lean")]
if lean_copies:
    fail(f"duplicated Lean source(s) inside reproducibility package: {lean_copies}")

if manifest:
    if manifest.get("package_id") != "erdos-678-reproducible-research-package":
        fail("unexpected package_id")
    if manifest.get("package_version") != "v1":
        fail("unexpected package_version")
    classification = manifest.get("classification", {})
    if classification.get("mathematical_author") != "Stijn Cambie":
        fail("mathematical attribution drift")
    if classification.get("new_mathematical_proof_claim") is not False:
        fail("new-mathematical-proof claim must remain false")
    if classification.get("first_formalization_claim") is not False:
        fail("first-formalization claim must remain false")

    provenance = manifest.get("verification_provenance", {})
    expected_status_context = provenance.get("exact_main_status_context")
    if expected_status_context != "erdos678/post-merge-verification":
        fail("exact-main status context drift")
    if provenance.get("publish_event") != "push":
        fail("exact-main status must be published only from push events")
    if provenance.get("publish_branch") != "main":
        fail("exact-main status must target main")

    workflow_path = REPO_ROOT / ".github" / "workflows" / "lean.yml"
    if not workflow_path.is_file():
        fail("canonical Lean workflow missing")
    else:
        workflow_text = workflow_path.read_text(encoding="utf-8")
        required_workflow_tokens = [
            "statuses: write",
            "Publish exact-main verification status",
            str(expected_status_context),
            "github.event_name == 'push'",
            "github.ref == 'refs/heads/main'",
            "/statuses/${GITHUB_SHA}",
        ]
        for token in required_workflow_tokens:
            if token not in workflow_text:
                fail(f"exact-main provenance workflow token missing: {token}")

    environment = manifest.get("environment", {})
    expected_toolchain = environment.get("lean_toolchain")
    actual_toolchain_path = REPO_ROOT / "formalization" / "lean-toolchain"
    if not actual_toolchain_path.is_file():
        fail("formalization/lean-toolchain missing")
    else:
        actual_toolchain = actual_toolchain_path.read_text(encoding="utf-8").strip()
        if actual_toolchain != expected_toolchain:
            fail(f"Lean toolchain drift: expected {expected_toolchain!r}, got {actual_toolchain!r}")

    lake_manifest_path = REPO_ROOT / "formalization" / "lake-manifest.json"
    lake_manifest = load_json(lake_manifest_path) if lake_manifest_path.is_file() else None
    if lake_manifest is None:
        if not lake_manifest_path.is_file():
            fail("formalization/lake-manifest.json missing")
    else:
        packages = {p.get("name"): p for p in lake_manifest.get("packages", [])}
        mathlib = packages.get("mathlib")
        pnt = packages.get("PrimeNumberTheoremAnd")
        if not mathlib:
            fail("Mathlib missing from lake-manifest.json")
        else:
            if mathlib.get("inputRev") != environment.get("mathlib_input"):
                fail("Mathlib input revision drift")
            if mathlib.get("rev") != environment.get("mathlib_resolved"):
                fail("Mathlib resolved revision drift")
        if not pnt:
            fail("PrimeNumberTheoremAnd missing from lake-manifest.json")
        elif pnt.get("rev") != environment.get("pnt_plus_resolved"):
            fail("PNT+ resolved revision drift")

    for endpoint in manifest.get("canonical_endpoints", []):
        name = endpoint.get("name")
        rel = endpoint.get("path")
        path = REPO_ROOT / str(rel)
        if not path.is_file():
            fail(f"canonical endpoint file missing: {rel}")
            continue
        text = path.read_text(encoding="utf-8")
        if not re.search(rf"\btheorem\s+{re.escape(str(name))}\b", text):
            fail(f"canonical theorem declaration missing: {name} in {rel}")

    for rel in manifest.get("regression_files", []):
        if not (REPO_ROOT / rel).is_file():
            fail(f"regression file missing: {rel}")

    for rel in manifest.get("evidence_roots", []):
        if not (REPO_ROOT / rel).is_file():
            fail(f"manifest evidence root missing: {rel}")

# Concrete semantic regressions must remain executable source, not prose-only memory.
concrete = REPO_ROOT / "formalization" / "Formalization" / "Erdos678" / "ConcreteTests.lean"
if concrete.is_file():
    concrete_text = concrete.read_text(encoding="utf-8")
    required_tokens = [
        "example : erdosM 36 8 > erdosM 47 9 := by",
        "example : ¬ (erdosM 495 8 > erdosM 504 9) := by",
    ]
    for token in required_tokens:
        if token not in concrete_text:
            fail(f"concrete regression semantic token missing: {token}")
else:
    fail("ConcreteTests.lean missing")

# Claim registry integrity and local evidence existence.
claim_by_id = {}
allowed_classes = {"established", "bounded-observation", "hypothesis", "unsupported"}
if claims_doc:
    for claim in claims_doc.get("claims", []):
        cid = claim.get("id")
        if not cid:
            fail("claim without id")
            continue
        if cid in claim_by_id:
            fail(f"duplicate claim id: {cid}")
        claim_by_id[cid] = claim
        if claim.get("class") not in allowed_classes:
            fail(f"invalid claim class for {cid}: {claim.get('class')}")
        if claim.get("class") == "unsupported" and claim.get("publication_allowed") is not False:
            fail(f"unsupported claim must be publication_allowed=false: {cid}")
        for rel in claim.get("evidence", []):
            if not (REPO_ROOT / rel).exists():
                fail(f"claim evidence path missing for {cid}: {rel}")

# Evidence index paths must resolve locally.
if evidence_doc:
    for item in evidence_doc.get("evidence", []):
        rels = []
        if item.get("path"):
            rels.append(item["path"])
        rels.extend(item.get("paths", []))
        for rel in rels:
            if not (REPO_ROOT / rel).exists():
                fail(f"evidence index path missing for {item.get('id')}: {rel}")


def check_paper(doc, label: str) -> None:
    if not doc:
        return
    for cid in doc.get("claim_ids", []):
        claim = claim_by_id.get(cid)
        if claim is None:
            fail(f"{label} references unknown claim id: {cid}")
        elif claim.get("publication_allowed") is not True:
            fail(f"{label} allowlist references non-publishable claim: {cid}")
    for cid in doc.get("discussion_only_hypotheses", []):
        claim = claim_by_id.get(cid)
        if claim is None:
            fail(f"{label} references unknown hypothesis: {cid}")
        elif claim.get("class") != "hypothesis":
            fail(f"{label} discussion-only id is not hypothesis class: {cid}")
    for cid in doc.get("prohibited_claim_ids", []):
        claim = claim_by_id.get(cid)
        if claim is None:
            fail(f"{label} references unknown prohibited claim: {cid}")
        elif claim.get("publication_allowed") is not False:
            fail(f"{label} prohibited claim is not publication_allowed=false: {cid}")


check_paper(paper1, "Paper 1")
check_paper(paper2, "Paper 2")

if errors:
    print("ERDOS678 PACKAGE VERIFICATION FAILED", file=sys.stderr)
    for error in errors:
        print(f"- {error}", file=sys.stderr)
    raise SystemExit(1)

print("ERDOS678 PACKAGE VERIFICATION PASS")
print(f"package_root={PACKAGE_ROOT}")
print(f"repo_root={REPO_ROOT}")
print(f"claims={len(claim_by_id)}")
