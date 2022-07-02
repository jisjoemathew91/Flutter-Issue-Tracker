import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/app/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      initialRoute: AppPageRoutes.issuesPage,
      routes: AppPageRoutes.routes,
    );
  }
}
