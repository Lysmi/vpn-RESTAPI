import 'package:stormberry/stormberry.dart';

import '../../../../domain/entities/region.dart';

@Model(tableName: 'regions')
abstract class RegionModel {
  @PrimaryKey()
  String get id;

  String get regionName;
}

extension ToEntity on RegionModel {
  Region toEntity() => Region(
        id: id,
        regionName: regionName,
      );
}
