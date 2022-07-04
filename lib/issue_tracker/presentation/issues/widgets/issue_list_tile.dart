import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/label_chip.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/state_icon.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/time_util.dart';
import 'package:flutter_issue_tracker/theme/presentation/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueListTile extends StatelessWidget {
  const IssueListTile({
    super.key,
    required this.issue,
    required this.onTap,
  });

  final IssueNode issue;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.sp,
          horizontal: 16.sp,
        ),
        decoration: BoxDecoration(
          border: BorderDirectional(
            bottom: BorderSide(
              color: AppColors.gray,
              width: 1.sp,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StateIcon(
              state: issue.state,
              stateReason: issue.stateReason,
            ),
            SizedBox(width: 12.sp),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${dotenv.env['PROJECT_OWNER']} / ${dotenv.env['PROJECT_NAME']} #${issue.number.toString()}',
                        style: AppTypography.style(
                          color: AppColors.closedGrey,
                          textType: TextType.body,
                          textSize: TextSize.small,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        TimeUtil.getTimeInAgoFormat(issue.createdAt),
                        style: AppTypography.style(
                          color: AppColors.closedGrey,
                          textType: TextType.body,
                          textSize: TextSize.small,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    issue.title ?? '',
                    style: AppTypography.style(
                      color: AppColors.black,
                      textSize: TextSize.small,
                      isBold: true,
                    ),
                  ),
                  SizedBox(height: 4.sp),
                  if (issue.labels?.nodes?.isNotEmpty == true)
                    Wrap(
                      children: issue.labels!.nodes!
                          .map(
                            (label) => LabelChip(label: label),
                          )
                          .toList(),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
