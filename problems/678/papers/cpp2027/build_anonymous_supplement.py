#!/usr/bin/env python3
"""Build a fail-closed CPP 2027 anonymous supplement from an exact checkout.

The script never sanitizes evidence in place. It collects the formalization source,
the curated reproducibility package, and evidence files reachable from the evidence
index. If configured identity tokens are found in collected text, archive creation
fails so that anonymity is reviewed explicitly rather than silently rewriting data.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import shutil
import sys
import tempfile
import zipfile

DEFAULT_FORBIDDEN = (
    "scientifica007",
    "github.com/scientifica007",
)

TEXT_SUFFIXES = {
    ".lean", ".md", ".json", ".yaml", ".yml", ".toml", ".txt", ".py", ".sh"
}


def repo_root(start: Path) -> Path:
    p = start.resolve()
    for candidate in (p, *p.parents):
        if (candidate / "formalization").is_dir() and (candidate / "problems" / "678").is_dir():
            return candidate
    raise SystemExit("Could not locate repository root")


def expand_path(path: Path) -> list[Path]:
    if path.is_file():
        return [path]
    if path.is_dir():
        return [p for p in path.rglob("*") if p.is_file()]
    return []


def strings(obj):
    if isinstance(obj, str):
        yield obj
    elif isinstance(obj, dict):
        for v in obj.values():
            yield from strings(v)
    elif isinstance(obj, list):
        for v in obj:
            yield from strings(v)


def collect(root: Path) -> list[Path]:
    selected: set[Path] = set()
    fixed = [
        root / "formalization" / "lean-toolchain",
        root / "formalization" / "lakefile.toml",
        root / "formalization" / "lake-manifest.json",
        root / "formalization" / "Formalization" / "Basic.lean",
        root / "formalization" / "Formalization" / "Erdos678",
        root / "problems" / "678" / "reproducible",
        root / "problems" / "678" / "SCIENTIFIC_EVIDENCE_LEDGER.yaml",
    ]
    for item in fixed:
        selected.update(expand_path(item))

    index = root / "problems" / "678" / "reproducible" / "evidence" / "EVIDENCE_INDEX.json"
    if not index.is_file():
        raise SystemExit(f"Missing evidence index: {index}")
    data = json.loads(index.read_text(encoding="utf-8"))
    for value in strings(data):
        rel = Path(value)
        if rel.is_absolute() or ".." in rel.parts:
            continue
        candidate = root / rel
        if not candidate.exists():
            continue
        if tuple(rel.parts[:3]) == ("problems", "678", "papers"):
            continue
        selected.update(expand_path(candidate))

    filtered = []
    for p in selected:
        rel = p.relative_to(root)
        if ".git" in rel.parts or ".lake" in rel.parts:
            continue
        if tuple(rel.parts[:3]) == ("problems", "678", "papers"):
            continue
        filtered.append(p)
    return sorted(set(filtered), key=lambda p: p.as_posix())


def anonymity_scan(paths: list[Path], forbidden: tuple[str, ...]) -> list[tuple[Path, str]]:
    hits = []
    for p in paths:
        if p.suffix.lower() not in TEXT_SUFFIXES and p.name not in {"lean-toolchain"}:
            continue
        try:
            text = p.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        low = text.lower()
        for token in forbidden:
            if token.lower() in low:
                hits.append((p, token))
    return hits


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--output", default="cpp2027-anonymous-supplement.zip")
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--forbid", action="append", default=[])
    args = ap.parse_args()

    root = repo_root(Path(__file__).parent)
    paths = collect(root)
    forbidden = tuple(DEFAULT_FORBIDDEN) + tuple(args.forbid)
    hits = anonymity_scan(paths, forbidden)
    if hits:
        for p, token in hits:
            print(f"ANONYMITY FAIL: {p.relative_to(root)} contains {token!r}", file=sys.stderr)
        return 2

    print(f"selected_files={len(paths)}")
    if args.dry_run:
        for p in paths:
            print(p.relative_to(root).as_posix())
        print("ANONYMITY SCAN PASS")
        return 0

    out = Path(args.output).resolve()
    if out.exists():
        out.unlink()
    with tempfile.TemporaryDirectory() as td:
        staging = Path(td) / "cpp2027-anonymous-supplement"
        for p in paths:
            rel = p.relative_to(root)
            dest = staging / rel
            dest.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(p, dest)
        manifest = {
            "format": "cpp2027-anonymous-supplement-v1",
            "files": [
                {"path": p.relative_to(root).as_posix(), "sha256": sha256(p)}
                for p in paths
            ],
        }
        (staging / "ARCHIVE_FILE_MANIFEST.json").write_text(
            json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8"
        )
        with zipfile.ZipFile(out, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as zf:
            for p in sorted(staging.rglob("*")):
                if p.is_file():
                    zf.write(p, p.relative_to(staging.parent).as_posix())
    print(f"archive={out}")
    print(f"sha256={sha256(out)}")
    print("ANONYMOUS SUPPLEMENT BUILD PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
