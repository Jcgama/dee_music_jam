import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../domain/major_key.dart';

class MajorKeyTile extends StatelessWidget {
  const MajorKeyTile({required this.keyData, super.key});

  final MajorKey keyData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAvailable = keyData.isAvailable;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isAvailable
          ? null
          : () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${keyData.name} major is not available yet.'),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            ),
      child: Opacity(
        opacity: isAvailable ? 1 : 0.4,
        child: OutlinedButton(
          key: ValueKey('major-key-${keyData.name}'),
          onPressed: isAvailable
              ? () => context.push(
                  '${AppRouter.chordProgressionPath}/${keyData.name}',
                )
              : null,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(
              color: isAvailable
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
            ),
            backgroundColor: isAvailable
                ? theme.colorScheme.primaryContainer
                : null,
          ),
          child: Center(
            child: Text(
              keyData.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: isAvailable
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
