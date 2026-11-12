import 'package:material_ui/material_ui.dart';

import '../../domain/harmonic_field.dart';
import 'harmonic_chord_tile.dart';
import 'progression_card.dart';

class HarmonicFieldContent extends StatelessWidget {
  const HarmonicFieldContent({required this.field, super.key});

  final HarmonicField field;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Text(
          'Chords',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...field.chords.map((chord) => HarmonicChordTile(chord: chord)),
        const SizedBox(height: 24),
        Text(
          'Common progressions',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A progression can feel different depending on tempo, rhythm, and '
          'arrangement!',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        ...field.progressions.map(
          (progression) => ProgressionCard(progression: progression),
        ),
      ],
    );
  }
}
