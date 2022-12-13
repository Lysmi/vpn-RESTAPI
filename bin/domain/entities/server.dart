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
    required this.countUsers,
    id,
    required this.ip,
    required this.serverName,
    required this.region,
  }) : id = id ?? Uuid().v4();

  Server copyWith({
    countUsers,
    id,
    ip,
    serverName,
    region,
  }) {
    return Server(
      countUsers: countUsers ?? this.countUsers,
      id: id ?? this.id,
      ip: ip ?? this.ip,
      serverName: serverName ?? this.serverName,
      region: region ?? this.region,
    );
  }
}
