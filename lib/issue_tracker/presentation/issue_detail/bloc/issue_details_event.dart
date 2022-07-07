part of 'issue_details_bloc.dart';

abstract class IssueDetailsEvent extends Equatable {
  const IssueDetailsEvent();
}

/// [FetchIssueDetailsEvent] fetch issue detail by [issueNumber]
class FetchIssueDetailsEvent extends IssueDetailsEvent {
  const FetchIssueDetailsEvent({required this.issueNumber});

  final int? issueNumber;

  @override
  List<Object?> get props => [issueNumber];
}
