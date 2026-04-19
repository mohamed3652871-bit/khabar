import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';




class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedTab = 0;

  final List<String> _categories = [
    'Travel',
    'Technology',
    'Business',
    'Entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.whiteB,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: Column(
        children: [
          _buildTopHeader(),
          _buildCategoryTabs(),
          SizedBox(height: 24.h,),

          Expanded(child: _buildContent()),
        ],
      ),
    );
  }



  Widget _buildTopHeader() {
    return Container(
      height: 127.h,
      color: AppColors.appMianColor,
      padding: const EdgeInsets.fromLTRB(32, 71, 20,12),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Explore',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: AppColors.textPrimary,
            ),
          ),
          Icon(Icons.search_outlined),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      color: AppColors.appWhite,
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          children: List.generate(_categories.length, (i) {
            final active = i == _selectedTab;
            return GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
                decoration: BoxDecoration(
                  color: active ? AppColors.whiteB : Colors.transparent,
                  border: Border.all(color: AppColors.whiteB),
                  borderRadius: BorderRadius.circular(56),
                ),
                child: Text(
                  _categories[i],
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
      children: [
        _buildFeatureCard(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFeatureCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          'https://picsum.photos/800/400',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Uncovering the Hidden Gems of the Amazon Forest',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildSmallCard(article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  article.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textColorBlack,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  )
                ),
                Row(children: [
                  CircleAvatar(
                    radius: 12.r,
                    backgroundImage: NetworkImage(article.avatarUrl),

                  ),
                  SizedBox(width: 8.w,),
                  Text('${article.author} · ${article.date}',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColors.textColor1),
                  )
                ],)
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 112.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(
    article.imageUrl,
    ),fit: BoxFit.cover)
            ),
            
          ),
        ],
      ),
    );
  }
}