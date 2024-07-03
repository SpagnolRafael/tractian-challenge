import 'package:flutter/material.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool enable;
  final double? height;
  final double? width;
  final Color? color;
  final Widget? text;
  final TextStyle? style;
  final BorderRadius? borderRadius;
  final Widget? icon;

  const CustomButton._({
    this.onTap,
    this.height,
    this.width,
    this.color,
    this.text,
    this.style,
    this.borderRadius,
    required this.enable,
    this.icon,
  });

  factory CustomButton.primary(
          {VoidCallback? onTap,
          required Widget text,
          required bool enable,
          Color color = AppColors.primary,
          Widget? icon}) =>
      CustomButton._(
        enable: enable,
        onTap: enable ? onTap : null,
        width: double.infinity,
        height: 54,
        color: enable ? color : AppColors.primary,
        text: text,
        style: AppTextStyle.robotoW500s16.copyWith(color: AppColors.white),
        icon: icon,
        borderRadius: BorderRadius.circular(10),
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color: color, borderRadius: borderRadius),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) ...[icon!, const SizedBox(width: 10)],
                    if (text != null) text!,
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
