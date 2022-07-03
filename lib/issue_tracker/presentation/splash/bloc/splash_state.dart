part of 'splash_bloc.dart';

enum SplashStatus { running, waiting, completed }

class SplashState extends Equatable {
  const SplashState({this.status});

  final SplashStatus? status;

  @override
  List<Object?> get props => [status];

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }
}
