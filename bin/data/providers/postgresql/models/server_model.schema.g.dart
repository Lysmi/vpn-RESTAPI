// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';
import 'package:uuid/uuid.dart';

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
        ModelRepositoryInsert<ServerModelInsertRequest>,
        ModelRepositoryUpdate<ServerModelUpdateRequest>,
        ModelRepositoryDelete<Uuid> {
  factory ServerModelRepository._(Database db) = _ServerModelRepository;

  Future<ServerModel?> queryServerModel(Uuid id);
  Future<List<ServerModel>> queryServerModels([QueryParams? params]);
}

class _ServerModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<ServerModelInsertRequest>,
        RepositoryUpdateMixin<ServerModelUpdateRequest>,
        RepositoryDeleteMixin<Uuid>
    implements ServerModelRepository {
  _ServerModelRepository(Database db) : super(db: db);

  @override
  Future<ServerModel?> queryServerModel(Uuid id) {
    return queryOne(id, ServerModelQueryable());
  }

  @override
  Future<List<ServerModel>> queryServerModels([QueryParams? params]) {
    return queryMany(ServerModelQueryable(), params);
  }

  @override
  Future<void> insert(Database db, List<ServerModelInsertRequest> requests) async {
    if (requests.isEmpty) return;

    await db.query(
      'INSERT INTO "servers" ( "id", "ip", "server_name", "count_users", "region_id" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.ip)}, ${registry.encode(r.serverName)}, ${registry.encode(r.countUsers)}, ${registry.encode(r.regionId)} )').join(', ')}\n'
      'ON CONFLICT ( "id" ) DO UPDATE SET "ip" = EXCLUDED."ip", "server_name" = EXCLUDED."server_name", "count_users" = EXCLUDED."count_users", "region_id" = EXCLUDED."region_id"',
    );
  }

  @override
  Future<void> update(Database db, List<ServerModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "servers"\n'
      'SET "ip" = COALESCE(UPDATED."ip"::text, "servers"."ip"), "server_name" = COALESCE(UPDATED."server_name"::text, "servers"."server_name"), "count_users" = COALESCE(UPDATED."count_users"::int8, "servers"."count_users"), "region_id" = COALESCE(UPDATED."region_id"::jsonb, "servers"."region_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.ip)}, ${registry.encode(r.serverName)}, ${registry.encode(r.countUsers)}, ${registry.encode(r.regionId)} )').join(', ')} )\n'
      'AS UPDATED("id", "ip", "server_name", "count_users", "region_id")\n'
      'WHERE "servers"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<Uuid> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "servers"\n'
      'WHERE "servers"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

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

class ServerModelInsertRequest {
  ServerModelInsertRequest(
      {required this.id, required this.ip, required this.serverName, required this.countUsers, required this.regionId});
  Uuid id;
  String ip;
  String serverName;
  int countUsers;
  Uuid regionId;
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.id, required this.regionName});
  Uuid id;
  String regionName;
}

class ServerModelUpdateRequest {
  ServerModelUpdateRequest({required this.id, this.ip, this.serverName, this.countUsers, this.regionId});
  Uuid id;
  String? ip;
  String? serverName;
  int? countUsers;
  Uuid? regionId;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  Uuid id;
  String? regionName;
}

class ServerModelQueryable extends KeyedViewQueryable<ServerModel, Uuid> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(Uuid key) => registry.encode(key);

  @override
  String get tableName => 'servers_view';

  @override
  String get tableAlias => 'servers';

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
  final Uuid id;
  @override
  final String ip;
  @override
  final String serverName;
  @override
  final int countUsers;
  @override
  final RegionModel region;
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
