import 'package:flutter_issue_tracker/issue_tracker/data/datasource/remote/issue_remote_query.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/assignable_users_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issues_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/labels_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/milestones_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Data Source for fetching issues related queries
abstract class IssueRemoteDataSource {
  /// Fetch issues with a fixed [limit] and a particular [states]
  ///
  /// 1. [states] values are OPEN or CLOSED
  /// 2. [direction] values are ASC or DESC
  /// 3. [field] values are CREATED_AT, UPDATED_AT & COMMENTS
  ///
  /// -> onSuccess returns [IssuesModel]
  /// -> onError throws [Exception]
  Future<IssuesModel> getIssues({
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

  /// Fetches issue by issue [number]
  ///
  /// -> onSuccess returns [IssueNodeModel]
  /// -> onError throws [Exception]
  Future<IssueNodeModel> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  });

  /// Fetches assignees with a fixed [limit]
  ///
  /// -> onSuccess returns [AssignableUsersModel]
  /// -> onError throws [Exception]
  Future<AssignableUsersModel> getAssignableUsers({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  });

  /// Fetches labels with a fixed [limit]
  ///
  /// 1. [direction] values are ASC or DESC
  /// 2. [field] values are NAME or CREATED_AT
  ///
  /// -> onSuccess returns [LabelsModel]
  /// -> onError throws [Exception]
  Future<LabelsModel> getLabels({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
    String? field,
    String? direction,
  });

  /// Fetches milestones with a fixed [limit]
  ///
  /// -> onSuccess returns [MilestonesModel]
  /// -> onError throws [Exception]
  Future<MilestonesModel> getMilestones({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  });
}

/// [IssueRemoteDataSource] Implementation class
class IssueRemoteDataSourceImpl implements IssueRemoteDataSource {
  IssueRemoteDataSourceImpl(this._client);

  final GraphQLClient _client;

  @override
  Future<IssueNodeModel> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  }) async {
    try {
      final variables = {'owner': owner, 'name': name, 'number': number};

      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.issueDetailQuery),
          variables: variables,
        ),
      );
      if (result.data?['repository']['issue'] != null) {
        return IssueNodeModel.fromJson(result.data?['repository']['issue']);
      } else {
        throw const ContextReadException();
      }
    } on ContextReadException {
      rethrow;
    } on Exception {
      throw const ServerException();
    }
  }

  @override
  Future<IssuesModel> getIssues({
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
      final variables = <String, dynamic>{
        'owner': owner,
        'name': name,
        'first': limit,
        'labelFirst': labelLimit,
        'filterBy': <String, dynamic>{'states': states}
      };
      if (nextToken != null) variables['after'] = nextToken;
      if (direction != null && field != null) {
        variables['orderBy'] = {'direction': direction, 'field': field};
      }
      if (assignee != null) {
        variables['filterBy']['assignee'] = assignee;
      }
      if (labels != null) {
        (variables['filterBy'])
            .addAll(<String, List<String>>{'labels': labels});
      }
      if (milestone != null) {
        variables['filterBy']['milestone'] = milestone;
      }

      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.listIssuesQuery),
          variables: variables,
        ),
      );
      if (result.data?['repository']['issues'] != null) {
        return IssuesModel.fromJson(result.data!['repository']['issues']);
      } else {
        throw const ContextReadException();
      }
    } on ContextReadException {
      rethrow;
    } on Exception {
      throw const ServerException();
    }
  }

  @override
  Future<AssignableUsersModel> getAssignableUsers({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  }) async {
    try {
      final variables = {'owner': owner, 'name': name, 'first': limit};
      if (nextToken != null) variables['after'] = nextToken;

      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.listAssignableUsersQuery),
          variables: variables,
        ),
      );
      if (result.data?['repository']['assignableUsers'] != null) {
        return AssignableUsersModel.fromJson(
          result.data?['repository']['assignableUsers'],
        );
      } else {
        throw const ContextReadException();
      }
    } on ContextReadException {
      rethrow;
    } on Exception {
      throw const ServerException();
    }
  }

  @override
  Future<LabelsModel> getLabels({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
    String? field,
    String? direction,
  }) async {
    try {
      final variables = {'owner': owner, 'name': name, 'first': limit};
      if (nextToken != null) variables['after'] = nextToken;
      if (direction != null && field != null) {
        variables['orderBy'] = {'direction': direction, 'field': field};
      }

      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.listLabelsQuery),
          variables: variables,
        ),
      );
      if (result.data?['repository']['labels'] != null) {
        return LabelsModel.fromJson(
          result.data?['repository']['labels'],
        );
      } else {
        throw const ContextReadException();
      }
    } on ContextReadException {
      rethrow;
    } on Exception {
      throw const ServerException();
    }
  }

  @override
  Future<MilestonesModel> getMilestones({
    required String owner,
    required String name,
    required int limit,
    String? nextToken,
  }) async {
    try {
      final variables = {'owner': owner, 'name': name, 'first': limit};
      if (nextToken != null) variables['after'] = nextToken;
      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.listMilestonesQuery),
          variables: variables,
        ),
      );
      if (result.data?['repository']['milestones'] != null) {
        return MilestonesModel.fromJson(
          result.data?['repository']['milestones'],
        );
      } else {
        throw const ContextReadException();
      }
    } on ContextReadException {
      rethrow;
    } on Exception {
      throw const ServerException();
    }
  }
}
