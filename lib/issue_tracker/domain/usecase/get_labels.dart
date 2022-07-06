import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting labels.
class GetLabels {
  GetLabels(this._repository);

  final IssueRepository _repository;

  Future<Either<Failure, Labels>> execute({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
    String? field,
    String? direction,
  }) {
    return _repository.getLabels(
      owner: owner,
      name: name,
      limit: limit,
      nextToken: nextToken,
      field: field,
      direction: direction,
    );
  }
}
