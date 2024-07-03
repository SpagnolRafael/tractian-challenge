import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_challenge/utils/app_colors.dart';
import 'package:tractian_challenge/utils/app_icons.dart';
import 'package:tractian_challenge/utils/app_text_style.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget child;
  final bool isLocation;
  final bool isComponent;
  final String name;
  final bool initiallyExpanded;
  final String? sensorType;
  final bool showExpandIcon;
  const CustomExpansionTile(
      {super.key,
      this.initiallyExpanded = false,
      this.showExpandIcon = true,
      required this.child,
      required this.isLocation,
      required this.isComponent,
      required this.name,
      this.sensorType});

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool expanded = false;
  @override
  void initState() {
    super.initState();
    expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      minTileHeight: 20,
      childrenPadding: const EdgeInsets.only(left: 15),
      initiallyExpanded: expanded,
      trailing: const SizedBox(),
      onExpansionChanged: (value) => setState(() => expanded = value),
      tilePadding: const EdgeInsets.symmetric(horizontal: 5),
      title: Row(
        children: [
          if (widget.showExpandIcon)
            RotatedBox(
                quarterTurns: expanded ? 2 : 0,
                child: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: AppColors.blue900))
          else
            const SizedBox(width: 22),
          if (widget.isLocation)
            const Icon(Icons.location_on_outlined, color: AppColors.blue400)
          else
            SvgPicture.asset(
                widget.isComponent
                    ? AppIcons.iconComponent
                    : AppIcons.iconAsset,
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(AppColors.blue400, BlendMode.srcIn)),
          const SizedBox(width: 10),
          Text(widget.name,
              style: AppTextStyle.robotoW400s14
                  .copyWith(color: AppColors.blue900)),
          if (widget.sensorType == 'energy')
            const Icon(Icons.bolt, color: AppColors.green100),
          if (widget.sensorType != null && widget.sensorType != 'energy')
            Container(
              margin: const EdgeInsets.only(left: 8),
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                  color: AppColors.red, shape: BoxShape.circle),
            )
        ],
      ),
      children: [widget.child],
    );
  }
}
