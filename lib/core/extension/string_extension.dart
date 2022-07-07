/// Extension on [String] common to the app
extension StringExtension on String {
  /// Capitalises the first letter of any string
  ///
  /// eg: 'abcd efgh' will transform to 'Abcd efgh'
  String capitalizeFirstLetter() {
    if (isNotEmpty && length > 1) {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
    return this[0].toUpperCase();
  }

  /// Replaces all underscore with empty space
  ///
  /// eg: 'AC_DEF' will return 'AC DEF' as value
  String removeUnderscore() {
    return replaceAll('_', ' ');
  }

  /// Used to pass values to prededined strings
  ///
  /// eg:
  /// `static const String helpText = r'''Hello $%[0]!, Hello $%[1]''';`
  ///
  /// `helpText.withParams(<String>['Jis', 'World'])`
  ///
  /// will give "Hello Jis, Hello World"
  String withParams(List<dynamic> params) {
    var tmp = this;
    for (var i = 0; i < params.length; i++) {
      tmp = tmp.replaceAll('%[$i]', params[i].toString());
    }
    return tmp;
  }
}
