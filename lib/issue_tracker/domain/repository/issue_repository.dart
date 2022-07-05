import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';

/// Repository for fetching issues
abstract class IssueRepository {
  /// Fetch issues with a fixed [limit] and a particular [states]
  ///
  /// -> Returns [Issues] when success
  /// -> Return [Failure] when failed
  ///
  /// 1. Use [nextToken] for pagination
  /// 2. Use [direction] and [field] for sorting result
  /// 3. Use [states], [assignee], [labels]
  /// and [milestone] for filtering result
  Future<Either<Failure, Issues>> getIssues({
    required String owner,
    required String name,
    required int limit,
    required int labelLimit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
    String? assignee,
    List<String>? labels,
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

  /// Fetch assignees with a fixed [limit]
  ///
  /// -> Returns [AssignableUsers] when success
  /// -> Return [Failure] when failed
  ///
  /// 1. Use [nextToken] for pagination
  Future<Either<Failure, AssignableUsers>> getAssignableUsers({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  });

  /// Fetch labels with a fixed [limit]
  ///
  /// -> Returns [Labels] when success
  /// -> Return [Failure] when failed
  ///
  /// 1. Use [nextToken] for pagination
  /// 2. Use [direction] and [field] for sorting result
  Future<Either<Failure, Labels>> getLabels({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
    String? field,
    String? direction,
  });

  /// Fetch milestones with a fixed [limit]
  ///
  /// -> Returns [Milestones] when success
  /// -> Return [Failure] when failed
  ///
  /// 1. Use [nextToken] for pagination
  Future<Either<Failure, Milestones>> getMilestones({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  });
}
