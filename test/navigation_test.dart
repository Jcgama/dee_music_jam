import 'package:dee_music_jam/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens chord progression and returns to the home page', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.text('Chord Progression'));
    await tester.pumpAndSettle();

    expect(find.text('Major keys'), findsOneWidget);
    expect(find.byKey(const ValueKey('major-key-G')), findsOneWidget);
    expect(find.text('Guitar Practice'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Guitar Practice'), findsOneWidget);
  });

  testWidgets('shows all major keys and opens the G harmonic field', (
    tester,
  ) async {
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

    final unavailableKey = find.byKey(const ValueKey('major-key-C'));
    expect(tester.widget<OutlinedButton>(unavailableKey).onPressed, isNull);
    final unavailableOpacity = find.ancestor(
      of: unavailableKey,
      matching: find.byType(Opacity),
    );
    expect(tester.widget<Opacity>(unavailableOpacity.first).opacity, 0.4);
    expect(find.text('Available'), findsNothing);

    await tester.tap(unavailableKey);
    await tester.pumpAndSettle();
    expect(find.text('C major is not available yet.'), findsOneWidget);
    expect(tester.widget<OutlinedButton>(unavailableKey).onPressed, isNull);

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
