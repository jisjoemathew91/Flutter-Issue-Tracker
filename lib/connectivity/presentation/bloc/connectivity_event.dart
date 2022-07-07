part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
}

/// Event called to listen to the connection state
/// Need to call only one time when app runs
class ListenConnectionEvent extends ConnectivityEvent {
  @override
  List<Object?> get props => [];
}
