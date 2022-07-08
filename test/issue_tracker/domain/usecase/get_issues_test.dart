import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get issues test', () {
    final IssueRepository repository = MockIssueRepository();
    final getIssues = GetIssues(repository);
    test('- Execute test', () async {
      when(
        () => repository.getIssues(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          states: any(named: 'states'),
          labelLimit: any(named: 'labelLimit'),
          assignee: any(named: 'assignee'),
          milestone: any(named: 'milestone'),
          direction: any(named: 'direction'),
          field: any(named: 'field'),
          nextToken: any(named: 'nextToken'),
          labels: any(named: 'labels'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Right(
            Issues(),
          ),
        ),
      );
      expect(
        await getIssues.execute(
          owner: 'owner',
          name: 'name',
          labelLimit: 1,
          states: 'states',
          limit: 1,
          nextToken: 'token',
          field: 'field',
          direction: 'direction',
          milestone: 'milestone',
          assignee: 'assignee',
          labels: [],
        ),
        equals(isA<Right<dynamic, Issues>>()),
      );
    });
  });
}
