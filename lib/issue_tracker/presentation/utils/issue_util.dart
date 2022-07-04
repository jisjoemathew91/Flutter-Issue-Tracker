import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';

/// Describes issue states
enum IssuesStates {
  open,
  closed,
  notPlanned,
}

class IssueUtil {
  /// Gives [IssuesStates] by comparing [state] and [stateReason] text.
  static IssuesStates getIssueState(String? state, String? stateReason) {
    if (state == 'OPEN') return IssuesStates.open;
    if (state == 'CLOSED' && stateReason != 'COMPLETED') {
      return IssuesStates.notPlanned;
    }
    return IssuesStates.closed;
  }

  /// Gives properties like [Color] and asset path of a [state]
  static Tuple2<String, Color> getIssueStatesProperty(IssuesStates state) {
    switch (state) {
      case IssuesStates.open:
        return const Tuple2<String, Color>(
          'assets/icon/ic_dot.png',
          AppColors.green,
        );
      case IssuesStates.closed:
        return const Tuple2<String, Color>(
          'assets/icon/ic_check.png',
          AppColors.violet,
        );
      case IssuesStates.notPlanned:
        return const Tuple2<String, Color>(
          'assets/icon/ic_slash.png',
          AppColors.closedGrey,
        );
    }
  }
}
