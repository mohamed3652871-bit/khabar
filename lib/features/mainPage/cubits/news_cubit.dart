import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';


import '../data/models/news_model.dart';
import '../data/repo/news_repo.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  static NewsCubit get(BuildContext context) => BlocProvider.of(context);

  List<NewsArticleModel> articles = [];
  String? errorMessage;

  Future<void> fetchNews() async {
    emit(NewsLoadingState());
    final result = await NewsRepo().fetchNews();
    result.fold(
      (error) {
        errorMessage = error;
        emit(NewsErrorState());
      },
      (articleList) {
        articles = articleList;
        emit(NewsSuccessState());
      },
    );
  }
}