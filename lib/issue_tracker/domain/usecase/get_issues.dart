import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

class GetIssues {
  GetIssues(this.repository);

  final IssueRepository repository;

  Future<Either<Failure, Issues>> execute({
    required String owner,
    required String name,
    required int limit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
  }) {
    return repository.getIssues(
      owner: owner,
      name: name,
      limit: limit,
      states: states,
      direction: direction,
      field: field,
      nextToken: nextToken,
    );
  }
}
