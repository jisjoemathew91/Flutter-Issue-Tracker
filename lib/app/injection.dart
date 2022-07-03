import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/datasource/issue_datasource.dart';
import 'package:flutter_issue_tracker/issue_tracker/data/repository/issue_repository_impl.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/repository/issue_repository.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issue_detail.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final locator = GetIt.I;

Future<void> init() async {
  locator

    // bloc
    ..registerFactory(() => IssuesBloc(locator()))

    // usecase
    ..registerLazySingleton(() => GetIssues(locator()))
    ..registerLazySingleton(() => GetIssueDetail(locator()))

    // repository
    ..registerLazySingleton<IssueRepository>(
      () => IssueRepositoryImpl(locator()),
    )

    // data source
    ..registerLazySingleton<IssueDataSource>(
      () => IssueDataSourceImpl(locator()),
    )

    // external
    ..registerLazySingleton<GraphQLClient>(
      () => GraphQLClient(
        link: AuthLink(
          getToken: () => 'Bearer ${dotenv.env['PERSONAL_ACCESS_TOKEN']}',
        ).concat(HttpLink('${dotenv.env['API_URL']}')),

        /// The default store is the InMemoryStore,
        /// which does NOT persist data to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
}
