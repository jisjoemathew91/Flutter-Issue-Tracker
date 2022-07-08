import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issue_detail.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/bloc/issue_details_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/helpers.dart';

void main() {
  group('Issue details Bloc test', () {
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      dotenv.testLoad(
        fileInput: '''
          PROJECT_OWNER=''
          PROJECT_NAME=''
          ''',
      );
    });
    final GetIssueDetail issueDetail = MockGetIssueDetail();
    final issueNode = IssueNode();
    blocTest<IssueDetailsBloc, void>(
      '- Get issue details success test',
      build: () => IssueDetailsBloc(issueDetail),
      act: (bloc) {
        when<Future<Either<Failure, IssueNode>>>(
          () => issueDetail.execute(
            owner: any(named: 'owner'),
            name: any(named: 'name'),
            number: any(named: 'number'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(
            Right(
              issueNode,
            ),
          ),
        );
        bloc.add(const FetchIssueDetailsEvent(issueNumber: 1));
      },
      expect: () => [
        const IssueDetailsState(
          status: IssueDetailsStatus.fetching,
        ),
        IssueDetailsState(
          status: IssueDetailsStatus.fetched,
          issueNode: issueNode,
        ),
      ],
    );
    blocTest<IssueDetailsBloc, void>(
      '- Get issue details fail test',
      build: () => IssueDetailsBloc(issueDetail),
      act: (bloc) {
        when<Future<Either<Failure, IssueNode>>>(
          () => issueDetail.execute(
            owner: any(named: 'owner'),
            name: any(named: 'name'),
            number: any(named: 'number'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(
            const Left(
              ServerFailure('msg'),
            ),
          ),
        );
        bloc.add(const FetchIssueDetailsEvent(issueNumber: 1));
      },
      expect: () => [
        const IssueDetailsState(
          status: IssueDetailsStatus.fetching,
        ),
        const IssueDetailsState(
          status: IssueDetailsStatus.error,
        ),
      ],
    );
  });
  group('Issue details Event test', () {
    test('- Fetch issue details event', () {
      const event = FetchIssueDetailsEvent(issueNumber: 1);
      expect(event.props, [1]);
    });
  });
  group('Issue details State test', () {
    test('- Issue details state test', () {
      final issueNode = IssueNode();
      const status = IssueDetailsStatus.fetched;
      final state = IssueDetailsState(
        issueNode: issueNode,
        status: status,
      );
      expect(state.props, [status, issueNode]);
      expect(state.copyWith(), state);
    });
  });
}
