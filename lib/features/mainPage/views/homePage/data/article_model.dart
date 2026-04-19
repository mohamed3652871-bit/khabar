import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/utils/app_colors.dart';


class ArticleViewBox extends StatelessWidget {
  const ArticleViewBox({super.key, required this.articleImage, required this.articleContent});
  final String articleImage ;
  final String articleContent ;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              width: double.infinity,
              height: 316.h,
              child: Image(
                image: AssetImage(articleImage),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        AppColors.buttonsBlack,

                        AppColors.articleBarA,
                        AppColors.buttonsBlack,

                      ],
                      stops: const [0, 1, 0.1],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23.r),
                      topRight: Radius.circular(24.r),
                    ),
                  ),
                  width: double.infinity,
                  height: 68.h,
                ),
                Container(
                  color: AppColors.buttonsBlack,
                  width: double.infinity,
                  height: 583.h,
                  //height: 593.h,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
