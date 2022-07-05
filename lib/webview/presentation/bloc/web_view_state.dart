part of 'web_view_bloc.dart';

class WebViewState extends Equatable {
  const WebViewState({
    this.height = 1,
  });

  final double height;

  @override
  List<Object?> get props => [
        height,
      ];

  WebViewState copyWith({
    double? height,
  }) {
    return WebViewState(
      height: height ?? this.height,
    );
  }
}
