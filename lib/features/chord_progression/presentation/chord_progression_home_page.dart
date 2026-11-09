import 'package:flutter/material.dart';

class ChordProgressionHomePage extends StatelessWidget {
  const ChordProgressionHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chord Progression'),
      ),
      body: Center(
        child: Text(
          'Chord Progression',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
