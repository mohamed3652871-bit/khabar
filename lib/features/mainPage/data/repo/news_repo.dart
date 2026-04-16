

import 'package:dartz/dartz.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/news_model.dart';

class NewsRepo{
  Future<Either<String, List<ArticleModel>>> fetchNews() async {
    try {
      final result =
      await APIHelper().getRequest(endPoint: EndPoints.everything);

      if (result.status) {
        final newsModel = ArticleModel.fromJson(result.data);
        return Right(newsModel.articles);
      } else {
        return Left(result.message);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }


}
