import 'package:go_router/go_router.dart';

import '../../features/chord_progression/presentation/harmonic_field_page.dart';
import '../../features/chord_progression/presentation/chord_progression_home_page.dart';
import '../../features/home/presentation/main_page.dart';

class AppRouter {
  static const chordProgressionPath = '/chord-progression';
  static const harmonicFieldPath = '$chordProgressionPath/:key';

  static String keyPath(String keyName) =>
      '$chordProgressionPath/${Uri.encodeComponent(keyName)}';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const MainPage()),
      GoRoute(
        path: chordProgressionPath,
        builder: (context, state) => const ChordProgressionHomePage(),
      ),
      GoRoute(
        path: harmonicFieldPath,
        builder: (context, state) =>
            HarmonicFieldPage(keyName: state.pathParameters['key'] ?? ''),
      ),
    ],
  );
}
