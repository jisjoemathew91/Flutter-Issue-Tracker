import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/label_chip.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/state_icon.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/time_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueListTile extends StatelessWidget {
  const IssueListTile({
    super.key,
    required this.issue,
    required this.onTap,
    required this.isOpened,
  });

  final IssueNode issue;
  final GestureTapCallback? onTap;
  final bool isOpened;

  @override
  Widget build(BuildContext context) {
    final textColor = isOpened
        ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
        : null;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.sp,
          horizontal: 16.sp,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: BorderDirectional(
            bottom: BorderSide(
              width: 0.5.sp,
              color: Theme.of(context).colorScheme.onSurface,
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
                          textType: TextType.body,
                          textSize: TextSize.small,
                        ).copyWith(
                          color: textColor,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        TimeUtil.getTimeInAgoFormat(issue.createdAt),
                        style: AppTypography.style(
                          textType: TextType.body,
                          textSize: TextSize.small,
                        ).copyWith(
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    issue.title ?? '',
                    style: AppTypography.style(
                      textSize: TextSize.small,
                      isBold: true,
                    ).copyWith(
                      color: textColor,
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
