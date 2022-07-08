import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/bloc/issue_details_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/pages/issue_details_page.dart';
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
    locator
      ..registerLazySingleton<IssueDetailsBloc>(MockIssueDetailsBloc.new)
      ..registerLazySingleton<ThemeBloc>(() => ThemeBloc(service));
    when(() => service.isDarkMode).thenAnswer((invocation) => false);
    when(service.toggleDarkLightTheme).thenAnswer((invocation) => false);
  });
  testWidgets('Issue details page render test', (tester) async {
    whenListen(
      locator<IssueDetailsBloc>(),
      Stream.fromIterable(
        [
          IssueDetailsState(
            issueNode: IssueNode()..createdAt = (DateTime(2000).toString()),
          )
        ],
      ),
      initialState: const IssueDetailsState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => const IssueDetailPage(),
      bloc: locator<ThemeBloc>(),
    );
    await tester.pump();
  });
  testWidgets('Issue details page pop test', (tester) async {
    whenListen(
      locator<IssueDetailsBloc>(),
      Stream.fromIterable(
        [const IssueDetailsState()],
      ),
      initialState: const IssueDetailsState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => const IssueDetailPage(),
      bloc: locator<ThemeBloc>(),
    );
    final widget = find.byType(IconButton);
    expect(widget, findsOneWidget);
    await tester.tap(widget);
  });
  testWidgets('Circular progress indicator on fetching status test',
      (tester) async {
    whenListen(
      locator<IssueDetailsBloc>(),
      Stream.fromIterable(
        [
          const IssueDetailsState(
            status: IssueDetailsStatus.fetching,
          )
        ],
      ),
      initialState: const IssueDetailsState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => const IssueDetailPage(),
      bloc: locator<ThemeBloc>(),
    );
    await tester.pump();
    final widget = find.byType(CircularProgressIndicator);
    expect(widget, findsOneWidget);
  });
  testWidgets('Error text on error status test', (tester) async {
    whenListen(
      locator<IssueDetailsBloc>(),
      Stream.fromIterable(
        [
          const IssueDetailsState(
            status: IssueDetailsStatus.error,
          )
        ],
      ),
      initialState: const IssueDetailsState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      widgetBuilder: () => const IssueDetailPage(),
      bloc: locator<ThemeBloc>(),
    );
    await tester.pump();
    final widget = find.byKey(const Key('errorText'));
    expect(widget, findsOneWidget);
  });
}
