import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignableUsersListTile extends StatelessWidget {
  const AssignableUsersListTile({
    super.key,
    required this.assignableUser,
    required this.onTap,
  });

  final AssignableUserNode assignableUser;
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
              ClipOval(
                child: Image.network(
                  height: 32.sp,
                  width: 32.sp,
                  assignableUser.avatarUrl ?? '',
                ),
              ),
              SizedBox(width: 12.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    assignableUser.login ?? '',
                    style: AppTypography.style(
                      textSize: TextSize.small,
                    ),
                  ),
                  Text(
                    assignableUser.name ?? '',
                    style: AppTypography.style(
                      textSize: TextSize.small,
                      textType: TextType.label,
                    ),
                  )
                ],
              ),
              const Spacer(),
              BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, state) {
                  if (assignableUser.login ==
                      state.selectedAssignableUser?.login) {
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
