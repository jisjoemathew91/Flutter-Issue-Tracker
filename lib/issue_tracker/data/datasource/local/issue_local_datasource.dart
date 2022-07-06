import 'package:shared_preferences/shared_preferences.dart';

abstract class IssueLocalDataSource {
  List<String> getOpenedIssues();

  Future<bool> setIssueOpened(List<String> numbers);
}

const viewedIssuesListKey = 'viewedIssuesList';

class IssueLocalDataSourceImpl implements IssueLocalDataSource {
  IssueLocalDataSourceImpl(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  @override
  List<String> getOpenedIssues() {
    try {
      final result = _sharedPreferences.getStringList(viewedIssuesListKey);
      return result ?? <String>[];
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> setIssueOpened(List<String> numbers) async {
    try {
      final result = await _sharedPreferences.setStringList(
        viewedIssuesListKey,
        numbers,
      );
      return result;
    } on Exception {
      rethrow;
    }
  }
}
