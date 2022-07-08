import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/failure.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/assignable_users_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/issue_node_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/labels_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/model/milestones_model.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestone_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_opened_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/set_issue_opened.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/mock_jsons.dart';

void main() {
  late GetIssues getIssues;
  late GetLabels getLabels;
  late GetAssignableUsers getAssignableUsers;
  late GetMilestones getMilestones;
  late GetOpenedIssues getOpenedIssues;

  final issueNodeModel = IssueNodeModel.fromJson(mockIssueJson);
  final labelsModel = LabelsModel.fromJson(mockLabelsJson);
  final assignableUsersModel = AssignableUsersModel.fromJson(
    mockAssignableUsersJson,
  );
  final milestonesModel = MilestonesModel.fromJson(mockMileStoneJson);

  final assignableUsers = assignableUsersModel.toEntity();
  final milestones = milestonesModel.toEntity();
  final issueNode = issueNodeModel.toEntity();
  final labelsNode = labelsModel.toEntity();

  final selectedLabels = labelsNode;
  final issues = Issues(nodes: [issueNode]);
  final previousIssue = Issues(nodes: [issueNode]);
  final openedIssues = <String>['1234df', 'df3455'];

  setUpAll(() async {
    dotenv.testLoad(
      fileInput: '''
          PROJECT_OWNER=''
          PROJECT_NAME=''
          ''',
    );
    locator
      ..registerLazySingleton<GetMilestones>(MockGetMilestones.new)
      ..registerLazySingleton<GetAssignableUsers>(MockGetAssignableUsers.new)
      ..registerLazySingleton<GetLabels>(MockGetLabels.new)
      ..registerLazySingleton<GetIssues>(MockGetIssues.new)
      ..registerLazySingleton<GetOpenedIssues>(MockGetIssuesOpened.new)
      ..registerLazySingleton<SetIssueOpened>(MockSetOpenedIssues.new)
      ..registerFactory(
        () => IssuesBloc(
          locator(),
          locator(),
          locator(),
          locator(),
          locator(),
          locator(),
        ),
      );
    getMilestones = locator<GetMilestones>();
    getAssignableUsers = locator<GetAssignableUsers>();
    getLabels = locator<GetLabels>();
    getIssues = locator<GetIssues>();
    getOpenedIssues = locator<GetOpenedIssues>();
  });

  group(
    '- Issues Bloc tests',
    () {
      group(' - FetchIssuesEvent test ', () {
        blocTest<IssuesBloc, IssuesState>(
          '- on FetchIssuesEvent when initial is true and when success, the'
          ' usecase will return a list of issues',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchIssuesEvent(isInitial: true)),
          wait: const Duration(milliseconds: 900),
          expect: () => [
            IssuesState(openedIssues: openedIssues),
            IssuesState(
              issuesStatus: IssuesStatus.fetching,
              openedIssues: openedIssues,
            ),
            IssuesState(
              issuesStatus: IssuesStatus.fetched,
              issues: issues,
              openedIssues: openedIssues,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- When initial is false and when the event is success a list of '
          'issues appended to previous list will be returned',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchIssuesEvent()),
          seed: () => IssuesState(
            issues: issues,
            issuesStatus: IssuesStatus.fetched,
            openedIssues: openedIssues,
          ),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              issuesStatus: IssuesStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
            ),
            IssuesState(
              issuesStatus: IssuesStatus.fetched,
              issues: issues
                ..nodes = ((issues.nodes ?? []) + (previousIssue.nodes ?? [])),
              openedIssues: openedIssues,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- When the call fails on FetchIssuesEvent the status will be '
          'IssuesStatus.error',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => const Right([]));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer(
              (_) async => const Left(
                ServerFailure('Failed to fetch issues'),
              ),
            );

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchIssuesEvent()),
          wait: const Duration(seconds: 1),
          expect: () => [
            const IssuesState(openedIssues: []),
            const IssuesState(
              issuesStatus: IssuesStatus.fetching,
              openedIssues: [],
            ),
            const IssuesState(
              issuesStatus: IssuesStatus.error,
              openedIssues: [],
            ),
          ],
        );
      });

      group('- FetchLabelsEvent test', () {
        blocTest<IssuesBloc, IssuesState>(
          '- on FetchLabelsEvent when initial is false and when success, the'
          ' usecase will return a list of labels',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getLabels.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(labelsNode));

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchLabelsEvent()),
          skip: 3,
          seed: () => const IssuesState(),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              labelsStatus: LabelsStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              labelsStatus: LabelsStatus.fetched,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
              labels: labelsNode,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- on FetchLabelsEvent when initial is true and when success, the'
          ' usecase will return a list of labels',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getLabels.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(labelsNode));

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchLabelsEvent(isInitial: true)),
          skip: 3,
          seed: () => IssuesState(selectedLabels: selectedLabels),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              labelsStatus: LabelsStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
              selectedLabels: labelsNode,
            ),
            IssuesState(
              labelsStatus: LabelsStatus.fetched,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
              labels: labelsNode,
              selectedLabels: selectedLabels,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- on FetchLabelsEvent returns the status as error',
          build: () {
            // arrange

            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getLabels.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer(
              (_) async => const Left(ServerFailure('Failed to fetch labels')),
            );

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchLabelsEvent()),
          skip: 3,
          seed: () => const IssuesState(),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              labelsStatus: LabelsStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              labelsStatus: LabelsStatus.error,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
          ],
        );
      });

      group('- FetchAssignableUsersEvent test', () {
        blocTest<IssuesBloc, IssuesState>(
          '- on FetchAssignableUsersEvent ',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getAssignableUsers.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(assignableUsers));

            return locator<IssuesBloc>();
          },
          act: (bloc) =>
              bloc.add(const FetchAssignableUsersEvent(isInitial: true)),
          skip: 3,
          seed: () => const IssuesState(),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              assignableUsersStatus: AssignableUsersStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              assignableUsersStatus: AssignableUsersStatus.fetched,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
              assignableUsers: assignableUsers,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- on FetchAssignableUsersEvent error',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getAssignableUsers.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer(
              (_) async => const Left(
                ServerFailure('Failed to get assignable users'),
              ),
            );

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(
            const FetchAssignableUsersEvent(
              isInitial: true,
            ),
          ),
          skip: 3,
          seed: () => const IssuesState(),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              assignableUsersStatus: AssignableUsersStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              assignableUsersStatus: AssignableUsersStatus.error,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
          ],
        );
      });

      group('- FetchMilestonesEvent test', () {
        blocTest<IssuesBloc, IssuesState>(
          '- on FetchMilestonesEvent ',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getMilestones.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(milestones));

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(const FetchMilestonesEvent(isInitial: true)),
          skip: 3,
          seed: () => const IssuesState(),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              milestonesStatus: MilestonesStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              milestonesStatus: MilestonesStatus.fetched,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
              milestones: milestones,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- on FetchMilestonesEvent fails the status will be error',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            when(
              () => getMilestones.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer(
              (_) async => const Left(
                ServerFailure('Failed to get milestones list'),
              ),
            );

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(
            const FetchMilestonesEvent(
              isInitial: true,
            ),
          ),
          skip: 3,
          seed: () => const IssuesState(),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              milestonesStatus: MilestonesStatus.fetching,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              milestonesStatus: MilestonesStatus.error,
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
          ],
        );
      });

      group('- _onUpdateSelectedAssignableUsers event tests', () {
        blocTest<IssuesBloc, IssuesState>(
          '- when selected user login and assignable user login are same',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          seed: () => IssuesState(
            assignableUsers: assignableUsers,
            assignableUsersStatus: AssignableUsersStatus.fetched,
            selectedAssignableUser: assignableUsers.nodes![0],
          ),
          act: (bloc) => bloc.add(
            UpdateSelectedAssignableUsersEvent(
              assignableUser: assignableUsers.nodes![0],
            ),
          ),
          skip: 3,
          wait: const Duration(seconds: 1),
          expect: () => [
            const IssuesState().copyWith(
              clearAssignableUser: true,
              issuesStatus: IssuesStatus.fetched,
              assignableUsersStatus: AssignableUsersStatus.fetched,
              issues: issues,
              assignableUsers: assignableUsers,
              openedIssues: openedIssues,
            ),
          ],
        );

        blocTest<IssuesBloc, IssuesState>(
          '- when selected user login and assignable user login are not same',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          seed: () => IssuesState(
            assignableUsers: assignableUsers,
            assignableUsersStatus: AssignableUsersStatus.fetched,
            selectedAssignableUser: assignableUsers.nodes![1],
          ),
          act: (bloc) => bloc.add(
            UpdateSelectedAssignableUsersEvent(
              assignableUser: assignableUsers.nodes![0],
            ),
          ),
          skip: 3,
          wait: const Duration(seconds: 1),
          expect: () => [
            const IssuesState().copyWith(
              issuesStatus: IssuesStatus.fetched,
              assignableUsersStatus: AssignableUsersStatus.fetched,
              issues: issues,
              assignableUsers: assignableUsers,
              openedIssues: openedIssues,
              selectedAssignableUser: assignableUsers.nodes![0],
            ),
          ],
        );
      });

      group('- _onUpdateDirection event test', () {
        blocTest<IssuesBloc, IssuesState>(
          '- Update direction ',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          act: (bloc) => bloc.add(
            const UpdateDirectionEvent(
              direction: 'direction',
            ),
          ),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              openedIssues: openedIssues,
            ),
            IssuesState(
              openedIssues: openedIssues,
              direction: 'direction',
            ),
            IssuesState(
              openedIssues: openedIssues,
              direction: 'direction',
              issuesStatus: IssuesStatus.fetching,
            ),
            IssuesState(
              openedIssues: openedIssues,
              issues: issues,
              direction: 'direction',
              issuesStatus: IssuesStatus.fetched,
            ),
          ],
        );
      });

      group('- _onUpdateSelectedMilestones event test', () {
        final milestoneNode = MilestoneNode(number: 1);
        blocTest<IssuesBloc, IssuesState>(
          '- Remove milestone when same selected',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          seed: () => IssuesState(selectedMilestone: milestoneNode),
          act: (bloc) => bloc.add(
            UpdateSelectedMilestonesEvent(milestone: MilestoneNode(number: 1)),
          ),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              openedIssues: openedIssues,
              selectedMilestone: milestoneNode,
            ),
            IssuesState(
              openedIssues: openedIssues,
            ),
            IssuesState(
              openedIssues: openedIssues,
              issuesStatus: IssuesStatus.fetching,
            ),
            IssuesState(
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
          ],
        );
      });

      group('- _onUpdateState event test', () {
        blocTest<IssuesBloc, IssuesState>(
          '- Update state ',
          build: () {
            // arrange
            when(() => getOpenedIssues.execute())
                .thenAnswer((_) => Right(openedIssues));

            when(
              () => getIssues.execute(
                owner: any(named: 'owner'),
                name: any(named: 'name'),
                limit: any(named: 'limit'),
                labelLimit: any(named: 'labelLimit'),
                states: any(named: 'states'),
                direction: any(named: 'direction'),
                field: any(named: 'field'),
                labels: any(named: 'labels'),
                milestone: any(named: 'milestone'),
                assignee: any(named: 'assignee'),
                nextToken: any(named: 'nextToken'),
              ),
            ).thenAnswer((_) async => Right(issues));

            return locator<IssuesBloc>();
          },
          seed: () => IssuesState(
            issues: issues,
            issuesStatus: IssuesStatus.fetched,
            states: 'CLOSED',
          ),
          act: (bloc) => bloc.add(
            const UpdateStateEvent(
              states: 'OPEN',
            ),
          ),
          wait: const Duration(seconds: 1),
          expect: () => [
            IssuesState(
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
              states: 'CLOSED',
            ),
            IssuesState(
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
            IssuesState(
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetching,
            ),
            IssuesState(
              openedIssues: openedIssues,
              issues: issues,
              issuesStatus: IssuesStatus.fetched,
            ),
          ],
        );
      });
    },
  );

  group('- Issue state tests', () {
    test('- Length of the props present is 14', () {
      const issueState = IssuesState();
      expect(issueState.props.length, 14);
    });

    test('- IssueState constructor test', () {
      final issueState = IssuesState(
        milestones: milestones,
        openedIssues: openedIssues,
        issues: issues,
        issuesStatus: IssuesStatus.fetched,
        labelsStatus: LabelsStatus.fetched,
        labels: labelsNode,
        milestonesStatus: MilestonesStatus.fetched,
        assignableUsersStatus: AssignableUsersStatus.fetched,
        assignableUsers: assignableUsers,
        selectedAssignableUser: assignableUsers.nodes![0],
        selectedLabels: selectedLabels,
      );
      expect(issueState.assignableUsersStatus, AssignableUsersStatus.fetched);
      expect(issueState.assignableUsers, assignableUsers);

      expect(issueState.nextToken, issues.pageInfo?.endCursor);
      expect(issueState.nextTokenLabel, labelsNode.pageInfo?.endCursor);
      expect(
        issueState.nextTokenAssignableUsers,
        assignableUsers.pageInfo?.endCursor,
      );
      expect(issueState.nextTokenMilestones, milestones.pageInfo?.endCursor);
      expect(issueState.hasMoreIssues, issues.pageInfo?.hasNextPage == true);
      expect(
        issueState.hasMoreLabels,
        labelsNode.pageInfo?.hasNextPage == true,
      );
      expect(
        issueState.hasMoreAssignableUsers,
        assignableUsers.pageInfo?.hasNextPage == true,
      );
      expect(
        issueState.hasMoreMilestones,
        milestones.pageInfo?.hasNextPage == true,
      );
      expect(
        issueState.queryLabels,
        selectedLabels.nodes!.map((l) => l.name ?? '').toList(),
      );
      expect(issueState.labelChipTitle, '2 Labels');
      expect(issueState.highlightLabelChip, true);
      expect(issueState.assigneeChipTitle, assignableUsers.nodes![0].login);
      expect(issueState.highlightAssigneeChip, true);
      expect(issueState.showClearFilter, true);
    });
  });

  group('- Issues Event tests', () {
    test('- Fetch Issues event', () {
      const event = FetchIssuesEvent();
      expect(event.props.length, 1);
      expect(event.props[0], false);

      const newEvent = FetchIssuesEvent(isInitial: true);
      expect(newEvent.props[0], true);
    });

    test('- Fetch Labels event', () {
      const event = FetchLabelsEvent();
      expect(event.props.length, 1);
      expect(event.props[0], false);

      const newEvent = FetchLabelsEvent(isInitial: true);
      expect(newEvent.props[0], true);
    });

    test('- FetchAssignableUsersEvent event', () {
      const event = FetchAssignableUsersEvent();
      expect(event.props.length, 1);
      expect(event.props[0], false);

      const newEvent = FetchAssignableUsersEvent(isInitial: true);
      expect(newEvent.props[0], true);
    });

    test('- FetchMilestonesEvent event', () {
      const event = FetchMilestonesEvent();
      expect(event.props.length, 1);
      expect(event.props[0], false);

      const newEvent = FetchMilestonesEvent(isInitial: true);
      expect(newEvent.props[0], true);
    });

    test('- UpdateStateEvent event', () {
      const event = UpdateStateEvent(states: 'CLOSED');
      expect(event.props.length, 1);
      expect(event.props[0], 'CLOSED');
    });

    test('- UpdateSelectedLabelsEvent event', () {
      final event = UpdateSelectedLabelsEvent(label: labelsNode.nodes![0]);
      expect(event.label, isA<LabelNode>());
    });

    test('- UpdateSelectedAssignableUsersEvent event', () {
      final event = UpdateSelectedAssignableUsersEvent(
        assignableUser: assignableUsers.nodes![0],
      );
      expect(event.assignableUser, isA<AssignableUserNode>());
    });

    test('- UpdateDirectionEvent event', () {
      const event = UpdateDirectionEvent(direction: 'DESC');
      expect(event.direction, 'DESC');
    });

    test('- ClearFilterEvent event', () {
      const event = ClearFilterEvent();
      expect(event.props.isEmpty, true);
    });

    test('- GetOpenedIssuesEvent event', () {
      const event = GetOpenedIssuesEvent();
      expect(event.props.isEmpty, true);
    });

    test('- SetIssueOpenedEvent event', () {
      const event = SetIssueOpenedEvent(number: 1324);
      expect(event.number, 1324);
    });
  });
}
