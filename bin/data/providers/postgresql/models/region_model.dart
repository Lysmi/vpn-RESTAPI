import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/region.dart';

@Model(tableName: 'regions')
abstract class RegionModel {
  @PrimaryKey()
  String get id;

  String get regionName;
}

Region regionToEntity(RegionModel model) => Region(
      id: model.id,
      regionName: model.regionName,
    );
