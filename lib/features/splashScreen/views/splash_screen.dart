import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/utils/app_assets.dart';
import 'lets_start.dart';
import '../cubits/splash_cubit.dart';
import '../cubits/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..startSplash(),

      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashDoneState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const LetsStart(),
              ),
            );
          }
        },

        child: Scaffold(
          backgroundColor: SplashCubit.appBgColor,
          body: Center(
            child: SizedBox(
              width: 176.w,
              height: 56.h,
              child: SvgPicture.asset(AppAssets.splashLogo),
            ),
          ),
        ),
      ),
    );
  }
}