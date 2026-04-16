import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khabar/features/mainPage/views/ExplorePage/views/explore_page.dart';
import 'package:khabar/features/mainPage/views/WeatherPage/views/weather_page.dart';
import 'package:khabar/features/mainPage/views/bookMarksPage/views/book_marks_page.dart';
import 'package:khabar/features/mainPage/views/homePage/views/home_page.dart';
import '../../../../../core/utils/app_colors.dart';

import '../../../core/widgets/bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.latLng});
  final LatLng? latLng;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    ExplorePage(),
    BookMarksPage(),
    WeatherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomBar(
        selectedIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}