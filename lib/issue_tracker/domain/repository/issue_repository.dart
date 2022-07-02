import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';

abstract class IssueRepository {
  Future<Either<Failure, Issues>> getIssues({
    required String owner,
    required String name,
    required int limit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
  });

  Future<Either<Failure, IssueNode>> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  });
}
