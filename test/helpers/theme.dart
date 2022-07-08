import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_themes/stacked_themes.dart';

Future<void> initTheme() async {
  /// Initialize shared preference with mock values.
  SharedPreferences.setMockInitialValues({});
  await ThemeManager.initialise();
}
