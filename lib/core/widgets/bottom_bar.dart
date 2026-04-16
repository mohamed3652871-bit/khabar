import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_icons.dart';
class BottomBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<String> icons = [
    AppIcons.homeIcon,
    AppIcons.exploreIcon,
    AppIcons.bookMarkIcon,
    AppIcons.weatherIcon,
  ];

  final List<String> labels = ['Home', 'Explore', 'Bookmark', 'Weather'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: AppColors.bottomBarColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32.r), topRight: Radius.circular(32.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          return GestureDetector(
            onTap: () => widget.onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: widget.selectedIndex == index ? 16.w : 12,
                vertical: 12.h,
              ),
              decoration: BoxDecoration(
                color: widget.selectedIndex == index
                    ? AppColors.bottomBarColorB
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Row(
                children: [
                  AppIcon(
                    icon: icons[index],
                    size: 24.r,
                    color: widget.selectedIndex == index
                        ? AppColors.appWhite
                        : AppColors.bottomBarColorB,
                  ),
                  if (widget.selectedIndex == index)
                    Padding(
                      padding: EdgeInsets.only(left: 7.w),
                      child: Text(
                        labels[index],
                        style: TextStyle(
                          color: AppColors.appWhite,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}