import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/features/mainPage/views/homePage/views/view_articles.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../articlePage/views/article_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String weatherState = 'Sunny';
  final int temperature = 32;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 59.h,
              right: 19.w,
              left: 19.w,
              bottom: 10.h,
            ),
            height: 142.h,
            width: double.infinity,
            color: AppColors.homePageBarColor,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 138.w,
                      child: Text(
                        'Good Morning, Mohamed Ahmed',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textColor1,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.w,
                      child: Text(
                        'Sun 9 April, 2023',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.textColorBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.sunny, color: Colors.amber),
                    SizedBox(width: 8.w),
                    Text(
                      weatherState,
                      style: TextStyle(
                        fontFamily: 'schibstedgrotesk',
                        fontSize: 14.sp,
                        color: AppColors.textColor1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(' '),
                    Text(
                      '${temperature.toString()}°C',
                      style: TextStyle(
                        fontFamily: 'schibstedgrotesk',
                        fontSize: 14.sp,
                        color: AppColors.textColor1,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                InkWell(
                  child: NewsSlider(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ArticlePage()),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most Popular',
                        style: TextStyle(
                          color: AppColors.textColorBlack,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.all(12)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'See More',
                          style: TextStyle(
                            color: AppColors.buttonBlue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SchibstedGrotesk',
                          ),
                        ),
                      ),
                    ],
                  ),
                ), //See More
                SizedBox(height: 13.h),
                SizedBox(
                  height: 313.h,
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => SizedBox(
                      width: 240.w,
                      child: InkWell(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image(
                                image: AssetImage(AppAssets.imageA),
                                fit: BoxFit.cover,
                                height: 230.h,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              'The Pros and Cons of Remote Work',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.textColorBlack,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SchibstedGrotesk',
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              'Technology',
                              style: TextStyle(
                                color: AppColors.textColor1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SchibstedGrotesk',
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticlePage(),
                            ),
                          );
                        },
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 16.w),
                    itemCount: 5,
                  ),
                ), //List Bar
                SizedBox(height: 9.h),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
