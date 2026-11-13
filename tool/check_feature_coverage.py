#!/usr/bin/env python3

from __future__ import annotations

import argparse
from pathlib import Path
import sys


def _feature_source_path(source: str) -> str | None:
    parts = source.replace("\\", "/").split("/")
    for index in range(len(parts) - 1):
        if parts[index : index + 2] == ["lib", "features"]:
            return "/".join(parts[index:])
    return None


def feature_coverage(
    lcov_path: Path, *, feature_root: Path | None = None
) -> tuple[int, int]:
    line_hits: dict[tuple[str, int], int] = {}
    feature_sources: set[str] = set()
    source: str | None = None

    with lcov_path.open(encoding="utf-8") as lcov_file:
        for raw_line in lcov_file:
            line = raw_line.strip()
            if line.startswith("SF:"):
                source = _feature_source_path(line[3:])
                if source is not None:
                    feature_sources.add(source)
            elif line.startswith("DA:") and source is not None:
                details = line[3:].split(",")
                if len(details) < 2:
                    raise ValueError(f"invalid line coverage entry: {line}")
                try:
                    line_number, hits = int(details[0]), int(details[1])
                except ValueError as error:
                    raise ValueError(f"invalid line coverage entry: {line}") from error
                key = (source, line_number)
                line_hits[key] = max(line_hits.get(key, 0), hits)

    if not line_hits:
        raise ValueError(f"{lcov_path} contains no feature lines")

    if feature_root is not None:
        expected_sources = {
            f"lib/features/{path.relative_to(feature_root).as_posix()}"
            for path in feature_root.rglob("*.dart")
        }
        missing_sources = sorted(expected_sources - feature_sources)
        if missing_sources:
            missing_list = ", ".join(missing_sources)
            raise ValueError(f"{lcov_path} is missing feature sources: {missing_list}")

    covered_lines = sum(hits > 0 for hits in line_hits.values())
    return covered_lines, len(line_hits)


def coverage_decreased(
    baseline: tuple[int, int], current: tuple[int, int]
) -> bool:
    baseline_covered, baseline_total = baseline
    current_covered, current_total = current
    return current_covered * baseline_total < baseline_covered * current_total


def _format_coverage(coverage: tuple[int, int]) -> str:
    covered, total = coverage
    return f"{covered}/{total} ({covered / total:.2%})"


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Fail when lib/features line coverage decreases."
    )
    parser.add_argument("baseline", type=Path, help="baseline LCOV report")
    parser.add_argument("current", type=Path, help="current LCOV report")
    arguments = parser.parse_args()

    try:
        baseline = feature_coverage(arguments.baseline)
        feature_root = Path(__file__).resolve().parents[1] / "lib" / "features"
        current = feature_coverage(arguments.current, feature_root=feature_root)
    except (OSError, ValueError) as error:
        parser.error(str(error))

    print(f"Base feature coverage: {_format_coverage(baseline)}")
    print(f"PR feature coverage:   {_format_coverage(current)}")

    if coverage_decreased(baseline, current):
        print("Feature coverage decreased; add tests before merging.", file=sys.stderr)
        return 1

    print("Feature coverage did not decrease.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
