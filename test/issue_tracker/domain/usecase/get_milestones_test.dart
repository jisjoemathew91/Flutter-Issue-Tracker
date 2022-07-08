import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_milestones.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get milestones users test', () {
    final IssueRepository repository = MockIssueRepository();
    final getMilestones = GetMilestones(repository);
    test('- Execute test', () async {
      when(
        () => repository.getMilestones(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Right(
            Milestones(),
          ),
        ),
      );
      expect(
        await getMilestones.execute(
          owner: 'owner',
          name: 'name',
          limit: 1,
          nextToken: 'token',
        ),
        equals(isA<Right<dynamic, Milestones>>()),
      );
    });
  });
}
