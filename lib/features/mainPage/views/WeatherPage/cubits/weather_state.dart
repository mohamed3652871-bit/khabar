import '../data/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {
  final WeatherModel weather;

  WeatherSuccessState(this.weather);
}

class WeatherErrorState extends WeatherState {
  final String message;

  WeatherErrorState(this.message);
}