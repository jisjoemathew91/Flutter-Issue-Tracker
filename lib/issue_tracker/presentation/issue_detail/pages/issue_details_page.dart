import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/bloc/issue_details_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/widgets/issue_header.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issue_detail/widgets/user_profile.dart';
import 'package:flutter_issue_tracker/themes/presentation/widget/dark_theme_switch.dart';
import 'package:flutter_issue_tracker/webview/presentation/widget/web_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueDetailsPageArguments {
  IssueDetailsPageArguments(this.issueNumber);

  final int? issueNumber;
}

class IssueDetailPage extends StatelessWidget {
  const IssueDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<IssueDetailsBloc>(),
      child: const IssueDetailsPageView(),
    );
  }
}

class IssueDetailsPageView extends StatelessWidget {
  const IssueDetailsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final _bloc = context.read<IssueDetailsBloc>();
    IssueDetailsPageArguments? args;

    if (arguments != null) {
      args = arguments as IssueDetailsPageArguments;
      _bloc.add(FetchIssueDetailsEvent(issueNumber: args.issueNumber));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          DarkThemeSwitch(),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          onRefresh: () async {
            _bloc.add(FetchIssueDetailsEvent(issueNumber: args?.issueNumber));
          },
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: BlocBuilder<IssueDetailsBloc, IssueDetailsState>(
                        builder: (context, state) {
                          // Initial loading when fetching issue details.
                          if (state.status == IssueDetailsStatus.fetching) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.sp),
                                child: CircularProgressIndicator(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            );
                          }

                          // Failure view when there is no data
                          if (state.status == IssueDetailsStatus.error) {
                            return Center(
                              child: Padding(
                                key: const Key('errorText'),
                                padding: EdgeInsets.only(top: 20.sp),
                                child: const Text(
                                  'Oops! Check your connection.',
                                ),
                              ),
                            );
                          }

                          if (state.issueNode != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 22.sp),
                                IssueHeader(
                                  stateReason: state.issueNode?.stateReason,
                                  issueNumber: state.issueNode?.number,
                                  issueTitle: state.issueNode?.title,
                                  state: state.issueNode?.state,
                                ),
                                SizedBox(height: 22.sp),
                                UserProfile(
                                  name: state.issueNode?.author?.login,
                                  profileUrl:
                                      state.issueNode?.author?.avatarUrl ?? '',
                                  authorAssociation:
                                      state.issueNode?.authorAssociation ?? '',
                                  createdAt: state.issueNode?.createdAt ?? '',
                                ),
                                SizedBox(height: 22.sp),
                                Divider(
                                  height: 2.sp,
                                  color: AppColors.darkGray.withOpacity(0.5),
                                ),
                                CustomWebView(
                                  htmlText: state.issueNode?.bodyHTML ?? '',
                                ),
                                SizedBox(height: 22.sp),
                              ],
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
