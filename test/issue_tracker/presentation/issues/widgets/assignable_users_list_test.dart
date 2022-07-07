import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/assignable_users_list.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/assignable_users_list_tile.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked_themes/stacked_themes.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/theme.dart';

void main() {
  final ThemeService service = MockThemeService();
  setUpAll(() {
    initTheme();
    HttpOverrides.global = HttpOverrides.current;
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

  testWidgets('CircularProgress indicator on null status test', (tester) async {
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
      bloc: locator<IssuesBloc>(),
      widgetBuilder: () =>
          AssignableUsersList(refreshController: RefreshController()),
    );
    final widget = find.byType(CircularProgressIndicator);
    expect(widget, findsOneWidget);
  });

  testWidgets('Shows error text on Error status test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          const IssuesState(
            assignableUsersStatus: AssignableUsersStatus.error,
          )
        ],
      ),
      initialState: const IssuesState(),
    );

    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      bloc: locator<IssuesBloc>(),
      widgetBuilder: () =>
          AssignableUsersList(refreshController: RefreshController()),
    );
    await tester.pumpAndSettle();
    final widget = find.byKey(const Key('errorText'));
    expect(widget, findsOneWidget);
  });

  testWidgets('List AssignableUsersListTile when assignableUsers not null',
      (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            assignableUsersStatus: AssignableUsersStatus.fetched,
            assignableUsers: AssignableUsers(
              nodes: [
                AssignableUserNode()..avatarUrl = '',
              ],
            ),
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await mockNetworkImagesFor(() async {
      await tester.pumpApp(
        wrapWithMaterial: true,
        wrapWithTheme: true,
        bloc: locator<IssuesBloc>(),
        widgetBuilder: () => AssignableUsersList(
          refreshController: RefreshController(),
        ),
      );
      await tester.pumpAndSettle();
      final widget = find.byType(AssignableUsersListTile);
      expect(widget, findsOneWidget);
      await tester.tap(widget);
    });
  });
}
