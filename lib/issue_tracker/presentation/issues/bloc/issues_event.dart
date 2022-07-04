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

class UpdateStateEvent extends IssuesEvent {
  const UpdateStateEvent({required this.states});

  final String states;

  @override
  List<Object?> get props => [states];
}
