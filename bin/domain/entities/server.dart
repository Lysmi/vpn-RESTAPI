import 'region.dart';

class Server {
  int? id;
  String ip;
  String serverName;
  int countUsers;
  Region region;

  Server({
    required this.countUsers,
    this.id,
    required this.ip,
    required this.serverName,
    required this.region,
  });

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
