import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueFilterChip extends StatelessWidget {
  const IssueFilterChip({
    super.key,
    required this.value,
    this.isHighlighted = false,
    this.onPressed,
  });

  final String value;
  final bool isHighlighted;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textColor = isHighlighted ? AppColors.lightBlue : AppColors.darkGray;
    return Container(
      height: 24.sp,
      margin: EdgeInsets.all(6.sp),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.lightBlue.withOpacity(0.1)
            : AppColors.fadeGray,
        borderRadius: BorderRadius.circular(24.sp),
        border: Border.all(
          color: textColor,
          width: 0.8.sp,
        ),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.sp),
        ),
        child: Row(
          children: [
            if (isHighlighted) ...[
              Transform.rotate(
                angle: pi * 1.2,
                child: Icon(
                  Icons.label_outline,
                  size: 12.sp,
                  color: textColor,
                ),
              ),
              SizedBox(width: 4.sp),
            ],
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(width: 6.sp),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 12.sp,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }
}
