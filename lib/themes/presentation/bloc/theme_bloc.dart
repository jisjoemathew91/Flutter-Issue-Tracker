import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stacked_themes/stacked_themes.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(this._themeService)
      : super(ThemeState(isDarkMode: _themeService.isDarkMode)) {
    on<ToggleThemeEvent>(_onToggleTheme);
  }

  final ThemeService _themeService;

  void _onToggleTheme(ToggleThemeEvent event, Emitter emit) {
    _themeService.setThemeMode(
      _themeService.isDarkMode ? ThemeManagerMode.light : ThemeManagerMode.dark,
    );
    emit(state.copyWith(isDarkMode: _themeService.isDarkMode));
  }
}
