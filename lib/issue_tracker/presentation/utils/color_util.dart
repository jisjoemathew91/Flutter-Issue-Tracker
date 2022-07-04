import 'package:flutter/material.dart';

class ColorUtil {
  /// Provides [Color] from hex string.
  static Color getColorFromHex(String? hex) {
    final color = Color(
      int.parse('0xFF${hex ?? '3FB5F3'}'),
    );
    return color;
  }

  /// Gives back black or whites color by checking luminance of background
  static Color getVisibleColorForBg(Color bgColor) {
    final textColor =
        bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
    return textColor;
  }
}
