import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_labels.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get labels test', () {
    final IssueRepository repository = MockIssueRepository();
    final getLabels = GetLabels(repository);
    test('- Execute test', () async {
      when(
        () => repository.getLabels(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          limit: any(named: 'limit'),
          nextToken: any(named: 'nextToken'),
          field: any(named: 'field'),
          direction: any(named: 'direction'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Right(
            Labels(),
          ),
        ),
      );
      expect(
        await getLabels.execute(
          owner: 'owner',
          name: 'name',
          limit: 1,
          direction: 'direction',
          field: 'field',
          nextToken: 'nextToken',
        ),
        equals(isA<Right<dynamic, Labels>>()),
      );
    });
  });
}
