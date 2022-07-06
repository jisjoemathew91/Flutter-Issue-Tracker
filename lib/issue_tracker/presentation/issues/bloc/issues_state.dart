part of 'issues_bloc.dart';

enum IssuesStatus { fetching, fetched, error }

enum LabelsStatus { fetching, fetched, error }

enum AssignableUsersStatus { fetching, fetched, error }

enum MilestonesStatus { fetching, fetched, error }

const List<String> availableStates = ['OPEN', 'CLOSED'];
const List<String> availableDirections = ['DESC', 'ASC'];

class IssuesState extends Equatable {
  const IssuesState({
    this.issuesStatus,
    this.labelsStatus,
    this.assignableUsersStatus,
    this.milestonesStatus,
    this.issues,
    this.labels,
    this.selectedLabels,
    this.assignableUsers,
    this.selectedAssignableUser,
    this.milestones,
    this.selectedMilestone,
    this.states = 'OPEN',
    this.direction = 'DESC',
    this.openedIssues,
  });

  final IssuesStatus? issuesStatus;
  final LabelsStatus? labelsStatus;
  final AssignableUsersStatus? assignableUsersStatus;
  final MilestonesStatus? milestonesStatus;
  final Issues? issues;
  final Labels? labels;
  final Labels? selectedLabels;
  final AssignableUserNode? selectedAssignableUser;
  final AssignableUsers? assignableUsers;
  final Milestones? milestones;
  final MilestoneNode? selectedMilestone;
  final String? states;
  final String? direction;
  final List<String>? openedIssues;

  @override
  List<Object?> get props => [
        issuesStatus,
        labelsStatus,
        assignableUsersStatus,
        milestonesStatus,
        issues,
        states,
        direction,
        labels,
        selectedLabels,
        assignableUsers,
        selectedAssignableUser,
        milestones,
        selectedMilestone,
        openedIssues,
      ];

  IssuesState copyWith({
    IssuesStatus? issuesStatus,
    LabelsStatus? labelsStatus,
    AssignableUsersStatus? assignableUsersStatus,
    MilestonesStatus? milestonesStatus,
    Issues? issues,
    String? states,
    Labels? labels,
    Labels? selectedLabels,
    AssignableUsers? assignableUsers,
    bool clearAssignableUser = false,
    AssignableUserNode? selectedAssignableUser,
    Milestones? milestones,
    bool clearMilestone = false,
    MilestoneNode? selectedMilestone,
    String? direction,
    List<String>? openedIssues,
  }) {
    return IssuesState(
      issuesStatus: issuesStatus ?? this.issuesStatus,
      labelsStatus: labelsStatus ?? this.labelsStatus,
      assignableUsersStatus:
          assignableUsersStatus ?? this.assignableUsersStatus,
      milestonesStatus: milestonesStatus ?? this.milestonesStatus,
      issues: issues ?? this.issues,
      states: states ?? this.states,
      labels: labels ?? this.labels,
      selectedLabels: selectedLabels ?? this.selectedLabels,
      assignableUsers: assignableUsers ?? this.assignableUsers,
      selectedAssignableUser: clearAssignableUser
          ? null
          : selectedAssignableUser ?? this.selectedAssignableUser,
      milestones: milestones ?? this.milestones,
      selectedMilestone:
          clearMilestone ? null : selectedMilestone ?? this.selectedMilestone,
      direction: direction ?? this.direction,
      openedIssues: openedIssues ?? this.openedIssues,
    );
  }

  String? get nextToken => issues?.pageInfo?.endCursor;

  String? get nextTokenLabel => labels?.pageInfo?.endCursor;

  String? get nextTokenAssignableUsers => assignableUsers?.pageInfo?.endCursor;

  String? get nextTokenMilestones => milestones?.pageInfo?.endCursor;

  bool get hasMoreIssues => issues?.pageInfo?.hasNextPage == true;

  bool get hasMoreLabels => labels?.pageInfo?.hasNextPage == true;

  bool get hasMoreAssignableUsers =>
      assignableUsers?.pageInfo?.hasNextPage == true;

  bool get hasMoreMilestones => milestones?.pageInfo?.hasNextPage == true;

  List<String>? get queryLabels => selectedLabels?.nodes?.isNotEmpty == true
      ? selectedLabels!.nodes!.map((l) => l.name ?? '').toList()
      : null;

  String get labelChipTitle {
    if (queryLabels == null) {
      return 'Label';
    }
    if (queryLabels!.length > 1) return '${queryLabels!.length} Labels';
    return queryLabels!.first;
  }

  bool get highlightLabelChip => labelChipTitle != 'Label';

  String get assigneeChipTitle => selectedAssignableUser?.login ?? 'Assignee';

  bool get highlightAssigneeChip => assigneeChipTitle != 'Assignee';

  String get milestoneChipTitle => selectedMilestone?.title ?? 'Milestone';

  bool get highlightMilestoneChip => milestoneChipTitle != 'Milestone';

  String get directionChipTitle =>
      'Sort: ${IssueUtil.getDirectionNameFromKey(direction!)}';

  bool get showClearFilter =>
      states != 'OPEN' ||
      direction != 'DESC' ||
      highlightLabelChip ||
      highlightAssigneeChip ||
      highlightMilestoneChip;

  bool isOpened(int number) {
    return openedIssues?.contains(number.toString()) == true;
  }
}
