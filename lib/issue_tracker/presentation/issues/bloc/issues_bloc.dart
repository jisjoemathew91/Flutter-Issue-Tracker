import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:stream_transform/stream_transform.dart';

part 'issues_event.dart';

part 'issues_state.dart';

const _duration = Duration(milliseconds: 800);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc(this._getIssues) : super(const IssuesState()) {
    on<FetchIssuesEvent>(onFetchIssues, transformer: debounce(_duration));
    on<UpdateStateEvent>(onUpdateState);
  }

  final GetIssues _getIssues;

  Future<void> onFetchIssues(
    FetchIssuesEvent event,
    Emitter<IssuesState> emit,
  ) async {
    emit(state.copyWith(status: IssuesStatus.fetching));
    final result = await _getIssues.execute(
      owner: dotenv.env['PROJECT_OWNER']!,
      name: dotenv.env['PROJECT_NAME']!,
      limit: 20,
      labelLimit: 30,
      states: state.states!,
      direction: 'DESC',
      field: 'CREATED_AT',
      nextToken: event.isInitial ? null : state.nextToken,
    );
    result.fold((failure) {
      emit(state.copyWith(status: IssuesStatus.error));
    }, (data) {
      if (!event.isInitial) {
        data.nodes = (state.issues?.nodes ?? []) + (data.nodes ?? []);
      }
      emit(state.copyWith(status: IssuesStatus.fetched, issues: data));
    });
  }

  void onUpdateState(
    UpdateStateEvent event,
    Emitter<IssuesState> emit,
  ) {
    if (state.states == event.states) return;
    emit(state.copyWith(states: event.states));
    add(const FetchIssuesEvent(isInitial: true));
  }
}
