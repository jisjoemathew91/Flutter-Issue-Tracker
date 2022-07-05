import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestone_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MilestonesListTile extends StatelessWidget {
  const MilestonesListTile({
    super.key,
    required this.milestone,
    required this.onTap,
  });

  final MilestoneNode milestone;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(
            vertical: 12.sp,
            horizontal: 16.sp,
          ),
          child: Row(
            children: [
              Text(
                milestone.title ?? '',
                style: AppTypography.style(
                  textSize: TextSize.small,
                ),
              ),
              const Spacer(),
              BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, state) {
                  if (milestone.number == state.selectedMilestone?.number) {
                    return const Icon(
                      Icons.check,
                      color: AppColors.green,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
