import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issue_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';

void main() {
  group('Get issue detail test', () {
    final IssueRepository repository = MockIssueRepository();
    final getIssueDetail = GetIssueDetail(repository);

    test('- Execute test', () async {
      when(
        () => repository.getIssueDetails(
          owner: any(named: 'owner'),
          name: any(named: 'name'),
          number: 1,
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Right(
            IssueNode(),
          ),
        ),
      );
      expect(
        await getIssueDetail.execute(
          owner: 'owner',
          name: 'name',
          number: 1,
        ),
        equals(isA<Right<dynamic, IssueNode>>()),
      );
    });
  });
}
