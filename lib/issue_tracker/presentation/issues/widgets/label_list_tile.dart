import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/bloc/issues_bloc.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/issues/widgets/label_chip.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/issue_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LabelListTile extends StatelessWidget {
  const LabelListTile({
    super.key,
    required this.label,
    required this.onTap,
  });

  final LabelNode label;
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
              LabelChip(label: label),
              const Spacer(),
              BlocBuilder<IssuesBloc, IssuesState>(
                builder: (context, state) {
                  if (IssueUtil.getSelectedLabelIndex(
                        label,
                        state.selectedLabels?.nodes ?? <LabelNode>[],
                      ) >
                      -1) {
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
