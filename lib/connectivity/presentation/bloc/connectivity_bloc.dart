import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
        _showToast('You are online.');
      } else if (status == DataConnectionStatus.disconnected) {
        _showToast('You are offline!');
      }
    });
  }

  void _showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
