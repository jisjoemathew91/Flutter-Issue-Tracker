import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/color_util.dart';
import 'package:flutter_issue_tracker/theme/presentation/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.label,
  });

  final LabelNode label;

  @override
  Widget build(BuildContext context) {
    final chipColor = ColorUtil.getColorFromHex(label.color);
    final textColor = ColorUtil.getVisibleColorForBg(chipColor);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 4.sp, 4.sp),
      padding: EdgeInsets.fromLTRB(6.sp, 0, 6.sp, 1.sp),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: Text(
        label.name ?? '',
        style: AppTypography.style(
          color: textColor,
          textType: TextType.body,
          textSize: TextSize.small,
        ),
      ),
    );
  }
}
