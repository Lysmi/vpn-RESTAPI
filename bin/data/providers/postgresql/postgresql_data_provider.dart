import 'package:get_it/get_it.dart';
import 'package:stormberry/stormberry.dart';

import '../../../domain/entities/user.dart';
import '../data_provider_interface.dart';
import 'models/sertificate_model.schema.g.dart';
import 'models/user_model.dart';

class PostgresqlDataProvider extends IDataProvider {
  final db = GetIt.I<Database>();
  @override
  Future<List<User>> getAllUsers() async {
    return (await db.userModels.queryUserModels())
        .map((e) => userToEntity(e))
        .toList();
  }

  @override
  Future<User?> getUserById(int id) async {
    final userModel = await db.userModels.queryUserModel(id);
    if (userModel != null) {
      return userToEntity(userModel);
    } else {
      return null;
    }
  }
}
