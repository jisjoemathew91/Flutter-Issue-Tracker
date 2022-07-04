import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/issue_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateIcon extends StatelessWidget {
  const StateIcon({
    super.key,
    required this.state,
    required this.stateReason,
    this.size,
  });

  final String? state;
  final String? stateReason;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final issueState = IssueUtil.getIssueState(state, stateReason);
    final issueStateProperty = IssueUtil.getIssueStatesProperty(issueState);
    return Image.asset(
      issueStateProperty.value1,
      color: issueStateProperty.value2,
      width: size ?? 20.sp,
    );
  }
}
