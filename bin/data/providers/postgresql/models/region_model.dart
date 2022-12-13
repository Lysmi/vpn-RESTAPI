import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/region.dart';

@Model()
abstract class RegionModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get regionName;
}

Region regionToEntity(RegionModel model) => Region(
      id: model.id,
      regionName: model.regionName,
    );
