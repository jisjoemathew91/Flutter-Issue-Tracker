import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'web_view_event.dart';
part 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(const WebViewState()) {
    on<InitializeWebViewControllerEvent>(_onInitializeWebViewController);
    on<InitializeHeightEvent>(_onInitializeHeight);
  }

  void _onInitializeWebViewController(
    InitializeWebViewControllerEvent event,
    Emitter<WebViewState> emit,
  ) {
    emit(state.copyWith(webViewController: event.webViewController));
  }

  void _onInitializeHeight(
    InitializeHeightEvent event,
    Emitter<WebViewState> emit,
  ) {
    final stringHeight = (event.height ?? state.height) as String?;
    final height = double.parse(stringHeight!);
    emit(state.copyWith(height: height));
  }
}
