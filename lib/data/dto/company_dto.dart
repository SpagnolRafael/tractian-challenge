import 'dart:convert';

class CompanyDto {
  final String id;
  final String name;
  CompanyDto({
    required this.id,
    required this.name,
  });

  CompanyDto copyWith({
    String? id,
    String? name,
  }) {
    return CompanyDto(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory CompanyDto.fromMap(Map<String, dynamic> map) {
    return CompanyDto(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyDto.fromJson(String source) =>
      CompanyDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CompanyDto(id: $id, name: $name)';

  @override
  bool operator ==(covariant CompanyDto other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
