import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/set_issue_opened.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get milestones users test', () {
    final IssueRepository repository = MockIssueRepository();
    final setIssueOpened = SetIssueOpened(repository);
    test('- Execute test', () async {
      when(
        () => repository.setIssueOpened(numbers: []),
      ).thenAnswer(
        (invocation) => Future.value(
          const Right(
            true,
          ),
        ),
      );
      expect(
        await setIssueOpened.execute(numbers: []),
        equals(isA<Right<dynamic, bool>>()),
      );
    });
  });
}
