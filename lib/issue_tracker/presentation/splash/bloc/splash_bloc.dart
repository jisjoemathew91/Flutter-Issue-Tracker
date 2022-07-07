import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<RunSplashEvent>(_onRunSplash);
    on<CompleteSplashEvent>(_onCompleteSplash);
  }

  FutureOr<void> _onRunSplash(
    RunSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    // Update splash status if the status is not completed yet
    if (state.status != SplashStatus.completed) {
      emit(state.copyWith(status: SplashStatus.running));
    }
    // Creates 3 sec delay for completing animation
    await Future<void>.delayed(const Duration(seconds: 3));

    // Update splash status if the status is not completed yet
    if (state.status != SplashStatus.completed) {
      emit(state.copyWith(status: SplashStatus.waiting));
    }
  }

  FutureOr<void> _onCompleteSplash(
    CompleteSplashEvent event,
    Emitter<SplashState> emit,
  ) {
    emit(state.copyWith(status: SplashStatus.completed));
  }
}
