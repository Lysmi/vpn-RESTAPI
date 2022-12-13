import 'package:stormberry/stormberry.dart';

import 'server_model.dart';

@Model()
abstract class RegionModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get regionName;
}
