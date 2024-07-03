import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_icons.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  final void Function()? onBackTap;
  final String? title;
  const CustomAppBar({super.key, this.onBackTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          bottom: 15, top: (MediaQuery.of(context).padding.top + 15)),
      color: AppColors.primary,
      child: Row(
        children: [
          if (onBackTap != null) ...[
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 25,
                    child: GestureDetector(
                      onTap: onBackTap,
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: AppColors.white),
                    ),
                  ),
                  if (title != null)
                    Center(
                      child: Text(title!, style: AppTextStyle.robotoW400s18),
                    )
                ],
              ),
            )
          ] else
            Expanded(
              child: Center(
                child: SvgPicture.asset(AppIcons.logo,
                    height: 25,
                    colorFilter: const ColorFilter.mode(
                        AppColors.white, BlendMode.srcIn)),
              ),
            ),
        ],
      ),
    );
  }
}
