import 'package:dee_music_jam/core/router/app_router.dart';
import 'package:dee_music_jam/features/chord_progression/domain/major_key.dart';
import 'package:dee_music_jam/features/chord_progression/presentation/widgets/major_key_tile.dart';
import 'package:dee_music_jam/main.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('opens chord progression and returns to the home page', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.text('Chord Progression'));
    await tester.pumpAndSettle();

    expect(find.text('Major keys'), findsOneWidget);
    expect(find.byKey(const ValueKey('major-key-G')), findsOneWidget);
    expect(find.text('Dee, your guitar helper'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Dee, your guitar helper'), findsOneWidget);
  });

  testWidgets('keeps reserved URL characters when navigating to a key detail', (
    tester,
  ) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(
            body: MajorKeyTile(keyData: MajorKey(name: 'F#')),
          ),
        ),
        GoRoute(
          path: AppRouter.harmonicFieldPath,
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(
                '${Uri.decodeComponent(state.pathParameters['key'] ?? '')} Major',
              ),
            ),
          ),
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    await tester.tap(find.text('F#'));
    await tester.pumpAndSettle();

    expect(find.text('F# Major'), findsOneWidget);
  });

  testWidgets('shows all major keys and opens harmonic fields', (tester) async {
    await tester.pumpWidget(const MainApp());
    await tester.tap(find.text('Chord Progression'));
    await tester.pumpAndSettle();

    for (final keyName in [
      'C',
      'Db',
      'D',
      'Eb',
      'E',
      'F',
      'F#',
      'G',
      'Ab',
      'A',
      'Bb',
      'B',
    ]) {
      expect(find.byKey(ValueKey('major-key-$keyName')), findsOneWidget);
    }

    final cMajorKey = find.byKey(const ValueKey('major-key-C'));
    expect(tester.widget<OutlinedButton>(cMajorKey).onPressed, isNotNull);

    await tester.tap(cMajorKey);
    await tester.pumpAndSettle();
    expect(find.text('C Major'), findsOneWidget);
    expect(find.text('Bdim'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    final gMajorKey = find.byKey(const ValueKey('major-key-G'));
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(gMajorKey);
    await tester.pumpAndSettle();

    expect(find.text('G Major'), findsOneWidget);
    expect(find.text('F#dim'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();
    expect(find.text('Common progressions'), findsOneWidget);
    expect(find.text('Uplifting'), findsOneWidget);
    expect(find.text('Hopeful'), findsOneWidget);
    expect(find.text('Nostalgic'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text('Joyful'), findsOneWidget);
  });
}
