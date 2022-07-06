import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issue_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issue_detail.dart';

part 'issue_details_event.dart';

part 'issue_details_state.dart';

class IssueDetailsBloc extends Bloc<IssueDetailsEvent, IssueDetailsState> {
  IssueDetailsBloc(this._getIssueDetail) : super(const IssueDetailsState()) {
    on<FetchIssueDetailsEvent>(_onFetchIssueDetails);
  }

  final GetIssueDetail _getIssueDetail;

  Future<void> _onFetchIssueDetails(
    FetchIssueDetailsEvent event,
    Emitter<IssueDetailsState> emit,
  ) async {
    emit(state.copyWith(status: IssueDetailsStatus.fetching));
    final result = await _getIssueDetail.execute(
      owner: dotenv.env['PROJECT_OWNER']!,
      name: dotenv.env['PROJECT_NAME']!,
      number: event.issueNumber ?? 0,
    );
    result.fold((failure) {
      emit(state.copyWith(status: IssueDetailsStatus.error));
    }, (data) {
      emit(state.copyWith(status: IssueDetailsStatus.fetched, issueNode: data));
    });
  }
}
