import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/network/end_points.dart';
import 'weather_model.dart';

class WeatherRepo {
  static final Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.weatherBaseUrl));

  Future<Either<String, WeatherModel>> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await _dio.get(
        EndPoints.weather,
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': EndPoints.weatherApiKey,
          'units': 'metric',
        },
      );
      if (response.statusCode == 200) {
        final model = WeatherModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(model);
      } else {
        return Left('Error: ${response.statusCode}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
