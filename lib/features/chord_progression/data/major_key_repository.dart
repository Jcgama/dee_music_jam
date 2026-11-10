import '../domain/major_key.dart';

class MajorKeyRepository {
  static const _majorKeys = [
    MajorKey(name: 'C', isAvailable: false),
    MajorKey(name: 'Db', isAvailable: false),
    MajorKey(name: 'D', isAvailable: false),
    MajorKey(name: 'Eb', isAvailable: false),
    MajorKey(name: 'E', isAvailable: false),
    MajorKey(name: 'F', isAvailable: false),
    MajorKey(name: 'F#', isAvailable: false),
    MajorKey(name: 'G', isAvailable: true),
    MajorKey(name: 'Ab', isAvailable: false),
    MajorKey(name: 'A', isAvailable: false),
    MajorKey(name: 'Bb', isAvailable: false),
    MajorKey(name: 'B', isAvailable: false),
  ];

  List<MajorKey> getMajorKeys() => _majorKeys;
}
