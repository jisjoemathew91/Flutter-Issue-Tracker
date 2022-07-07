import 'package:flutter_issue_tracker/issue_tracker/data/datasource/remote/issue_remote_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/assignable_users_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issues_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/labels_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/milestones_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/helpers.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(QueryOptions(document: gql('')));
  });
  group('Issue datasource test', () {
    final GraphQLClient client = MockGraphQLClient();
    final dataSourceImpl = IssueRemoteDataSourceImpl(client);
    test('- Get issue details success test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'issue': (IssueNodeModel()..id = '123').toJson(),
              },
            },
          ),
        ),
      );
      expect(
        await dataSourceImpl.getIssueDetails(name: '', number: 123, owner: ''),
        isA<IssueNodeModel>(),
      );
    });
    test('- Get issue details fail test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'issue': null,
              },
            },
          ),
        ),
      );
      expect(
        dataSourceImpl.getIssueDetails(name: '', number: 123, owner: ''),
        throwsA(isA<ServerException>()),
      );
    });
    test('- Get issues success test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'issues': (IssuesModel()..nodes = []).toJson(),
              },
            },
          ),
        ),
      );
      expect(
        await dataSourceImpl.getIssues(
          owner: 'owner',
          name: 'name',
          limit: 1,
          labelLimit: 1,
          states: 'state',
          labels: [],
          assignee: 'assigne',
          direction: 'direction',
          field: 'field',
          milestone: 'milestone',
          nextToken: 'token',
        ),
        isA<IssuesModel>(),
      );
    });
    test('- Get issues fail test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'issues': null,
              },
            },
          ),
        ),
      );
      expect(
        dataSourceImpl.getIssues(
          owner: 'owner',
          name: 'name',
          limit: 1,
          labelLimit: 1,
          states: 'state',
          labels: [],
          assignee: 'assigne',
          direction: 'direction',
          field: 'field',
          milestone: 'milestone',
          nextToken: 'token',
        ),
        throwsA(isA<ServerException>()),
      );
    });
    test('- Get assignable users success test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'assignableUsers': AssignableUsersModel().toJson(),
              },
            },
          ),
        ),
      );
      expect(
        await dataSourceImpl.getAssignableUsers(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        isA<AssignableUsersModel>(),
      );
    });
    test('- Get assignable users fail test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'assignableUsers': null,
              },
            },
          ),
        ),
      );
      expect(
        dataSourceImpl.getAssignableUsers(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        throwsA(isA<ServerException>()),
      );
    });
    test('- Get labels success test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'labels': LabelsModel().toJson(),
              },
            },
          ),
        ),
      );
      expect(
        await dataSourceImpl.getLabels(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
          field: 'field',
          direction: 'direction',
        ),
        isA<LabelsModel>(),
      );
    });
    test('- Get labels fail test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'labels': null,
              },
            },
          ),
        ),
      );
      expect(
        dataSourceImpl.getLabels(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
          field: 'field',
          direction: 'direction',
        ),
        throwsA(isA<ServerException>()),
      );
    });
    test('- Get milestones success test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'milestones': MilestonesModel().toJson(),
              },
            },
          ),
        ),
      );
      expect(
        await dataSourceImpl.getMilestones(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        isA<MilestonesModel>(),
      );
    });
    test('- Get milestones fail test', () async {
      when(() => client.query(any())).thenAnswer(
        (invocation) => Future.value(
          QueryResult(
            options: QueryOptions(document: gql('')),
            source: QueryResultSource.network,
            data: <String, dynamic>{
              'repository': {
                'milestones': null,
              },
            },
          ),
        ),
      );
      expect(
        dataSourceImpl.getMilestones(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
