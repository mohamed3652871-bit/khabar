import 'package:flutter_bloc/flutter_bloc.dart';

import '../../articlePage/data/article_model.dart';
import 'news_state.dart';


class NewsCubit extends Cubit<NewsState>{
  NewsCubit():super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);

  List<ArticleModel> articles = [];
  String? errorMessage;


  fetchNews()async{
    // emit(NewsLoadingState());
    // var result = await NewsRepo().fetchNews();
    // result.fold(
    //     (errorMsg){
    //       errorMessage = errorMsg;
    //       emit(NewsErrorState());
    //     },
    //     (articles) {
    //       this.articles = articles;
    //       emit(NewsSuccessState());
    //     }
    // );
  }
}