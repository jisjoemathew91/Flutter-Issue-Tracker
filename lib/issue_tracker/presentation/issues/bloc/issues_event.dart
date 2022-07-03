part of 'issues_bloc.dart';

abstract class IssuesEvent extends Equatable {
  const IssuesEvent();
}

class FetchIssuesEvent extends IssuesEvent {
  @override
  List<Object?> get props => [];
}
