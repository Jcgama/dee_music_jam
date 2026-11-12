import '../domain/chord_progression.dart';
import '../domain/harmonic_chord.dart';
import '../domain/harmonic_field.dart';

class HarmonicFieldRepository {
  static const _keyTonics = {
    'C': 'C',
    'DB': 'Db',
    'D': 'D',
    'EB': 'Eb',
    'E': 'E',
    'F': 'F',
    'F#': 'F#',
    'G': 'G',
    'AB': 'Ab',
    'A': 'A',
    'BB': 'Bb',
    'B': 'B',
  };

  static const _scaleIntervals = [0, 2, 4, 5, 7, 9, 11];
  static const _letters = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];
  static const _naturalPitchClasses = {
    'C': 0,
    'D': 2,
    'E': 4,
    'F': 5,
    'G': 7,
    'A': 9,
    'B': 11,
  };
  static const _accidentals = {0: '', 1: '#', 11: 'b'};
  static const _degrees = ['I', 'ii', 'iii', 'IV', 'V', 'vi', 'vii°'];
  static const _qualities = [
    'Major',
    'Minor',
    'Minor',
    'Major',
    'Major',
    'Minor',
    'Diminished',
  ];
  static const _chordSuffixes = ['', 'm', 'm', '', '', 'm', 'dim'];
  static const _degreeIndices = {
    'I': 0,
    'ii': 1,
    'iii': 2,
    'IV': 3,
    'V': 4,
    'vi': 5,
    'vii°': 6,
  };

  static const _progressions = [
    _ProgressionTemplate(
      name: 'Pop anthem',
      degrees: ['I', 'V', 'vi', 'IV'],
      emotion: 'Uplifting',
    ),
    _ProgressionTemplate(
      name: 'Reflective',
      degrees: ['vi', 'IV', 'I', 'V'],
      emotion: 'Hopeful',
    ),
    _ProgressionTemplate(
      name: 'Classic ballad',
      degrees: ['I', 'vi', 'IV', 'V'],
      emotion: 'Nostalgic',
    ),
    _ProgressionTemplate(
      name: 'Strong resolution',
      degrees: ['ii', 'V', 'I'],
      emotion: 'Joyful',
    ),
  ];

  HarmonicField? getField(String keyName) {
    final tonic = _keyTonics[keyName.trim().toUpperCase()];
    if (tonic == null) {
      return null;
    }

    final scale = _buildMajorScale(tonic);
    final chords = [
      for (var index = 0; index < _degrees.length; index++)
        HarmonicChord(
          degree: _degrees[index],
          name: '${scale[index]}${_chordSuffixes[index]}',
          quality: _qualities[index],
        ),
    ];
    final progressions = [
      for (final progression in _progressions)
        ChordProgression(
          name: progression.name,
          degrees: progression.degrees,
          chords: [
            for (final degree in progression.degrees)
              _chordForDegree(degree, scale),
          ],
          emotion: progression.emotion,
        ),
    ];

    return HarmonicField(
      keyName: tonic,
      chords: chords,
      progressions: progressions,
    );
  }

  List<String> _buildMajorScale(String tonic) {
    final tonicLetterIndex = _letters.indexOf(tonic[0]);
    final tonicPitchClass =
        (_naturalPitchClasses[tonic[0]]! +
            (tonic.endsWith('#')
                ? 1
                : tonic.endsWith('b')
                ? -1
                : 0)) %
        12;

    return [
      for (var degree = 0; degree < _scaleIntervals.length; degree++)
        _scaleNote(
          _letters[(tonicLetterIndex + degree) % _letters.length],
          (tonicPitchClass + _scaleIntervals[degree]) % 12,
        ),
    ];
  }

  String _scaleNote(String letter, int pitchClass) {
    final naturalPitchClass = _naturalPitchClasses[letter]!;
    final accidentalOffset = (pitchClass - naturalPitchClass + 12) % 12;
    final accidental = _accidentals[accidentalOffset];
    if (accidental == null) {
      throw StateError('Cannot spell pitch class $pitchClass with $letter.');
    }
    return '$letter$accidental';
  }

  String _chordForDegree(String degree, List<String> scale) {
    final index = _degreeIndices[degree];
    if (index == null) {
      throw StateError('Unknown progression degree: $degree.');
    }
    return '${scale[index]}${_chordSuffixes[index]}';
  }
}

class _ProgressionTemplate {
  const _ProgressionTemplate({
    required this.name,
    required this.degrees,
    required this.emotion,
  });

  final String name;
  final List<String> degrees;
  final String emotion;
}
