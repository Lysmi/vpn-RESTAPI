import 'package:get_it/get_it.dart';
import 'package:stormberry/stormberry.dart';

import '../../../domain/entities/server.dart';
import '../../../domain/entities/user.dart';
import '../data_provider_interface.dart';
import 'models/sertificate_model.schema.g.dart';
import 'models/user_model.dart';
import 'models/server_model.dart';

class Postgresql extends DataProvider {
  final db = GetIt.I<Database>();
  @override
  Future<List<User>> getAllUsers() async {
    return (await db.userModels.queryUserModels())
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<User?> getUserById(String id) async {
    final userModel = await db.userModels.queryUserModel(id);
    return userModel?.toEntity();
  }

  @override
  void addUser(User user) {
    db.userModels.insertOne(UserModelInsertRequest(
        id: user.id,
        telegramId: user.telegramId,
        balance: user.balance,
        freePeriodUsed: user.freePeriodUsed));
  }

  @override
  void addServer(Server server) {
    db.serverModels.insertOne(ServerModelInsertRequest(
        id: server.id,
        ip: server.ip,
        serverName: server.serverName,
        countUsers: server.countUsers,
        regionId: server.region.id));
  }

  @override
  Future<List<Server>> getAllServers() async {
    return (await db.serverModels.queryServerModels())
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  void registration() {
    // TODO: implement registration
  }

  @override
  User updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
