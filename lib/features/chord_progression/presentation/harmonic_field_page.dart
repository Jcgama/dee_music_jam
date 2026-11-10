import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/harmonic_field_bloc.dart';
import 'widgets/harmonic_field_content.dart';

class HarmonicFieldPage extends StatelessWidget {
  const HarmonicFieldPage({required this.keyName, super.key});

  final String keyName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HarmonicFieldBloc()..add(HarmonicFieldRequested(keyName)),
      child: Scaffold(
        appBar: AppBar(title: Text('$keyName Major')),
        body: BlocBuilder<HarmonicFieldBloc, HarmonicFieldState>(
          builder: (context, state) => switch (state) {
            HarmonicFieldInitial() || HarmonicFieldLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            HarmonicFieldLoaded(:final field) => HarmonicFieldContent(
              field: field,
            ),
            HarmonicFieldNotFound(:final keyName) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'The $keyName major harmonic field is not available yet.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          },
        ),
      ),
    );
  }
}
