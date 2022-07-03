import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';

/// Repository for fetching issues
abstract class IssueRepository {
  /// Fetch issues with a fixed [limit] and a particular [states]
  ///
  /// -> Returns [Issues] when success
  /// -> Return [Failure] when failed
  ///
  /// 1. Use [nextToken] for pagination
  /// 2. Use [direction] and [field] for ordering result
  /// 3. Use [states], [assignee], [createdBy]
  /// and [milestone] for filtering result
  Future<Either<Failure, Issues>> getIssues({
    required String owner,
    required String name,
    required int limit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
    String? assignee,
    String? createdBy,
    String? milestone,
  });

  /// Fetch issue by issue [number].
  ///
  /// -> Returns [IssueNode] when success
  /// -> Return [Failure] when failed
  Future<Either<Failure, IssueNode>> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  });
}
