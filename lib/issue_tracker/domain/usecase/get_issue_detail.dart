import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';

class GetIssueDetail {
  GetIssueDetail(this.repository);

  final IssueRepository repository;

  Future<Either<Failure, IssueNode>> execute({
    required String owner,
    required String name,
    required int number,
  }) {
    return repository.getIssueDetails(
      owner: owner,
      name: name,
      number: number,
    );
  }
}
