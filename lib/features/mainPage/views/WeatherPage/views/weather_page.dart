import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../cubits/weather_cubit.dart';
import '../cubits/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, this.latLng});

  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is WeatherErrorState) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(24.r),
                child: Text(
                  state.message,
                  style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        if (state is WeatherSuccessState) {
          final weather = state.weather;

          return Scaffold(
            backgroundColor: AppColors.bgPrimary,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWeatherHeader(
                    weatherMain: weather.weatherMain,
                    temp: weather.temp.round().toString(),
                  ),

                  SizedBox(height: 29.h),

                  _buildLocationRow(
                    city: weather.cityName,
                    country: weather.country,
                  ),

                  SizedBox(height: 8.h),

                  _buildTemperatureRow(
                    temp: weather.temp.round().toString(),
                    icon: weather.weatherIcon,
                    weatherMain: weather.weatherMain,
                  ),

                  _buildConditionText(
                    main: weather.weatherMain,
                    description: weather.weatherDescription,
                    feelsLike: weather.feelsLike.round().toString(),
                  ),

                  SizedBox(height: 45.h),

                  _buildDetailGrid(
                    humidity: weather.humidity.toString(),
                    pressure: weather.pressure.toString(),
                    feelsLike: weather.feelsLike.round().toString(),
                    tempF: ((weather.temp * 9 / 5) + 32).round().toString(),
                  ),

                  SizedBox(height: 82.h),

                  _buildChangeLocationButton(context),
                ],
              ),
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }


  Widget _buildWeatherHeader({
    required String weatherMain,
    required String temp,
  }) {
    return Container(
      width: double.infinity,
      height: 142.h,
      color: AppColors.brandBlue10,
      padding: EdgeInsets.fromLTRB(32.w, 68.h, 32.w, 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good Morning'),
                Spacer(),
                Text(_formattedDate(),style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w800,color: AppColors.textPrimary))],
            ),
          ),
          Row(
            children: [
              Icon(
                _getWeatherIcon(weatherMain),
                color: _getWeatherColor(weatherMain),
              ),
              SizedBox(width: 6.w),
              Text('$weatherMain $temp°C'),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildLocationRow({required String city, required String country}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Text('$city - $country', overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w600,color: AppColors.textPrimary)),
    );
  }


  Widget _buildTemperatureRow({
    required String temp,
    required String weatherMain,
    String? icon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        children: [
          Text(
            temp,
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          _buildWeatherIcon(weatherMain, icon),
        ],
      ),
    );
  }

  Widget _buildWeatherIcon(String weatherMain, String? icon) {
    // fallback: no icon or error case → use weather logic
    if (icon == null || icon.isEmpty) {
      return Icon(
        _getWeatherIcon(weatherMain),
        size: 76.r,
        color: _getWeatherColor(weatherMain),
      );
    }

    return Image.network(
      'https://openweathermap.org/img/wn/$icon@2x.png',
      width: 90.w,
      height: 90.h,

      errorBuilder: (_, __, ___) {
        return Icon(
          _getWeatherIcon(weatherMain),
          size: 76.r,
          color: _getWeatherColor(weatherMain),
        );
      },

      /// loading state
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: 40.r,
          height: 40.r,
          child: const CircularProgressIndicator(strokeWidth: 2),
        );
      },
    );
  }

  Widget _buildConditionText({
    required String main,
    required String description,
    required String feelsLike,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$main - ${_capitalize(description)}',style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.w500,color: AppColors.textPrimary)),
          Text('Feels like $feelsLike°C',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.textPrimary)),
        ],
      ),
    );
  }


  Widget _buildDetailGrid({
    required String tempF,
    required String pressure,
    required String feelsLike,
    required String humidity,
  }) {
    final items = [
      _DetailItem(Icons.thermostat, '$tempF°F', 'Fahrenheit'),
      _DetailItem(Icons.air, '$pressure hPa', 'Pressure'),
      _DetailItem(Icons.wb_sunny_outlined, '$feelsLike°C', 'Feels Like'),
      _DetailItem(Icons.water_drop_outlined, '$humidity%', 'Humidity'),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          childAspectRatio: (179.w) / (85.h),
        ),
        itemBuilder: (_, i) => _buildDetailCard(items[i]),
      ),
    );
  }

  Widget _buildDetailCard(_DetailItem item) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Icon(item.icon, color: AppColors.brandBlue, size: 42.r),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.value,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,color: AppColors.textBlue)),
              SizedBox(height: 9.h),
              Text(item.label,style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w300,color: AppColors.textSecondary))],
          ),
        ],
      ),
    );
  }

  // ───────────────────────── BUTTON ─────────────────────────

  Widget _buildChangeLocationButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.location_on),
        label: const Text('Change Location'),
      ),
    );
  }

  // ───────────────────────── HELPERS ─────────────────────────

  IconData _getWeatherIcon(String weather) {
    switch (weather.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.umbrella;
      default:
        return Icons.wb_sunny;
    }
  }

  Color _getWeatherColor(String weather) {
    switch (weather.toLowerCase()) {
      case 'clear':
        return Colors.orange;
      case 'clouds':
        return Colors.grey;
      case 'rain':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  String _formattedDate() {
    final now = DateTime.now();
    return '${now.day}/${now.month}/${now.year}';
  }

  String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}

class _DetailItem {
  final IconData icon;
  final String value;
  final String label;

  _DetailItem(this.icon, this.value, this.label);
}
