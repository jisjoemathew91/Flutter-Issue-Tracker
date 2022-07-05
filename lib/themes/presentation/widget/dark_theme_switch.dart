import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/injection.dart';
import 'package:flutter_issue_tracker/themes/presentation/bloc/theme_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DarkThemeSwitch extends StatelessWidget {
  const DarkThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ThemeBloc>(),
      child: const DarkThemeSwitchView(),
    );
  }
}

class DarkThemeSwitchView extends StatelessWidget {
  const DarkThemeSwitchView({super.key});

  @override
  Widget build(BuildContext context) {
    final _bloc = context.read<ThemeBloc>();

    return BlocBuilder<ThemeBloc, ThemeState>(
      bloc: _bloc,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            _bloc.add(const ToggleThemeEvent());
          },
          borderRadius: BorderRadius.circular(20.sp),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: SizedBox(
              width: 20.sp,
              height: 20.sp,
              child: Image.asset(
                Theme.of(context).colorScheme.onSurface.value ==
                        AppColors.white.value
                    ? 'assets/icon/ic_moon.png'
                    : 'assets/icon/ic_sun.png',
                color: Theme.of(context).colorScheme.onSurface,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }
}
