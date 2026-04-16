import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/end_points.dart';
import '../models/news_model.dart';

class NewsRepo {
  static final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.newsBaseUrl));

  Future<Either<String, List<ArticleModel>>> fetchNews() async {
    try {
      final response = await _dio.get(
        EndPoints.everything,
        queryParameters: {
          'q': 'a',
          'apiKey': EndPoints.newsApiKey,
          'language': 'en',
          'sortBy': 'popularity',
        },
      );

      if (response.statusCode == 200) {
        final newsResponse = FetchNewsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(newsResponse.articles ?? []);
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
