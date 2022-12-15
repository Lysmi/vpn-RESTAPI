// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

@jsonSerializable
class Region {
  String id;
  String regionName;

  Region({
    id,
    required this.regionName,
  }) : id = id ?? Uuid().v4();

  Region copyWidth({id, regionName}) {
    return Region(
      regionName: regionName,
      id: id,
    );
  }

  Region copyWith({
    String? id,
    String? regionName,
  }) {
    return Region(
      id: id ?? this.id,
      regionName: regionName ?? this.regionName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'regionName': regionName,
    };
  }

  factory Region.fromMap(Map<String, dynamic> map) {
    return Region(
      id: map['id'] as String,
      regionName: map['regionName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Region.fromJson(String source) =>
      Region.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Region(id: $id, regionName: $regionName)';

  @override
  bool operator ==(covariant Region other) {
    if (identical(this, other)) return true;

    return other.id == id && other.regionName == regionName;
  }

  @override
  int get hashCode => id.hashCode ^ regionName.hashCode;
}
