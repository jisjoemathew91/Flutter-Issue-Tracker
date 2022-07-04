extension StringExtension on String {
  String capitalizeFirstofEach() {
    if (isNotEmpty && length > 1) {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
    return this[0].toUpperCase();
  }
}
