import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/filter_list_item.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/issue_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IssueDirectionDialog extends StatelessWidget {
  const IssueDirectionDialog({super.key});

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
              ...availableDirections
                  .map(
                    (d) => FilterListItem(
                      text: IssueUtil.getDirectionNameFromKey(d),
                      isSelected: d == state.direction,
                      onTap: () {
                        _bloc.add(UpdateDirectionEvent(direction: d));
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
