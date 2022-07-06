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
