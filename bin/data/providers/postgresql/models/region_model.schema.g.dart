// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';

import 'region_model.dart';

extension Repositories on Database {
  RegionModelRepository get regionModels => RegionModelRepository._(this);
}

final registry = ModelRegistry({});

abstract class RegionModelRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<RegionModelInsertRequest>,
        ModelRepositoryUpdate<RegionModelUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory RegionModelRepository._(Database db) = _RegionModelRepository;

  Future<RegionModel?> queryRegionModel(int id);
  Future<List<RegionModel>> queryRegionModels([QueryParams? params]);
}

class _RegionModelRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<RegionModelInsertRequest>,
        RepositoryUpdateMixin<RegionModelUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements RegionModelRepository {
  _RegionModelRepository(Database db) : super(db: db);

  @override
  Future<RegionModel?> queryRegionModel(int id) {
    return queryOne(id, RegionModelQueryable());
  }

  @override
  Future<List<RegionModel>> queryRegionModels([QueryParams? params]) {
    return queryMany(RegionModelQueryable(), params);
  }

  @override
  Future<List<int>> insert(Database db, List<RegionModelInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var rows =
        await db.query(requests.map((r) => "SELECT nextval('region_models_id_seq') as \"id\"").join('\nUNION ALL\n'));
    var autoIncrements = rows.map((r) => r.toColumnMap()).toList();

    await db.query(
      'INSERT INTO "region_models" ( "id", "region_name" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(autoIncrements[requests.indexOf(r)]['id'])}, ${registry.encode(r.regionName)} )').join(', ')}\n',
    );

    return autoIncrements.map<int>((m) => registry.decode(m['id'])).toList();
  }

  @override
  Future<void> update(Database db, List<RegionModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "region_models"\n'
      'SET "region_name" = COALESCE(UPDATED."region_name"::text, "region_models"."region_name")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.regionName)} )').join(', ')} )\n'
      'AS UPDATED("id", "region_name")\n'
      'WHERE "region_models"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<int> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "region_models"\n'
      'WHERE "region_models"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.regionName});
  String regionName;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  int id;
  String? regionName;
}

class RegionModelQueryable extends KeyedViewQueryable<RegionModel, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => registry.encode(key);

  @override
  String get tableName => 'region_models_view';

  @override
  String get tableAlias => 'region_models';

  @override
  RegionModel decode(TypedMap map) =>
      RegionModelView(id: map.get('id', registry.decode), regionName: map.get('region_name', registry.decode));
}

class RegionModelView implements RegionModel {
  RegionModelView({required this.id, required this.regionName});

  @override
  final int id;
  @override
  final String regionName;
}
