// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';
import 'package:uuid/uuid.dart';

import 'region_model.dart';

extension Repositories on Database {
  RegionModelRepository get regionModels => RegionModelRepository._(this);
}

final registry = ModelRegistry({});

abstract class RegionModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<RegionModelInsertRequest>,
        ModelRepositoryUpdate<RegionModelUpdateRequest>,
        ModelRepositoryDelete<Uuid> {
  factory RegionModelRepository._(Database db) = _RegionModelRepository;

  Future<RegionModel?> queryRegionModel(Uuid id);
  Future<List<RegionModel>> queryRegionModels([QueryParams? params]);
}

class _RegionModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<RegionModelInsertRequest>,
        RepositoryUpdateMixin<RegionModelUpdateRequest>,
        RepositoryDeleteMixin<Uuid>
    implements RegionModelRepository {
  _RegionModelRepository(Database db) : super(db: db);

  @override
  Future<RegionModel?> queryRegionModel(Uuid id) {
    return queryOne(id, RegionModelQueryable());
  }

  @override
  Future<List<RegionModel>> queryRegionModels([QueryParams? params]) {
    return queryMany(RegionModelQueryable(), params);
  }

  @override
  Future<void> insert(Database db, List<RegionModelInsertRequest> requests) async {
    if (requests.isEmpty) return;

    await db.query(
      'INSERT INTO "regions" ( "id", "region_name" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.regionName)} )').join(', ')}\n'
      'ON CONFLICT ( "id" ) DO UPDATE SET "region_name" = EXCLUDED."region_name"',
    );
  }

  @override
  Future<void> update(Database db, List<RegionModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "regions"\n'
      'SET "region_name" = COALESCE(UPDATED."region_name"::text, "regions"."region_name")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.regionName)} )').join(', ')} )\n'
      'AS UPDATED("id", "region_name")\n'
      'WHERE "regions"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<Uuid> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "regions"\n'
      'WHERE "regions"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.id, required this.regionName});
  Uuid id;
  String regionName;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  Uuid id;
  String? regionName;
}

class RegionModelQueryable extends KeyedViewQueryable<RegionModel, Uuid> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(Uuid key) => registry.encode(key);

  @override
  String get tableName => 'regions_view';

  @override
  String get tableAlias => 'regions';

  @override
  RegionModel decode(TypedMap map) =>
      RegionModelView(id: map.get('id', registry.decode), regionName: map.get('region_name', registry.decode));
}

class RegionModelView implements RegionModel {
  RegionModelView({required this.id, required this.regionName});

  @override
  final Uuid id;
  @override
  final String regionName;
}
