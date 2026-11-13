# Dee, musical companion and king!

## Who or what is Dee?

Dee is a Flutter project, capable of building for both iOS and Android.
Dee implements clean architecture, with each `feature` having its own folder.
Inside each feature folder, we have different layers for `presentation`, `data` and `domain`, as well as state management with blocs, nested within `application`
Files that are important to the whole project should be at `lib/core`!

## And what does Dee do?

Dee, for now, has chord progression for each major key

More features are on the way!

## Code coverage

Pull request CI runs the test suite with coverage and compares line coverage for
`lib/features/` against the base branch. A pull request cannot pass this check
if its feature coverage decreases. Run `flutter test --coverage` locally to
generate `coverage/lcov.info`.

