
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
abstract class AppIcons {
  static const String rightArrow = 'assets/iconsSvg/khabarRightArrow.svg';
  static const String profileIconA = 'assets/iconsSvg/ProfileSvg.svg';
  static const String sunnyIcon = 'assets/iconsSvg/sunny.svg';
  static const String homeIcon = 'assets/iconsSvg/homeIcon.svg';
  static const String exploreIcon = 'assets/iconsSvg/exploreIcon.svg';
  static const String bookMarkIcon = 'assets/iconsSvg/bookMarkIcon.svg';
  static const String weatherIcon = 'assets/iconsSvg/WeatherIcon.svg';
  static const String articleBackIcon = 'assets/iconsSvg/long-arrow-left.svg';
  static const String articleBookMarkA = 'assets/iconsSvg/articleBookMarkA.svg';
  static const String articleBookMarkB = 'assets/iconsSvg/articleBookMarkB.svg';
  static const String articleShare = 'assets/iconsSvg/share.svg';
  static const String weatherSun = 'assets/iconsSvg/sun.svg';

}
class AppIcon extends StatelessWidget {
  final String icon;
  final double size;
  final Color? color;

  const AppIcon( {
    super.key,
    required this.icon,
    this.size = 24,
    this.color,});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      fit: BoxFit.contain,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
