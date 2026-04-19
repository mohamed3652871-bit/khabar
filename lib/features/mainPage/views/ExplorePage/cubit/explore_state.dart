import '../../../data/models/news_model.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreLoaded extends ExploreState {
  final List<NewsArticleModel> articles;
  final List<String> categories;
  final int selectedCategory;
  final bool isSearching;
  final String searchQuery;

  ExploreLoaded({
    required this.articles,
    required this.categories,
    required this.selectedCategory,
    this.isSearching = false,
    this.searchQuery = '',
  });
  ExploreLoaded copyWith({
    List<NewsArticleModel>? articles,
    List<String>? categories,
    int? selectedCategory,
    bool? isSearching,
    String? searchQuery,
  }) {
    return ExploreLoaded(
      articles: articles ?? this.articles,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ExploreError extends ExploreState {
  final String message;
  ExploreError(this.message);
}
