import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khabar/features/mainPage/views/WeatherPage/cubits/weather_state.dart';
import 'package:flutter/material.dart';

import '../data/weather_repo.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(BuildContext context) =>
      BlocProvider.of(context);



  Future<void> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    emit(WeatherLoadingState());

    final result = await WeatherRepo().fetchWeather(lat: lat, lon: lon);

    result.fold(
          (error) {
        emit(WeatherErrorState(error));
      },
          (model) {
        emit(WeatherSuccessState(model));
      },
    );
  }
  IconData getWeatherIcon(String weather) {
    switch (weather.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.umbrella;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'fog':
        return Icons.blur_on;
      default:
        return Icons.wb_sunny;
    }
  }

  Color getWeatherColor(String weather) {
    switch (weather.toLowerCase()) {
      case 'clear':
        return Colors.amber;
      case 'clouds':
        return Colors.grey;
      case 'rain':
        return Colors.blue;
      case 'drizzle':
        return Colors.lightBlue;
      case 'thunderstorm':
        return Colors.deepPurple;
      case 'snow':
        return Colors.lightBlueAccent;
      case 'mist':
      case 'fog':
        return Colors.blueGrey;
      default:
        return Colors.amber;
    }
  }
}