import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/server.dart';
import 'region_model.dart';

@Model()
abstract class ServerModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get ip;
  String get serverName;
  int get countUsers;
  RegionModel get region;

  Server toEntity() => Server(
        id: id,
        countUsers: countUsers,
        ip: ip,
        serverName: serverName,
        region: region.toEntity(),
      );
}
