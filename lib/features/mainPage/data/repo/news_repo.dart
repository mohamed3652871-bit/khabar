import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/end_points.dart';
import '../models/news_model.dart';

class NewsRepo {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.newsBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<Either<String, List<NewsArticleModel>>> fetchNews(

      ) async {


    try {
      final response = await _dio.get(
        EndPoints.topHeadlines,
        queryParameters: {
          'apiKey': EndPoints.newsApiKey,
          'country': 'us',
          'category': 'science',
        },
      );

      if (response.statusCode == 200) {
        final newsResponse = NewsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        print(newsResponse.articles);
        return Right(newsResponse.articles ?? []);
      } else {
        print('Error: ${response.statusCode}');
        return Left('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
