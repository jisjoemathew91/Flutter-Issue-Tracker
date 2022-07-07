import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_opened_issues.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get opened issues test', () {
    final IssueRepository repository = MockIssueRepository();
    final getOpenedIssues = GetOpenedIssues(repository);
    test('- Execute test', () async {
      when(
        repository.getOpenedIssues,
      ).thenAnswer(
        (invocation) => const Right(
          [''],
        ),
      );
      expect(
        getOpenedIssues.execute(),
        equals(isA<Right<dynamic, List<String>>>()),
      );
    });
  });
}
