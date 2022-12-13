import 'package:stormberry/stormberry.dart';

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
}
