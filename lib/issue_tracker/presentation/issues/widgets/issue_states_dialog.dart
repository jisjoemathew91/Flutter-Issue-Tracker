import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/filter_list_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueStatesDialog extends StatelessWidget {
  const IssueStatesDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<IssuesBloc>();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.sp),
      ),
      content: BlocBuilder<IssuesBloc, IssuesState>(
        bloc: _bloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...availableStates
                  .map(
                    (st) => FilterListItem(
                      text: st,
                      isSelected: st == state.states,
                      onTap: () {
                        _bloc.add(UpdateStateEvent(states: st));
                        Navigator.pop(context);
                      },
                    ),
                  )
                  .toList()
            ],
          );
        },
      ),
    );
  }
}
