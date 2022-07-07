import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting opened issues.
class GetOpenedIssues {
  GetOpenedIssues(this._repository);

  final IssueRepository _repository;

  Either<Failure, List<String>> execute() {
    return _repository.getOpenedIssues();
  }
}
