import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestone_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';

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

  /// Gives index of [label] from [selectedLabels]
  /// If not found, returns -1 as value.
  static int getSelectedLabelIndex(
    LabelNode label,
    List<LabelNode> selectedLabels,
  ) {
    final index = selectedLabels.indexWhere(
      (sn) => sn.name == label.name,
    );
    return index;
  }

  static Labels getDistinctLabels(Labels labels) {
    final idSet = <String>{};
    final distinctNodes = <LabelNode>[];
    for (final node in labels.nodes ?? <LabelNode>[]) {
      if (node.id != null && idSet.add(node.id!)) {
        distinctNodes.add(node);
      }
    }
    return labels..nodes = distinctNodes;
  }

  static AssignableUsers getDistinctAsignee(AssignableUsers users) {
    final idSet = <String>{};
    final distinctNodes = <AssignableUserNode>[];
    for (final node in users.nodes ?? <AssignableUserNode>[]) {
      if (node.id != null && idSet.add(node.id!)) {
        distinctNodes.add(node);
      }
    }
    return users..nodes = distinctNodes;
  }

  static Milestones getDistinctMilestone(Milestones users) {
    final idSet = <String>{};
    final distinctNodes = <MilestoneNode>[];
    for (final node in users.nodes ?? <MilestoneNode>[]) {
      if (node.id != null && idSet.add(node.id!)) {
        distinctNodes.add(node);
      }
    }
    return users..nodes = distinctNodes;
  }
}
