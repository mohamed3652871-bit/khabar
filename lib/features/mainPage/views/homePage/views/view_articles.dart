import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';

class NewsSlider extends StatefulWidget {
  const NewsSlider({super.key});

  @override
  State<NewsSlider> createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 274.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image(
                        image: AssetImage(AppAssets.article),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        height: 66.h,
                        padding: EdgeInsets.only(left: 14.w,right: 7.w,top: 9.h),
                        decoration: BoxDecoration(color: AppColors.blackShade),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 255.w,
                              child: Text(
                                overflow: TextOverflow.visible,
                                r"Experience the Serenity of Japan's Traditional Countryside",
                                style: TextStyle(
                                  color: AppColors.appWhite,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only( top:4),
                              child: Text(
                                softWrap: true,
                                'Luc Olinga',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 15.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 3.w),
                width: _currentPage == index
                    ? 9.w:8.w,
                height: _currentPage == index
                    ? 9.h:8.h,                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: _currentPage == index
                      ? AppColors.buttonBlue
                      : AppColors.buttonGry,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
