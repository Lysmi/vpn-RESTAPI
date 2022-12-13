import 'package:stormberry/stormberry.dart';

@Model()
abstract class RegionModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get regionName;
}
