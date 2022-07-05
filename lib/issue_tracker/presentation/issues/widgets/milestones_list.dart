import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/milestones_list_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MilestonesList extends StatelessWidget {
  const MilestonesList({super.key, required this.refreshController});

  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<IssuesBloc>()
      ..add(const FetchMilestonesEvent(isInitial: true));
    return ColoredBox(
      color: Theme.of(context).colorScheme.onSecondary,
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () => _bloc.add(const FetchMilestonesEvent()),
        child: CustomScrollView(
          controller: ModalScrollController.of(context),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocConsumer<IssuesBloc, IssuesState>(
                    listener: (context, state) {
                      if (state.milestonesStatus == MilestonesStatus.fetched) {
                        // Removes loading and refresh indicator
                        // when fetch issue completes
                        refreshController
                          ..refreshCompleted()
                          ..loadComplete();
                      }

                      if (state.milestonesStatus == MilestonesStatus.error) {
                        // Removes loading and refresh indicator
                        // when fetch issue fails
                        refreshController
                          ..refreshFailed()
                          ..loadFailed();
                      }

                      if (state.milestonesStatus == MilestonesStatus.fetched &&
                          !state.hasMoreLabels) {
                        // Stops pagination and shows,
                        // no more issue is there to load
                        refreshController.loadNoData();
                      }
                    },
                    builder: (context, state) {
                      // Initial loading when fetching issues
                      if (state.milestonesStatus == null) {
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
                      if (state.milestonesStatus == MilestonesStatus.error &&
                          state.milestones == null) {
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
                      if (state.milestones != null) {
                        return Column(
                          children: state.milestones?.nodes?.map(
                                (milestone) {
                                  return MilestonesListTile(
                                    onTap: () => _bloc.add(
                                      UpdateSelectedMilestonesEvent(
                                        milestone: milestone,
                                      ),
                                    ),
                                    milestone: milestone,
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
