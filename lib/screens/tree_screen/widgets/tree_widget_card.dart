import 'package:flutter/material.dart';
import 'package:tractian_challenge/data/dto/asset_dto.dart';
import 'package:tractian_challenge/data/dto/company_asset_dto.dart';
import 'package:tractian_challenge/data/dto/location_dto.dart';
import 'package:tractian_challenge/shareds/custom_expansion_tile.dart';

class TreeWidgetCard extends StatefulWidget {
  final List<CompanyAssetDto> parents;
  final List<CompanyAssetDto> others;
  const TreeWidgetCard(
      {super.key, required this.parents, required this.others});

  @override
  State<TreeWidgetCard> createState() => _TreeWidgetCardState();
}

class _TreeWidgetCardState extends State<TreeWidgetCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final asset = widget.parents[index];
        final isLocation = asset.isLocation();
        final parents =
            widget.others.where((e) => e.parentId == asset.id).toList();
        final others =
            widget.others.where((e) => e.parentId != asset.id).toList();
        return CustomExpansionTile(
          sensorType: asset.sensorType,
          showExpandIcon: parents.isNotEmpty,
          isComponent: asset.sensorType != null,
          isLocation: isLocation,
          name: isLocation
              ? (widget.parents[index] as LocationDto).name
              : (widget.parents[index] as AssetDto).name,
          child: TreeWidgetCard(
            parents: parents,
            others: others,
          ),
        );

        // ExpansionTile(
        //   trailing: const SizedBox(),
        //   leading: const Icon(Icons.keyboard_arrow_down_rounded),
        //   childrenPadding: const EdgeInsets.only(left: 15),
        //   initiallyExpanded: true,
        //   title: Row(
        //     children: [
        //       if (isLocation)
        //         const Icon(Icons.location_on_outlined, color: AppColors.blue400)
        //       else
        //         SvgPicture.asset(
        //             asset.sensorType != null
        //                 ? AppIcons.iconComponent
        //                 : AppIcons.iconAsset,
        //             width: 20,
        //             height: 20,
        //             colorFilter: const ColorFilter.mode(
        //                 AppColors.blue400, BlendMode.srcIn)),
        //       const SizedBox(width: 10),
        //       Expanded(
        //         child: Text(isLocation
        //             ? (widget.parents[index] as LocationDto).name
        //             : (widget.parents[index] as AssetDto).name),
        //       ),
        //     ],
        //   ),
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(left: 15),
        //       child: TreeWidget(
        //         parents: parents,
        //         others: others,
        //       ),
        //     ),
        //   ],
        // );
      },
      itemCount: widget.parents.length,
    );
  }
}
