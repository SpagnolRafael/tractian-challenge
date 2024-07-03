import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/shareds/custom_button.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_icons.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CustomErrorWidget extends StatelessWidget {
  final void Function()? onTryAgain;
  final String description;
  const CustomErrorWidget(
      {super.key, this.onTryAgain, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(),
        SvgPicture.asset(
          AppIcons.warning,
          height: 80,
        ),
        const SizedBox(height: 10),
        Text('An error occurred trying to load $description',
            style:
                AppTextStyle.robotoW400s18.copyWith(color: AppColors.primary)),
        if (onTryAgain != null) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomButton.primary(
              text: Text('Try Again', style: AppTextStyle.robotoW500s16),
              enable: true,
              onTap: onTryAgain,
            ),
          )
        ]
      ],
    );
  }
}
