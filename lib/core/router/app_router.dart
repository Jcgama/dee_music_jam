import 'package:go_router/go_router.dart';

import '../../features/chord_progression/presentation/chord_progression_home_page.dart';
import '../../features/home/presentation/main_page.dart';

class AppRouter {
  static const chordProgressionPath = '/chord-progression';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const MainPage()),
      GoRoute(
        path: chordProgressionPath,
        builder: (context, state) => const ChordProgressionHomePage(),
      ),
    ],
  );
}
