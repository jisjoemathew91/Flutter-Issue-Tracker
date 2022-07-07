import 'package:equatable/equatable.dart';

/// Most of the failures are addressed by [Failure] class
abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

/// When the request to server fails
/// [ServerFailure] is being called
class ServerFailure extends Failure {
  const ServerFailure(super.msg);
}

/// When the socket error occurs
/// [ConnectionFailure] is being called
class ConnectionFailure extends Failure {
  const ConnectionFailure(super.msg);
}

/// When data cannot be read from local storage
/// [ReadCacheFailure] is called
class ReadCacheFailure extends Failure {
  const ReadCacheFailure(super.msg);
}

/// When data cannot be write to local storage
/// [WriteCacheFailure] is called
class WriteCacheFailure extends Failure {
  const WriteCacheFailure(super.msg);
}
