import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/entities/server.dart';
import 'region_model.dart';

@Model(tableName: 'servers')
abstract class ServerModel {
  @PrimaryKey()
  Uuid get id;
  String get ip;
  String get serverName;
  int get countUsers;
  RegionModel get region;
}

extension ToEntity on ServerModel {
  Server toEntity() => Server(
        id: id,
        countUsers: countUsers,
        ip: ip,
        serverName: serverName,
        region: region.toEntity(),
      );
}
