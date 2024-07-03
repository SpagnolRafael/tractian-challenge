import 'dart:convert';

import 'package:tractian_challenge/data/dto/company_asset_dto.dart';

class LocationDto extends CompanyAssetDto {
  @override
  final String id;
  @override
  final String name;
  @override
  final String? parentId;
  @override
  final String type;
  LocationDto({
    required this.id,
    required this.name,
    this.parentId,
    required this.type,
  }) : super(id: id, type: type, parentId: parentId, name: name);

  LocationDto copyWith({
    String? id,
    String? name,
    String? parentId,
    String? type,
  }) {
    return LocationDto(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
      'type': type,
    };
  }

  factory LocationDto.fromMap(Map<String, dynamic> map) {
    return LocationDto(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationDto.fromJson(String source) =>
      LocationDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationDto(id: $id, name: $name, parentId: $parentId, type: $type)';
  }

  @override
  bool operator ==(covariant LocationDto other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        other.id == id &&
        other.name == name &&
        other.parentId == parentId &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ parentId.hashCode ^ type.hashCode;
  }
}
