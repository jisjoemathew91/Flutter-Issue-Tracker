import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_issue_tracker/core/helper/toast_helper.dart';

part 'connectivity_event.dart';

part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc(this._dataConnectionChecker)
      : super(const ConnectivityState()) {
    on<ListenConnectionEvent>(_onListenConnection);
    add(ListenConnectionEvent());
  }

  final DataConnectionChecker _dataConnectionChecker;
  StreamSubscription? _subscription;

  void _onListenConnection(ListenConnectionEvent event, Emitter emit) {
    _subscription = _dataConnectionChecker.onStatusChange.listen((status) {
      if (status == DataConnectionStatus.connected) {
        ToastHelper.showShortToast('You are online.');
      } else if (status == DataConnectionStatus.disconnected) {
        ToastHelper.showShortToast('You are offline!');
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
