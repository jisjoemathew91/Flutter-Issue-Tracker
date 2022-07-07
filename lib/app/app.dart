import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/connectivity/presentation/bloc/connectivity_bloc.dart';
import 'package:flutter_issue_tracker/core/app_themes.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/core/routes.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_themes/stacked_themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // classes which are required all over the app
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => locator<ConnectivityBloc>(),
        ),
        BlocProvider(
          create: (BuildContext context) => locator<ThemeBloc>(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      darkTheme: AppThemeData.darkTheme,
      lightTheme: AppThemeData.lightTheme,
      builder: (context, regularTheme, darkTheme, themeMode) {
        return MaterialApp(
          builder: (ctx, child) {
            ScreenUtil.init(ctx);
            return child!;
          },
          theme: regularTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          initialRoute: AppPageRoutes.splashPage,
          routes: AppPageRoutes.routes,
        );
      },
    );
  }
}
