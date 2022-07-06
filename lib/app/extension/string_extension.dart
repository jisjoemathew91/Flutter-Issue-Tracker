extension StringExtension on String {
  /// Capitalises the first letter of any string
  /// eg: 'abcd efgh' will transform to 'Abcd efgh'
  String capitalizeFirstLetter() {
    if (isNotEmpty && length > 1) {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
    return this[0].toUpperCase();
  }

  /// Replaces all underscore with empty space
  /// eg: 'AC_DEF' will return 'AC DEF' as value
  String removeUnderscore() {
    return replaceAll('_', ' ');
  }
}
