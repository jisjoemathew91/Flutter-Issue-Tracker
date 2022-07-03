import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/issue_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class IssueRepositoryImpl implements IssueRepository {
  IssueRepositoryImpl(this._issueDataSource);

  final IssueDataSource _issueDataSource;

  @override
  Future<Either<Failure, IssueNode>> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  }) async {
    try {
      final model = await _issueDataSource.getIssueDetails(
        owner: owner,
        name: name,
        number: number,
      );
      final entity = model.toEntity();
      return Right(entity);
    } on ServerException {
      return const Left(
        ServerFailure('Request failed! Server error'),
      );
    } on ContextReadException {
      return const Left(
        ServerFailure('Request failed! Server failed to pass the data'),
      );
    }
  }

  @override
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
  }) async {
    try {
      final model = await _issueDataSource.getIssues(
        owner: owner,
        name: name,
        limit: limit,
        states: states,
        direction: direction,
        field: field,
        nextToken: nextToken,
        assignee: assignee,
        createdBy: createdBy,
        milestone: milestone,
      );
      final entity = model.toEntity();
      return Right(entity);
    } on ServerException {
      return const Left(
        ServerFailure('Request failed! Server error'),
      );
    } on ContextReadException {
      return const Left(
        ServerFailure('Request failed! Server failed to pass the data'),
      );
    }
  }
}
