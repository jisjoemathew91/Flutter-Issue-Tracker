import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_issue_tracker/webview/presentation/bloc/web_view_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Web view Bloc test', () {
    blocTest<WebViewBloc, void>(
      '- Get issue details success test',
      build: WebViewBloc.new,
      act: (bloc) {
        bloc.add(const InitializeHeightEvent(height: '100'));
      },
      expect: () => [
        const WebViewState(
          height: 200,
        ),
      ],
    );
  });
  group('Web view Event test', () {
    test('- Initialize height event', () {
      const event = InitializeHeightEvent(height: '100');
      expect(event.props, ['100']);
    });
  });
  group('Web view State test', () {
    test('- Web view state test', () {
      const state = WebViewState(
        height: 100,
      );
      expect(state.props, [100]);
      expect(state.copyWith(), state);
    });
  });
}
