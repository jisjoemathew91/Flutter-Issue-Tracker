import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/local/issue_local_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/remote/issue_remote_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/assignable_users_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issues_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/labels_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/milestones_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/repository/issue_repository_impl.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Issue repository impl test', () {
    final IssueRemoteDataSource remoteDataSource = MockIssueRemoteDataSource();
    final IssueLocalDataSource localDataSource = MockIssueLocalDataSource();

    final repository = IssueRepositoryImpl(remoteDataSource, localDataSource);

    test('- Get issue details success test', () async {
      when(
        () => remoteDataSource.getIssueDetails(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          number: any(named: 'number'),
        ),
      ).thenAnswer((invocation) => Future.value(IssueNodeModel()));
      expect(
        await repository.getIssueDetails(
          owner: 'owner',
          name: 'name',
          number: 1,
        ),
        equals(isA<Right<dynamic, IssueNode>>()),
      );
    });

    test('- Get issue details fail with ServerException test', () async {
      when(
        () => remoteDataSource.getIssueDetails(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          number: any(named: 'number'),
        ),
      ).thenThrow(
        const ServerException(),
      );
      expect(
        await repository.getIssueDetails(
          owner: 'owner',
          name: 'name',
          number: 1,
        ),
        equals(isA<Left<dynamic, IssueNode>>()),
      );
    });

    test('- Get issue details fail with ContextReadException test', () async {
      when(
        () => remoteDataSource.getIssueDetails(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          number: any(named: 'number'),
        ),
      ).thenThrow(
        const ContextReadException(),
      );
      expect(
        await repository.getIssueDetails(
          owner: 'owner',
          name: 'name',
          number: 1,
        ),
        equals(isA<Left<dynamic, IssueNode>>()),
      );
    });

    test('- Get issues success test', () async {
      when(
        () => remoteDataSource.getIssues(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          states: any(named: 'states'),
          labelLimit: any(named: 'labelLimit'),
          labels: any(named: 'labels'),
          assignee: any(named: 'assignee'),
          direction: any(named: 'direction'),
          milestone: any(named: 'milestone'),
          nextToken: any(named: 'nextToken'),
          field: any(named: 'field'),
        ),
      ).thenAnswer((invocation) => Future.value(IssuesModel()));
      expect(
        await repository.getIssues(
          owner: 'owner',
          name: 'name',
          labelLimit: 1,
          limit: 1,
          states: 'states',
          field: 'field',
          nextToken: 'token',
          milestone: 'milestone',
          direction: 'direction',
          assignee: 'assignee',
          labels: [],
        ),
        equals(isA<Right<dynamic, Issues>>()),
      );
    });

    test('- Get issues fail on ServerException test', () async {
      when(
        () => remoteDataSource.getIssues(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          states: any(named: 'states'),
          labelLimit: any(named: 'labelLimit'),
          labels: any(named: 'labels'),
          assignee: any(named: 'assignee'),
          direction: any(named: 'direction'),
          milestone: any(named: 'milestone'),
          nextToken: any(named: 'nextToken'),
          field: any(named: 'field'),
        ),
      ).thenThrow(const ServerException());
      expect(
        await repository.getIssues(
          owner: 'owner',
          name: 'name',
          labelLimit: 1,
          limit: 1,
          states: 'states',
          field: 'field',
          nextToken: 'token',
          milestone: 'milestone',
          direction: 'direction',
          assignee: 'assignee',
          labels: [],
        ),
        equals(isA<Left<dynamic, Issues>>()),
      );
    });

    test('- Get issues fail on ContextReadException test', () async {
      when(
        () => remoteDataSource.getIssues(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          states: any(named: 'states'),
          labelLimit: any(named: 'labelLimit'),
          labels: any(named: 'labels'),
          assignee: any(named: 'assignee'),
          direction: any(named: 'direction'),
          milestone: any(named: 'milestone'),
          nextToken: any(named: 'nextToken'),
          field: any(named: 'field'),
        ),
      ).thenThrow(const ContextReadException());
      expect(
        await repository.getIssues(
          owner: 'owner',
          name: 'name',
          labelLimit: 1,
          limit: 1,
          states: 'states',
          field: 'field',
          nextToken: 'token',
          milestone: 'milestone',
          direction: 'direction',
          assignee: 'assignee',
          labels: [],
        ),
        equals(isA<Left<dynamic, Issues>>()),
      );
    });

    test('- Get assignable users success test', () async {
      when(
        () => remoteDataSource.getAssignableUsers(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenAnswer((invocation) => Future.value(AssignableUsersModel()));
      expect(
        await repository.getAssignableUsers(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Right<dynamic, AssignableUsers>>()),
      );
    });

    test('- Get assignable users fail on ServerException test', () async {
      when(
        () => remoteDataSource.getAssignableUsers(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenThrow(const ServerException());
      expect(
        await repository.getAssignableUsers(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Left<dynamic, AssignableUsers>>()),
      );
    });

    test('- Get assignable users fail on ContextReadException test', () async {
      when(
        () => remoteDataSource.getAssignableUsers(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenThrow(const ContextReadException());
      expect(
        await repository.getAssignableUsers(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Left<dynamic, AssignableUsers>>()),
      );
    });

    test('- Get labels success test', () async {
      when(
        () => remoteDataSource.getLabels(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
          direction: any(named: 'direction'),
          field: any(named: 'field'),
        ),
      ).thenAnswer((invocation) => Future.value(LabelsModel()));
      expect(
        await repository.getLabels(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
          field: 'field',
          direction: 'direction',
        ),
        equals(isA<Right<dynamic, Labels>>()),
      );
    });

    test('- Get labels fail on ServerException test', () async {
      when(
        () => remoteDataSource.getLabels(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
          direction: any(named: 'direction'),
          field: any(named: 'field'),
        ),
      ).thenThrow(const ServerException());
      expect(
        await repository.getLabels(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
          field: 'field',
          direction: 'direction',
        ),
        equals(isA<Left<dynamic, Labels>>()),
      );
    });

    test('- Get labels fail on ContextReadException  test', () async {
      when(
        () => remoteDataSource.getLabels(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
          direction: any(named: 'direction'),
          field: any(named: 'field'),
        ),
      ).thenThrow(const ContextReadException());
      expect(
        await repository.getLabels(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
          field: 'field',
          direction: 'direction',
        ),
        equals(isA<Left<dynamic, Labels>>()),
      );
    });

    test('- Get milestones success test', () async {
      when(
        () => remoteDataSource.getMilestones(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenAnswer((invocation) => Future.value(MilestonesModel()));
      expect(
        await repository.getMilestones(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Right<dynamic, Milestones>>()),
      );
    });

    test('- Get milestones fail on ServerException test', () async {
      when(
        () => remoteDataSource.getMilestones(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenThrow(const ServerException());
      expect(
        await repository.getMilestones(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Left<dynamic, Milestones>>()),
      );
    });

    test('- Get milestones fail on ContextReadException test', () async {
      when(
        () => remoteDataSource.getMilestones(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenThrow(const ContextReadException());
      expect(
        await repository.getMilestones(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Left<dynamic, Milestones>>()),
      );
    });
    test('- Get opened issues success test', () async {
      when(
        localDataSource.getOpenedIssues,
      ).thenAnswer((invocation) => ['']);
      expect(
        repository.getOpenedIssues(),
        equals(isA<Right<dynamic, List>>()),
      );
    });
    test('- Get opened issues fail test', () async {
      when(
        localDataSource.getOpenedIssues,
      ).thenThrow(Exception(''));
      expect(
        repository.getOpenedIssues(),
        equals(isA<Left<dynamic, List>>()),
      );
    });
  });
}
