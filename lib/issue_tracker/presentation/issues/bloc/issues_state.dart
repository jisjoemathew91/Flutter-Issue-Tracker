part of 'issues_bloc.dart';

enum IssuesStatus { fetching, fetched, error }

const List<String> availableStates = ['OPEN', 'CLOSED'];

class IssuesState extends Equatable {
  const IssuesState({
    this.status,
    this.issues,
    this.states = 'OPEN',
  });

  final IssuesStatus? status;
  final Issues? issues;
  final String? states;

  @override
  List<Object?> get props => [
        status,
        issues,
        states,
      ];

  IssuesState copyWith({
    IssuesStatus? status,
    Issues? issues,
    String? states,
  }) {
    return IssuesState(
      status: status ?? this.status,
      issues: issues ?? this.issues,
      states: states ?? this.states,
    );
  }

  String? get nextToken => issues?.pageInfo?.endCursor;

  bool get hasMoreIssues => issues?.pageInfo?.hasNextPage == true;

  bool get isFetchingMoreIssues =>
      issues != null && status == IssuesStatus.fetching;
}
