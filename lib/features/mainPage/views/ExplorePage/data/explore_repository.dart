import '../../../../../core/network/api_helper.dart';
import '../../../../../core/network/end_points.dart';
import '../../../data/models/news_model.dart';

class ExploreRepository {
  final APIHelper _api = APIHelper();

  static const List<String> _categoryKeys = [
    'science',
    'technology',
    'business',
    'entertainment',
  ];

  /// 🔥 Fetch articles by category (Top Headlines)
  Future<List<NewsArticleModel>> fetchArticles({
    int categoryIndex = 0,
  }) async {
    try {
      final category = _categoryKeys[categoryIndex];

      final response = await _api.getRequest(
        endPoint: EndPoints.topHeadlines,
        queryParams: {
          'category': category,
          'country': 'us',
          'apiKey': EndPoints.newsApiKey,
        },
      );

      if (!response.status || response.data == null) return [];

      final List articlesJson = response.data['articles'] ?? [];

      return articlesJson
          .map((e) => NewsArticleModel.fromJson(e))
          .where((a) =>
      (a.title?.isNotEmpty ?? false) &&
          a.title != '[Removed]')
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 🔥 Search articles
  Future<List<NewsArticleModel>> searchArticles(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final response = await _api.getRequest(
        endPoint: EndPoints.everything,
        queryParams: {
          'q': query,
          'apiKey': EndPoints.newsApiKey,
        },
      );

      if (!response.status || response.data == null) return [];

      final List articlesJson = response.data['articles'] ?? [];

      return articlesJson
          .map((e) => NewsArticleModel.fromJson(e))
          .where((a) =>
      (a.title?.isNotEmpty ?? false) &&
          a.title != '[Removed]')
          .toList();
    } catch (e) {
      return [];
    }
  }
}