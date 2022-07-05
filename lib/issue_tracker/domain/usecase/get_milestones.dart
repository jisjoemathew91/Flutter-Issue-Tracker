import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

/// Usecase for getting milestones.
class GetMilestones {
  GetMilestones(this.repository);

  final IssueRepository repository;

  Future<Either<Failure, Milestones>> execute({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  }) {
    return repository.getMilestones(
      owner: owner,
      name: name,
      limit: limit,
      nextToken: nextToken,
    );
  }
}
