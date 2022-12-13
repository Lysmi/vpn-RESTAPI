// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';

import 'region_model.dart';
import 'sertificate_model.dart';
import 'server_model.dart';
import 'user_model.dart';

extension Repositories on Database {
  UserModelRepository get userModels => UserModelRepository._(this);
  SertificateModelRepository get sertificateModels => SertificateModelRepository._(this);
  ServerModelRepository get serverModels => ServerModelRepository._(this);
  RegionModelRepository get regionModels => RegionModelRepository._(this);
}

final registry = ModelRegistry({});

abstract class UserModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserModelInsertRequest>,
        ModelRepositoryUpdate<UserModelUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory UserModelRepository._(Database db) = _UserModelRepository;

  Future<UserModel?> queryUserModel(String id);
  Future<List<UserModel>> queryUserModels([QueryParams? params]);
}

class _UserModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserModelInsertRequest>,
        RepositoryUpdateMixin<UserModelUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements UserModelRepository {
  _UserModelRepository(Database db) : super(db: db);

  @override
  Future<UserModel?> queryUserModel(String id) {
    return queryOne(id, UserModelQueryable());
  }

  @override
  Future<List<UserModel>> queryUserModels([QueryParams? params]) {
    return queryMany(UserModelQueryable(), params);
  }

  @override
  Future<void> insert(Database db, List<UserModelInsertRequest> requests) async {
    if (requests.isEmpty) return;

    await db.query(
      'INSERT INTO "users" ( "id", "telegram_id", "username", "balance", "free_period_used", "current_certificate_id" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.telegramId)}, ${registry.encode(r.username)}, ${registry.encode(r.balance)}, ${registry.encode(r.freePeriodUsed)}, ${registry.encode(r.currentCertificateId)} )').join(', ')}\n'
      'ON CONFLICT ( "id" ) DO UPDATE SET "telegram_id" = EXCLUDED."telegram_id", "username" = EXCLUDED."username", "balance" = EXCLUDED."balance", "free_period_used" = EXCLUDED."free_period_used", "current_certificate_id" = EXCLUDED."current_certificate_id"',
    );
  }

  @override
  Future<void> update(Database db, List<UserModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "users"\n'
      'SET "telegram_id" = COALESCE(UPDATED."telegram_id"::text, "users"."telegram_id"), "username" = COALESCE(UPDATED."username"::text, "users"."username"), "balance" = COALESCE(UPDATED."balance"::int8, "users"."balance"), "free_period_used" = COALESCE(UPDATED."free_period_used"::bool, "users"."free_period_used"), "current_certificate_id" = COALESCE(UPDATED."current_certificate_id"::text, "users"."current_certificate_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.telegramId)}, ${registry.encode(r.username)}, ${registry.encode(r.balance)}, ${registry.encode(r.freePeriodUsed)}, ${registry.encode(r.currentCertificateId)} )').join(', ')} )\n'
      'AS UPDATED("id", "telegram_id", "username", "balance", "free_period_used", "current_certificate_id")\n'
      'WHERE "users"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<String> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "users"\n'
      'WHERE "users"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

abstract class SertificateModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<SertificateModelInsertRequest>,
        ModelRepositoryUpdate<SertificateModelUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory SertificateModelRepository._(Database db) = _SertificateModelRepository;

  Future<SertificateModel?> querySertificateModel(String id);
  Future<List<SertificateModel>> querySertificateModels([QueryParams? params]);
}

class _SertificateModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<SertificateModelInsertRequest>,
        RepositoryUpdateMixin<SertificateModelUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements SertificateModelRepository {
  _SertificateModelRepository(Database db) : super(db: db);

  @override
  Future<SertificateModel?> querySertificateModel(String id) {
    return queryOne(id, SertificateModelQueryable());
  }

  @override
  Future<List<SertificateModel>> querySertificateModels([QueryParams? params]) {
    return queryMany(SertificateModelQueryable(), params);
  }

  @override
  Future<void> insert(Database db, List<SertificateModelInsertRequest> requests) async {
    if (requests.isEmpty) return;

    await db.query(
      'INSERT INTO "sertificates" ( "user_id", "id", "private_key", "public_key", "server_id", "date_create" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.userId)}, ${registry.encode(r.id)}, ${registry.encode(r.privateKey)}, ${registry.encode(r.publicKey)}, ${registry.encode(r.serverId)}, ${registry.encode(r.dateCreate)} )').join(', ')}\n'
      'ON CONFLICT ( "id" ) DO UPDATE SET "user_id" = EXCLUDED."user_id", "private_key" = EXCLUDED."private_key", "public_key" = EXCLUDED."public_key", "server_id" = EXCLUDED."server_id", "date_create" = EXCLUDED."date_create"',
    );
  }

  @override
  Future<void> update(Database db, List<SertificateModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "sertificates"\n'
      'SET "user_id" = COALESCE(UPDATED."user_id"::text, "sertificates"."user_id"), "private_key" = COALESCE(UPDATED."private_key"::text, "sertificates"."private_key"), "public_key" = COALESCE(UPDATED."public_key"::text, "sertificates"."public_key"), "server_id" = COALESCE(UPDATED."server_id"::text, "sertificates"."server_id"), "date_create" = COALESCE(UPDATED."date_create"::timestamp, "sertificates"."date_create")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.userId)}, ${registry.encode(r.id)}, ${registry.encode(r.privateKey)}, ${registry.encode(r.publicKey)}, ${registry.encode(r.serverId)}, ${registry.encode(r.dateCreate)} )').join(', ')} )\n'
      'AS UPDATED("user_id", "id", "private_key", "public_key", "server_id", "date_create")\n'
      'WHERE "sertificates"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<String> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "sertificates"\n'
      'WHERE "sertificates"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

abstract class ServerModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<ServerModelInsertRequest>,
        ModelRepositoryUpdate<ServerModelUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory ServerModelRepository._(Database db) = _ServerModelRepository;

  Future<ServerModel?> queryServerModel(String id);
  Future<List<ServerModel>> queryServerModels([QueryParams? params]);
}

class _ServerModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<ServerModelInsertRequest>,
        RepositoryUpdateMixin<ServerModelUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements ServerModelRepository {
  _ServerModelRepository(Database db) : super(db: db);

  @override
  Future<ServerModel?> queryServerModel(String id) {
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
      'SET "ip" = COALESCE(UPDATED."ip"::text, "servers"."ip"), "server_name" = COALESCE(UPDATED."server_name"::text, "servers"."server_name"), "count_users" = COALESCE(UPDATED."count_users"::int8, "servers"."count_users"), "region_id" = COALESCE(UPDATED."region_id"::text, "servers"."region_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.ip)}, ${registry.encode(r.serverName)}, ${registry.encode(r.countUsers)}, ${registry.encode(r.regionId)} )').join(', ')} )\n'
      'AS UPDATED("id", "ip", "server_name", "count_users", "region_id")\n'
      'WHERE "servers"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<String> keys) async {
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
        ModelRepositoryDelete<String> {
  factory RegionModelRepository._(Database db) = _RegionModelRepository;

  Future<RegionModel?> queryRegionModel(String id);
  Future<List<RegionModel>> queryRegionModels([QueryParams? params]);
}

class _RegionModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<RegionModelInsertRequest>,
        RepositoryUpdateMixin<RegionModelUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements RegionModelRepository {
  _RegionModelRepository(Database db) : super(db: db);

  @override
  Future<RegionModel?> queryRegionModel(String id) {
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
  Future<void> delete(Database db, List<String> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "regions"\n'
      'WHERE "regions"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

class UserModelInsertRequest {
  UserModelInsertRequest(
      {required this.id,
      required this.telegramId,
      this.username,
      required this.balance,
      required this.freePeriodUsed,
      this.currentCertificateId});
  String id;
  String telegramId;
  String? username;
  int balance;
  bool freePeriodUsed;
  String? currentCertificateId;
}

class SertificateModelInsertRequest {
  SertificateModelInsertRequest(
      {required this.userId,
      required this.id,
      required this.privateKey,
      required this.publicKey,
      required this.serverId,
      required this.dateCreate});
  String userId;
  String id;
  String privateKey;
  String publicKey;
  String serverId;
  DateTime dateCreate;
}

class ServerModelInsertRequest {
  ServerModelInsertRequest(
      {required this.id, required this.ip, required this.serverName, required this.countUsers, required this.regionId});
  String id;
  String ip;
  String serverName;
  int countUsers;
  String regionId;
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.id, required this.regionName});
  String id;
  String regionName;
}

class UserModelUpdateRequest {
  UserModelUpdateRequest(
      {required this.id, this.telegramId, this.username, this.balance, this.freePeriodUsed, this.currentCertificateId});
  String id;
  String? telegramId;
  String? username;
  int? balance;
  bool? freePeriodUsed;
  String? currentCertificateId;
}

class SertificateModelUpdateRequest {
  SertificateModelUpdateRequest(
      {this.userId, required this.id, this.privateKey, this.publicKey, this.serverId, this.dateCreate});
  String? userId;
  String id;
  String? privateKey;
  String? publicKey;
  String? serverId;
  DateTime? dateCreate;
}

class ServerModelUpdateRequest {
  ServerModelUpdateRequest({required this.id, this.ip, this.serverName, this.countUsers, this.regionId});
  String id;
  String? ip;
  String? serverName;
  int? countUsers;
  String? regionId;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  String id;
  String? regionName;
}

class UserModelQueryable extends KeyedViewQueryable<UserModel, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => registry.encode(key);

  @override
  String get tableName => 'users_view';

  @override
  String get tableAlias => 'users';

  @override
  UserModel decode(TypedMap map) => UserModelView(
      id: map.get('id', registry.decode),
      telegramId: map.get('telegram_id', registry.decode),
      username: map.getOpt('username', registry.decode),
      balance: map.get('balance', registry.decode),
      freePeriodUsed: map.get('free_period_used', registry.decode),
      currentCertificate: map.getOpt('currentCertificate', SertificateModelQueryable().decoder));
}

class UserModelView implements UserModel {
  UserModelView(
      {required this.id,
      required this.telegramId,
      this.username,
      required this.balance,
      required this.freePeriodUsed,
      this.currentCertificate});

  @override
  final String id;
  @override
  final String telegramId;
  @override
  final String? username;
  @override
  final int balance;
  @override
  final bool freePeriodUsed;
  @override
  final SertificateModel? currentCertificate;
}

class SertificateModelQueryable extends KeyedViewQueryable<SertificateModel, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => registry.encode(key);

  @override
  String get tableName => 'sertificates_view';

  @override
  String get tableAlias => 'sertificates';

  @override
  SertificateModel decode(TypedMap map) => SertificateModelView(
      user: map.get('user', UserModelQueryable().decoder),
      id: map.get('id', registry.decode),
      privateKey: map.get('private_key', registry.decode),
      publicKey: map.get('public_key', registry.decode),
      server: map.get('server', ServerModelQueryable().decoder),
      dateCreate: map.get('date_create', registry.decode));
}

class SertificateModelView implements SertificateModel {
  SertificateModelView(
      {required this.user,
      required this.id,
      required this.privateKey,
      required this.publicKey,
      required this.server,
      required this.dateCreate});

  @override
  final UserModel user;
  @override
  final String id;
  @override
  final String privateKey;
  @override
  final String publicKey;
  @override
  final ServerModel server;
  @override
  final DateTime dateCreate;
}

class ServerModelQueryable extends KeyedViewQueryable<ServerModel, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => registry.encode(key);

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
  final String id;
  @override
  final String ip;
  @override
  final String serverName;
  @override
  final int countUsers;
  @override
  final RegionModel region;
}

class RegionModelQueryable extends KeyedViewQueryable<RegionModel, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => registry.encode(key);

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
  final String id;
  @override
  final String regionName;
}
