import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/issue_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueLabel extends StatelessWidget {
  const IssueLabel({
    super.key,
    required this.state,
    required this.stateReason,
  });

  final String? state;
  final String? stateReason;

  @override
  Widget build(BuildContext context) {
    final issueState = IssueUtil.getIssueState(state, stateReason);
    final issueStateProperty = IssueUtil.getIssueStatesProperty(issueState);
    return Container(
      padding: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.sp),
        color: issueStateProperty.value2.withOpacity(0.1),
        border: Border.all(
          width: 1.sp,
          color: issueStateProperty.value2.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            issueStateProperty.value1,
            color: issueStateProperty.value2,
            width: 16.sp,
          ),
          SizedBox(width: 6.sp),
          Padding(
            padding: EdgeInsets.only(bottom: 2.sp),
            child: Text(
              issueState.name,
              style: AppTypography.style(
                textType: TextType.label,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
