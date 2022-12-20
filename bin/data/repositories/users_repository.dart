import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/users_repository_interface.dart';
import '../providers/data_provider_interface.dart';

class UserRepository extends IUsersRepository {
  final IDataProvider _dataProvider = GetIt.I<IDataProvider>();
  
  @override
  Future<List<User>> getAllUsers() {
    return _dataProvider.getAllUsers();
  }

  @override
  Future<User?> getUserById(Uuid id) {
    return _dataProvider.getUserById(id);
  }
}
