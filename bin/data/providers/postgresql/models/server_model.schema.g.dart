// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';

import 'region_model.dart';
import 'server_model.dart';

extension Repositories on Database {
  ServerModelRepository get serverModels => ServerModelRepository._(this);
  RegionModelRepository get regionModels => RegionModelRepository._(this);
}

final registry = ModelRegistry({});

abstract class ServerModelRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<ServerModelInsertRequest>,
        ModelRepositoryUpdate<ServerModelUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory ServerModelRepository._(Database db) = _ServerModelRepository;

  Future<ServerModel?> queryServerModel(int id);
  Future<List<ServerModel>> queryServerModels([QueryParams? params]);
}

class _ServerModelRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<ServerModelInsertRequest>,
        RepositoryUpdateMixin<ServerModelUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements ServerModelRepository {
  _ServerModelRepository(Database db) : super(db: db);

  @override
  Future<ServerModel?> queryServerModel(int id) {
    return queryOne(id, ServerModelQueryable());
  }

  @override
  Future<List<ServerModel>> queryServerModels([QueryParams? params]) {
    return queryMany(ServerModelQueryable(), params);
  }

  @override
  Future<List<int>> insert(Database db, List<ServerModelInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var rows =
        await db.query(requests.map((r) => "SELECT nextval('server_models_id_seq') as \"id\"").join('\nUNION ALL\n'));
    var autoIncrements = rows.map((r) => r.toColumnMap()).toList();

    await db.query(
      'INSERT INTO "server_models" ( "id", "ip", "server_name", "count_users", "region_id" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(autoIncrements[requests.indexOf(r)]['id'])}, ${registry.encode(r.ip)}, ${registry.encode(r.serverName)}, ${registry.encode(r.countUsers)}, ${registry.encode(r.regionId)} )').join(', ')}\n',
    );

    return autoIncrements.map<int>((m) => registry.decode(m['id'])).toList();
  }

  @override
  Future<void> update(Database db, List<ServerModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "server_models"\n'
      'SET "ip" = COALESCE(UPDATED."ip"::text, "server_models"."ip"), "server_name" = COALESCE(UPDATED."server_name"::text, "server_models"."server_name"), "count_users" = COALESCE(UPDATED."count_users"::int8, "server_models"."count_users"), "region_id" = COALESCE(UPDATED."region_id"::int8, "server_models"."region_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.ip)}, ${registry.encode(r.serverName)}, ${registry.encode(r.countUsers)}, ${registry.encode(r.regionId)} )').join(', ')} )\n'
      'AS UPDATED("id", "ip", "server_name", "count_users", "region_id")\n'
      'WHERE "server_models"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<int> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "server_models"\n'
      'WHERE "server_models"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

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

class ServerModelInsertRequest {
  ServerModelInsertRequest(
      {required this.ip, required this.serverName, required this.countUsers, required this.regionId});
  String ip;
  String serverName;
  int countUsers;
  int regionId;
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.regionName});
  String regionName;
}

class ServerModelUpdateRequest {
  ServerModelUpdateRequest({required this.id, this.ip, this.serverName, this.countUsers, this.regionId});
  int id;
  String? ip;
  String? serverName;
  int? countUsers;
  int? regionId;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  int id;
  String? regionName;
}

class ServerModelQueryable extends KeyedViewQueryable<ServerModel, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => registry.encode(key);

  @override
  String get tableName => 'server_models_view';

  @override
  String get tableAlias => 'server_models';

  @override
  ServerModel decode(TypedMap map) => ServerModelView(
      id: map.get('id', registry.decode),
      ip: map.get('ip', registry.decode),
      serverName: map.get('server_name', registry.decode),
      countUsers: map.get('count_users', registry.decode),
      region: map.get('region', RegionModelQueryable().decoder));
}

class ServerModelView implements ServerModel {
  ServerModelView(
      {required this.id, required this.ip, required this.serverName, required this.countUsers, required this.region});

  @override
  final int id;
  @override
  final String ip;
  @override
  final String serverName;
  @override
  final int countUsers;
  @override
  final RegionModel region;
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
