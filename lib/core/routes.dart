import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/pages/issue_details_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/pages/issues_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/splash/pages/splash_page.dart';

/// Class defines the route names.
/// [routes] has the mapping between screens and its corresponding route name
class AppPageRoutes {
  static const String splashPage = '/';
  static const String issuesPage = '/issues';
  static const String issueDetailPage = '/issue_detail';

  static Map<String, Widget Function(BuildContext)> routes = {
    splashPage: (_) => const SplashPage(),
    issuesPage: (_) => const IssuesPage(),
    issueDetailPage: (_) => const IssueDetailPage(),
  };
}
