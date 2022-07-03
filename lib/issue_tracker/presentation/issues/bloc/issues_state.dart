part of 'issues_bloc.dart';

enum IssuesStatus { fetching, fetched, error }

class IssuesState extends Equatable {
  const IssuesState({
    this.status,
    this.issues,
  });

  final IssuesStatus? status;
  final Issues? issues;

  @override
  List<Object?> get props => [
        status,
        issues,
      ];

  IssuesState copyWith({IssuesStatus? status, Issues? issues}) {
    return IssuesState(
      status: status ?? this.status,
      issues: issues ?? this.issues,
    );
  }

  String? get nextToken => issues?.pageInfo?.endCursor;

  bool get hasMoreIssues => issues?.pageInfo?.hasNextPage == true;

  bool get isFetchingMoreIssues =>
      issues != null && status == IssuesStatus.fetching;
}
