import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/region.dart';

@Model()
abstract class RegionModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get regionName;

  Region toEntity() => Region(
        id: id,
        regionName: regionName,
      );
}
