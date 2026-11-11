# Dee Music Jam Review Findings

## Summary

I found 2 actionable issues in the current codebase.

## 1) Navigation breaks for keys containing URL-reserved characters

- Severity: High
- Files:
  - lib/core/router/app_router.dart
  - lib/features/chord_progression/presentation/widgets/major_key_tile.dart
- Problem:
  Route parameters are constructed with raw key names and no URL encoding. The app builds paths like `/chord-progression/F#`, but `#` is a reserved URL fragment separator; when parsed, the path is effectively `/chord-progression/F`, so the `:key` route never matches the intended value. This breaks navigation for any key containing reserved URL characters such as `F#` and can also affect other characters in the future.
- Trigger:
  Any key tile that uses a key name with a reserved URI character when pushing its detail page.

## 2) Test suite is asserting stale UI text and no longer matches the app

- Severity: Medium
- Files:
  - test/navigation_test.dart
  - lib/features/home/presentation/main_page.dart
- Problem:
  The tests assert that the home screen contains the text “Guitar Practice,” but the current app renders “Dee, your guitar helper.” The suite fails immediately and no longer validates the current UI state, which risks hiding real regressions.
- Trigger:
  Running `flutter test` or relying on the current page title/back-navigation assertions.

## Validation

- `flutter analyze` passed with no static issues.
- `flutter test` failed with 1 failing test, specifically the stale title assertion in test/navigation_test.dart.
