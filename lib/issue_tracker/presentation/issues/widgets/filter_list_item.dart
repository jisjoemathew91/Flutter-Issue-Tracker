import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterListItem extends StatelessWidget {
  const FilterListItem({
    super.key,
    required this.text,
    required this.onTap,
    this.isSelected = true,
  });

  final String text;
  final GestureTapCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.sp),
        ),
        tileColor: isSelected
            ? AppColors.green.withOpacity(0.1)
            : Colors.transparent,
        trailing: isSelected
            ? const Icon(
                Icons.check,
                color: AppColors.green,
              )
            : null,
        title: Text(
          text,
          style: AppTypography.style(
            isBold: true,
            textType: TextType.body,
          ),
        ),
      ),
    );
  }
}
