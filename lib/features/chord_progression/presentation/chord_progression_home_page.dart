import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/major_keys_bloc.dart';
import 'widgets/major_key_grid.dart';

class ChordProgressionHomePage extends StatelessWidget {
  const ChordProgressionHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => MajorKeysBloc()..add(const MajorKeysRequested()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chord Progression')),
        body: BlocBuilder<MajorKeysBloc, MajorKeysState>(
          builder: (context, state) => switch (state) {
            MajorKeysInitial() || MajorKeysLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            MajorKeysLoaded(:final keys) => ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Major keys',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose a key to see its chords and common progressions',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                MajorKeyGrid(keys: keys),
              ],
            ),
          },
        ),
      ),
    );
  }
}
