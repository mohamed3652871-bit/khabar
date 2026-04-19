import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/news_model.dart';

class NewsSlider extends StatefulWidget {
  const NewsSlider({super.key, required this.articles,required this.onTap,});
  final List<NewsArticleModel> articles;
  final Function(NewsArticleModel article) onTap;

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
    final sliderItems = widget.articles.take(5).toList();
    if (sliderItems.isEmpty) {
      return SizedBox(height: 274.h + 15.h + 16.h);
    }

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
            itemCount: sliderItems.length,
            itemBuilder: (context, index) {
              final article = sliderItems[index];
              return GestureDetector(
                onTap: () {
                  widget.onTap(article);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Image
                        article.urlToImage != null
                            ? Image.network(
                                article.urlToImage!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (_, err, e) => Container(
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image, size: 64),
                                ),
                              )
                            : Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.image, size: 64),
                              ),
                        // Caption bar
                        Container(
                          width: double.infinity,
                          height: 66.h,
                          padding: EdgeInsets.only(
                            left: 14.w, right: 7.w, top: 9.h,
                          ),
                          decoration:
                              BoxDecoration(color: AppColors.blackShade),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 255.w,
                                child: Text(
                                  article.title ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.appWhite,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(

                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  article.author ?? '',
                                  softWrap: true,
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
                ),
              );
            },
          ),
        ),

        SizedBox(height: 15.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(sliderItems.length, (index) {
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
                width: _currentPage == index ? 9.w : 8.w,
                height: _currentPage == index ? 9.h : 8.h,
                decoration: BoxDecoration(
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
