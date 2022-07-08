import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/pages/issues_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/splash/pages/splash_page.dart';
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
      ..registerLazySingleton<SplashBloc>(MockSplashBloc.new)
      ..registerLazySingleton<IssuesBloc>(MockIssuesBloc.new)
      ..registerLazySingleton<ThemeBloc>(() => ThemeBloc(service));
    when(() => service.isDarkMode).thenAnswer((invocation) => false);
    when(service.toggleDarkLightTheme).thenAnswer((invocation) => false);
  });
  testWidgets('- Splash View Render test', (tester) async {
    whenListen(
      locator<SplashBloc>(),
      Stream.fromIterable(
        [const SplashState(status: SplashStatus.waiting)],
      ),
      initialState: const SplashState(),
    );
    await tester.pumpApp(
      routes: {'/issues': (_) => const IssuesPage()},
      widgetBuilder: () => const SplashPageView(),
      bloc: locator<SplashBloc>(),
    );
  });
}
