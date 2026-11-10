import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/major_key_repository.dart';
import '../domain/major_key.dart';

sealed class MajorKeysEvent {
  const MajorKeysEvent();
}

class MajorKeysRequested extends MajorKeysEvent {
  const MajorKeysRequested();
}

sealed class MajorKeysState {
  const MajorKeysState();
}

class MajorKeysInitial extends MajorKeysState {
  const MajorKeysInitial();
}

class MajorKeysLoading extends MajorKeysState {
  const MajorKeysLoading();
}

class MajorKeysLoaded extends MajorKeysState {
  const MajorKeysLoaded(this.keys);

  final List<MajorKey> keys;
}

class MajorKeysBloc extends Bloc<MajorKeysEvent, MajorKeysState> {
  MajorKeysBloc({MajorKeyRepository? repository})
    : _repository = repository ?? MajorKeyRepository(),
      super(const MajorKeysInitial()) {
    on<MajorKeysRequested>((event, emit) {
      emit(const MajorKeysLoading());
      emit(MajorKeysLoaded(_repository.getMajorKeys()));
    });
  }

  final MajorKeyRepository _repository;
}
