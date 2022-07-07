import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'web_view_event.dart';

part 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  WebViewBloc() : super(const WebViewState()) {
    on<InitializeHeightEvent>(_onInitializeHeight);
  }

  WebViewController? webViewController;

  void _onInitializeHeight(
    InitializeHeightEvent event,
    Emitter<WebViewState> emit,
  ) {
    final stringHeight = (event.height ?? state.height) as String?;
    final height = double.parse(stringHeight!);
    // A 100 px is provided extra to avoid cropping of webview in the bottom
    emit(state.copyWith(height: height + 100));
  }
}
