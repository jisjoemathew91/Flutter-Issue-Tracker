import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../../../helpers/helpers.dart';

void main() {
  late ThemeService themeService;

  /// Registers a function to be run once before all tests.
  setUpAll(() {
    locator
      ..registerLazySingleton<ThemeService>(MockThemeService.new)
      ..registerFactory<ThemeBloc>(() => ThemeBloc(locator()));
    registerFallbackValue(ThemeManagerMode.dark);
    themeService = locator<ThemeService>();
  });

  group('- Theme Bloc Test', () {
    blocTest<ThemeBloc, ThemeState>(
      ' - When the theme is dark mode and on ToggleThemeEvent the theme changes'
      ' to light',
      seed: () => const ThemeState(isDarkMode: true),
      build: () {
        when(() => themeService.isDarkMode).thenAnswer((_) => false);
        return locator<ThemeBloc>();
      },
      act: (bloc) => bloc.add(const ToggleThemeEvent()),
      verify: (_) => verify(() => themeService.setThemeMode(any())).called(1),
      expect: () => [const ThemeState(isDarkMode: false)],
    );

    blocTest<ThemeBloc, ThemeState>(
      ' - When the theme is light and on ToggleThemeEvent the theme changes '
      'to dark',
      seed: () => const ThemeState(isDarkMode: false),
      build: () {
        when(() => themeService.isDarkMode).thenAnswer((_) => true);
        return locator<ThemeBloc>();
      },
      act: (bloc) => bloc.add(const ToggleThemeEvent()),
      verify: (_) => verify(() => themeService.setThemeMode(any())).called(1),
      expect: () => [const ThemeState(isDarkMode: true)],
    );
  });

  group('Theme event test', () {
    test('ToggleThemeEvent test', () {
      const event = ToggleThemeEvent();
      expect(event.props.length, 0);
    });
  });

  test('Theme state test', () {
    const state = ThemeState(isDarkMode: true);
    expect(state.props.length, 1);
    expect(state.props[0], true);
  });
}
