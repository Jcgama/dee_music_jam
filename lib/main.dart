import 'package:flutter/material.dart';

import 'features/chord_progression/presentation/chord_progression_home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xFFFFD54F);

    return MaterialApp(
      title: 'Dee Music Jam',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          secondary: accentColor,
        ),
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guitar Practice',
          style: TextStyle(color: Color(0xFFFFD54F)),
        ),
        backgroundColor: const Color(0xFF121212),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFFD54F),
              side: const BorderSide(color: Color(0xFFFFD54F)),
              padding: const EdgeInsets.symmetric(vertical: 18),
              alignment: Alignment.center,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const ChordProgressionHomePage(),
                ),
              );
            },
            child: const Text('Chord Progression'),
          ),
        ],
      ),
    );
  }
}
