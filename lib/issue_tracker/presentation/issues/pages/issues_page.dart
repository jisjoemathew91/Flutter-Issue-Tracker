import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/app/injection.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';

class IssuesPage extends StatelessWidget {
  const IssuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<IssuesBloc>(),
      child: const IssuesPageView(),
    );
  }
}

class IssuesPageView extends StatelessWidget {
  const IssuesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IssuesBloc>(context).add(FetchIssuesEvent());
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<IssuesBloc, IssuesState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: state.status == IssuesStatus.fetching
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text(
                        'Issues count ${state.issues?.nodes?.length ?? 0}',
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
