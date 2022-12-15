// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:uuid/uuid.dart';

import 'region.dart';

@jsonSerializable
class Server {
  String id;
  String ip;
  String serverName;
  int countUsers;
  Region region;

  Server({
    id,
    required this.ip,
    required this.serverName,
    required this.countUsers,
    required this.region,
  }) : id = id ?? Uuid().v4();

  Server copyWith({
    String? id,
    String? ip,
    String? serverName,
    int? countUsers,
    Region? region,
  }) {
    return Server(
      id: id ?? this.id,
      ip: ip ?? this.ip,
      serverName: serverName ?? this.serverName,
      countUsers: countUsers ?? this.countUsers,
      region: region ?? this.region,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ip': ip,
      'serverName': serverName,
      'countUsers': countUsers,
      'region': region.toMap(),
    };
  }

  factory Server.fromMap(Map<String, dynamic> map) {
    return Server(
      id: map['id'] as String,
      ip: map['ip'] as String,
      serverName: map['serverName'] as String,
      countUsers: map['countUsers'] as int,
      region: Region.fromMap(map['region'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Server.fromJson(String source) =>
      Server.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Server(id: $id, ip: $ip, serverName: $serverName, countUsers: $countUsers, region: $region)';
  }

  @override
  bool operator ==(covariant Server other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.ip == ip &&
        other.serverName == serverName &&
        other.countUsers == countUsers &&
        other.region == region;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        ip.hashCode ^
        serverName.hashCode ^
        countUsers.hashCode ^
        region.hashCode;
  }
}
