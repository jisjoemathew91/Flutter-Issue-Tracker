import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/local/issue_local_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/remote/issue_remote_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issue_detail.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_opened_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/set_issue_opened.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/bloc/issue_details_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_themes/stacked_themes.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

class MockIssueRemoteDataSource extends Mock implements IssueRemoteDataSource {}

class MockIssueLocalDataSource extends Mock implements IssueLocalDataSource {}

class MockIssueRepository extends Mock implements IssueRepository {}

class MockGetIssueDetail extends Mock implements GetIssueDetail {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockIssueDetailsBloc
    extends MockBloc<IssueDetailsEvent, IssueDetailsState>
    implements IssueDetailsBloc {}

class MockIssuesBloc extends MockBloc<IssuesEvent, IssuesState>
    implements IssuesBloc {}

class MockSplashBloc extends MockBloc<SplashEvent, SplashState>
    implements SplashBloc {}

class MockThemeService extends Mock implements ThemeService {}

class MockGetMilestones extends Mock implements GetMilestones {}

class MockGetAssignableUsers extends Mock implements GetAssignableUsers {}

class MockGetLabels extends Mock implements GetLabels {}

class MockGetIssues extends Mock implements GetIssues {}

class MockGetIssuesOpened extends Mock implements GetOpenedIssues {}

class MockSetOpenedIssues extends Mock implements SetIssueOpened {}

class MockThemeBloc extends MockBloc<ThemeEvent, ThemeState>
    implements ThemeBloc {}
