import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/local/issue_local_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/remote/issue_remote_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// [IssueRepository] implementation class
class IssueRepositoryImpl implements IssueRepository {
  IssueRepositoryImpl(
    this._issueRemoteDataSource,
    this._issueLocalDataSource,
  );

  final IssueRemoteDataSource _issueRemoteDataSource;
  final IssueLocalDataSource _issueLocalDataSource;

  @override
  Future<Either<Failure, IssueNode>> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  }) async {
    try {
      final model = await _issueRemoteDataSource.getIssueDetails(
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
    required int labelLimit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
    String? assignee,
    List<String>? labels,
    String? milestone,
  }) async {
    try {
      final model = await _issueRemoteDataSource.getIssues(
        owner: owner,
        name: name,
        limit: limit,
        labelLimit: labelLimit,
        states: states,
        direction: direction,
        field: field,
        nextToken: nextToken,
        assignee: assignee,
        labels: labels,
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

  @override
  Future<Either<Failure, AssignableUsers>> getAssignableUsers({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  }) async {
    try {
      final model = await _issueRemoteDataSource.getAssignableUsers(
        owner: owner,
        name: name,
        limit: limit,
        nextToken: nextToken,
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
  Future<Either<Failure, Labels>> getLabels({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
    String? field,
    String? direction,
  }) async {
    try {
      final model = await _issueRemoteDataSource.getLabels(
        owner: owner,
        name: name,
        limit: limit,
        nextToken: nextToken,
        field: field,
        direction: direction,
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
  Future<Either<Failure, Milestones>> getMilestones({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  }) async {
    try {
      final model = await _issueRemoteDataSource.getMilestones(
        owner: owner,
        name: name,
        limit: limit,
        nextToken: nextToken,
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
  Either<Failure, List<String>> getOpenedIssues() {
    try {
      final result = _issueLocalDataSource.getOpenedIssues();
      return Right(result);
    } on Exception {
      return const Left(
        ReadCacheFailure('Permission denied! Failed to read data'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> setIssueOpened({
    required List<String> numbers,
  }) async {
    try {
      final result = await _issueLocalDataSource.setIssueOpened(numbers);
      return Right(result);
    } on Exception {
      return const Left(
        ReadCacheFailure('Permission denied! Failed to write data'),
      );
    }
  }
}
