import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/webview/presentation/widget/web_view_dialog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/helpers.dart';
import '../../../helpers/theme.dart';

void main() {
  setUpAll(() async {
    await initTheme();
  });
  testWidgets(
    'DarkThemeSwitch widget render test',
    (WidgetTester tester) async {
      await tester.pumpApp(
        widgetBuilder: () => const SingleChildScrollView(
          child: CustomWebViewDialog(
            url: '',
          ),
        ),
        wrapWithMaterial: true,
      );
    },
  );
}
