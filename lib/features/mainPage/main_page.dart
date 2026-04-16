import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/bottom_bar.dart';
import 'cubits/news_cubit.dart';
import 'views/ExplorePage/views/explore_page.dart';
import 'views/WeatherPage/cubits/weather_cubit.dart';
import 'views/WeatherPage/views/weather_page.dart';
import 'views/bookMarksPage/views/book_marks_page.dart';
import 'views/homePage/views/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, this.latLng});
  final LatLng? latLng;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      const HomeScreen(),
      const ExplorePage(),
      const BookMarksPage(),
      WeatherPage(latLng: widget.latLng),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsCubit()..fetchNews(),
        ),
        BlocProvider(
          create: (_) {
            final cubit = WeatherCubit();
            if (widget.latLng != null) {
              cubit.fetchWeather(
                lat: widget.latLng!.latitude,
                lon: widget.latLng!.longitude,
              );
            }
            return cubit;
          },
        ),
      ],
      child: Scaffold(
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
      ),
    );
  }
}