import 'dart:convert';

import 'package:tractian_challenge/data/dto/company_asset_dto.dart';

class AssetDto extends CompanyAssetDto {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? parentId;
  final String? sensorId;
  @override
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;
  @override
  final String type;
  AssetDto({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
    required this.type,
  }) : super(
            id: id,
            type: type,
            parentId: parentId,
            sensorType: sensorType,
            name: name);

  AssetDto copyWith({
    String? id,
    String? name,
    String? parentId,
    String? sensorId,
    String? sensorType,
    String? status,
    String? gatewayId,
    String? locationId,
    String? type,
  }) {
    return AssetDto(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      gatewayId: gatewayId ?? this.gatewayId,
      locationId: locationId ?? this.locationId,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
      'gatewayId': gatewayId,
      'locationId': locationId,
      'type': type,
    };
  }

  factory AssetDto.fromMap(Map<String, dynamic> map) {
    return AssetDto(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      sensorId: map['sensorId'] != null ? map['sensorId'] as String : null,
      sensorType:
          map['sensorType'] != null ? map['sensorType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      gatewayId: map['gatewayId'] != null ? map['gatewayId'] as String : null,
      locationId:
          map['locationId'] != null ? map['locationId'] as String : null,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetDto.fromJson(String source) =>
      AssetDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssetDto(id: $id, name: $name, parentId: $parentId, sensorId: $sensorId, sensorType: $sensorType, status: $status, gatewayId: $gatewayId, locationId: $locationId, type: $type)';
  }

  @override
  bool operator ==(covariant AssetDto other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.parentId == parentId &&
        other.sensorId == sensorId &&
        other.sensorType == sensorType &&
        other.status == status &&
        other.gatewayId == gatewayId &&
        other.locationId == locationId &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        parentId.hashCode ^
        sensorId.hashCode ^
        sensorType.hashCode ^
        status.hashCode ^
        gatewayId.hashCode ^
        locationId.hashCode ^
        type.hashCode;
  }
}
