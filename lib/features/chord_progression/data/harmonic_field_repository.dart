import '../domain/chord_progression.dart';
import '../domain/harmonic_chord.dart';
import '../domain/harmonic_field.dart';

class HarmonicFieldRepository {
  static const _gMajorField = HarmonicField(
    keyName: 'G',
    chords: [
      HarmonicChord(degree: 'I', name: 'G', quality: 'Major'),
      HarmonicChord(degree: 'ii', name: 'Am', quality: 'Minor'),
      HarmonicChord(degree: 'iii', name: 'Bm', quality: 'Minor'),
      HarmonicChord(degree: 'IV', name: 'C', quality: 'Major'),
      HarmonicChord(degree: 'V', name: 'D', quality: 'Major'),
      HarmonicChord(degree: 'vi', name: 'Em', quality: 'Minor'),
      HarmonicChord(degree: 'vii°', name: 'F#dim', quality: 'Diminished'),
    ],
    progressions: [
      ChordProgression(
        name: 'Pop anthem',
        degrees: ['I', 'V', 'vi', 'IV'],
        chords: ['G', 'D', 'Em', 'C'],
        emotion: 'Uplifting',
      ),
      ChordProgression(
        name: 'Reflective',
        degrees: ['vi', 'IV', 'I', 'V'],
        chords: ['Em', 'C', 'G', 'D'],
        emotion: 'Hopeful',
      ),
      ChordProgression(
        name: 'Classic ballad',
        degrees: ['I', 'vi', 'IV', 'V'],
        chords: ['G', 'Em', 'C', 'D'],
        emotion: 'Nostalgic',
      ),
      ChordProgression(
        name: 'Strong resolution',
        degrees: ['ii', 'V', 'I'],
        chords: ['Am', 'D', 'G'],
        emotion: 'Joyful',
      ),
    ],
  );

  HarmonicField? getField(String keyName) {
    if (keyName.toUpperCase() == _gMajorField.keyName) {
      return _gMajorField;
    }
    return null;
  }
}
