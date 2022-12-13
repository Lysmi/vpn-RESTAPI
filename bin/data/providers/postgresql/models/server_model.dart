import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/server.dart';
import 'region_model.dart';

@Model(tableName: 'servers')
abstract class ServerModel {
  @PrimaryKey()
  String get id;

  String get ip;
  String get serverName;
  int get countUsers;
  RegionModel get region;
}

Server serverToEntity(ServerModel model) => Server(
      id: model.id,
      countUsers: model.countUsers,
      ip: model.ip,
      serverName: model.serverName,
      region: regionToEntity(model.region),
    );
