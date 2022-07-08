import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/label_list_tile.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_themes/stacked_themes.dart';
import '../../../../helpers/helpers.dart';
import '../../../../helpers/theme.dart';

void main() {
  final ThemeService service = MockThemeService();
  final labelNode = LabelNode();
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

  testWidgets('shows check icon when selected test', (tester) async {
    whenListen(
      locator<IssuesBloc>(),
      Stream.fromIterable(
        [
          IssuesState(
            selectedLabels: Labels()
              ..nodes = [
                labelNode,
              ],
          )
        ],
      ),
      initialState: const IssuesState(),
    );
    await tester.pumpApp(
      wrapWithMaterial: true,
      wrapWithTheme: true,
      bloc: locator<IssuesBloc>(),
      widgetBuilder: () => LabelListTile(
        label: labelNode,
        onTap: () {},
      ),
    );
    await tester.pumpAndSettle();
    final widget = find.byType(Icon);
    expect(widget, findsOneWidget);
  });
}
