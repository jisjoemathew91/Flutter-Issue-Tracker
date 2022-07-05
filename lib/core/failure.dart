import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.msg);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.msg);
}

class ReadCacheFailure extends Failure {
  const ReadCacheFailure(super.msg);
}

class WriteCacheFailure extends Failure {
  const WriteCacheFailure(super.msg);
}
