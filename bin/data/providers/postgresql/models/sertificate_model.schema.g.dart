// ignore_for_file: prefer_relative_imports
import 'package:stormberry/internals.dart';

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
        KeyedModelRepositoryInsert<SertificateModelInsertRequest>,
        ModelRepositoryUpdate<SertificateModelUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory SertificateModelRepository._(Database db) = _SertificateModelRepository;

  Future<SertificateModel?> querySertificateModel(int id);
  Future<List<SertificateModel>> querySertificateModels([QueryParams? params]);
}

class _SertificateModelRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<SertificateModelInsertRequest>,
        RepositoryUpdateMixin<SertificateModelUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements SertificateModelRepository {
  _SertificateModelRepository(Database db) : super(db: db);

  @override
  Future<SertificateModel?> querySertificateModel(int id) {
    return queryOne(id, SertificateModelQueryable());
  }

  @override
  Future<List<SertificateModel>> querySertificateModels([QueryParams? params]) {
    return queryMany(SertificateModelQueryable(), params);
  }

  @override
  Future<List<int>> insert(Database db, List<SertificateModelInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var rows = await db
        .query(requests.map((r) => "SELECT nextval('sertificate_models_id_seq') as \"id\"").join('\nUNION ALL\n'));
    var autoIncrements = rows.map((r) => r.toColumnMap()).toList();

    await db.query(
      'INSERT INTO "sertificate_models" ( "id", "private_key", "public_key", "server_id", "date_create", "user_id" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(autoIncrements[requests.indexOf(r)]['id'])}, ${registry.encode(r.privateKey)}, ${registry.encode(r.publicKey)}, ${registry.encode(r.serverId)}, ${registry.encode(r.dateCreate)}, ${registry.encode(r.userId)} )').join(', ')}\n',
    );

    return autoIncrements.map<int>((m) => registry.decode(m['id'])).toList();
  }

  @override
  Future<void> update(Database db, List<SertificateModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "sertificate_models"\n'
      'SET "private_key" = COALESCE(UPDATED."private_key"::text, "sertificate_models"."private_key"), "public_key" = COALESCE(UPDATED."public_key"::text, "sertificate_models"."public_key"), "server_id" = COALESCE(UPDATED."server_id"::int8, "sertificate_models"."server_id"), "date_create" = COALESCE(UPDATED."date_create"::timestamp, "sertificate_models"."date_create"), "user_id" = COALESCE(UPDATED."user_id"::int8, "sertificate_models"."user_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.id)}, ${registry.encode(r.privateKey)}, ${registry.encode(r.publicKey)}, ${registry.encode(r.serverId)}, ${registry.encode(r.dateCreate)}, ${registry.encode(r.userId)} )').join(', ')} )\n'
      'AS UPDATED("id", "private_key", "public_key", "server_id", "date_create", "user_id")\n'
      'WHERE "sertificate_models"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<int> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "sertificate_models"\n'
      'WHERE "sertificate_models"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
    );
  }
}

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

abstract class UserModelRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UserModelInsertRequest>,
        ModelRepositoryUpdate<UserModelUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UserModelRepository._(Database db) = _UserModelRepository;

  Future<UserModel?> queryUserModel(int id);
  Future<List<UserModel>> queryUserModels([QueryParams? params]);
}

class _UserModelRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UserModelInsertRequest>,
        RepositoryUpdateMixin<UserModelUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UserModelRepository {
  _UserModelRepository(Database db) : super(db: db);

  @override
  Future<UserModel?> queryUserModel(int id) {
    return queryOne(id, UserModelQueryable());
  }

  @override
  Future<List<UserModel>> queryUserModels([QueryParams? params]) {
    return queryMany(UserModelQueryable(), params);
  }

  @override
  Future<List<int>> insert(Database db, List<UserModelInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var rows =
        await db.query(requests.map((r) => "SELECT nextval('user_models_id_seq') as \"id\"").join('\nUNION ALL\n'));
    var autoIncrements = rows.map((r) => r.toColumnMap()).toList();

    await db.query(
      'INSERT INTO "user_models" ( "current_certificate_id", "id", "telegram_id", "username", "first_name", "last_name", "balance", "free_period_used" )\n'
      'VALUES ${requests.map((r) => '( ${registry.encode(r.currentCertificateId)}, ${registry.encode(autoIncrements[requests.indexOf(r)]['id'])}, ${registry.encode(r.telegramId)}, ${registry.encode(r.username)}, ${registry.encode(r.firstName)}, ${registry.encode(r.lastName)}, ${registry.encode(r.balance)}, ${registry.encode(r.freePeriodUsed)} )').join(', ')}\n',
    );

    return autoIncrements.map<int>((m) => registry.decode(m['id'])).toList();
  }

  @override
  Future<void> update(Database db, List<UserModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    await db.query(
      'UPDATE "user_models"\n'
      'SET "current_certificate_id" = COALESCE(UPDATED."current_certificate_id"::int8, "user_models"."current_certificate_id"), "telegram_id" = COALESCE(UPDATED."telegram_id"::text, "user_models"."telegram_id"), "username" = COALESCE(UPDATED."username"::text, "user_models"."username"), "first_name" = COALESCE(UPDATED."first_name"::text, "user_models"."first_name"), "last_name" = COALESCE(UPDATED."last_name"::text, "user_models"."last_name"), "balance" = COALESCE(UPDATED."balance"::int8, "user_models"."balance"), "free_period_used" = COALESCE(UPDATED."free_period_used"::bool, "user_models"."free_period_used")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${registry.encode(r.currentCertificateId)}, ${registry.encode(r.id)}, ${registry.encode(r.telegramId)}, ${registry.encode(r.username)}, ${registry.encode(r.firstName)}, ${registry.encode(r.lastName)}, ${registry.encode(r.balance)}, ${registry.encode(r.freePeriodUsed)} )').join(', ')} )\n'
      'AS UPDATED("current_certificate_id", "id", "telegram_id", "username", "first_name", "last_name", "balance", "free_period_used")\n'
      'WHERE "user_models"."id" = UPDATED."id"',
    );
  }

  @override
  Future<void> delete(Database db, List<int> keys) async {
    if (keys.isEmpty) return;
    await db.query(
      'DELETE FROM "user_models"\n'
      'WHERE "user_models"."id" IN ( ${keys.map((k) => registry.encode(k)).join(',')} )',
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

class SertificateModelInsertRequest {
  SertificateModelInsertRequest(
      {required this.privateKey,
      required this.publicKey,
      required this.serverId,
      required this.dateCreate,
      required this.userId});
  String privateKey;
  String publicKey;
  int serverId;
  DateTime dateCreate;
  int userId;
}

class ServerModelInsertRequest {
  ServerModelInsertRequest(
      {required this.ip, required this.serverName, required this.countUsers, required this.regionId});
  String ip;
  String serverName;
  int countUsers;
  int regionId;
}

class UserModelInsertRequest {
  UserModelInsertRequest(
      {required this.currentCertificateId,
      required this.telegramId,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.balance,
      required this.freePeriodUsed});
  int currentCertificateId;
  String telegramId;
  String username;
  String firstName;
  String lastName;
  int balance;
  bool freePeriodUsed;
}

class RegionModelInsertRequest {
  RegionModelInsertRequest({required this.regionName});
  String regionName;
}

class SertificateModelUpdateRequest {
  SertificateModelUpdateRequest(
      {required this.id, this.privateKey, this.publicKey, this.serverId, this.dateCreate, this.userId});
  int id;
  String? privateKey;
  String? publicKey;
  int? serverId;
  DateTime? dateCreate;
  int? userId;
}

class ServerModelUpdateRequest {
  ServerModelUpdateRequest({required this.id, this.ip, this.serverName, this.countUsers, this.regionId});
  int id;
  String? ip;
  String? serverName;
  int? countUsers;
  int? regionId;
}

class UserModelUpdateRequest {
  UserModelUpdateRequest(
      {this.currentCertificateId,
      required this.id,
      this.telegramId,
      this.username,
      this.firstName,
      this.lastName,
      this.balance,
      this.freePeriodUsed});
  int? currentCertificateId;
  int id;
  String? telegramId;
  String? username;
  String? firstName;
  String? lastName;
  int? balance;
  bool? freePeriodUsed;
}

class RegionModelUpdateRequest {
  RegionModelUpdateRequest({required this.id, this.regionName});
  int id;
  String? regionName;
}

class SertificateModelQueryable extends KeyedViewQueryable<SertificateModel, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => registry.encode(key);

  @override
  String get tableName => 'sertificate_models_view';

  @override
  String get tableAlias => 'sertificate_models';

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
  final int id;
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

class UserModelQueryable extends KeyedViewQueryable<UserModel, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => registry.encode(key);

  @override
  String get tableName => 'user_models_view';

  @override
  String get tableAlias => 'user_models';

  @override
  UserModel decode(TypedMap map) => UserModelView(
      currentCertificate: map.get('currentCertificate', SertificateModelQueryable().decoder),
      id: map.get('id', registry.decode),
      telegramId: map.get('telegram_id', registry.decode),
      username: map.get('username', registry.decode),
      firstName: map.get('first_name', registry.decode),
      lastName: map.get('last_name', registry.decode),
      balance: map.get('balance', registry.decode),
      freePeriodUsed: map.get('free_period_used', registry.decode));
}

class UserModelView implements UserModel {
  UserModelView(
      {required this.currentCertificate,
      required this.id,
      required this.telegramId,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.balance,
      required this.freePeriodUsed});

  @override
  final SertificateModel currentCertificate;
  @override
  final int id;
  @override
  final String telegramId;
  @override
  final String username;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final int balance;
  @override
  final bool freePeriodUsed;
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
