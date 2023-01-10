import 'package:get_it/get_it.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository_interface.dart';
import '../providers/data_provider_interface.dart';

class UserRepository extends IUsersRepository {
  final DataProvider _dataProvider = GetIt.I<DataProvider>();
  @override
  Future<List<User>> getAllUsers() {
    return _dataProvider.getAllUsers();
  }

  @override
  Future<User?> getUserById(String id) {
    return _dataProvider.getUserById(id);
  }

  @override
  void addUser(User user) {
    return _dataProvider.addUser(user);
  }

  @override
  Future<User?> updateUser(User user) async {
    if ((await _dataProvider.getUserById(user.id)) != null) {
      return _dataProvider.updateUser(user);
    } else {
      return null;
    }
  }
}
