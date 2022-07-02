import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/pages/issue_detail_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/pages/issues_page.dart';

/// Class defines the route names.
/// [routes] has the mapping between screens and its corresponding name
class AppPageRoutes {
  static const String issuesPage = 'issues';
  static const String issueDetailPage = 'issue_detail';

  static Map<String, Widget Function(BuildContext)> routes = {
    issuesPage: (_) => const IssuesPage(),
    issueDetailPage: (_) => const IssueDetailPage(),
  };
}
