import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextSize { large, medium, small }

enum TextType { display, headline, title, label, body }

class AppTypography {
  static double getFontSize(TextType type, TextSize size) {
    switch (size) {
      case TextSize.large:
        {
          switch (type) {
            case TextType.display:
              return 57.sp;
            case TextType.headline:
              return 32.sp;
            case TextType.title:
              return 22.sp;
            case TextType.label:
              return 14.sp;
            case TextType.body:
              return 16.sp;
          }
        }
      case TextSize.medium:
        {
          switch (type) {
            case TextType.display:
              return 45.sp;
            case TextType.headline:
              return 28.sp;
            case TextType.title:
              return 16.sp;
            case TextType.label:
              return 12.sp;
            case TextType.body:
              return 14.sp;
          }
        }
      case TextSize.small:
        {
          switch (type) {
            case TextType.display:
              return 36.sp;
            case TextType.headline:
              return 24.sp;
            case TextType.title:
              return 14.sp;
            case TextType.label:
              return 11.sp;
            case TextType.body:
              return 12.sp;
          }
        }
    }
  }

  static double getFontHeight(TextType type, TextSize size) {
    final fontSize = getFontSize(type, size);
    switch (size) {
      case TextSize.large:
        {
          switch (type) {
            case TextType.display:
              return 64.sp / fontSize;
            case TextType.headline:
              return 40.sp / fontSize;
            case TextType.title:
              return 28.sp / fontSize;
            case TextType.label:
              return 20.sp / fontSize;
            case TextType.body:
              return 24.sp / fontSize;
          }
        }
      case TextSize.medium:
        {
          switch (type) {
            case TextType.display:
              return 52.sp / fontSize;
            case TextType.headline:
              return 36.sp / fontSize;
            case TextType.title:
              return 24.sp / fontSize;
            case TextType.label:
              return 16.sp / fontSize;
            case TextType.body:
              return 20.sp / fontSize;
          }
        }
      case TextSize.small:
        {
          switch (type) {
            case TextType.display:
              return 44.sp / fontSize;
            case TextType.headline:
              return 32.sp / fontSize;
            case TextType.title:
              return 20.sp / fontSize;
            case TextType.label:
              return 16.sp / fontSize;
            case TextType.body:
              return 16.sp / fontSize;
          }
        }
    }
  }

  static TextStyle style({
    TextType textType = TextType.title,
    TextSize textSize = TextSize.medium,
    bool isBold = false,
  }) {
    return TextStyle(
      fontSize: getFontSize(textType, textSize),
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontFamily: 'Roboto',
      height: getFontHeight(textType, textSize),
    );
  }
}
