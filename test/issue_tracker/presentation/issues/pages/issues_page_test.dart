import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/pages/issue_details_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/pages/issues_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/filter_bottom_sheet.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_direction_dialog.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_list_tile.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_states_dialog.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_themes/stacked_themes.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/theme.dart';

void main() {
  final ThemeService service = MockThemeService();
  setUpAll(() {
    initTheme();
    dotenv.testLoad(
      fileInput: '''
        PROJECT_OWNER=''
        PROJECT_NAME=''
        ''',
    );
    locator
      ..registerLazySingleton<IssuesBloc>(MockIssuesBloc.new)
      ..registerLazySingleton<ThemeBloc>(() => ThemeBloc(service));
    when(() => service.isDarkMode).thenAnswer((invocation) => false);
    when(service.toggleDarkLightTheme).thenAnswer((invocation) => false);
  });

  testWidgets('Issue page render test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [const IssuesState()],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => const IssuesPage(),
      bloc: locator<ThemeBloc>(),
    );
    await tester.pump();
  });

  testWidgets('Lists issues test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()
              ..nodes = [
                IssueNode()
                  ..number = 1
                  ..labels = (Labels()
                    ..nodes = [
                      LabelNode(
                        name: 'name',
                        color: 'FFFFFF',
                        id: 'id',
                      )
                    ])
              ],
            issuesStatus: IssuesStatus.fetched,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
      routes: {
        '/issue_detail': (context) => const IssueDetailPage(),
      },
    );
    await tester.pumpAndSettle();
    final widget = find.byType(IssueListTile);
    expect(widget, findsOneWidget);
    await tester.tap(widget);
  });

  testWidgets('Show clear filter cip test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()..nodes = [IssueNode()..number = 1],
            issuesStatus: IssuesStatus.fetched,
            states: 'ASC',
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(const Key('clearAllChip'));
    expect(widget, findsOneWidget);
    await tester.tap(widget);
  });

  testWidgets('states filter chip test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()..nodes = [IssueNode()..number = 1],
            issuesStatus: IssuesStatus.fetched,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(const Key('issueStateFilter'));
    expect(widget, findsOneWidget);
    await tester.tap(widget);
    await tester.pumpAndSettle();
    expect(find.byType(IssueStatesDialog), findsOneWidget);
  });

  testWidgets('Label filter chip test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()..nodes = [IssueNode()..number = 1],
            issuesStatus: IssuesStatus.fetched,
            labelsStatus: LabelsStatus.fetched,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(const Key('labelFilter'));
    expect(widget, findsOneWidget);
    await tester.tap(widget);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheetComponent), findsOneWidget);
  });

  testWidgets('Assignee filter chip test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()..nodes = [IssueNode()..number = 1],
            issuesStatus: IssuesStatus.fetched,
            assignableUsersStatus: AssignableUsersStatus.fetched,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(const Key('assigneeFilter'));
    expect(widget, findsOneWidget);
    await tester.tap(widget);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheetComponent), findsOneWidget);
  });

  testWidgets('Milestone filter chip test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()..nodes = [IssueNode()..number = 1],
            issuesStatus: IssuesStatus.fetched,
            milestonesStatus: MilestonesStatus.fetched,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(
      const Key('milestoneFilter'),
      skipOffstage: false,
    );
    expect(widget, findsOneWidget);
    await tester.ensureVisible(widget);
    await tester.pumpAndSettle();
    await tester.tap(widget);
    await tester.pumpAndSettle();
    expect(find.byType(BottomSheetComponent), findsOneWidget);
  });

  testWidgets('Sort chip test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            issues: Issues()..nodes = [IssueNode()..number = 1],
            issuesStatus: IssuesStatus.fetched,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(
      const Key('sortChip'),
      skipOffstage: false,
    );
    expect(widget, findsOneWidget);
    await tester.ensureVisible(widget);
    await tester.pumpAndSettle();
    await tester.tap(widget);
    await tester.pumpAndSettle();
    expect(find.byType(IssueDirectionDialog), findsOneWidget);
  });

  testWidgets('Show error text on Error status test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          const IssuesState(
            issuesStatus: IssuesStatus.error,
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => locator<IssuesBloc>()),
          BlocProvider(create: (_) => locator<ThemeBloc>()),
        ],
        child: IssuesPageView(),
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(
      const Key('errorText'),
      skipOffstage: false,
    );
    expect(widget, findsOneWidget);
  });
  testWidgets('Golden test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [const IssuesState()],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      bloc: locator<ThemeBloc>(),
      widgetBuilder: () => const IssuesPage(),
    );
    await tester.pump();
  });
}
