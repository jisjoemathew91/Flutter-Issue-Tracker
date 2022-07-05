part of 'web_view_bloc.dart';

class WebViewState extends Equatable {
  const WebViewState({
    this.height = 1,
    this.webViewController,
  });

  final double height;
  final WebViewController? webViewController;

  @override
  List<Object?> get props => [
        height,
        webViewController,
      ];

  WebViewState copyWith({
    double? height,
    WebViewController? webViewController,
  }) {
    return WebViewState(
      height: height ?? this.height,
      webViewController: webViewController ?? this.webViewController,
    );
  }
}
