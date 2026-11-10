import 'package:flutter/material.dart';

import '../../domain/harmonic_chord.dart';

class HarmonicChordTile extends StatelessWidget {
  const HarmonicChordTile({required this.chord, super.key});

  final HarmonicChord chord;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          foregroundColor: theme.colorScheme.onPrimaryContainer,
          child: Text(
            chord.degree,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(chord.name),
        trailing: Text(
          chord.quality,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
