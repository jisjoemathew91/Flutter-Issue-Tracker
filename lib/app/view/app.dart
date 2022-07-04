import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/app/routes.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (ctx, child) {
        ScreenUtil.init(ctx);
        return child!;
      },
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.darkBlue,
        backgroundColor: AppColors.white,
        canvasColor: AppColors.white,
        bottomAppBarColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: AppColors.white,
        ),
      ),
      initialRoute: AppPageRoutes.splashPage,
      routes: AppPageRoutes.routes,
    );
  }
}
