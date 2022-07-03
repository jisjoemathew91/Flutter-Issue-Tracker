import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting issues.
class GetIssues {
  GetIssues(this.repository);

  final IssueRepository repository;

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
    String? createdBy,
    String? milestone,
  }) {
    return repository.getIssues(
      owner: owner,
      name: name,
      limit: limit,
      labelLimit: labelLimit,
      states: states,
      direction: direction,
      field: field,
      nextToken: nextToken,
      assignee: assignee,
      createdBy: createdBy,
      milestone: milestone,
    );
  }
}
