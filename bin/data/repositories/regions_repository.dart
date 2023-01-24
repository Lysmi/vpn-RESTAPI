import 'package:get_it/get_it.dart';

import '../../domain/entities/region.dart';
import '../../domain/repositories/regions_repository_interface.dart';
import '../providers/data_provider.dart';

class RegionsRepository implements IRegionsRepository {
  final DataProvider _dataProvider = GetIt.I<DataProvider>();

  @override
  void addRegion(Region region) {
    _dataProvider.addRegion(region);
  }

  @override
  Future<List<Region>> getAllRegions() {
    return _dataProvider.getAllRegions();
  }

  @override
  Future<Region?> getRegionById(String id) {
    return _dataProvider.getRegionById(id);
  }
}
