import 'package:flutter_issue_tracker/issue_tracker/data/datasource/issue_query.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issues_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class IssueDataSource {
  Future<IssuesModel> getIssues({
    required String owner,
    required String name,
    required int limit,
    required String states,
    String? direction,
    String? field,
    String? nextToken,
  });

  Future<IssueNodeModel> getIssueDetails({
    required String owner,
    required String name,
    required int number,
  });
}

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
      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.issueDetailQuery),
          variables: <String, dynamic>{
            'owner': owner,
            'name': name,
            'number': number
          },
        ),
      );
      return IssueNodeModel.fromJson(result.data?['repository']['issue']);
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
  }) async {
    try {
      print(owner);
      print(name);
      print(limit);
      print(states);
      print(direction);
      print(field);
      print('nextToken: $nextToken');
      final result = await _client.query(
        QueryOptions(
          document: gql(IssueQueries.listIssuesQuery),
          variables: <String, dynamic>{
            'owner': owner,
            'name': name,
            'first': limit,
            'states': states,
            'direction': direction,
            'field': field,
            'after': nextToken
          },
        ),
      );
      print(result.data);
      return IssuesModel.fromJson(result.data?['repository']['issues']);
    } catch(e) {
      print('MMMM');
      print(e);
      throw const ServerException();
    }
  }
}
