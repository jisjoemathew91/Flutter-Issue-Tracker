import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for setting opened issues.
class SetIssueOpened {
  SetIssueOpened(this._repository);

  final IssueRepository _repository;

  Future<Either<Failure, bool>> execute({required List<String> numbers}) {
    return _repository.setIssueOpened(numbers: numbers);
  }
}
