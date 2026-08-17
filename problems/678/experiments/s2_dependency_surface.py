#!/usr/bin/env python3
"""Reproducible module-level dependency-surface measurement for Erdős #678.

The experiment deliberately separates:
- artifact-owned proof modules;
- repository-local support modules (including comparator-vendored PNT+);
- unresolved/external import frontier.

Module counts are structural packaging metrics, not proof-complexity metrics.
"""

from __future__ import annotations

import argparse
import collections
import json
import pathlib
import re
import subprocess
import tempfile
from dataclasses import dataclass
from typing import Callable, Iterable

COMPARATOR_REPO = "https://github.com/plby/lean-proofs.git"
COMPARATOR_COMMIT = "6f906fef432892db5c910c48ad1a3728dd42cdac"
COMPARATOR_ENTRY_PATH = "src/latest/ErdosProblems/Erdos678.lean"
COMPARATOR_ENTRY_BLOB = "f2331e8bcc71bc36cce7724a0c54fafd8d64d480"
COMPARATOR_SOURCE_PREFIX = "src/latest/"

INTERNAL_ENTRY_MODULE = "Formalization.Erdos678.Erdos678Final"
COMPARATOR_ENTRY_MODULE = "ErdosProblems.Erdos678"


def run(cmd: list[str], *, cwd: pathlib.Path | None = None) -> str:
    proc = subprocess.run(
        cmd,
        cwd=cwd,
        check=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    return proc.stdout.strip()


def strip_lean_comments(text: str) -> str:
    """Strip nested block comments and line comments while preserving newlines."""
    out: list[str] = []
    i = 0
    depth = 0
    n = len(text)
    while i < n:
        if text.startswith("/-", i):
            depth += 1
            out.extend((" ", " "))
            i += 2
            continue
        if depth > 0 and text.startswith("-/", i):
            depth -= 1
            out.extend((" ", " "))
            i += 2
            continue
        if depth == 0 and text.startswith("--", i):
            while i < n and text[i] != "\n":
                out.append(" ")
                i += 1
            continue

        ch = text[i]
        if depth > 0:
            out.append("\n" if ch == "\n" else " ")
        else:
            out.append(ch)
        i += 1
    return "".join(out)


IMPORT_RE = re.compile(r"(?m)^[ \t]*import[ \t]+([^\n]+)$")
DECL_RE = re.compile(
    r"(?m)^[ \t]*(?:(?:private|protected|noncomputable)[ \t]+)*"
    r"(theorem|lemma|def|abbrev|structure|class|instance|inductive)[ \t]+"
)


def parse_imports(text: str) -> list[str]:
    stripped = strip_lean_comments(text)
    result: list[str] = []
    for match in IMPORT_RE.finditer(stripped):
        for token in match.group(1).split():
            if re.fullmatch(r"[A-Za-z0-9_'.]+", token):
                result.append(token)
    return result


def declaration_counts(text: str) -> dict[str, int]:
    stripped = strip_lean_comments(text)
    counter: collections.Counter[str] = collections.Counter()
    for match in DECL_RE.finditer(stripped):
        counter[match.group(1)] += 1
    return dict(sorted(counter.items()))


def source_lines(text: str) -> int:
    return len(text.splitlines()) if text else 0


@dataclass(frozen=True)
class ModuleRecord:
    module: str
    source_id: str
    imports: tuple[str, ...]
    lines: int
    declarations: dict[str, int]
    ownership: str


class SourceProvider:
    def modules(self) -> Iterable[str]:
        raise NotImplementedError

    def read(self, module: str) -> tuple[str, str]:
        """Return (source_id, text)."""
        raise NotImplementedError


class FileSystemProvider(SourceProvider):
    def __init__(self, source_root: pathlib.Path):
        self.source_root = source_root
        self._paths: dict[str, pathlib.Path] = {}
        for path in source_root.rglob("*.lean"):
            rel = path.relative_to(source_root).with_suffix("")
            self._paths[".".join(rel.parts)] = path

    def modules(self) -> Iterable[str]:
        return self._paths.keys()

    def read(self, module: str) -> tuple[str, str]:
        path = self._paths[module]
        return str(path), path.read_text(encoding="utf-8")


class GitTreeProvider(SourceProvider):
    def __init__(
        self,
        *,
        repo_url: str,
        commit: str,
        source_prefix: str,
        expected_entry_path: str,
        expected_entry_blob: str,
    ):
        self.commit = commit
        self.source_prefix = source_prefix.rstrip("/") + "/"
        self._tmp = tempfile.TemporaryDirectory(prefix="erdos678-s2-comparator-")
        self.git_dir = pathlib.Path(self._tmp.name) / "git"
        self.git_dir.mkdir(parents=True)
        run(["git", "init", "-q"], cwd=self.git_dir)
        run(["git", "remote", "add", "origin", repo_url], cwd=self.git_dir)
        run(
            ["git", "fetch", "--depth=1", "--filter=blob:none", "origin", commit],
            cwd=self.git_dir,
        )
        actual_commit = run(["git", "rev-parse", "FETCH_HEAD"], cwd=self.git_dir)
        if actual_commit != commit:
            raise RuntimeError(f"Comparator commit mismatch: {actual_commit} != {commit}")
        actual_blob = run(
            ["git", "rev-parse", f"FETCH_HEAD:{expected_entry_path}"], cwd=self.git_dir
        )
        if actual_blob != expected_entry_blob:
            raise RuntimeError(
                f"Comparator blob mismatch: {actual_blob} != {expected_entry_blob}"
            )

        names = run(
            ["git", "ls-tree", "-r", "--name-only", "FETCH_HEAD", self.source_prefix],
            cwd=self.git_dir,
        )
        self._paths: dict[str, str] = {}
        for raw in names.splitlines():
            if not raw.endswith(".lean"):
                continue
            rel = raw[len(self.source_prefix) : -len(".lean")]
            self._paths[rel.replace("/", ".")] = raw

    def modules(self) -> Iterable[str]:
        return self._paths.keys()

    def read(self, module: str) -> tuple[str, str]:
        path = self._paths[module]
        text = run(["git", "show", f"FETCH_HEAD:{path}"], cwd=self.git_dir)
        return f"{self.commit}:{path}", text

    def close(self) -> None:
        self._tmp.cleanup()


@dataclass
class GraphResult:
    entry: str
    records: dict[str, ModuleRecord]
    local_edges: list[tuple[str, str]]
    external_edges: list[tuple[str, str]]
    direct_imports: list[str]
    max_depth: int


def build_graph(
    provider: SourceProvider,
    entry: str,
    ownership: Callable[[str], str],
) -> GraphResult:
    available = set(provider.modules())
    if entry not in available:
        raise KeyError(f"Entry module {entry!r} not found")

    records: dict[str, ModuleRecord] = {}
    local_edges: list[tuple[str, str]] = []
    external_edges: list[tuple[str, str]] = []
    visiting: set[str] = set()

    def visit(module: str) -> None:
        if module in records:
            return
        if module in visiting:
            raise RuntimeError(f"Import cycle detected at {module}")
        visiting.add(module)
        source_id, text = provider.read(module)
        imports = tuple(parse_imports(text))
        records[module] = ModuleRecord(
            module=module,
            source_id=source_id,
            imports=imports,
            lines=source_lines(text),
            declarations=declaration_counts(text),
            ownership=ownership(module),
        )
        for imported in imports:
            if imported in available:
                local_edges.append((module, imported))
                visit(imported)
            else:
                external_edges.append((module, imported))
        visiting.remove(module)

    visit(entry)

    children: dict[str, list[str]] = collections.defaultdict(list)
    for src, dst in local_edges:
        children[src].append(dst)

    memo: dict[str, int] = {}

    def depth(module: str) -> int:
        if module in memo:
            return memo[module]
        if not children[module]:
            memo[module] = 0
        else:
            memo[module] = 1 + max(depth(child) for child in children[module])
        return memo[module]

    return GraphResult(
        entry=entry,
        records=records,
        local_edges=sorted(set(local_edges)),
        external_edges=sorted(set(external_edges)),
        direct_imports=list(records[entry].imports),
        max_depth=depth(entry),
    )


def summarize(graph: GraphResult) -> dict:
    ownership_counts: collections.Counter[str] = collections.Counter()
    ownership_lines: collections.Counter[str] = collections.Counter()
    ownership_decls: collections.Counter[str] = collections.Counter()

    for rec in graph.records.values():
        ownership_counts[rec.ownership] += 1
        ownership_lines[rec.ownership] += rec.lines
        ownership_decls[rec.ownership] += sum(rec.declarations.values())

    external_modules = sorted({dst for _, dst in graph.external_edges})
    external_families = sorted({m.split(".", 1)[0] for m in external_modules})
    local_sources = {src for src, _ in graph.local_edges}
    local_leaf_count = sum(1 for module in graph.records if module not in local_sources)

    return {
        "entry_module": graph.entry,
        "reachable_local_module_count": len(graph.records),
        "reachable_local_edge_count": len(graph.local_edges),
        "max_local_import_depth": graph.max_depth,
        "local_leaf_module_count": local_leaf_count,
        "direct_entry_imports": graph.direct_imports,
        "direct_entry_import_count": len(graph.direct_imports),
        "external_frontier_modules": external_modules,
        "external_frontier_module_count": len(external_modules),
        "external_frontier_families": external_families,
        "external_frontier_family_count": len(external_families),
        "ownership_module_counts": dict(sorted(ownership_counts.items())),
        "ownership_source_lines": dict(sorted(ownership_lines.items())),
        "ownership_declaration_commands": dict(sorted(ownership_decls.items())),
        "reachable_modules": sorted(graph.records),
        "local_edges": [list(edge) for edge in graph.local_edges],
        "external_edges": [list(edge) for edge in graph.external_edges],
    }


def internal_ownership(module: str) -> str:
    if module.startswith("Formalization.Erdos678"):
        return "artifact_owned"
    return "repository_local_support"


def comparator_ownership(module: str) -> str:
    if module == COMPARATOR_ENTRY_MODULE:
        return "artifact_owned"
    if module.startswith("PrimeNumberTheoremAnd"):
        return "third_party_repository_local_support"
    return "repository_local_support"


def markdown_report(payload: dict) -> str:
    internal = payload["profiles"]["canonical_result"]["internal"]
    comparator = payload["profiles"]["canonical_result"]["comparator"]
    rows = [
        ("reachable local modules", internal["reachable_local_module_count"], comparator["reachable_local_module_count"]),
        ("local import edges", internal["reachable_local_edge_count"], comparator["reachable_local_edge_count"]),
        ("max local import depth", internal["max_local_import_depth"], comparator["max_local_import_depth"]),
        ("external frontier modules", internal["external_frontier_module_count"], comparator["external_frontier_module_count"]),
        ("external frontier families", internal["external_frontier_family_count"], comparator["external_frontier_family_count"]),
        ("artifact-owned modules", internal["ownership_module_counts"].get("artifact_owned", 0), comparator["ownership_module_counts"].get("artifact_owned", 0)),
        ("artifact-owned source lines", internal["ownership_source_lines"].get("artifact_owned", 0), comparator["ownership_source_lines"].get("artifact_owned", 0)),
        ("repository-local third-party support modules", internal["ownership_module_counts"].get("third_party_repository_local_support", 0), comparator["ownership_module_counts"].get("third_party_repository_local_support", 0)),
    ]

    lines = [
        "# Erdős #678 — S2a Dependency-Surface Baseline",
        "",
        "This report measures **module/import structure**, not mathematical proof complexity or architecture quality.",
        "",
        "The comparator source is fetched ephemerally at the pinned commit/blob and is not vendored.",
        "",
        "| Metric | Erdos_Solving | Public comparator |",
        "|---|---:|---:|",
    ]
    for metric, ours, public in rows:
        lines.append(f"| {metric} | {ours} | {public} |")

    lines += [
        "",
        "## Boundary notes",
        "",
        f"- Internal external frontier families: `{', '.join(internal['external_frontier_families'])}`.",
        f"- Comparator external frontier families: `{', '.join(comparator['external_frontier_families'])}`.",
        "- Comparator modules physically present under `src/latest/PrimeNumberTheoremAnd` are counted separately as `third_party_repository_local_support`; they are **not** attributed to the #678 formal authors.",
        "- In Erdos_Solving, PNT+ is an external pinned Lake dependency, so physical-repository module counts are not compared as if packaging were proof complexity.",
        "",
        "## Interpretation rule",
        "",
        "These numbers are a structural baseline only. Any claim about lower coupling, easier maintenance, faster builds, or greater robustness requires the controlled S2 experiments defined in the protocol.",
        "",
    ]
    return "\n".join(lines)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo-root", type=pathlib.Path, default=pathlib.Path.cwd())
    parser.add_argument(
        "--output-json",
        type=pathlib.Path,
        default=pathlib.Path("problems/678/experiments/out/s2_dependency_surface.json"),
    )
    parser.add_argument(
        "--output-md",
        type=pathlib.Path,
        default=pathlib.Path("problems/678/experiments/out/s2_dependency_surface.md"),
    )
    args = parser.parse_args()

    repo_root = args.repo_root.resolve()
    internal_provider = FileSystemProvider(repo_root / "formalization")
    comparator_provider = GitTreeProvider(
        repo_url=COMPARATOR_REPO,
        commit=COMPARATOR_COMMIT,
        source_prefix=COMPARATOR_SOURCE_PREFIX,
        expected_entry_path=COMPARATOR_ENTRY_PATH,
        expected_entry_blob=COMPARATOR_ENTRY_BLOB,
    )
    try:
        internal_graph = build_graph(internal_provider, INTERNAL_ENTRY_MODULE, internal_ownership)
        comparator_graph = build_graph(comparator_provider, COMPARATOR_ENTRY_MODULE, comparator_ownership)

        try:
            internal_head = run(["git", "rev-parse", "HEAD"], cwd=repo_root)
        except subprocess.CalledProcessError:
            internal_head = "unknown"

        payload = {
            "schema_version": 1,
            "experiment": "erdos678-s2a-dependency-surface",
            "metric_scope": "module-import-structure-not-proof-complexity",
            "internal_repository": {
                "repository": "scientifica007/Erdos_Solving",
                "commit": internal_head,
                "entry_module": INTERNAL_ENTRY_MODULE,
            },
            "comparator": {
                "repository": "plby/lean-proofs",
                "commit": COMPARATOR_COMMIT,
                "entry_path": COMPARATOR_ENTRY_PATH,
                "entry_blob": COMPARATOR_ENTRY_BLOB,
                "entry_module": COMPARATOR_ENTRY_MODULE,
                "redistribution": "ephemeral-fetch-only",
            },
            "profiles": {
                "canonical_result": {
                    "internal": summarize(internal_graph),
                    "comparator": summarize(comparator_graph),
                }
            },
            "interpretation_constraints": [
                "Module counts are packaging/structure metrics, not proof-complexity metrics.",
                "Comparator PrimeNumberTheoremAnd modules physically present in its repository are classified as third-party repository-local support.",
                "Internal PrimeNumberTheoremAnd is a pinned external Lake dependency.",
                "No architecture-superiority claim follows from S2a structural counts alone.",
            ],
        }

        args.output_json.parent.mkdir(parents=True, exist_ok=True)
        args.output_md.parent.mkdir(parents=True, exist_ok=True)
        args.output_json.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
        args.output_md.write_text(markdown_report(payload), encoding="utf-8")

        print(json.dumps(payload, indent=2, sort_keys=True))
        print("\n--- S2A_MARKDOWN_REPORT ---\n")
        print(markdown_report(payload))
    finally:
        comparator_provider.close()


if __name__ == "__main__":
    main()
