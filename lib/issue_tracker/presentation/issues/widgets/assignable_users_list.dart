import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/assignable_users_list_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssignableUsersList extends StatelessWidget {
  const AssignableUsersList({super.key, required this.refreshController});

  final RefreshController refreshController;

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<IssuesBloc>()
      ..add(const FetchAssignableUsersEvent(isInitial: true));
    return ColoredBox(
      color: AppColors.white,
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () => _bloc.add(const FetchAssignableUsersEvent()),
        child: CustomScrollView(
          controller: ModalScrollController.of(context),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocConsumer<IssuesBloc, IssuesState>(
                    listener: (context, state) {
                      if (state.assignableUsersStatus ==
                          AssignableUsersStatus.fetched) {
                        // Removes loading and refresh indicator
                        // when fetch issue completes
                        refreshController
                          ..refreshCompleted()
                          ..loadComplete();
                      }

                      if (state.assignableUsersStatus ==
                          AssignableUsersStatus.error) {
                        // Removes loading and refresh indicator
                        // when fetch issue fails
                        refreshController
                          ..refreshFailed()
                          ..loadFailed();
                      }

                      if (state.assignableUsersStatus ==
                              AssignableUsersStatus.fetched &&
                          !state.hasMoreLabels) {
                        // Stops pagination and shows,
                        // no more issue is there to load
                        refreshController.loadNoData();
                      }
                    },
                    builder: (context, state) {
                      // Initial loading when fetching issues
                      if (state.assignableUsersStatus == null) {
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
                      if (state.assignableUsersStatus ==
                              AssignableUsersStatus.error &&
                          state.assignableUsers == null) {
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
                      if (state.assignableUsers != null) {
                        return Column(
                          children: state.assignableUsers?.nodes?.map(
                                (assignableUser) {
                                  return AssignableUsersListTile(
                                    assignableUser: assignableUser,
                                    onTap: () => _bloc.add(
                                      UpdateSelectedAssignableUsersEvent(
                                        assignableUser: assignableUser,
                                      ),
                                    ),
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
