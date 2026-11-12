import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../domain/major_key.dart';

class MajorKeyTile extends StatelessWidget {
  const MajorKeyTile({required this.keyData, super.key});

  final MajorKey keyData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      key: ValueKey('major-key-${keyData.name}'),
      onPressed: () => context.push(AppRouter.keyPath(keyData.name)),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide(color: theme.colorScheme.primary),
      ),
      child: Center(
        child: Text(
          keyData.name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
