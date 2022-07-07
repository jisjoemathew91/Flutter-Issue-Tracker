import 'package:flutter_issue_tracker/core/routes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('- AppPageRoutes test', () {
    test(
        'returns SplashScreen when the '
        'AppPageRoutes.splashPage is used as a key for routes Map', () {
      expect(AppPageRoutes.routes[AppPageRoutes.splashPage], isA<Function>());
    });

    test(
        'returns IssueDetailPage when the '
        'AppPageRoutes.issueDetailPage is used as a key for routes Map', () {
      expect(
        AppPageRoutes.routes[AppPageRoutes.issueDetailPage],
        isA<Function>(),
      );
    });

    test(
        'returns IssuesPage when the '
        'AppPageRoutes.issuesPage is used as a key for routes Map', () {
      expect(
        AppPageRoutes.routes[AppPageRoutes.issuesPage],
        isA<Function>(),
      );
    });
  });
}
