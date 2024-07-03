import 'package:tractian_challenge/data/dto/asset_dto.dart';
import 'package:tractian_challenge/data/dto/location_dto.dart';

class CompanyAssetDto {
  final String id;
  final String? parentId;
  final String type;
  final String name;
  final String? sensorType;
  CompanyAssetDto(
      {this.parentId,
      required this.id,
      required this.type,
      required this.name,
      this.sensorType});

  static fromMap(Map<String, dynamic> map) {
    if (map["type"] == 'location') return LocationDto.fromMap(map);
    return AssetDto.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    try {
      return (this as LocationDto).toMap();
    } catch (e) {
      return (this as AssetDto).toMap();
    }
  }

  bool isLocation() => type == 'location';
  bool isAsset() => type == 'asset';
}
