import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';


class BookMarksPage extends StatefulWidget {
  const BookMarksPage({super.key});

  @override
  State<BookMarksPage> createState() => _BookMarksPageState();
}

class _BookMarksPageState extends State<BookMarksPage> {


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
          SizedBox(height: 24.h,),

          Expanded(child: _buildContent()),
        ],
      ),
    );
  }



  Widget _buildTopHeader() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 123.h,
      color: AppColors.appMianColor,
      padding: EdgeInsets.only(bottom: 12.h),
      child: const   Text(
        'Bookmark',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }


  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(32,0, 32, 24),
      children: [
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