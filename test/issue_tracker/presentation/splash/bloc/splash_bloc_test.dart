import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    dotenv.testLoad(
      fileInput: '''
        PROJECT_OWNER=''
        PROJECT_NAME=''
        ''',
    );
  });

  blocTest<SplashBloc, void>(
    '- RunSplashEvent event  test',
    build: SplashBloc.new,
    act: (bloc) => bloc.add(RunSplashEvent()),
    wait: const Duration(seconds: 3),
    expect: () => [
      const SplashState(status: SplashStatus.running),
      const SplashState(status: SplashStatus.waiting)
    ],
  );

  blocTest<SplashBloc, void>(
    '- on complete splash event the status will be completed',
    build: SplashBloc.new,
    act: (bloc) => bloc.add(CompleteSplashEvent()),
    expect: () => [
      const SplashState(status: SplashStatus.completed),
    ],
  );
  group('Splash Event test', () {
    test('- Run splash event  event', () {
      final event = RunSplashEvent();
      expect(event.props, <dynamic>[]);
    });
    test('- Complete splash event  event', () {
      final event = CompleteSplashEvent();
      expect(event.props, <dynamic>[]);
    });
  });
  group('Splash state tests', () {
    test('- checks if value is set', () {
      const splashState = SplashState(status: SplashStatus.completed);
      expect(splashState.status, SplashStatus.completed);
      expect(splashState.props.length, 1);
      final state = splashState.copyWith(status: SplashStatus.running);
      expect(state.status, SplashStatus.running);
    });
  });
}
