import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/widgets/issue_label.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueHeader extends StatelessWidget {
  const IssueHeader({
    super.key,
    required this.stateReason,
    this.state,
    this.issueNumber,
    this.issueTitle,
  });

  final int? issueNumber;
  final String? issueTitle;
  final String? state;
  final String? stateReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.darkGray.withOpacity(0.2),
          width: 1.sp,
        ),
        borderRadius: BorderRadius.circular(4.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'flutter / flutter #${issueNumber ?? ''}',
            style: AppTypography.style(
              textSize: TextSize.small,
            ),
          ),
          Text(
            issueTitle ?? '',
            style: AppTypography.style(
              textSize: TextSize.large,
              isBold: true,
            ),
          ),
          SizedBox(height: 10.sp),
          IssueLabel(state: state, stateReason: stateReason),
        ],
      ),
    );
  }
}
