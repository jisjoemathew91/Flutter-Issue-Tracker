import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/assignable_users_list.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/labels_list.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/milestones_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum BottomSheetType { label, author, assignee, milestone }

class BottomSheetComponent extends StatelessWidget {
  BottomSheetComponent({
    super.key,
    required this.type,
  });

  String get title {
    switch (type) {
      case BottomSheetType.label:
        return 'Filter by label';
      case BottomSheetType.author:
        return 'Filter by author';
      case BottomSheetType.assignee:
        return 'Filter by assignee';
      case BottomSheetType.milestone:
        return 'Filter by milestone';
    }
  }

  final BottomSheetType type;
  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    context.read<IssuesBloc>().add(
          const FetchLabelsEvent(isInitial: true),
        );
    return SafeArea(
      bottom: false,
      child: NestedScrollView(
        controller: ScrollController(),
        physics: const ScrollPhysics(
          parent: PageScrollPhysics(),
        ),
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.sp),
                      ),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50.sp),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                      vertical: 8.sp,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40.sp,
                          height: 5.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.sp),
                            color: AppColors.gray,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: AppTypography.style(
                                isBold: true,
                              ),
                            ),
                            const CloseButton(),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: type == BottomSheetType.label
            ? LabelsList(
                refreshController: _refreshController,
              )
            : type == BottomSheetType.assignee
                ? AssignableUsersList(
                    refreshController: _refreshController,
                  )
                : MilestonesList(
                    refreshController: _refreshController,
                  ),
      ),
    );
  }
}
