import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../data/models/news_model.dart';
import '../../../../articlePage/views/article_page.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_state.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExploreCubit(),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildTopHeader(context),
              _buildCategoryTabs(context),
              SizedBox(height: 24.h),
              Expanded(child: _buildContent(context, state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    final cubit = context.read<ExploreCubit>();
    final state = context.watch<ExploreCubit>().state;
    final topPadding = MediaQuery.of(context).padding.top;

    final isSearching = state is ExploreLoaded && state.isSearching;

    return Container(
      color: AppColors.appMianColor,
      padding: EdgeInsets.fromLTRB(32, topPadding + 16, 20, 12),
      child: Row(
        children: [
          Expanded(
            child: isSearching
                ? TextField(
              autofocus: true,
              onChanged: cubit.onSearchChanged,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
              ),
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: AppColors.textPrimary),
                border: InputBorder.none,
              ),
            )
                : const Text(
              'Explore',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          GestureDetector(
            onTap: cubit.toggleSearch,
            child: Icon(
              isSearching ? Icons.close : Icons.search_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context) {
    final cubit = context.read<ExploreCubit>();
    final state = context.watch<ExploreCubit>().state;

    int selectedIndex = 0;

    if (state is ExploreLoaded) {
      selectedIndex = state.selectedCategory;
    }

    final categories = [
      'Science',
      'Technology',
      'Business',
      'Entertainment',
    ];

    return Container(
      color: AppColors.appWhite,
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 32),
        child: Row(
          children: List.generate(categories.length, (i) {
            final isSelected = selectedIndex == i;

            return GestureDetector(
              onTap: () => cubit.selectCategory(i),
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.appMianColor
                      : Colors.transparent,
                  border: Border.all(color: AppColors.whiteB),
                  borderRadius: BorderRadius.circular(56),
                ),
                child: Text(
                  categories[i],
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

  Widget _buildContent(BuildContext context, ExploreState state) {
    if (state is ExploreLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ExploreError) {
      return Center(child: Text(state.message));
    }

    if (state is ExploreLoaded) {
      final articles = state.articles;

      if (articles.isEmpty) {
        return const Center(child: Text('No articles found'));
      }

      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
        itemCount: articles.length,
        separatorBuilder: (_, __) => SizedBox(height: 20.h),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildFeaturedArticleCard(context, articles[index]);
          }
          return _buildArticleCard(context, articles[index]);
        },
      );
    }

    return const SizedBox();
  }

  Widget _buildFeaturedArticleCard(
      BuildContext context,
      NewsArticleModel article,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticlePage(articleData: article),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((article.urlToImage ?? '').isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.urlToImage!,
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          SizedBox(height: 12.h),
          Text(
            article.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8.h),
          _buildAuthorRow(article),
        ],
      ),
    );
  }

  Widget _buildArticleCard(
      BuildContext context,
      NewsArticleModel article,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticlePage(articleData: article),
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildAuthorRow(article),
              ],
            ),
          ),
          if ((article.urlToImage ?? '').isNotEmpty) ...[
            SizedBox(width: 12.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                article.urlToImage!,
                height: 72.h,
                width: 82.w,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAuthorRow(NewsArticleModel article) {
    return Row(
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: Colors.grey.shade300,
          child: const Icon(Icons.person, size: 14),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            '${article.author ?? 'Unknown'} · ${_formatDate(article.publishedAt)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      const months = [
        'Jan','Feb','Mar','Apr','May','Jun',
        'Jul','Aug','Sep','Oct','Nov','Dec'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (_) {
      return dateStr;
    }
  }
}