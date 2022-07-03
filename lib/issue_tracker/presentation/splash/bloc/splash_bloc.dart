import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<RunSplashEvent>(onRunSplash);
    on<CompleteSplashEvent>(onCompleteSplash);
  }

  FutureOr<void> onRunSplash(
    RunSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    if (state.status != SplashStatus.completed) {
      emit(state.copyWith(status: SplashStatus.running));
    }
    // Mocking 3's delay for loading app related data
    await Future<void>.delayed(const Duration(seconds: 3));
    if (state.status != SplashStatus.completed) {
      emit(state.copyWith(status: SplashStatus.waiting));
    }
  }

  FutureOr<void> onCompleteSplash(
    CompleteSplashEvent event,
    Emitter<SplashState> emit,
  ) {
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
