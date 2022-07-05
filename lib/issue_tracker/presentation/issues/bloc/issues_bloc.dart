import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_user_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/label_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestone_node.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/entities/milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_assignable_users.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_issues.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_labels.dart';
import 'package:flutter_issue_tracker/issue_tracker/domain/usecase/get_milestones.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/issue_util.dart';
import 'package:stream_transform/stream_transform.dart';

part 'issues_event.dart';

part 'issues_state.dart';

const _duration = Duration(milliseconds: 800);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class IssuesBloc extends Bloc<IssuesEvent, IssuesState> {
  IssuesBloc(
    this._getIssues,
    this._getLabels,
    this._getAssignableUsers,
    this._getMilestones,
  ) : super(const IssuesState()) {
    on<FetchIssuesEvent>(
      _onFetchIssues,
      transformer: debounce(_duration),
    );
    on<FetchLabelsEvent>(
      _onFetchLabels,
      transformer: debounce(_duration),
    );
    on<FetchAssignableUsersEvent>(
      _onFetchAssignableUsers,
      transformer: debounce(_duration),
    );
    on<FetchMilestonesEvent>(
      _onFetchMilestones,
      transformer: debounce(_duration),
    );
    on<UpdateSelectedLabelsEvent>(_onUpdateSelectedLabels);
    on<UpdateSelectedAssignableUsersEvent>(_onUpdateSelectedAssignableUsers);
    on<UpdateSelectedMilestonesEvent>(_onUpdateSelectedMilestone);
    on<UpdateStateEvent>(_onUpdateState);
    on<UpdateDirectionEvent>(_onUpdateDirection);
    on<ClearFilterEvent>(_onClearFilter);
    add(const FetchIssuesEvent(isInitial: true));
  }

  final GetIssues _getIssues;
  final GetLabels _getLabels;
  final GetAssignableUsers _getAssignableUsers;
  final GetMilestones _getMilestones;

  Future<void> _onFetchIssues(
    FetchIssuesEvent event,
    Emitter<IssuesState> emit,
  ) async {
    emit(state.copyWith(issuesStatus: IssuesStatus.fetching));
    final result = await _getIssues.execute(
      owner: dotenv.env['PROJECT_OWNER']!,
      name: dotenv.env['PROJECT_NAME']!,
      limit: 20,
      labelLimit: 30,
      states: state.states!,
      direction: state.direction,
      field: 'CREATED_AT',
      labels: state.queryLabels,
      milestone: state.selectedMilestone?.number?.toString(),
      assignee: state.selectedAssignableUser?.login,
      nextToken: event.isInitial ? null : state.nextToken,
    );
    result.fold((failure) {
      emit(state.copyWith(issuesStatus: IssuesStatus.error));
    }, (data) {
      if (!event.isInitial) {
        data.nodes = (state.issues?.nodes ?? []) + (data.nodes ?? []);
      }
      emit(state.copyWith(issuesStatus: IssuesStatus.fetched, issues: data));
    });
  }

  Future<void> _onFetchLabels(
    FetchLabelsEvent event,
    Emitter<IssuesState> emit,
  ) async {
    emit(state.copyWith(labelsStatus: LabelsStatus.fetching));
    final result = await _getLabels.execute(
      owner: dotenv.env['PROJECT_OWNER']!,
      name: dotenv.env['PROJECT_NAME']!,
      limit: 50,
      direction: 'ASC',
      field: 'NAME',
      nextToken: event.isInitial ? null : state.nextTokenLabel,
    );
    result.fold((failure) {
      emit(state.copyWith(labelsStatus: LabelsStatus.error));
    }, (data) {
      if (!event.isInitial) {
        data.nodes = (state.labels?.nodes ?? []) + (data.nodes ?? []);
      } else {
        data.nodes = (state.selectedLabels?.nodes ?? []) + (data.nodes ?? []);
      }
      emit(
        state.copyWith(
          labelsStatus: LabelsStatus.fetched,
          labels: IssueUtil.getDistinctLabels(data),
        ),
      );
    });
  }

  Future<void> _onFetchAssignableUsers(
    FetchAssignableUsersEvent event,
    Emitter<IssuesState> emit,
  ) async {
    emit(state.copyWith(assignableUsersStatus: AssignableUsersStatus.fetching));
    final result = await _getAssignableUsers.execute(
      owner: dotenv.env['PROJECT_OWNER']!,
      name: dotenv.env['PROJECT_NAME']!,
      limit: 50,
      nextToken: event.isInitial ? null : state.nextTokenAssignableUsers,
    );
    result.fold((failure) {
      emit(state.copyWith(assignableUsersStatus: AssignableUsersStatus.error));
    }, (data) {
      if (!event.isInitial) {
        data.nodes = (state.assignableUsers?.nodes ?? []) + (data.nodes ?? []);
      } else if (state.selectedAssignableUser != null) {
        data.nodes = [state.selectedAssignableUser!] + (data.nodes ?? []);
      }
      emit(
        state.copyWith(
          assignableUsersStatus: AssignableUsersStatus.fetched,
          assignableUsers: IssueUtil.getDistinctAsignee(data),
        ),
      );
    });
  }

  Future<void> _onFetchMilestones(
    FetchMilestonesEvent event,
    Emitter<IssuesState> emit,
  ) async {
    emit(state.copyWith(milestonesStatus: MilestonesStatus.fetching));
    final result = await _getMilestones.execute(
      owner: dotenv.env['PROJECT_OWNER']!,
      name: dotenv.env['PROJECT_NAME']!,
      limit: 50,
      nextToken: event.isInitial ? null : state.nextTokenMilestones,
    );
    result.fold((failure) {
      emit(state.copyWith(milestonesStatus: MilestonesStatus.error));
    }, (data) {
      if (!event.isInitial) {
        data.nodes = (state.milestones?.nodes ?? []) + (data.nodes ?? []);
      } else if (state.selectedMilestone != null) {
        data.nodes = [state.selectedMilestone!] + (data.nodes ?? []);
      }
      emit(
        state.copyWith(
          milestonesStatus: MilestonesStatus.fetched,
          milestones: IssueUtil.getDistinctMilestone(data),
        ),
      );
    });
  }

  void _onUpdateState(
    UpdateStateEvent event,
    Emitter<IssuesState> emit,
  ) {
    if (state.states == event.states) return;
    emit(state.copyWith(states: event.states));
    add(const FetchIssuesEvent(isInitial: true));
  }

  void _onUpdateDirection(
    UpdateDirectionEvent event,
    Emitter<IssuesState> emit,
  ) {
    if (state.direction == event.direction) return;
    emit(state.copyWith(direction: event.direction));
    add(const FetchIssuesEvent(isInitial: true));
  }

  void _onUpdateSelectedLabels(
    UpdateSelectedLabelsEvent event,
    Emitter<IssuesState> emit,
  ) {
    // previous labels
    final selectedLabels = List<LabelNode>.from(
      state.selectedLabels?.nodes ?? <LabelNode>[],
    );

    // check already exist
    final existingIndex = IssueUtil.getSelectedLabelIndex(
      event.label,
      selectedLabels,
    );

    if (existingIndex > -1) {
      // remove if exist
      selectedLabels.removeAt(existingIndex);
    } else {
      // add if not exist
      selectedLabels.add(event.label);
    }
    emit(
      state.copyWith(
        selectedLabels: Labels(nodes: selectedLabels),
      ),
    );
    add(const FetchIssuesEvent(isInitial: true));
  }

  void _onUpdateSelectedAssignableUsers(
    UpdateSelectedAssignableUsersEvent event,
    Emitter<IssuesState> emit,
  ) {
    // check existing value is same
    final exist =
        event.assignableUser.login == state.selectedAssignableUser?.login;

    if (exist) {
      emit(state.copyWith(clearAssignableUser: true));
    } else {
      emit(state.copyWith(selectedAssignableUser: event.assignableUser));
    }
    add(const FetchIssuesEvent(isInitial: true));
  }

  void _onUpdateSelectedMilestone(
    UpdateSelectedMilestonesEvent event,
    Emitter<IssuesState> emit,
  ) {
    // check existing value is same
    final exist = event.milestone.number == state.selectedMilestone?.number;

    if (exist) {
      emit(state.copyWith(clearMilestone: true));
    } else {
      emit(state.copyWith(selectedMilestone: event.milestone));
    }
    add(const FetchIssuesEvent(isInitial: true));
  }

  void _onClearFilter(
    ClearFilterEvent event,
    Emitter<IssuesState> emit,
  ) {
    emit(
      state.copyWith(
        states: 'OPEN',
        direction: 'DESC',
        selectedLabels: Labels(),
        clearMilestone: true,
        clearAssignableUser: true,
      ),
    );
    add(const FetchIssuesEvent(isInitial: true));
  }
}
