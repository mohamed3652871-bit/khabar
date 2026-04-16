import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';



class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWeatherHeader(),
                SizedBox(height: 29.h),
                _buildLocationRow(),
                SizedBox(height: 8.h),
                _buildTemperatureRow(),
                SizedBox(height: 8.h),
                _buildConditionText(),
                SizedBox(height: 45.h),
                _buildDetailGrid(),
                SizedBox(height: 82.h),
                _buildChangeLocationButton(),
              ],
            ),
          ),

        ],
      ),
    );
  }



  Widget _buildWeatherHeader() {
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
                  'Good Morning, Ahmed Saber',
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
                'Sun 9 April, 2023',
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

              Text(
                '☀️',
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(width: 8.w),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sunny 32',
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

  Widget _buildLocationRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Text(
        'Cairo - EG',
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

  Widget _buildTemperatureRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '27',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 48.sp,
              height: 1.0,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Image.network(
            'https://www.figma.com/api/mcp/asset/6e3a8412-e07d-4648-9a25-782d2dbeff1e',
            width: 100.w,
            height: 100.h,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => AppIcon(icon: AppIcons.weatherSun
            ,size: 76.r,),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Clear - Clear Sky',
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
            'Feels like 28',
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

  Widget _buildDetailGrid() {
    final items = [
      _DetailItem(
        networkIconUrl:
            'https://www.figma.com/api/mcp/asset/249c3d92-2d72-4a41-9f72-250f0ff8c83e',
        fallbackIcon: Icons.thermostat,
        value: '72°',
        label: 'Fahrenheit',
      ),
      _DetailItem(
        networkIconUrl:
            'https://www.figma.com/api/mcp/asset/baed359b-20f4-4db5-bf8e-cf3a4c0407aa',
        fallbackIcon: Icons.air,
        value: '134 mp/h',
        label: 'Pressure',
      ),
      _DetailItem(
        networkIconUrl:
            'https://www.figma.com/api/mcp/asset/6e3a8412-e07d-4648-9a25-782d2dbeff1e',
        fallbackIcon: Icons.wb_sunny_outlined,
        value: '0.2',
        label: 'UV Index',
      ),
      _DetailItem(
        networkIconUrl:
            'https://www.figma.com/api/mcp/asset/f6d96849-827c-4174-af92-6b3741d86b3f',
        fallbackIcon: Icons.water_drop_outlined,
        value: '48%',
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
          colors: [
            Color(0xFFFFFFFF),
            Color(0x00FFFFFF),
          ],
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
          Image.network(
            item.networkIconUrl,
            width: 42.w,
            height: 42.h,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Icon(
              item.fallbackIcon,
              size: 36.sp,
              color: AppColors.brandBlue,
            ),
          ),
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


  Widget _buildChangeLocationButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandBlue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w, vertical: 16.h,
          ),
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

}

class _DetailItem {
  final String networkIconUrl;
  final IconData fallbackIcon;
  final String value;
  final String label;

  const _DetailItem({
    required this.networkIconUrl,
    required this.fallbackIcon,
    required this.value,
    required this.label,
  });
}

