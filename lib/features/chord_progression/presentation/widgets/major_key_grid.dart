import 'package:material_ui/material_ui.dart';

import '../../domain/major_key.dart';
import 'major_key_tile.dart';

class MajorKeyGrid extends StatelessWidget {
  const MajorKeyGrid({required this.keys, super.key});

  final List<MajorKey> keys;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemBuilder: (context, index) => MajorKeyTile(keyData: keys[index]),
    );
  }
}
