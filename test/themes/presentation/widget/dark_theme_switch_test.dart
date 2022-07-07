import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_issue_tracker/themes/presentation/widget/dark_theme_switch.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../helpers/helpers.dart';
import '../../../helpers/theme.dart';

void main() {
  late ThemeBloc themeBloc;

  setUpAll(() async {
    await initTheme();
    locator.registerLazySingleton<ThemeBloc>(MockThemeBloc.new);
    themeBloc = locator<ThemeBloc>();
  });

  group('Dark Theme Switch Widget test', () {
    testWidgets(
      'DarkThemeSwitch widget render test',
      (WidgetTester tester) async {
        when(() => themeBloc.state).thenReturn(
          const ThemeState(
            isDarkMode: true,
          ),
        );

        await tester.pumpApp<ThemeBloc>(
          widgetBuilder: () => const DarkThemeSwitch(),
          bloc: themeBloc,
          wrapWithTheme: true,
          wrapWithMaterial: true,
        );
        expect(find.byKey(const Key('darkThemeSwitchKey')), findsOneWidget);
      },
    );

    testWidgets(
      'DarkThemeSwitchView widget tap test',
      (WidgetTester tester) async {
        when(() => themeBloc.state).thenReturn(
          const ThemeState(
            isDarkMode: true,
          ),
        );

        await tester.pumpApp<ThemeBloc>(
          widgetBuilder: () => const DarkThemeSwitchView(),
          bloc: themeBloc,
          wrapWithTheme: true,
          wrapWithMaterial: true,
        );
        final finder = find.byKey(const Key('darkThemeSwitchViewInkwellKey'));
        expect(finder, findsOneWidget);
        await tester.tap(finder);
        verify(() => themeBloc.add(const ToggleThemeEvent())).called(1);
      },
    );
  });
}
