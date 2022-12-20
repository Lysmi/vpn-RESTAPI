// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';
import 'package:uuid/uuid.dart';

import 'region_model.dart';
import 'sertificate_model.dart';
import 'server_model.dart';
import 'user_model.dart';

extension Repositories on Database {
  SertificateModelRepository get sertificateModels => SertificateModelRepository._(this);
  ServerModelRepository get serverModels => ServerModelRepository._(this);
  UserModelRepository get userModels => UserModelRepository._(this);
  RegionModelRepository get regionModels => RegionModelRepository._(this);
}

final registry = ModelRegistry({});

abstract class SertificateModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<SertificateModelInsertRequest>,
        ModelRepositoryUpdate<SertificateModelUpdateRequest>,
        ModelRepositoryDelete<Uuid> {
  factory SertificateModelRepository._(Database db) = _SertificateModelRepository;

  Future<SertificateModel?> querySertificateModel(Uuid id);
  Future<List<SertificateModel>> querySertificateModels([QueryParams? params]);
}

class _SertificateModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<SertificateModelInsertRequest>,
        RepositoryUpdateMixin<SertificateModelUpdateRequest>,
        RepositoryDeleteMixin<Uuid>
    implements SertificateModelRepository {
  _SertificateModelRepository(Database db) : super(db: db);

  @override
  Future<SertificateModel?> querySertificateModel(Uuid id) {
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
      'INSERT INTO "sertificates" ( "id", "private_key", "public_key", "server_id", "date_create", "user_id" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.privateKey)}, ${registry.encode(r.publicKey)}, ${registry.encode(r.serverId)}, ${registry.encode(r.dateCreate)}, ${registry.encode(r.userId)} )').join(', ')}\n'
      'ON CONFLICT ( "id" ) DO UPDATE SET "private_key" = EXCLUDED."private_key", "public_key" = EXCLUDED."public_key", "server_id" = EXCLUDED."server_id", "date_create" = EXCLUDED."date_create", "user_id" = EXCLUDED."user_id"',
    );
  }

  @override
  Future<void> update(Database db, List<SertificateModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "sertificates"\n'
      'SET "private_key" = COALESCE(UPDATED."private_key"::text, "sertificates"."private_key"), "public_key" = COALESCE(UPDATED."public_key"::text, "sertificates"."public_key"), "server_id" = COALESCE(UPDATED."server_id"::jsonb, "sertificates"."server_id"), "date_create" = COALESCE(UPDATED."date_create"::timestamp, "sertificates"."date_create"), "user_id" = COALESCE(UPDATED."user_id"::jsonb, "sertificates"."user_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.privateKey)}, ${registry.encode(r.publicKey)}, ${registry.encode(r.serverId)}, ${registry.encode(r.dateCreate)}, ${registry.encode(r.userId)} )').join(', ')} )\n'
      'AS UPDATED("id", "private_key", "public_key", "server_id", "date_create", "user_id")\n'
      'WHERE "sertificates"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<Uuid> keys) async {
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

abstract class UserModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserModelInsertRequest>,
        ModelRepositoryUpdate<UserModelUpdateRequest>,
        ModelRepositoryDelete<Uuid> {
  factory UserModelRepository._(Database db) = _UserModelRepository;

  Future<UserModel?> queryUserModel(Uuid id);
  Future<List<UserModel>> queryUserModels([QueryParams? params]);
}

class _UserModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserModelInsertRequest>,
        RepositoryUpdateMixin<UserModelUpdateRequest>,
        RepositoryDeleteMixin<Uuid>
    implements UserModelRepository {
  _UserModelRepository(Database db) : super(db: db);

  @override
  Future<UserModel?> queryUserModel(Uuid id) {
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
      'INSERT INTO "users" ( "current_certificate_id", "id", "telegram_id", "username", "balance", "free_period_used" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.currentCertificateId)}, ${registry.encode(r.id)}, ${registry.encode(r.telegramId)}, ${registry.encode(r.username)}, ${registry.encode(r.balance)}, ${registry.encode(r.freePeriodUsed)} )').join(', ')}\n'
      'ON CONFLICT ( "id" ) DO UPDATE SET "current_certificate_id" = EXCLUDED."current_certificate_id", "telegram_id" = EXCLUDED."telegram_id", "username" = EXCLUDED."username", "balance" = EXCLUDED."balance", "free_period_used" = EXCLUDED."free_period_used"',
    );
  }

  @override
  Future<void> update(Database db, List<UserModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "users"\n'
      'SET "current_certificate_id" = COALESCE(UPDATED."current_certificate_id"::jsonb, "users"."current_certificate_id"), "telegram_id" = COALESCE(UPDATED."telegram_id"::text, "users"."telegram_id"), "username" = COALESCE(UPDATED."username"::text, "users"."username"), "balance" = COALESCE(UPDATED."balance"::int8, "users"."balance"), "free_period_used" = COALESCE(UPDATED."free_period_used"::bool, "users"."free_period_used")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.currentCertificateId)}, ${registry.encode(r.id)}, ${registry.encode(r.telegramId)}, ${registry.encode(r.username)}, ${registry.encode(r.balance)}, ${registry.encode(r.freePeriodUsed)} )').join(', ')} )\n'
      'AS UPDATED("current_certificate_id", "id", "telegram_id", "username", "balance", "free_period_used")\n'
      'WHERE "users"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<Uuid> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "users"\n'
      'WHERE "users"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
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

class SertificateModelInsertRequest {
  SertificateModelInsertRequest(
      {required this.id,
      required this.privateKey,
      required this.publicKey,
      required this.serverId,
      required this.dateCreate,
      required this.userId});
  Uuid id;
  String privateKey;
  String publicKey;
  Uuid serverId;
  DateTime dateCreate;
  Uuid userId;
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

class UserModelInsertRequest {
  UserModelInsertRequest(
      {this.currentCertificateId,
      required this.id,
      required this.telegramId,
      this.username,
      required this.balance,
      required this.freePeriodUsed});
  Uuid? currentCertificateId;
  Uuid id;
  String telegramId;
  String? username;
  int balance;
  bool freePeriodUsed;
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.id, required this.regionName});
  Uuid id;
  String regionName;
}

class SertificateModelUpdateRequest {
  SertificateModelUpdateRequest(
      {required this.id, this.privateKey, this.publicKey, this.serverId, this.dateCreate, this.userId});
  Uuid id;
  String? privateKey;
  String? publicKey;
  Uuid? serverId;
  DateTime? dateCreate;
  Uuid? userId;
}

class ServerModelUpdateRequest {
  ServerModelUpdateRequest({required this.id, this.ip, this.serverName, this.countUsers, this.regionId});
  Uuid id;
  String? ip;
  String? serverName;
  int? countUsers;
  Uuid? regionId;
}

class UserModelUpdateRequest {
  UserModelUpdateRequest(
      {this.currentCertificateId, required this.id, this.telegramId, this.username, this.balance, this.freePeriodUsed});
  Uuid? currentCertificateId;
  Uuid id;
  String? telegramId;
  String? username;
  int? balance;
  bool? freePeriodUsed;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  Uuid id;
  String? regionName;
}

class SertificateModelQueryable extends KeyedViewQueryable<SertificateModel, Uuid> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(Uuid key) => registry.encode(key);

  @override
  String get tableName => 'sertificates_view';

  @override
  String get tableAlias => 'sertificates';

  @override
  SertificateModel decode(TypedMap map) => SertificateModelView(
      id: map.get('id', registry.decode),
      privateKey: map.get('private_key', registry.decode),
      publicKey: map.get('public_key', registry.decode),
      server: map.get('server', ServerModelQueryable().decoder),
      dateCreate: map.get('date_create', registry.decode),
      user: map.get('user', UserModelQueryable().decoder));
}

class SertificateModelView implements SertificateModel {
  SertificateModelView(
      {required this.id,
      required this.privateKey,
      required this.publicKey,
      required this.server,
      required this.dateCreate,
      required this.user});

  @override
  final Uuid id;
  @override
  final String privateKey;
  @override
  final String publicKey;
  @override
  final ServerModel server;
  @override
  final DateTime dateCreate;
  @override
  final UserModel user;
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

class UserModelQueryable extends KeyedViewQueryable<UserModel, Uuid> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(Uuid key) => registry.encode(key);

  @override
  String get tableName => 'users_view';

  @override
  String get tableAlias => 'users';

  @override
  UserModel decode(TypedMap map) => UserModelView(
      currentCertificate: map.getOpt('currentCertificate', SertificateModelQueryable().decoder),
      id: map.get('id', registry.decode),
      telegramId: map.get('telegram_id', registry.decode),
      username: map.getOpt('username', registry.decode),
      balance: map.get('balance', registry.decode),
      freePeriodUsed: map.get('free_period_used', registry.decode));
}

class UserModelView implements UserModel {
  UserModelView(
      {this.currentCertificate,
      required this.id,
      required this.telegramId,
      this.username,
      required this.balance,
      required this.freePeriodUsed});

  @override
  final SertificateModel? currentCertificate;
  @override
  final Uuid id;
  @override
  final String telegramId;
  @override
  final String? username;
  @override
  final int balance;
  @override
  final bool freePeriodUsed;
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
