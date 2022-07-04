import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/app/extension/string_extension.dart';
import 'package:flutter_issue_tracker/app/injection.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_filter_chip.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_list_tile.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/issue_states_dialog.dart';
import 'package:flutter_issue_tracker/theme/presentation/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final _bloc = context.read<IssuesBloc>()
      ..add(const FetchIssuesEvent(isInitial: true));
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 1.sp,
        title: Center(
          child: Column(
            children: [
              Text(
                dotenv.env['PROJECT_NAME']!,
                style: AppTypography.style(
                  textType: TextType.label,
                  textSize: TextSize.large,
                  color: AppColors.darkGray,
                ),
              ),
              Text(
                'Issues',
                style: AppTypography.style(
                  color: AppColors.black,
                  textSize: TextSize.large,
                  isBold: true,
                ),
              )
            ],
          ),
        ),
        // elevation: ,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.sp),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Row(
                children: [
                  BlocBuilder<IssuesBloc, IssuesState>(
                    builder: (context, state) {
                      return IssueFilterChip(
                        value: state.states!.capitalizeFirstofEach(),
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
                      );
                    },
                  ),
                  IssueFilterChip(
                    value: 'Label',
                    onPressed: () {},
                  ),
                  IssueFilterChip(
                    value: 'Author',
                    onPressed: () {},
                  ),
                  IssueFilterChip(
                    value: 'Assignee',
                    onPressed: () {},
                  ),
                  IssueFilterChip(
                    value: 'Project',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: () => _bloc.add(const FetchIssuesEvent(isInitial: true)),
        onLoading: () => _bloc.add(const FetchIssuesEvent()),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocConsumer<IssuesBloc, IssuesState>(
                    listener: (context, state) {
                      if (state.status == IssuesStatus.fetched) {
                        // Removes loading and refresh indicator
                        // when fetch issue completes
                        _refreshController
                          ..refreshCompleted()
                          ..loadComplete();
                      }

                      if (state.status == IssuesStatus.error) {
                        // Removes loading and refresh indicator
                        // when fetch issue fails
                        _refreshController
                          ..refreshFailed()
                          ..loadFailed();
                      }

                      if (state.status == IssuesStatus.fetched &&
                          !state.hasMoreIssues) {
                        // Stops pagination and shows,
                        // no more issue is there to load
                        _refreshController.loadNoData();
                      }
                    },
                    builder: (context, state) {
                      // Initial loading when fetching issues
                      if (state.status == null) {
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
                      if (state.status == IssuesStatus.error &&
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
                                    onTap: () {},
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
