import 'package:flutter_issue_tracker/issue_tracker/data/datasource/local/issue_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../helpers/helpers.dart';

void main() {
  group('Issue datasource test', () {
    final SharedPreferences sharedPreferences = MockSharedPreferences();
    final dataSourceImpl = IssueLocalDataSourceImpl(sharedPreferences);
    test('- Get string list success test', () async {
      when(() => sharedPreferences.getStringList(any())).thenAnswer(
        (invocation) => [''],
      );
      expect(
        dataSourceImpl.getOpenedIssues(),
        [''],
      );
    });
    test('- Get string list success test', () async {
      when(() => sharedPreferences.setStringList(any(), any())).thenAnswer(
        (invocation) => Future.value(true),
      );
      expect(
        await dataSourceImpl.setIssueOpened(['numbers']),
        true,
      );
    });
  });
}
