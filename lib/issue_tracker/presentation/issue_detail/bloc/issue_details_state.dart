part of 'issue_details_bloc.dart';

enum IssueDetailsStatus { fetching, fetched, error }

class IssueDetailsState extends Equatable {
  const IssueDetailsState({
    this.status,
    this.issueNode,
  });

  final IssueDetailsStatus? status;
  final IssueNode? issueNode;

  IssueDetailsState copyWith({
    IssueDetailsStatus? status,
    IssueNode? issueNode,
  }) {
    return IssueDetailsState(
      status: status ?? this.status,
      issueNode: issueNode ?? this.issueNode,
    );
  }

  @override
  List<Object?> get props => [status, issueNode];
}
