import 'package:get_it/get_it.dart';
import 'package:stormberry/stormberry.dart';

import '../../../domain/entities/user.dart';
import '../data_provider_interface.dart';
import 'models/sertificate_model.schema.g.dart';

class PostgresqlDataProvider extends IDataProvider {
  final db = GetIt.I<Database>();
  @override
  Future<List<User>> getAllUsers() async {
    return (await db.userModels.queryUserModels())
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<User?> getUserById(int id) async {
    // TODO: implement getUserById
    return (await db.userModels.queryUserModel(id))?.toEntity();
  }
}
