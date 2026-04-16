import 'package:flutter/material.dart';

class ButtonA extends StatelessWidget {
  const ButtonA({
    super.key,
    required this.buttonPadding,
    required this.buttonRadius,
    required this.buttonColor,
    required this.onPressedFunction,
    this.text,
    this.textSize,
    this.textColor,
    this.startIcon,
    this.endIcon,
    this.textPadding,
  });

  final EdgeInsetsGeometry buttonPadding;
  final double buttonRadius;
  final Color buttonColor;
  final Function() onPressedFunction;
  final String? text;
  final double? textSize;
  final Color? textColor;
  final EdgeInsetsGeometry? textPadding;
  final Widget? startIcon;
  final Widget? endIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressedFunction,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: buttonColor,
        padding: buttonPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        elevation: 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ?startIcon,
          if (text != null)
            Padding(
              padding: textPadding ?? EdgeInsets.zero,
              child: Text(
                text!,
                style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                  fontFamily: 'SchibstedGrotesk',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ?endIcon,
        ],
      ),
    );
  }
}
class ButtonB extends StatelessWidget {
  const ButtonB({
    super.key,
    required this.size,
    required this.borderRadius,
    required this.buttonColor,
    required this.onPressedFunction,
    required this.icon,
    this.iconColor,
  });

  final double size;
  final double borderRadius;
  final Color buttonColor;
  final VoidCallback onPressedFunction;

  final Widget icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressedFunction,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: icon
          ),
        ),
      ),
    );
  }
}
