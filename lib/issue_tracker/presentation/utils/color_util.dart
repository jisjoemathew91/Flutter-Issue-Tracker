import 'package:flutter/material.dart';

/// Utility class makes color handling easier in issue_tracker feature
class ColorUtil {
  /// Provides [Color] from hex string.
  static Color getColorFromHex(String? hex) {
    final color = Color(
      int.parse('0xFF${hex ?? '3FB5F3'}'),
    );
    return color;
  }

  /// Gives back black or whites [Color] by checking
  /// luminance of background color
  static Color getVisibleColorForBg(Color bgColor) {
    final textColor =
        bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return textColor;
  }
}
