import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_assignable_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get assignable users test', () {
    final IssueRepository repository = MockIssueRepository();
    final getAssignableUsers = GetAssignableUsers(repository);
    test('- Execute test', () async {
      when(
        () => repository.getAssignableUsers(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Right(AssignableUsers()),
        ),
      );
      expect(
        await getAssignableUsers.execute(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Right<dynamic, AssignableUsers>>()),
      );
    });
  });
}
