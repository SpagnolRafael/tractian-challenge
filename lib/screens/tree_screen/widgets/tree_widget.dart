import 'package:flutter/material.dart';
import 'package:tractian_challenge/data/dto/asset_dto.dart';
import 'package:tractian_challenge/data/dto/company_asset_dto.dart';
import 'package:tractian_challenge/data/dto/location_dto.dart';
import 'package:tractian_challenge/screens/tree_screen/widgets/tree_widget_card.dart';
import 'package:tractian_challenge/shareds/custom_expansion_tile.dart';

class TreeWidget extends StatefulWidget {
  final List<CompanyAssetDto> parents;
  final List<CompanyAssetDto> others;
  final bool shrinkWrap;
  const TreeWidget({
    super.key,
    required this.parents,
    required this.others,
    this.shrinkWrap = true,
  });

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: widget.shrinkWrap,
      shrinkWrap: widget.shrinkWrap,
      physics: !widget.shrinkWrap ? null : const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final asset = widget.parents[index];
        final isLocation = asset.isLocation();
        final parents =
            widget.others.where((e) => e.parentId == asset.id).toList();
        final others =
            widget.others.where((e) => e.parentId != asset.id).toList();
        return CustomExpansionTile(
          initiallyExpanded: !widget.shrinkWrap,
          showExpandIcon: parents.isNotEmpty,
          isComponent: asset.sensorType != null,
          isLocation: isLocation,
          sensorType: asset.sensorType,
          name: isLocation
              ? (widget.parents[index] as LocationDto).name
              : (widget.parents[index] as AssetDto).name,
          child: TreeWidgetCard(
            parents: parents,
            others: others,
          ),
        );

        // ExpansionTile(
        //   childrenPadding: const EdgeInsets.only(left: 15),
        //   initiallyExpanded: ,
        //   trailing: const SizedBox(),
        //   leading: const Icon(Icons.keyboard_arrow_down_rounded),
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
        //       const Expanded(
        //         child: Text(),
        //       ),
        //     ],
        //   ),
        //   children: const [],
        // );
      },
      itemCount: widget.parents.length,
    );
  }
}
