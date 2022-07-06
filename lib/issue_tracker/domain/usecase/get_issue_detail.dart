import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting issue detail.
class GetIssueDetail {
  GetIssueDetail(this._repository);

  final IssueRepository _repository;

  Future<Either<Failure, IssueNode>> execute({
    required String owner,
    required String name,
    required int number,
  }) {
    return _repository.getIssueDetails(
      owner: owner,
      name: name,
      number: number,
    );
  }
}
