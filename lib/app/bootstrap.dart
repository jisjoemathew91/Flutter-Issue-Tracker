import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/injection.dart' as di;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:stacked_themes/stacked_themes.dart';

/// [AppBlocObserver] obeserves the bloc and
/// logs the change and error in any bloc class
class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

/// Wrap method to load initial data before running App in main method
/// Logs the error in thhe defined zones
Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // All flutter errors are captured here
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Loads the environments values before running the app
      await dotenv.load();

      // Prefetch the configured the theme before running the app
      await ThemeManager.initialise();

      // HiveStore is initialised before running the app
      // Used as as cache memory for graphQL persistance
      await initHiveForFlutter();

      // Ensuring screen size of the window before running the app
      await ScreenUtil.ensureScreenSize();

      // Call for dependency injection
      await di.init();

      await BlocOverrides.runZoned(
        () async => runApp(await builder()),
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
