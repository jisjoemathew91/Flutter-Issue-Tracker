part of 'web_view_bloc.dart';

abstract class WebViewEvent extends Equatable {
  const WebViewEvent();
}

class InitializeHeightEvent extends WebViewEvent {
  const InitializeHeightEvent({required this.height});

  final String? height;

  @override
  List<Object?> get props => [height];
}

class InitializeWebViewControllerEvent extends WebViewEvent {
  const InitializeWebViewControllerEvent(this.webViewController);

  final WebViewController webViewController;

  @override
  List<Object?> get props => [webViewController];
}
