import 'package:dee_music_jam/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('opens chord progression and returns to the home page', (
    tester,
  ) async {
    await tester.pumpWidget(const MainApp());

    await tester.tap(find.text('Chord Progression'));
    await tester.pumpAndSettle();

    expect(find.text('Chord Progression'), findsNWidgets(2));
    expect(find.text('Guitar Practice'), findsNothing);

    await tester.pageBack();
    await tester.pumpAndSettle();

    expect(find.text('Guitar Practice'), findsOneWidget);
  });
}
