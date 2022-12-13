import 'package:get_it/get_it.dart';
import 'package:stormberry/stormberry.dart';

import '../../../domain/entities/user.dart';
import '../data_provider_interface.dart';

class PostgresqlDataProvider extends IDataProvider {
  final db = GetIt.I<Database>();
  @override
  List<User> getAllUsers() {
    db.users.
  }

  @override
  User getUserById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }
}
