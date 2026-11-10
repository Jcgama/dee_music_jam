import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/harmonic_field_repository.dart';
import '../domain/harmonic_field.dart';

sealed class HarmonicFieldEvent {
  const HarmonicFieldEvent();
}

class HarmonicFieldRequested extends HarmonicFieldEvent {
  const HarmonicFieldRequested(this.keyName);

  final String keyName;
}

sealed class HarmonicFieldState {
  const HarmonicFieldState();
}

class HarmonicFieldInitial extends HarmonicFieldState {
  const HarmonicFieldInitial();
}

class HarmonicFieldLoading extends HarmonicFieldState {
  const HarmonicFieldLoading();
}

class HarmonicFieldLoaded extends HarmonicFieldState {
  const HarmonicFieldLoaded(this.field);

  final HarmonicField field;
}

class HarmonicFieldNotFound extends HarmonicFieldState {
  const HarmonicFieldNotFound(this.keyName);

  final String keyName;
}

class HarmonicFieldBloc extends Bloc<HarmonicFieldEvent, HarmonicFieldState> {
  HarmonicFieldBloc({HarmonicFieldRepository? repository})
    : _repository = repository ?? HarmonicFieldRepository(),
      super(const HarmonicFieldInitial()) {
    on<HarmonicFieldRequested>((event, emit) {
      emit(const HarmonicFieldLoading());
      final field = _repository.getField(event.keyName);
      if (field == null) {
        emit(HarmonicFieldNotFound(event.keyName));
      } else {
        emit(HarmonicFieldLoaded(field));
      }
    });
  }

  final HarmonicFieldRepository _repository;
}
