import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/utils/app_colors.dart';
import 'package:khabar/core/widgets/shared_buttons.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_icons.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              alignment: AlignmentGeometry.bottomCenter,
              children: [
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 316.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAssets.articlePic2),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 23.h),
                  ],
                ),
                Container(
                  height: 68.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r),
                    ),
                    color: AppColors.articleBarA, // خليه نفس لون محتوى المقال
                  ),
                  child: Row(
                    children: [
                      ButtonB(
                        size: 44,
                        borderRadius: 20,
                        buttonColor: Colors.transparent,
                        onPressedFunction: () {
                          print('TODO : back button Function');
                          Navigator.pop(context);
                        },
                        //TODO : back button Function
                        icon: AppIcon(icon: AppIcons.articleBackIcon, size: 16),
                      ),
                      const Spacer(),
                      ButtonB(
                        size: 44.r,
                        borderRadius: 44.r,
                        buttonColor: Colors.transparent,
                        onPressedFunction: (){
                          print('TODO : bookmark button Function ');
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                          print(isBookmarked);
                        },
                        icon: AppIcon(
                          icon: isBookmarked ? AppIcons.articleBookMarkB : AppIcons.articleBookMarkA,
                          size: 20.r,

                        ),
                      ),
                      SizedBox(width: 14.w),
                      ButtonB(
                        size: 44.r,
                        borderRadius: 22.r,
                        buttonColor: Colors.transparent,
                        onPressedFunction: () {
                          print('TODO : share button Function');
                          //TODO : share button Function

                        },
                        icon: AppIcon(
                          icon: AppIcons.articleShare,
                          size: 20.r,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 6.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // article address
                Text(
                  'See How the Forest is Helping Our World',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 16.h),

                // The Author
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12.r,
                      backgroundImage: AssetImage(AppAssets.imageA),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Harry Harper · ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Apr 12, 2023',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                Text(
                  r"""Forests are one of the most important natural resources that our planet possesses. Not only do they provide us with a diverse range of products such as timber, medicine, and food, but they also play a vital role in mitigating climate change and maintaining the overall health of our planet's ecosystems. In this article, we will explore the ways in which forests are helping our world.
One of the most important roles that forests play is in absorbing carbon dioxide from the atmosphere. Trees absorb carbon dioxide through photosynthesis and store it in their trunks, branches, and leaves. This carbon sequestration helps to mitigate climate change by reducing the amount of greenhouse gases in the atmosphere. Forests are estimated to absorb approximately 2.4 billion tonnes of carbon dioxide each year, which is equivalent to around 10% of global greenhouse gas emissions.
Forests also play a crucial role in maintaining the water cycle. Trees absorb water from the soil and release it back into the atmosphere through a process known as transpiration. This helps to regulate the local climate and prevents soil erosion and flooding. Forests also act as natural water filters, helping to purify water that flows through them.
Forests are also important sources of biodiversity. They provide habitat for countless species of plants and animals, many of which are found nowhere else on earth. Forests also provide a source of food and medicine for many communities around the world. In fact, it is estimated that around 80% of the world's population relies on traditional medicine derived from plants, many of which are found in forests.
In addition to their ecological and cultural importance, forests also provide economic benefits. They provide jobs and income for millions of people around the world, particularly in rural areas. Forests also provide timber, paper, and other products that are essential to many industries.
""",
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.6,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
