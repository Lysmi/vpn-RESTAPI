import '../entities/region.dart';
import '../entities/server.dart';

abstract class IRegionsRepository {
  Future<List<Region>> getAllRegions();
  Future<Region?> getRegionById(String id);
  void addRegion(Region region);
}
