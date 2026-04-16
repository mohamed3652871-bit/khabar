import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/utils/app_assets.dart';
import 'package:khabar/core/utils/app_colors.dart';

import '../../../core/utils/app_icons.dart';
import '../../../core/widgets/shared_buttons.dart';
import '../../mapPage/map_page.dart';

class LetsStart extends StatefulWidget {
  const LetsStart({super.key});

  @override
  State<LetsStart> createState() => _LetsStartState();
}

class _LetsStartState extends State<LetsStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.blueB, AppColors.whiteB],
            stops: const [0, 1],
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 538.h,
              child: Image(
                image: AssetImage(AppAssets.letsStartLogo),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.appWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                  ),
                  width: double.infinity,
                  height: 421.h,
                  child: Column(
                    children: [
                      SizedBox(height: 52.h),
                      SizedBox(
                        height: 80.h,
                        width: 366.w,
                        child: Text(
                          'Get The Latest News And Updates',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32.sp,
                            color: AppColors.textColorBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 104.h,
                        width: 366.w,
                        child: Text(
                          'From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'SchibstedGrotesk',
                            fontSize: 18.sp,
                            color: AppColors.textColorBlack,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      ButtonA(
                        buttonPadding: EdgeInsetsGeometry.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        buttonRadius: 128.r,
                        buttonColor: AppColors.buttonBlue,
                        text: 'Explore',
                        textSize: 20.sp,
                        textColor: AppColors.appWhite,
                        onPressedFunction: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MapPage()));
                        },
                        endIcon: AppIcon(
                          icon: AppIcons.rightArrow,
                          color: AppColors.appWhite,
                          size: 16.sp,
                        ),
                        textPadding: EdgeInsetsGeometry.symmetric(
                          horizontal: 7.w,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
