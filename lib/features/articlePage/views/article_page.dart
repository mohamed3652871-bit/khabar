import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/utils/app_colors.dart';
import 'package:khabar/core/widgets/shared_buttons.dart';
import 'package:khabar/features/mainPage/data/models/news_model.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_icons.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key, this.articleData});
  final ArticleModel? articleData;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final article = widget.articleData;
    final imageUrl = article?.urlToImage;
    final title = article?.title ?? 'Article';
    final author = article?.author ?? 'Unknown';
    final publishedAt = _formatDate(article?.publishedAt);
    final content = article?.content ?? article?.description ?? '';
    final source = article?.source?.name ?? '';

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
                        color: Colors.grey[300],
                        image: imageUrl != null
                            ? DecorationImage(
                                image: NetworkImage(imageUrl),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
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
                    color: AppColors.articleBarA,
                  ),
                  child: Row(
                    children: [
                      ButtonB(
                        size: 44,
                        borderRadius: 20,
                        buttonColor: Colors.transparent,
                        onPressedFunction: () => Navigator.pop(context),
                        icon: AppIcon(icon: AppIcons.articleBackIcon, size: 16),
                      ),
                      const Spacer(),
                      ButtonB(
                        size: 44.r,
                        borderRadius: 44.r,
                        buttonColor: Colors.transparent,
                        onPressedFunction: () {
                          setState(() {
                            isBookmarked = !isBookmarked;
                          });
                        },
                        icon: AppIcon(
                          icon: isBookmarked
                              ? AppIcons.articleBookMarkB
                              : AppIcons.articleBookMarkA,
                          size: 20.r,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      ButtonB(
                        size: 44.r,
                        borderRadius: 22.r,
                        buttonColor: Colors.transparent,
                        onPressedFunction: () {},
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
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 16.h),

                // Author
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12.r,
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person, size: 16),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        '$author · $publishedAt${source.isNotEmpty ? ' · $source' : ''}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textColor1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Content
                Text(
                  content,
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

  String _formatDate(String? iso) {
    if (iso == null) return '';
    try {
      final dt = DateTime.parse(iso);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (_) {
      return iso;
    }
  }
}
