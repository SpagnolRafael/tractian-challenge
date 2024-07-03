import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/data/dto/company_dto.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_icons.dart';
import 'package:tractian_challenge/utils/app_routes.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CompanyCard extends StatelessWidget {
  final CompanyDto company;
  const CompanyCard({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.assetScreen,
          arguments: {"id": company.id}),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.only(left: 35),
        height: 76,
        decoration: BoxDecoration(
            color: AppColors.blue400, borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            SvgPicture.asset(AppIcons.iconNetwork,
                height: 25,
                width: 25,
                colorFilter:
                    const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
            const SizedBox(width: 15),
            Expanded(
                child: Text('${company.name} Unit',
                    style: AppTextStyle.robotoW500s18)),
          ],
        ),
      ),
    );
  }
}
