import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/app/extension/string_extension.dart';
import 'package:flutter_issue_tracker/app/routes.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/pages/issue_details_page.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/filter_bottom_sheet.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_direction_dialog.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_filter_chip.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_list_tile.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_states_dialog.dart';
import 'package:flutter_issue_tracker/themes/presentation/widget/dark_theme_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<IssuesBloc>(),
      child: IssuesPageView(),
    );
  }
}

class IssuesPageView extends StatelessWidget {
  IssuesPageView({super.key});

  final _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<IssuesBloc>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 1.sp,
        title: Center(
          child: Column(
            children: [
              Text(
                '#${dotenv.env['PROJECT_NAME']!}',
                style: AppTypography.style(
                  textType: TextType.label,
                  textSize: TextSize.large,
                ).copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              Text(
                'Issues',
                style: AppTypography.style(
                  textSize: TextSize.large,
                  isBold: true,
                ),
              )
            ],
          ),
        ),
        actions: const [
          DarkThemeSwitch(),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.sp),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(8.sp, 0.sp, 8.sp, 4.sp),
              child: BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      if (state.showClearFilter)
                        IssueFilterChip(
                          value: 'Clear All',
                          isHighlighted: true,
                          showDropDown: false,
                          icon: Icons.clear_all,
                          highlightColor: AppColors.red,
                          onPressed: () => _bloc.add(const ClearFilterEvent()),
                        ),
                      IssueFilterChip(
                        value: state.states!.capitalizeFirstLetter(),
                        isHighlighted: true,
                        onPressed: () => showDialog<IssueStatesDialog>(
                          context: context,
                          builder: (context) {
                            return BlocProvider.value(
                              value: _bloc,
                              child: const IssueStatesDialog(),
                            );
                          },
                        ),
                      ),
                      IssueFilterChip(
                        value: state.labelChipTitle,
                        isHighlighted: state.highlightLabelChip,
                        icon: Icons.label_outline,
                        onPressed: () {
                          showMaterialModalBottomSheet<Widget>(
                            backgroundColor: Colors.transparent,
                            expand: true,
                            enableDrag: false,
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: _bloc,
                              child: BottomSheetComponent(
                                type: BottomSheetType.label,
                              ),
                            ),
                          );
                        },
                      ),
                      IssueFilterChip(
                        value: state.assigneeChipTitle,
                        isHighlighted: state.highlightAssigneeChip,
                        icon: Icons.person_outline,
                        onPressed: () {
                          showMaterialModalBottomSheet<Widget>(
                            backgroundColor: Colors.transparent,
                            expand: true,
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: _bloc,
                              child: BottomSheetComponent(
                                type: BottomSheetType.assignee,
                              ),
                            ),
                          );
                        },
                      ),
                      IssueFilterChip(
                        value: state.milestoneChipTitle,
                        isHighlighted: state.highlightMilestoneChip,
                        icon: Icons.flag_outlined,
                        onPressed: () {
                          showMaterialModalBottomSheet<Widget>(
                            backgroundColor: Colors.transparent,
                            expand: true,
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: _bloc,
                              child: BottomSheetComponent(
                                type: BottomSheetType.milestone,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.sp,
                        child: VerticalDivider(
                          width: 3.sp,
                          thickness: 1.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      IssueFilterChip(
                        value: state.directionChipTitle,
                        isHighlighted: true,
                        icon: Icons.sort,
                        onPressed: () => showDialog<IssueStatesDialog>(
                          context: context,
                          builder: (context) {
                            return BlocProvider.value(
                              value: _bloc,
                              child: const IssueDirectionDialog(),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        footer: ClassicFooter(
          loadingIcon: Platform.isIOS
              ? const CupertinoActivityIndicator()
              : SizedBox(
                  height: 20.sp,
                  width: 20.sp,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
        ),
        onRefresh: () => _bloc.add(const FetchIssuesEvent(isInitial: true)),
        onLoading: () => _bloc.add(const FetchIssuesEvent()),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocConsumer<IssuesBloc, IssuesState>(
                    listener: (context, state) {
                      if (state.issuesStatus == IssuesStatus.fetched) {
                        // Removes loading and refresh indicator
                        // when fetch issue completes
                        _refreshController
                          ..refreshCompleted()
                          ..loadComplete();
                      }

                      if (state.issuesStatus == IssuesStatus.error) {
                        // Removes loading and refresh indicator
                        // when fetch issue fails
                        _refreshController
                          ..refreshFailed()
                          ..loadFailed();
                      }

                      if (state.issuesStatus == IssuesStatus.fetched &&
                          !state.hasMoreIssues) {
                        // Stops pagination and shows,
                        // no more issue is there to load
                        _refreshController.loadNoData();
                      }
                    },
                    builder: (context, state) {
                      // Initial loading when fetching issues
                      if (state.issuesStatus == null) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                            child: const CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          ),
                        );
                      }

                      // Failure view when there is no data
                      if (state.issuesStatus == IssuesStatus.error &&
                          state.issues == null) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.sp),
                            child: const Text(
                              'Oops! Check your connection.',
                            ),
                          ),
                        );
                      }

                      // Issue list view
                      if (state.issues != null) {
                        return Column(
                          children: state.issues?.nodes?.map(
                                (issue) {
                                  return IssueListTile(
                                    issue: issue,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppPageRoutes.issueDetailPage,
                                        arguments: IssueDetailsPageArguments(
                                          issue.number,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).toList() ??
                              [],
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
