import 'dart:ui';

/// Extension on [Color] common to the app
extension HexColor on Color {
  /// Prefixes a hash sign if [leadingHashSign] is set to `true`
  ///
  /// (default is `true`).
  String toHex({bool leadingHashSign = true, bool outputAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${outputAlpha ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
