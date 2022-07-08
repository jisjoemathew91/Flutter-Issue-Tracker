import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/label_list_tile.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/labels_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked_themes/stacked_themes.dart';
import '../../../../helpers/helpers.dart';

void main() {
  late IssuesBloc issuesBloc;
  final labelNode = LabelNode();

  setUpAll(() {
    ThemeManager.initialise();
    dotenv.testLoad(
      fileInput: '''
        PROJECT_OWNER=''
        PROJECT_NAME=''
      ''',
    );
    locator.registerLazySingleton<IssuesBloc>(MockIssuesBloc.new);
    issuesBloc = locator<IssuesBloc>();
  });

  testWidgets('- When loaded state the LabelListTile is rendered',
      (widgetTester) async {
    when(() => issuesBloc.state).thenAnswer(
      (_) => IssuesState(
        labelsStatus: LabelsStatus.fetched,
        labels: Labels()
          ..nodes = [
            labelNode,
          ],
      ),
    );
    await widgetTester.pumpApp(
      widgetBuilder: () {
        return LabelsList(refreshController: RefreshController());
      },
      bloc: issuesBloc,
      wrapWithTheme: true,
      wrapWithMaterial: true,
    );
    expect(find.byType(LabelListTile), findsOneWidget);
  });

  testWidgets('- When loading state the progress indicator is rendered',
      (widgetTester) async {
    when(() => issuesBloc.state).thenAnswer(
      (_) => const IssuesState(),
    );
    await widgetTester.pumpApp(
      widgetBuilder: () {
        return LabelsList(refreshController: RefreshController());
      },
      bloc: issuesBloc,
      wrapWithTheme: true,
      wrapWithMaterial: true,
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('- When state is error, error text is rendered',
      (widgetTester) async {
    when(() => issuesBloc.state).thenAnswer(
      (_) => const IssuesState(
        labelsStatus: LabelsStatus.error,
      ),
    );

    await widgetTester.pumpApp(
      widgetBuilder: () {
        return LabelsList(refreshController: RefreshController());
      },
      bloc: issuesBloc,
      wrapWithTheme: true,
      wrapWithMaterial: true,
    );
    expect(find.byKey(const Key('labelsListErrorKey')), findsOneWidget);
  });
}
