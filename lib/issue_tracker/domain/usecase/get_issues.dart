import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting issues.
class GetIssues {
  GetIssues(this._repository);

  final IssueRepository _repository;

  Future<Either<Failure, Issues>> execute({
    required String owner,
    required String name,
    required int limit,
    required int labelLimit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
    String? assignee,
    List<String>? labels,
    String? milestone,
  }) {
    return _repository.getIssues(
      owner: owner,
      name: name,
      limit: limit,
      labelLimit: labelLimit,
      states: states,
      direction: direction,
      field: field,
      nextToken: nextToken,
      assignee: assignee,
      labels: labels,
      milestone: milestone,
    );
  }
}
