import tempfile
import unittest
from pathlib import Path

from check_feature_coverage import coverage_decreased, feature_coverage


class FeatureCoverageTest(unittest.TestCase):
    def test_counts_covered_lines_only_in_features(self):
        lcov = """\
TN:
SF:lib/features/chord_progression/domain/major_key.dart
DA:1,1
DA:2,0
end_of_record
SF:lib/core/router/app_router.dart
DA:1,0
end_of_record
"""
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "lcov.info"
            path.write_text(lcov, encoding="utf-8")

            self.assertEqual(feature_coverage(path), (1, 2))

    def test_accepts_absolute_source_paths(self):
        lcov = """\
SF:/home/runner/work/app/app/lib/features/home/presentation/main_page.dart
DA:1,1
end_of_record
"""
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "lcov.info"
            path.write_text(lcov, encoding="utf-8")

            self.assertEqual(feature_coverage(path), (1, 1))

    def test_fails_when_lcov_has_no_feature_lines(self):
        lcov = """\
SF:lib/core/router/app_router.dart
DA:1,1
end_of_record
"""
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "lcov.info"
            path.write_text(lcov, encoding="utf-8")

            with self.assertRaisesRegex(ValueError, "no feature lines"):
                feature_coverage(path)

    def test_fails_when_feature_source_is_missing_from_lcov(self):
        lcov = """\
SF:lib/features/home/presentation/main_page.dart
DA:1,1
end_of_record
"""
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "lcov.info"
            feature_root = Path(directory) / "lib" / "features"
            feature_root.joinpath("home/presentation").mkdir(parents=True)
            feature_root.joinpath(
                "home/presentation/main_page.dart"
            ).write_text("void mainPage() {}", encoding="utf-8")
            feature_root.joinpath(
                "home/presentation/new_page.dart"
            ).write_text("void newPage() {}", encoding="utf-8")
            path.write_text(lcov, encoding="utf-8")

            with self.assertRaisesRegex(ValueError, "new_page.dart"):
                feature_coverage(path, feature_root=feature_root)

    def test_detects_decreases_without_rounding_percentages(self):
        self.assertTrue(coverage_decreased((2, 3), (3, 5)))
        self.assertFalse(coverage_decreased((2, 3), (4, 6)))


if __name__ == "__main__":
    unittest.main()
