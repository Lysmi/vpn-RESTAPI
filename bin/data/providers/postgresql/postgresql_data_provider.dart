import 'package:get_it/get_it.dart';
import 'package:stormberry/stormberry.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/user.dart';
import '../data_provider_interface.dart';
import 'models/sertificate_model.schema.g.dart';
import 'models/user_model.dart';

class PostgresqlDataProvider extends IDataProvider {
  final db = GetIt.I<Database>();

  //region Users
  @override
  Future<List<User>> getAllUsers() async {
    return (await db.userModels.queryUserModels())
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<User?> getUserById(Uuid id) async {
    final userModel = await db.userModels.queryUserModel(id);
    return userModel?.toEntity();
  }
  //endregion
  
  //region Servers

  //endregion
}
