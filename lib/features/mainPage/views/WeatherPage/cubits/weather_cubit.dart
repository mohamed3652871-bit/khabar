import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/weather_model.dart';
import '../data/weather_repo.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(BuildContext context) => BlocProvider.of(context);

  WeatherModel? weather;
  String? errorMessage;

  Future<void> fetchWeather({
    required double lat,
    required double lon,
  }) async
  {
    emit(WeatherLoadingState());
    final result = await WeatherRepo().fetchWeather(lat: lat, lon: lon);
    result.fold(
      (error) {
        errorMessage = error;
        emit(WeatherErrorState());
      },
      (model) {
        weather = model;
        emit(WeatherSuccessState());
      },
    );
  }
}
