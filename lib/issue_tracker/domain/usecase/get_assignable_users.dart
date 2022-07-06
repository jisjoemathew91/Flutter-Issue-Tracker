import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting assignable users.
class GetAssignableUsers {
  GetAssignableUsers(this._repository);

  final IssueRepository _repository;

  Future<Either<Failure, AssignableUsers>> execute({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  }) {
    return _repository.getAssignableUsers(
      owner: owner,
      name: name,
      limit: limit,
      nextToken: nextToken,
    );
  }
}
