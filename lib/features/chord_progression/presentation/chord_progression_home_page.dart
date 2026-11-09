import 'package:flutter/material.dart';

class ChordProgressionHomePage extends StatelessWidget {
  const ChordProgressionHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chord Progression',
          style: TextStyle(color: Color(0xFFFFD54F)),
        ),
        backgroundColor: const Color(0xFF121212),
      ),
      body: const Center(
        child: Text(
          'Chord Progression',
          style: TextStyle(
            color: Color(0xFFFFD54F),
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
