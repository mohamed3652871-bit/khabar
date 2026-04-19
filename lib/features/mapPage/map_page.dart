import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khabar/core/utils/app_colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/app_icons.dart';
import '../../core/widgets/shared_buttons.dart';
import '../mainPage/main_page.dart';
import 'cubits/map_cupit.dart';
import 'cubits/map_state.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MapCubit(),
      child: Builder(
        builder: (context) {
          final cubit = MapCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.appWhite,
              child: Column(
                children: [
                  SizedBox(height: 100.h),

                  /// Search bar
                  Container(
                    height: 48.h,
                    width: 362.w,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: AppColors.mapPageBarColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        AppIcon(
                          icon: AppIcons.profileIconA,
                          size: 24.r,
                          color: AppColors.textColorBlack,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextFormField(
                            controller: cubit.searchController,

                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              hintText: 'Enter your Name',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 33.h),

                  /// Map
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        BlocBuilder<MapCubit, MapState>(
                          builder: (context, state) {
                            return GoogleMap(
                              markers: cubit.markers,
                              onMapCreated: (controller) {
                                cubit.mapController = controller;
                              },
                              initialCameraPosition: CameraPosition(
                                target: cubit.initLatLng,
                                zoom: 12,
                              ),
                              onTap: (latLng) {
                                cubit.addMarker(latLng);
                                debugPrint(
                                  "latitude:${latLng.latitude}, longitude:${latLng.longitude}",
                                );
                              },
                            );
                          },
                        ),

                        /// Button
                        Container(
                          margin: EdgeInsets.only(bottom: 28.h),
                          child: ButtonA(
                            buttonPadding: EdgeInsets.symmetric(
                              vertical: 16.h,
                              horizontal: 24.w,
                            ),
                            buttonRadius: 128.r,
                            buttonColor: AppColors.buttonBlue,
                            text: 'Get Started',
                            textColor: AppColors.appWhite,
                            textSize: 20.sp,
                            onPressedFunction: () {
                              final cubit = context.read<MapCubit>();

                              if (cubit.selectedLatLng == null) return;

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      MainPage(latLng: cubit.selectedLatLng!,
                                        userName: cubit.searchController.text,
                                      ),
                                ),
                              );

                              debugPrint(
                                "selected latitude: ${cubit.selectedLatLng!}",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
