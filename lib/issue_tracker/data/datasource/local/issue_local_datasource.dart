import 'package:shared_preferences/shared_preferences.dart';

abstract class IssueLocalDataSource {
  /// Fetch opened issues from local storage
  ///
  /// -> onSuccess returns `List<String>`
  /// -> onError throws [Exception]
  List<String> getOpenedIssues();

  /// Updates opened issues to local storage
  ///
  /// Pass all the opened issue [numbers]
  ///
  /// -> onSuccess returns `List<String>`
  /// -> onError throws [Exception]
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
