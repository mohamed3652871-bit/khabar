import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../articlePage/views/article_page.dart';
import '../../../cubits/news_cubit.dart';
import '../../../cubits/news_state.dart';
import '../../../views/WeatherPage/cubits/weather_cubit.dart';
import 'view_articles.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.watch<WeatherCubit>();
    final weatherState = weatherCubit.weather?.weatherMain ?? '—';
    final temperature = weatherCubit.weather?.temp.round();

    return BlocProvider(
      create: (_) => NewsCubit()..fetchNews(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.appWhite,
            body: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
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
                              'Good Morning\n ${widget.name}',
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
                              _formattedDate(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.textColorBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.sunny, color: Colors.amber),
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
                          const Text(' '),
                          if (temperature != null)
                            Text(
                              '$temperature°C',
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

                // ── News Content ─────────────────────────────────────────
                Expanded(
                  child: BlocBuilder<NewsCubit, NewsState>(
                    builder: (context, state) {
                      final cubit = NewsCubit.get(context);

                      if (state is NewsLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is NewsErrorState) {
                        return Center(
                          child: Text(
                            cubit.errorMessage ?? 'Failed to load news',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14.sp,
                            ),
                          ),
                        );
                      }

                      final articles = cubit.articles;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),

                          NewsSlider(
                              articles: articles,
                              onTap: (article) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ArticlePage(
                                      articleData: article,
                                    ),
                                  ),
                                );
                              },
                            ),


                          // Most Popular header
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
                                    padding: WidgetStateProperty.all(
                                      EdgeInsets.all(12),
                                    ),
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
                          ),

                          SizedBox(height: 13.h),

                          // Horizontal list
                          SizedBox(
                            height: 313.h,
                            child: articles.isEmpty
                                ? const Center(
                                    child: Text('No articles available'),
                                  )
                                : ListView.separated(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 32.w,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: articles.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(width: 16.w),
                                    itemBuilder: (context, index) {
                                      final article = articles[index];
                                      return SizedBox(
                                        width: 240.w,
                                        child: InkWell(
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => ArticlePage(
                                                articleData: article,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                child:
                                                    article.urlToImage != null
                                                    ? Image.network(
                                                        article.urlToImage!,
                                                        fit: BoxFit.cover,
                                                        height: 232.h,
                                                        width: double.infinity,
                                                        errorBuilder:
                                                            (
                                                              _,
                                                              __,
                                                              ___,
                                                            ) => Container(
                                                              height: 230.h,
                                                              color: Colors
                                                                  .grey[300],
                                                              child: const Icon(
                                                                Icons.image,
                                                                size: 48,
                                                              ),
                                                            ),
                                                      )
                                                    : Container(
                                                        height: 230.h,
                                                        color: Colors.grey[300],
                                                        child: const Icon(
                                                          Icons.image,
                                                          size: 48,
                                                        ),
                                                      ),
                                              ),
                                              Text(
                                                article.title ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.visible,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.textColorBlack,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily:
                                                      'SchibstedGrotesk',
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                article.source?.name ?? '',
                                                style: TextStyle(
                                                  color: AppColors.textColor1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily:
                                                      'SchibstedGrotesk',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),

                          SizedBox(height: 9.h),
                          const Spacer(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${days[now.weekday - 1]} ${now.day} ${months[now.month - 1]}, ${now.year}';
  }
}
