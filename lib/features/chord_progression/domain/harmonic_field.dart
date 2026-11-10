import 'chord_progression.dart';
import 'harmonic_chord.dart';

class HarmonicField {
  const HarmonicField({
    required this.keyName,
    required this.chords,
    required this.progressions,
  });

  final String keyName;
  final List<HarmonicChord> chords;
  final List<ChordProgression> progressions;
}
