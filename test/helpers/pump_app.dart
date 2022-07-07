import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/core/app_themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked_themes/stacked_themes.dart';

typedef WidgetBuilderNoContext = Widget Function();

extension BlocAndRepoTesterExt on WidgetTester {
  /// Test Helper to instantiate and pump widget/screen which depends on
  ///  Bloc [B].
  Future<void> pumpApp<B extends BlocBase<dynamic>>({
    required WidgetBuilderNoContext widgetBuilder,
    B? bloc,
    bool wrapWithTheme = false,
    Duration? duration,
    bool wrapWithMaterial = false,
    final Map<String, WidgetBuilder>? routes,
  }) async {
    final toTest = widgetBuilder.call();

    late Widget widget;

    /// Wraps the widget with theme.
    widget = ThemeBuilder(
      defaultThemeMode: ThemeMode.light,
      darkTheme: AppThemeData.darkTheme,
      lightTheme: AppThemeData.lightTheme,
      builder: (ctx, regularTheme, darkTheme, themeMode) {
        return MaterialApp(
          home: ScreenUtilInit(
            builder: (BuildContext context, Widget? child) {
              return child!;
            },
            child: toTest,
          ),
          routes: routes ?? {},
          theme: regularTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
        );
      },
    );

    if (bloc != null) {
      widget = BlocProvider<B>.value(
        value: bloc,
        child: widget,
      );
    }

    if (wrapWithMaterial) {
      widget = Material(child: widget);
    }

    await pumpWidget(
      widget,
      duration,
    );
  }
}
