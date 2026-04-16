import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../cubits/weather_cubit.dart';
import '../cubits/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key, this.latLng});
  final LatLng? latLng;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        final cubit = WeatherCubit.get(context);
        final weather = cubit.weather;

        return Scaffold(
          backgroundColor: AppColors.bgPrimary,
          body: state is WeatherLoadingState
              ? const Center(child: CircularProgressIndicator())
              : state is WeatherErrorState
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Text(
                          cubit.errorMessage ?? 'Something went wrong',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildWeatherHeader(
                                weatherMain: weather?.weatherMain ?? '—',
                                temp: weather?.temp.round().toString() ?? '—',
                              ),
                              SizedBox(height: 29.h),
                              _buildLocationRow(
                                city: weather?.cityName ?? '—',
                                country: weather?.country ?? '—',
                              ),
                              SizedBox(height: 8.h),
                              _buildTemperatureRow(
                                temp: weather?.temp.round().toString() ?? '—',
                                icon: weather?.weatherIcon,
                              ),
                              SizedBox(height: 8.h),
                              _buildConditionText(
                                main: weather?.weatherMain ?? '—',
                                description: weather?.weatherDescription ?? '—',
                                feelsLike:
                                    weather?.feelsLike.round().toString() ??
                                        '—',
                              ),
                              SizedBox(height: 45.h),
                              _buildDetailGrid(
                                humidity: weather?.humidity.toString() ?? '—',
                                pressure: weather?.pressure.toString() ?? '—',
                                feelsLike:
                                    weather?.feelsLike.round().toString() ??
                                        '—',
                                tempF: weather != null
                                    ? ((weather.temp * 9 / 5) + 32)
                                        .round()
                                        .toString()
                                    : '—',
                              ),
                              SizedBox(height: 82.h),
                              _buildChangeLocationButton(context),
                            ],
                          ),
                        ),
                      ],
                    ),
        );
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 138.w,
                child: Text(
                  'Good Morning',
                  style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    height: 20 / 14,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                _formattedDate(),
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  height: 24 / 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('☀️', style: TextStyle(fontSize: 20.sp)),
              SizedBox(width: 8.w),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$weatherMain $temp',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    WidgetSpan(
                      child: Transform.translate(
                        offset: Offset(0, -4.h),
                        child: Text(
                          'o',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: 'C',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow({required String city, required String country}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Text(
        '$city - $country',
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
          fontSize: 32.sp,
          height: 40 / 32,
          color: AppColors.textPrimary,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _buildTemperatureRow({required String temp, String? icon}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            temp,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 48.sp,
              height: 1.0,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          icon != null
              ? Image.network(
                  'https://openweathermap.org/img/wn/$icon@2x.png',
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => AppIcon(
                    icon: AppIcons.weatherSun,
                    size: 76.r,
                  ),
                )
              : AppIcon(icon: AppIcons.weatherSun, size: 76.r),
        ],
      ),
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
          Text(
            '$main - ${_capitalize(description)}',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              fontSize: 32.sp,
              height: 40 / 32,
              color: AppColors.textPrimary,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          Text(
            'Feels like $feelsLike°C',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
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
      _DetailItem(
        fallbackIcon: Icons.thermostat,
        value: '$tempF°F',
        label: 'Fahrenheit',
      ),
      _DetailItem(
        fallbackIcon: Icons.air,
        value: '$pressure hPa',
        label: 'Pressure',
      ),
      _DetailItem(
        fallbackIcon: Icons.wb_sunny_outlined,
        value: '$feelsLike°C',
        label: 'Feels Like',
      ),
      _DetailItem(
        fallbackIcon: Icons.water_drop_outlined,
        value: '$humidity%',
        label: 'Humidity',
      ),
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
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFFFFFFFF), Color(0x00FFFFFF)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(item.fallbackIcon, size: 36.sp, color: AppColors.brandBlue),
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.value,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  height: 1.12,
                  letterSpacing: 0.3,
                  color: AppColors.brandBlue,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                item.label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  height: 1.12,
                  letterSpacing: 0.3,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChangeLocationButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => Navigator.pop(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandBlue,
          foregroundColor: Colors.white,
          padding:
              EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(128.r),
          ),
          elevation: 0,
        ),
        icon: Icon(Icons.location_on, size: 22.sp, color: Colors.white),
        label: Text(
          'Change Location',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            height: 24 / 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  String _formattedDate() {
    final now = DateTime.now();
    const days = [
      'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    ];
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${days[now.weekday - 1]} ${now.day} ${months[now.month - 1]}, ${now.year}';
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}

class _DetailItem {
  final IconData fallbackIcon;
  final String value;
  final String label;

  const _DetailItem({
    required this.fallbackIcon,
    required this.value,
    required this.label,
  });
}
