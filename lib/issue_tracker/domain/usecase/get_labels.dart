import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting labels.
class GetLabels {
  GetLabels(this.repository);

  final IssueRepository repository;

  Future<Either<Failure, Labels>> execute({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
    String? field,
    String? direction,
  }) {
    return repository.getLabels(
      owner: owner,
      name: name,
      limit: limit,
      nextToken: nextToken,
      field: field,
      direction: direction,
    );
  }
}