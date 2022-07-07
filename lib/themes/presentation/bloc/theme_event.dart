part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

/// [ToggleThemeEvent] is triggred to switch the current theme.
/// The event switch the theme to opposite of current theme.
class ToggleThemeEvent extends ThemeEvent {
  const ToggleThemeEvent();

  @override
  List<Object?> get props => [];
}
