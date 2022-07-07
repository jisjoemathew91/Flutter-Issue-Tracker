part of 'issues_bloc.dart';

abstract class IssuesEvent extends Equatable {
  const IssuesEvent();
}

/// Set [isInitial] as true when fetching issues for first time
/// or new list of issues is requested
class FetchIssuesEvent extends IssuesEvent {
  const FetchIssuesEvent({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

/// Set [isInitial] as true when fetching issues for first time
/// or new list of labels is requested
class FetchLabelsEvent extends IssuesEvent {
  const FetchLabelsEvent({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

/// Set [isInitial] as true when fetching issues for first time
/// or new list of assignable users is requested
class FetchAssignableUsersEvent extends IssuesEvent {
  const FetchAssignableUsersEvent({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

/// Set [isInitial] as true when fetching issues for first time
/// or new list of milestones is requested
class FetchMilestonesEvent extends IssuesEvent {
  const FetchMilestonesEvent({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

/// [UpdateStateEvent] updates the current [states]
class UpdateStateEvent extends IssuesEvent {
  const UpdateStateEvent({required this.states});

  final String states;

  @override
  List<Object?> get props => [states];
}

/// [UpdateSelectedLabelsEvent] add/remove the current selected [label]
/// to selected labels list.
class UpdateSelectedLabelsEvent extends IssuesEvent {
  const UpdateSelectedLabelsEvent({required this.label});

  final LabelNode label;

  @override
  List<Object?> get props => [];
}

/// [UpdateSelectedAssignableUsersEvent] add/remove the
/// current selected [assignableUser]
class UpdateSelectedAssignableUsersEvent extends IssuesEvent {
  const UpdateSelectedAssignableUsersEvent({required this.assignableUser});

  final AssignableUserNode assignableUser;

  @override
  List<Object?> get props => [];
}

/// [UpdateSelectedMilestonesEvent] add/remove the
/// current selected [milestone]
class UpdateSelectedMilestonesEvent extends IssuesEvent {
  const UpdateSelectedMilestonesEvent({required this.milestone});

  final MilestoneNode milestone;

  @override
  List<Object?> get props => [];
}

/// [UpdateDirectionEvent] updates the current [direction]
class UpdateDirectionEvent extends IssuesEvent {
  const UpdateDirectionEvent({required this.direction});

  final String direction;

  @override
  List<Object?> get props => [direction];
}

/// [ClearFilterEvent] clear all filters and
/// replaces with initial filter state
class ClearFilterEvent extends IssuesEvent {
  const ClearFilterEvent();

  @override
  List<Object?> get props => [];
}

/// [GetOpenedIssuesEvent] update state with all opened issues
class GetOpenedIssuesEvent extends IssuesEvent {
  const GetOpenedIssuesEvent();

  @override
  List<Object?> get props => [];
}

/// [SetIssueOpenedEvent] updates opened issues locally.
class SetIssueOpenedEvent extends IssuesEvent {
  const SetIssueOpenedEvent({required this.number});

  final int number;

  @override
  List<Object?> get props => [];
}
