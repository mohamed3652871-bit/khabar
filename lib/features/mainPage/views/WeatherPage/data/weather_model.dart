class WeatherModel {
  final String cityName;
  final String country;
  final double temp;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;

  WeatherModel({
    required this.cityName,
    required this.country,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.weatherMain,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = (json['weather'] as List).first as Map<String, dynamic>;
    final main = json['main'] as Map<String, dynamic>;
    final sys = json['sys'] as Map<String, dynamic>;
    return WeatherModel(
      cityName: json['name'] ?? '',
      country: sys['country'] ?? '',
      temp: (main['temp'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      humidity: (main['humidity'] as num).toInt(),
      pressure: (main['pressure'] as num).toInt(),
      weatherMain: weather['main'] ?? '',
      weatherDescription: weather['description'] ?? '',
      weatherIcon: weather['icon'] ?? '',
    );
  }
}
