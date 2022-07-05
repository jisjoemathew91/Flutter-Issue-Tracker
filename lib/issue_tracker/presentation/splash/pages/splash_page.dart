import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/app/routes.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/splash/bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(),
      child: const SplashPageView(),
    );
  }
}

class SplashPageView extends StatelessWidget {
  const SplashPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<SplashBloc>(context)..add(RunSplashEvent());
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.waiting) {
          _bloc.add(CompleteSplashEvent());
          Navigator.pushReplacementNamed(context, AppPageRoutes.issuesPage);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Flutter Issue Tracker',
                textStyle: AppTypography.style(
                  isBold: true,
                ),
                speed: const Duration(milliseconds: 60),
              ),
            ],
            totalRepeatCount: 1,
          ),
        ),
      ),
    );
  }
}
