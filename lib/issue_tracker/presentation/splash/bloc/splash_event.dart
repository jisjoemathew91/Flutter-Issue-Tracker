part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

/// [RunSplashEvent] is initailly triggered to starts animation timer
class RunSplashEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}

/// [CompleteSplashEvent] will update the state when animation is complete.
class CompleteSplashEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
