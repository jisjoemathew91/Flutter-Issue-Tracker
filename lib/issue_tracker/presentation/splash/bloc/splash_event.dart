part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class RunSplashEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
class CompleteSplashEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
