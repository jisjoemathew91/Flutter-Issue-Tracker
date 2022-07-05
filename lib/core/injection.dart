import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/connectivity/presentation/bloc/connectivity_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/issue_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/repository/issue_repository_impl.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issue_detail.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/bloc/issue_details_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked_themes/stacked_themes.dart';

final locator = GetIt.I;

Future<void> init() async {
  locator

    // external
    ..registerSingleton(ThemeService.getInstance())
    ..registerLazySingleton<GraphQLClient>(
      () => GraphQLClient(
        link: AuthLink(
          getToken: () => 'Bearer ${dotenv.env['PERSONAL_ACCESS_TOKEN']}',
        ).concat(HttpLink('${dotenv.env['API_URL']}')),

        /// The default store is the InMemoryStore,
        /// which does NOT persist data to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    )
    ..registerSingleton(DataConnectionChecker())

    // bloc
    ..registerFactory(
      () => IssuesBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ),
    )
    ..registerFactory(() => IssueDetailsBloc(locator()))
    ..registerFactory(() => ThemeBloc(locator()))
    ..registerSingleton(ConnectivityBloc(locator()))

    // usecase
    ..registerLazySingleton(() => GetIssues(locator()))
    ..registerLazySingleton(() => GetLabels(locator()))
    ..registerLazySingleton(() => GetAssignableUsers(locator()))
    ..registerLazySingleton(() => GetMilestones(locator()))
    ..registerLazySingleton(() => GetIssueDetail(locator()))

    // repository
    ..registerLazySingleton<IssueRepository>(
      () => IssueRepositoryImpl(locator()),
    )

    // data source
    ..registerLazySingleton<IssueDataSource>(
      () => IssueDataSourceImpl(locator()),
    );
}
