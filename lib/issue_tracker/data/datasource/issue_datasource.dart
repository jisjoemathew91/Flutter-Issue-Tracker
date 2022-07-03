import 'package:flutter_issue_tracker/issue_tracker/data/datasource/issue_query.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issues_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// Data Source for fetching issues related queries
abstract class IssueDataSource {
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
    required String states,
    String? direction,
    String? field,
    String? nextToken,
    String? assignee,
    String? createdBy,
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
}

/// [IssueDataSource] Implementation class
class IssueDataSourceImpl implements IssueDataSource {
  IssueDataSourceImpl(this._client);

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
    } on Exception {
      throw const ServerException();
    }
  }

  @override
  Future<IssuesModel> getIssues({
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
      final variables = {
        'owner': owner,
        'name': name,
        'first': limit,
        'filterBy': {'states': states}
      };
      if (nextToken != null) variables['after'] = nextToken;
      if (direction != null && field != null) {
        variables['orderBy'] = {'direction': direction, 'field': field};
      }
      if (assignee != null) variables['assignee'] = assignee;
      if (createdBy != null) variables['createdBy'] = createdBy;
      if (milestone != null) variables['milestone'] = milestone;

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
    } on Exception {
      throw const ServerException();
    }
  }
}
