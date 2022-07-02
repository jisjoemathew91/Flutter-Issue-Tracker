import 'package:flutter_issue_tracker/app/app.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/pages/issues_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(IssuesPage), findsOneWidget);
    });
  });
}
