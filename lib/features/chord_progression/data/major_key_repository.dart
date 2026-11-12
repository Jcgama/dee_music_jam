import '../domain/major_key.dart';

class MajorKeyRepository {
  static const _majorKeys = [
    MajorKey(name: 'C'),
    MajorKey(name: 'Db'),
    MajorKey(name: 'D'),
    MajorKey(name: 'Eb'),
    MajorKey(name: 'E'),
    MajorKey(name: 'F'),
    MajorKey(name: 'F#'),
    MajorKey(name: 'G'),
    MajorKey(name: 'Ab'),
    MajorKey(name: 'A'),
    MajorKey(name: 'Bb'),
    MajorKey(name: 'B'),
  ];

  List<MajorKey> getMajorKeys() => _majorKeys;
}
