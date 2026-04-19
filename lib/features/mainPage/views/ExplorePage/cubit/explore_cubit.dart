import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/explore_repository.dart';
import 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepository _repo = ExploreRepository();

  static const int defaultCategoryIndex = 0;

  Timer? _debounce;

  static const List<String> _categories = [
    'Science',
    'Technology',
    'Business',
    'Entertainment',
  ];

  List<String> get categories => _categories;

  ExploreCubit() : super(ExploreInitial()) {
    fetchArticles(categoryIndex: defaultCategoryIndex);
  }

  Future<void> fetchArticles({int categoryIndex = defaultCategoryIndex}) async {
    emit(ExploreLoading());

    try {
      final articles = await _repo.fetchArticles(
        categoryIndex: categoryIndex,
      );

      emit(ExploreLoaded(
        articles: articles,
        categories: _categories,
        selectedCategory: categoryIndex,
        isSearching: false,
        searchQuery: '',
      ));
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }

  void selectCategory(int index) {
    fetchArticles(categoryIndex: index);
  }

  void toggleSearch() {
    if (state is! ExploreLoaded) return;

    final current = state as ExploreLoaded;

    final newSearchState = !current.isSearching;

    if (!newSearchState) {
      fetchArticles(categoryIndex: current.selectedCategory);
      return;
    }

    emit(current.copyWith(
      isSearching: true,
      searchQuery: '',
    ));
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
          () => _search(query),
    );
  }

  Future<void> _search(String query) async {
    if (state is! ExploreLoaded) return;

    final current = state as ExploreLoaded;

    if (query.trim().isEmpty) {
      fetchArticles(categoryIndex: current.selectedCategory);
      return;
    }

    try {
      final articles = await _repo.searchArticles(query);

      emit(current.copyWith(
        articles: articles,
        isSearching: true,
        searchQuery: query,
      ));
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}