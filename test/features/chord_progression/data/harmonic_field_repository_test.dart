import 'package:dee_music_jam/features/chord_progression/data/harmonic_field_repository.dart';
import 'package:dee_music_jam/features/chord_progression/data/major_key_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HarmonicFieldRepository', () {
    const expectedChords = {
      'C': ['C', 'Dm', 'Em', 'F', 'G', 'Am', 'Bdim'],
      'Db': ['Db', 'Ebm', 'Fm', 'Gb', 'Ab', 'Bbm', 'Cdim'],
      'D': ['D', 'Em', 'F#m', 'G', 'A', 'Bm', 'C#dim'],
      'Eb': ['Eb', 'Fm', 'Gm', 'Ab', 'Bb', 'Cm', 'Ddim'],
      'E': ['E', 'F#m', 'G#m', 'A', 'B', 'C#m', 'D#dim'],
      'F': ['F', 'Gm', 'Am', 'Bb', 'C', 'Dm', 'Edim'],
      'F#': ['F#', 'G#m', 'A#m', 'B', 'C#', 'D#m', 'E#dim'],
      'G': ['G', 'Am', 'Bm', 'C', 'D', 'Em', 'F#dim'],
      'Ab': ['Ab', 'Bbm', 'Cm', 'Db', 'Eb', 'Fm', 'Gdim'],
      'A': ['A', 'Bm', 'C#m', 'D', 'E', 'F#m', 'G#dim'],
      'Bb': ['Bb', 'Cm', 'Dm', 'Eb', 'F', 'Gm', 'Adim'],
      'B': ['B', 'C#m', 'D#m', 'E', 'F#', 'G#m', 'A#dim'],
    };

    test('builds diatonic chords for every major key', () {
      final repository = HarmonicFieldRepository();

      for (final entry in expectedChords.entries) {
        final field = repository.getField(entry.key);

        expect(field, isNotNull, reason: entry.key);
        expect(
          field!.chords.map((chord) => chord.name).toList(),
          entry.value,
          reason: entry.key,
        );
      }
    });

    test(
      'transposes the existing progressions and preserves their degrees',
      () {
        final repository = HarmonicFieldRepository();
        final field = repository.getField('Bb')!;
        final expectedProgressions = [
          (
            name: 'Pop anthem',
            degrees: ['I', 'V', 'vi', 'IV'],
            chords: ['Bb', 'F', 'Gm', 'Eb'],
            emotion: 'Uplifting',
          ),
          (
            name: 'Reflective',
            degrees: ['vi', 'IV', 'I', 'V'],
            chords: ['Gm', 'Eb', 'Bb', 'F'],
            emotion: 'Hopeful',
          ),
          (
            name: 'Classic ballad',
            degrees: ['I', 'vi', 'IV', 'V'],
            chords: ['Bb', 'Gm', 'Eb', 'F'],
            emotion: 'Nostalgic',
          ),
          (
            name: 'Strong resolution',
            degrees: ['ii', 'V', 'I'],
            chords: ['Cm', 'F', 'Bb'],
            emotion: 'Joyful',
          ),
        ];

        expect(field.progressions, hasLength(expectedProgressions.length));
        for (var index = 0; index < expectedProgressions.length; index++) {
          final actual = field.progressions[index];
          final expected = expectedProgressions[index];
          expect(actual.name, expected.name);
          expect(actual.degrees, expected.degrees);
          expect(actual.chords, expected.chords);
          expect(actual.emotion, expected.emotion);
        }

        final gField = repository.getField('G')!;
        expect(
          gField.progressions.map((progression) => progression.chords).toList(),
          [
            ['G', 'D', 'Em', 'C'],
            ['Em', 'C', 'G', 'D'],
            ['G', 'Em', 'C', 'D'],
            ['Am', 'D', 'G'],
          ],
        );
      },
    );

    test('returns null for an unsupported key', () {
      expect(HarmonicFieldRepository().getField('H'), isNull);
    });

    test('lists every supported major key', () {
      final keys = MajorKeyRepository().getMajorKeys();

      expect(
        keys.map((key) => key.name).toList(),
        expectedChords.keys.toList(),
      );
    });
  });
}
