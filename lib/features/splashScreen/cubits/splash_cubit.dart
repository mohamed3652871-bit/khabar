import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/features/splashScreen/cubits/splash_state.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';


class SplashCubit extends Cubit<SplashState>
{
  SplashCubit():super(InitSplashState());
  static SplashCubit get(BuildContext context)=>BlocProvider.of(context);
  static const Color appBgColor=AppColors.appMianColor;

  void startSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashDoneState());


  }


}

